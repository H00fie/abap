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