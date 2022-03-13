*---------------------------------------------------------------------------------------------------------------------------------
*INTERNAL TABLES. MATERIAL MASTER TABLE -> MARA
*---------------------------------------------------------------------------------------------------------------------------------

*MARA is a standard SAP table and contains most of the fields related to material master. Material master is a base table that
*stores all the materials. There are other tables associated with materials, but MARA is the base table which stores all the materials.
*There is a parameter called MATERIAL GROUP used to manage the materials (e.g. electronics).

TABLES: mara. "I don't need ALL the columns of mara (245). There is a lot of data that I might not need, I just want some of it.

*When I am declaring the  TABLES mara and then creating a SELECT * FROM mara WHERE xyz, I would receive all 245 columns selected.
*This requires an optimization. I don't need all these fields... I only need three fields - matnr, ersda and matkl.
*So, instead of declaring the entire table (which will in turn create a work area internally...) - I am declaring a TYPES statement.
*Thus I am creating a structure that will contain whatever number of fields I want it to, e.g. just 3.
*A structure all by itself is no good since it cannot hold any data, it's just a definition of a structure. It's a blueprint for something
*that WILL hold the data.
*The actual data is held by an internal table.

TYPES: BEGIN OF ty_mara,          "TYPES declares a structure. It cannot hold any data yet. It's ONLY a structure. In order for it to hold the data...
                matnr TYPE matnr, "... I have to DECLARE it using a DATA statement!
                ersda TYPE ersda,
                matkl TYPE matkl,
  END OF ty_mara.

*Below I am creating an internal table which is of the type of previously declared structure ty_mara (it has the mentioned columns).
*Internal table is a table in memory which can hold any number of records.

DATA: it_mara TYPE TABLE OF ty_mara, "This is a 'grid' - it can contain any number of rows.
      wa_mara TYPE ty_mara.          "It's exactly the same in structure as it_mara, but it only has a single row.

PARAMETERS: p_matkl TYPE matkl.

SELECT matnr ersda matkl FROM mara INTO TABLE it_mara WHERE matkl = p_matkl.
*If I leave the statement as "INTO mara", it says I cannot use the internal table as a work area. Which means that
*INTO xyz means getting that data into a work_area.
  LOOP AT it_mara INTO wa_mara.                           "By that, I am grabbing a single record.
    WRITE: / wa_mara-matnr, wa_mara-ersda, wa_mara-matkl. "I need to specify WHAT matnr, ersda and matkl I want. And they are already assigned to the work_area.
  ENDLOOP.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*INTERNAL TABLES. DIFFERENT LANGUAGES -> JOINING TABLES (INNER JOIN)
*---------------------------------------------------------------------------------------------------------------------------------
*The table MAKT contains the descriptions of all the materials in different languages are stored. I need data from at least two
*tables... e.g. matnr and matkl from mara as well as description and language from makt.
*TABLE JOIN is used.
*I need to make sure there is a common field between two tables (like Primary Key) - when the join is joined (xD), SAP
*internally creates a "complicated data set" called Cartesian Product... which means data combined from both tables. All columns
*are combined. Then I have that huge piece of data from which I can choose stuff.
*Internal tables come in handy here... If I just go TABLES: MARA. and SELCT... - it's a huge waste of memory (using just TABLES: MARA
*is already a waste). Internal tables allow me to choose just the fields I require so they make that process very efficient.
*I can just e.g. four tables. Then I use SELECT *... without an internal table, the system "goes crazy".

TYPES : BEGIN OF ty_mara,
              matnr TYPE matnr,
              matkl TYPE matkl,
              spras TYPE spras,
              maktx TYPE maktx,
  END OF ty_mara.

DATA: it_mara TYPE TABLE OF ty_mara,
      wa_mara TYPE ty_mara.

PARAMETERS: p_matnr TYPE matnr,
            p_spras TYPE spras.

*Below I am choosing four fields spread across multiple tables. So I am doing an INNER JOIN!
SELECT mara~matnr mara~matkl makt~spras makt~maktx
  FROM mara AS mara INNER JOIN makt AS makt "AS -> an alias.
  ON mara~matnr = makt~matnr                "The common field of all tables, I am joining the tables ON this field (by it/thanks to it/through it). These are the common columns.
  INTO TABLE it_mara                        "Into my beautiful internal table.
  WHERE mara~matnr = p_matnr                "These and below is the narrowing of the selection.
  AND makt~spras = p_spras. 
