*---------------------------------------------------------------------------------------------------------------------------------
*MODULARIZATION. INTERNAL TABLES AS PARAMETERS. DELETE, MODIFY.
*---------------------------------------------------------------------------------------------------------------------------------

TYPES: BEGIN OF t_emp,
          empno        TYPE i,
          ename(20)    TYPE c,
          empdesig(25) TYPE c,
       END OF t_emp.

DATA: it_emp TYPE TABLE OF t_emp,
      wa_emp TYPE t_emp.

CLEAR wa_emp.
wa_emp-empno = 3.
wa_emp-ename = 'Dazikiri'.
wa_emp-empdesig = 'Developer'.
APPEND wa_emp TO it_emp.

CLEAR wa_emp.
wa_emp-empno = 1.
wa_emp-ename = 'Attalos'.
wa_emp-empdesig = 'Junior Developer'.
APPEND wa_emp TO it_emp.

CLEAR wa_emp.
wa_emp-empno = 5.
wa_emp-ename = 'Astrastvael'.
wa_emp-empdesig = 'Senior Developer'.
APPEND wa_emp TO it_emp.

*Displays the internal table's contents.
PERFORM sub2 TABLES it_emp.

ULINE.

*Deletes some of the internal table's contents.
PERFORM sub3 TABLES it_emp.
PERFORM sub2 TABLES it_emp.

ULINE.

PERFORM sub4 TABLES it_emp.

ULINE.

*A work area can be used anywhere in the program, including the FORMs. I am using it directly, because
*the work area itself is but a 'tool' for passing data and can be used for multiple internal tables.
FORM sub2 TABLES lt_emp.
  LOOP AT lt_emp INTO wa_emp.
    WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
  ENDLOOP.
ENDFORM.

*If I tried to do it as below with the USING keyword, SAP would throw an error saying 'lt_emp' is not
*recognized as an internal table.
*PERFORM sub1 USING it_temp.
*FORM sub1 USING lt_emp.
*  LOOP AT lt_emp INTO wa_emp.
*    doing important stuff!!!
*  ENDLOOP.
*ENDFORM.

*------------------------------
*----------DELETE--------------
*------------------------------
*Wherever I am altering the data in the internal table in a subroutine (MODIFY or DELETE), I need to
*specify the structure of the internal table by adding the keyword STRUCTURE and providing the work area
*used. "Row type" is work area.
*Without this addition (the example below) I will get an error:
*"The row type of the table must be identifiable statically in "...WHERE..."".
*FORM sub3 TABLES lt_emp.
*  DELETE lt_emp WHERE empdesig = 'Senior Developer'.
*ENDFORM.

*Changes done to the formal internal table will also affect the actual internal table which means it's
*passed by reference by default.
FORM sub3 TABLES lt_emp STRUCTURE wa_emp.
  DELETE lt_emp WHERE empdesig = 'Senior Developer'.
ENDFORM.

*------------------------------
*----------MODIFY--------------
*------------------------------
*I cannot modify an internal table directly, first I need to assign the desired value to the work area
*and then I can update the internal table via the work area.
*"TRANSPORTING empdesig" means that only this field is to be taken into account. I could say instead:
*"(...)TRANSPORTING ename WHERE empdesig = 'Developer'." if my work area contained the updated name
*which I wanted to assign to all developers.
FORM sub4 TABLES lt_emp STRUCTURE wa_emp.
  CLEAR wa_emp.
  wa_emp-empdesig = 'Senior Developer'.
  MODIFY lt_emp FROM wa_emp TRANSPORTING empdesig WHERE empdesig = 'Developer'. 
ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------