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