*Above basically means I want to join matnr, matkl, spras and maktx from two tables, so join these tables
*on their common column which is matnr, put the result into my internal table and do all of these only for these
*records that meet my criteria, so where mara in matnr column has a record with the value I provided and makt
*in spras column has a record with the value I provided.

LOOP AT it_mara INTO wa_mara.
*Below the fields I want already belong to the Work Area. With every loop, my Work Area contains and thus
*provides one row of data that exists in it_mara. It exists there because I put it there via my SELECT above.
  WRITE: / wa_mara-matnr, wa_mara-matkl, wa_mara-spras, wa_mara-maktx.
ENDLOOP.
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*INTERNAL TABLES. MATERIAL STOCK -> JOINING TABLES (LEFT OUTER JOIN).
*---------------------------------------------------------------------------------------------------------------------------------

*When I want to join two tables and one is missing a row for a particular plant (because MARD is designed in such a way that if there
*is no stock for the plant, there's no row) -> I'd rather use OUTER JOIN, because INNER JOIN will drop everything it gathered so far
*from table MARA if it couldn't find data in table MARD and there's no information at all.
*OUTER JOIN will still return everything that was available and add a null or a zero for what was missing.

TYPES: BEGIN OF ty_mara,
          matnr TYPE matnr,
          werks TYPE werks,
          lgort TYPE lgort,
          labst TYPE labst,
  END OF ty_mara.

DATA: it_mat TYPE TABLE OF ty_mara,
      wa_mat TYPE ty_mara.

PARAMETERS: p_matnr TYPE matnr.

*Looks like SQL requires '~' instead of '-' when specifying the table~column relationship.
SELECT mara~matnr mard~werks mard~lgort mard~labst
  FROM mara AS mara LEFT OUTER JOIN mard AS mard
  ON mara~matnr = mard~matnr
  INTO TABLE it_mat
  WHERE mara~matnr = p_matnr.

LOOP AT it_mat INTO wa_mat.
  WRITE: / wa_mat-matnr, wa_mat-werks, wa_mat-lgort, wa_mat-labst. "Everything taken from MARA and MARD has already been put into it_mat and then, with every loop, is handed to wa_mat. wa_mat holds every new row every loop.
ENDLOOP.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*INTERNAL TABLES. JAPANESE MATERIAL STOCK -> JOINING THREE TABLES (INNER JOIN).
*---------------------------------------------------------------------------------------------------------------------------------
*As I am pulling in more tables into the pool included in my JOIN, the LEFT OUTER JOIN is not recommended as it pulls in more
*rows than are needed.

TYPES: BEGIN OF ty_mat,
         matnr TYPE matnr, "This is the material number, my key-field.
         matkl TYPE matkl, "The material group.
         spras TYPE spras, "That's the language.
         maktx TYPE maktx, "The description.
         werks TYPE werks, "Currency?
         labst TYPE labst, "The quantity!
  END OF ty_mat.

DATA: it_mat TYPE TABLE OF ty_mat,
      wa_mat TYPE ty_mat.

PARAMETERS: p_matnr TYPE matnr,
            p_spras TYPE spras.

SELECT mara~matnr mara~matkl makt~spras makt~maktx mard~werks mard~labst
  FROM mara AS mara
  INNER JOIN makt AS makt ON mara~matnr = makt~matnr
  INNER JOIN mard AS mard ON mara~matnr = mard~matnr
  INTO TABLE it_mat
  WHERE mara~matnr = p_matnr
  AND makt~spras = p_spras.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*INTERNAL TABLES. TYPES AND OPERATIONS.
*---------------------------------------------------------------------------------------------------------------------------------

*There are two methods of dealing with internal tables. The old way is HEADER LINE and the new way is WORK AREA.
*Internal tables can be defined using any number of other defined structures. This allows me to have many normal table structures
*grouped together and placed into a single internal table (something akin to a multidimensional array).
*The basic form of an internal table consists of a table body (all the records within the table) and a header record OR a table
*body and a separate work area.
*A header line or a work area is used when I want to read a single record from my internal table. When I read a record from the
*old style table, that record is placed into the header record and for the new style it is read into a work area (which is separate).
*Similarly, when creating a new record, it is first placed in the header/work area and then transferred into the body of the internal
*table.
*The introduction of work area allowed us to create multi-dimensional tables - tables within tables.
*The architecture of SAP limits the size of internal tables to around 2GB.

*There are different kinds of internal tables:
*1. Standard tables: give me an option to access the records via a table key or an index. When I access records using a key, the larger
*                    table is, the longer it will take to read the records. This is why I can use an index.
*                    Standard tables do not give me the option of defining a unique key, so I might have identical lines repeated. A
*                    standard internal table can thus hold many identical records.
*                    Accessing records using a table key may take a long time, but a standard table can also be filled with record very
*                    quickly because the system doesn't have to check the table for any duplicate records.
*2. Sorted tables:   a unique key can be defined and a duplication of records can be avoided. Records can be accessed using the table key
*                    or the table index. A table key can also be used to find records. Much like with the standard tables, it's not the
*                    fastest way possible, but a lot better for the sorted ones nonetheless.
*                    The usage of a sorted table over a standard table is preferred due to the increased speed of accessing records and
*                    because sorted tables sort my records into a specific sequence which gives me a performance increase when accessing
*                    the data.
*3. Hashed tables:   records are not accessed via an index. Only a unique key is to be used. Hashed tables are usually preferred when
*                    it comes to speed. When I know my internal table is going to be huge, a hashed table might be my best bet.
*                    Hash tables use a hash algorithm which makes them fast.

*OCCURS 0 tells SAP we are declaring an internal table with no records initially (even if I use OCCURS 5, I can easily add more than just
*5 records. OCCURS is basically obsolete). Using OCCURS automatically tells the system this is an internal table with a header record.
DATA: BEGIN OF itab01 OCCURS 0,
        surname LIKE zpokemon-surname,
        dob     LIKE zpokemon-dob,
      END OF itab01.

*Below internal table should be used because it complies with ABAP objects!
*I am just defining a LINE of an internal table here. No OCCURS also kind of means it's not yet a table. It's but a line of a table.
TYPES: BEGIN OF line01_typ,
        surname LIKE zpokemon-surname,
        dob     LIKE zpokemon-dob,
  END OF line01_typ.

*Below I am defining the table type. This is going to be a standard table. So it can have multiple identical records so no unique key
*needs to be included in the table type definition. There's no OCCURS here, but I can use INITIAL SIZE if I chose to, but it's optional.
TYPES itab02_typ TYPE STANDARD TABLE OF line01_typ.

*Below table is sorted and so it requires the information of what it's going to be sorted by. In this case - a surname.
TYPES itab03_typ TYPE SORTED TABLE OF line01_typ WITH UNIQUE KEY surname.

*The above are just blueprints. Now I declare an actual table based on the table type. Technically, I could add WITH HEADER LINE at the
*end, but I should not as this would make the table unusable with ABAP objects.
DATA itab02 TYPE itab02_typ.
*And I need a WORK AREA! It will be used in conjunction with the table I just defined. WA is not part of the internal table. I move
*data to my WA, I work with it and then I update my table from the WA. WA is a completely separate entity - if I have multiple
*tables of the same structure, I can use a single work area to read and write data to and from them.
DATA wa_itab02 TYPE line01_typ.

*POPULATING AN INTERNAL TABLE WITH A HEADER LINE----------------------------------------
*When I read or write data to or from an internal table that has a header line, said data is always moved through the header line itself.
*When I read a record from the internal table, that record is moved to the header line and I access it there. When I want to add a record
*to the internal table, I move it to the header line which then gets appended to the internal table.
TABLES: zpokemon.
*
DATA: BEGIN OF very_tab OCCURS 0,
  employee LIKE zpokemon-employee,
  surname  LIKE zpokemon-surname,
  forename LIKE zpokemon-forename,
  title    LIKE zpokemon-title,
  dob      LIKE zpokemon-dob,
  los      TYPE i VALUE 3, "Length of service.
END OF very_tab.

*FIRST METHOD ---> ARRAY FETCH----------------------------------------

*Below means the records from zpokemon will be moved to very_tab by matching them by their names.
*It is called an 'array fetch' -> it picks up records and puts them in my table all at once. It is different than performing a SELECT
*within a loop, because then it grabs every record one at a time. An 'array fetch' goes big and grabs them all at once. An 'array fetch'
*does not have an ENDSELECT statement.
*The extra field, 'los', will be added to every record and assigned the value of 3.
*Using an array fetch I am not populating my table line by line and I am taking away the loop generated by the SELECT and ENDSELECT
*statements. Only fields that correspond to those within the strucutre they are to move to are moved. This type of a SELECT statement is
*much faster than using a loop.
*Also no header record is being used here - I am using a block by block array fetch method to fill my table.
SELECT * FROM zpokemon
  INTO CORRESPONDING FIELDS OF TABLE very_tab.

*In the debugger -  a hat symbol represents the header line. When I F5 this good boy, all records will be placed inside in one fell swoop,
*because it's an array fetch!
WRITE very_tab-surname.

*SECOND METHOD ---> APPEND----------------------------------------

*Append is another way of filling an internal table. Instead of doing an array fetch, this is a loop and I am grabbing every record one
*at a time. Essentially, the first record will be selected and then I am performing individual MOVE statements to move the data, field by
*field to the corresponding fields of very_tab. APPEND tells the system to take the values from the header record and add them to the body
*of the internal table.
*It is a good practice to clear the header record as soon as the data held within is appended to the body of the internal table. Otherwise
*SAP will have to keep overwriting the data previously held within every field of the header record.
*Every record, upon being appended to the table, will also be given a default value of 3 to 'los' field as per the definition of the table.
*WITHOUT THE APPEND IT WILL JUST KEEP OVERWRITING THE CONTENT OF THE HEADER LINE BECAUSE THE DATA IS NOT BEING PASSED FURTHER ON TO
*THE ACTUAL TABLE. In the debugger, if I F5 it, at the end of the loop (when all the fields are filled with MOVE statement), SAP will just
*start overwriting the data already present within the header record.
SELECT * FROM zpokemon.
  MOVE zpokemon-employee TO very_tab-employee.
  MOVE zpokemon-surname  TO very_tab-surname.
  MOVE zpokemon-forename TO very_tab-forename.
  MOVE zpokemon-title    TO very_tab-title.
  MOVE zpokemon-dob      TO very_tab-dob.
  APPEND very_tab.
ENDSELECT.

WRITE very_tab-surname.

*THIRD METHOD ---> MOVE-CORRESPONDING----------------------------------------

*Similar to the above, but way shorter. I also need to specify the name of the table again within the operation itself. This method matches up the
*technical name of each field from the zpokemon with a matching field in very_tab - when such a match is found, contents are moved. With
*this method I need to make sure the fields are named alike in both tables. Fields moved to and from also need to be of the same data type
*and length.
*Just for the record - this is NOT an array fetch. It grabs record by record, not all at once.
SELECT * FROM zpokemon.
  MOVE-CORRESPONDING zpokemon TO very_tab.
  APPEND very_tab.
ENDSELECT.

WRITE very_tab-surname.

*ANOTHER WAY OF CREATING AN INTERNAL TABLE ---> INCLUDE STRUCTURE.
*A statement that I can use to add various structures that I've already defined or have already been defined to build up my own internal table.
*Other data elements can also be added (e.g. count).
DATA: BEGIN OF very_tab2 OCCURS 0.
        INCLUDE STRUCTURE very_tab.
*       INCLUDE STRUCTURE zpokemon. "Field would be repeated because very_tab and zpokemon have similar ones, but that's just an example. It throws an error due to that repeat!
        DATA count TYPE i.
DATA END OF very_tab2.




*FILLING AN INTERNAL TABLE WITH A WORK AREA----------------------------------------
*The fundamental difference is that when selecting records from the table I am using a SEPARATE work area instead of the internal table's
*OWN header line.

*Declaring a line type... I think this is basically the equivalent of a database table. Like having tables TYPE STANDARD TABLE OF mara.
TYPES: BEGIN OF line03_typ,
  surname LIKE zpokemon-surname,
  dob     LIKE zpokemon-dob,
END OF line03_typ.

*Declaring a 'table type' based on the 'line type'. (I think that this could be omitted and I could go straight to declaring the table itself.)
TYPES itab03_typ TYPE STANDARD TABLE OF line03_typ.

*Declaring the table itself based on the 'table type'. (I think I could just do a DATA itab03 TYPE STANDARD TABLE OF line03_typ. here.)
DATA itab03    TYPE itab03_typ.
DATA itab04    TYPE STANDARD TABLE OF line03_typ. "I think that's literally the same as above, but with fewer steps.
DATA wa_itab03 TYPE line03_typ.

*I CAN EITHER FILL MY INTERNAL TABLE VIA MY WORK AREA...
*Works the same with both itab03 and itab04.
SELECT surname dob FROM zpokemon
  INTO wa_itab03.
  APPEND wa_itab03 TO itab03.
ENDSELECT.

*OR BY AN ARRAY FETCH...
**An array fetch is possible with Work Areas too!... And it skips the Work Area just like before, with Header Lines, it skipped the Header Line.
*SELECT * FROM zpokemon
*  INTO CORRESPONDING FIELDS OF TABLE itab03.
*
*Confirming if records are indeed inserted into the table. It was declared with the Work Area, so I am moving records from itab to wa.
LOOP AT itab03 INTO wa_itab03.
  WRITE wa_itab03-surname.
ENDLOOP.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*LOOPING THROUGH INTERNAL TABLES.
*---------------------------------------------------------------------------------------------------------------------------------
*Reading through the records of an internal table line by line using a loop. Standard ABAP Dictionary Table's records are accessed
*via SELECT and ENDLSELECT statements (unless it's an array fetch!) while internal table's records are accessed via LOOP and ENDLOOP
*statements.

*STEPS FOR THE TABLE WITH THE HEADER LINE:
*Without declaring the Standard ABAP Dictionary Table here, it throws an error in the SELECT statement claiming that
*the 'destination area' needs to be inserted directly by INTO clause or indirectly by TABLES instruction.
*Which means that the Standard ABAP Dictionary Table from which I am extracting data is considered 'destination' here.
TABLES: zpokemon.

*1) This is my internal table.
DATA: BEGIN OF very_tab OCCURS 0,
  employee LIKE zpokemon-employee,
  surname  LIKE zpokemon-surname,
  forename LIKE zpokemon-forename,
  title    LIKE zpokemon-title,
  dob      LIKE zpokemon-dob,
  los      TYPE i VALUE 3, "Length of service.
END OF very_tab.

*2) This is how I access Standard ABAP Dictionary Table's records and put them within my internal table.
SELECT * FROM zpokemon.
  MOVE zpokemon-employee TO very_tab-employee.
  MOVE zpokemon-surname  TO very_tab-surname.
  MOVE zpokemon-forename TO very_tab-forename.
  MOVE zpokemon-title    TO very_tab-title.
  MOVE zpokemon-dob      TO very_tab-dob.
  APPEND very_tab.
