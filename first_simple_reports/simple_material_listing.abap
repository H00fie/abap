*---------------------------------------------------------------------------------------------------------------------------------
*Below is a program listing materials.
*---------------------------------------------------------------------------------------------------------------------------------

TABLES mara.

*A parameter for the selection-screen! Add the prefix 'p_' to the names of parameters. 
*Thanks to this convention, it's clear that a variable comes from the selection screen.
PARAMETERS: p_name TYPE mara-ERNAM. 

SELECT * FROM mara UP TO 20 ROWS WHERE ERNAM EQ p_name. "EQ and '=' are used like in Java.
  WRITE: / mara-MATNR, mara-ERSDA, mara-ERNAM, '|'.     "The parameter in the selection-screen is changed because I asked SAP to 
ENDSELECT.                                              "add the name of the field it's referencing. Skok do -> Elementy tekstowe -> teksty wyboru.
WRITE: / '--------------------------------------------'.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*Below is another program listing materials.
*---------------------------------------------------------------------------------------------------------------------------------

TABLES: zbm_mat.

SELECT * FROM zbm_mat.
  WRITE: / zbm_mat-material,
         zbm_mat-description.
ENDSELECT.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------