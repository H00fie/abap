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