ENDSELECT.

*3) Perform whatever I want to do with internal table's records within my loop. When I access records of an internal
*table with a header line, each record gets transferred one record at a time from the body of the internal table to the
*header line.
LOOP AT very_tab.
  WRITE: / very_tab-surname, very_tab-forename. "Underneath, the WRITE accessed the header line here.
ENDLOOP.



*MODIFY----------------------------------------
*If the IF statement is true, then MODIFY will take the content of the header line that has just been updated and update
*the record in the internal table that was originally read into the header record.
*Without the MODIFY, it will still WRITE the updated value, but, I believe, only the content of the header line is updated
*this way and the internal table itself still holds the original value.
*MODIFY, when used inside a loop of an internal table, has some specific features. It changes only the content of the existing
*line in the internal table that I've read and does not create a new record. It is always the current line that is changed when
*MODIFY is within a loop. It should not be used to modify the key fields that use a unique key.
*If MODIFY is used outside of a loop - I must specify a record's index number that I want to modify. It's not required within
*loops, because, while in a loop, the system monitors the index number automatically.
*MODIFY can be used like that only with index tables and tables with header lines.
LOOP AT very_tab.
  IF very_tab-surname = 'TOHANA'.
    very_tab-surname = 'Taehana'.
*    MODIFY very_tab.
  ENDIF.
  WRITE very_tab-surname.
ENDLOOP.



*DESCRIBE----------------------------------------
*Used to find out the content of the internal table - the number of records the table holds, the reserved memory space used and the
*type of a table (standard, sorted, hash). Usually used just to check how many records are there within the internal table.
*Below statement will return an integer value that represents the number of lines contained in my internal table. The value will be
*stored in line_cnt.
DATA line_cnt TYPE i.
DESCRIBE TABLE very_tab LINES line_cnt.



*INSERT----------------------------------------
*While the APPEND statement adds lines to the end of the table, INSERT allows me to insert a record into any position I choose inside
*my internal table by specifying the table's index number.
*Due to DESCRIBE putting the number of records into line_cnt variable and INSERT inserting a value at that index, the new value will be
*placed between the last record in the internal table and the one before it - shifting the previously last record forward index-wise.
INSERT very_tab INDEX line_cnt.



*READ----------------------------------------
*In order to access the records of an internal table, a READ statement can also be used. It allows me to specifically read individual
*records from the table. Because I am using a header line, when I use READ, the record will be read into that header line.
*When I use the READ statement, I need to be aware of how has my table been decalred - that will affect how I will be using my
*READ (whether it's a standard, a sorted or a hash table).
*The READ statement is the fastest way of accessing records of an internal table and using the index specifically is the fastest form
*of READ itself. I is about three times faster than using the hash algorithm and up to 14 times faster than using a normal table key.
*But, obviously, I do not always know the index number of the record that I want read - that's why usually table keys are used.

*STANDARD TABLE WITH A NON-UNIQUE STANDARD KEY.
READ TABLE very_tab INDEX 5. "I am reading the fifth record of my internal table into my header record.

*WITH A TABLE KEY.
*WITH KEY accepts unique table keys, but also other fields as well. But then it's difficult to know which record exactly
*I will be reading. If I specify a surname and I have three records sharing it, no clue which one will be taken... Actually,
*there is a clue, a certainty even - with a non-unique key, READ statement reads sequentially through the table and will take
*the first record it encounters.
*The READ statement can also be used for sorted and hash tables. When I specify the key fields to use in my search, the system
*will run the binary search for sorted tables and use a hash algorithm for hash tables. If the fields used are not key fields,
*the system will carry out a sequential search for both the sorted and hash tables.
READ TABLE very_tab WITH KEY employee = 10000007.



*DELETE----------------------------------------
*I can use it to delete individual records or groups of records from my internal table. The fastest way is by using the
*table index, just like with READ. This only applies to standard tables and sorted tables, not hash tables, because
*only these two have an index.
*I make no use of the header line here.
DELETE very_tab INDEX 5.

*DELETE can also be used within a loop.
LOOP AT very_tab.
  IF very_tab-surname = 'Tohana'.
    DELETE very_tab INDEX sy-index. "This variable gets updated automatically by the system, so always points at the index of the current record!
  ENDIF.
ENDLOOP.

*DELETE should not be used without the index addition. If outside a loop - I will get a run time error. If I am within a loop,
*I need to make sure the index addition is included in order to be compliant with the future releases of ABAP syntax.

*WHERE addition to DELETE statement.
*I can use it when I don't know the exact index of the record I want to delete. I should always try to be as specific as possible
*when trying to identify the records I want deleted.
*Below ALL records with the surname 'Tohana' will be deleted.
DELETE very_tab WHERE surname = 'Tohana'.



*SORT----------------------------------------
*Below (no additions) means that the data will be sorted in an ascending order based on the defined table key. This works for
*sorted tables and hash tables.
SORT very_tab.

*If I want to sort a standard internal table, then I need to use BY addition. Moreover, SAP caters to all sorts of languages
*and this needs to be taken into account if I am working for a company whose systems are used throughout the world. In order to
*make sure that the internal table is sorted according to language specific criteria, I use AS TEXT addition directly after the
*name of my internal table.
SORT very_tab AS TEXT BY surname.

*I am not limited to using just one field while using SORT. I can use up to 250 fields. Below, AS TEXT will be applied to all
*specified fields because of where the statement is placed.
SORT very_tab AS TEXT BY surname forename.

*If I want AS TEXT applied only to the forename.
SORT very_tab BY surname AS TEXT forename.

*The default way of sorting is the ascending one, but I can specify it.
SORT very_tab DESCENDING AS TEXT BY surname forename.

*WORK AREA------------------------------
*An example table for work area's usage.
TYPES: BEGIN OF line01_typ,
  surname LIKE zemployees-surname,
  dob     LIKE zemployees-dob,
  END OF line01_typ.
  
TYPES itab02_typ TYPE STANDARD TABLE OF line01_typ.
  
DATA itab02 TYPE itab02_typ.
  
DATA wa_itab02 TYPE line01_typ.
  
SELECT * FROM zpokemon
  INTO CORRESPONDING FIELDS OF TABLE itab02.

*LOOP----------------------------------------
*Looping through an internal table with work area.
LOOP AT itab02 INTO wa_itab02.
  WRITE wa_itab02-surname.
ENDLOOP.

*MODIFY----------------------------------------
LOOP AT itab02 INTO wa_itab02.
  IF wa_itab02-surname = 'Tohana'.
    wa_itab02-surname = 'Taehna'.
    MODIFY itab02 FROM wa_itab02.
  ENDIF.
ENDLOOP.
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------