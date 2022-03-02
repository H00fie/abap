*---------------------------------------------------------------------------------------------------------------------------------
*OPEN SQL.
*---------------------------------------------------------------------------------------------------------------------------------
*I need to get into the habit of checking whether the action I've been executing has been executed successfully. Sy-subrc will come in handy.



*INSERT----------------------------------------
DATA: wa_zpokemon LIKE zpokemon. "WA is a record structure, not a table structure -> stores one record.

wa_zpokemon-EMPLOYEE   = '80000'.
wa_zpokemon-SURNAME    = 'Taha'.
wa_zpokemon-FORENAME   = 'Justinia'.
wa_zpokemon-TITLE      = 'Ms'.
wa_zpokemon-DOB        = '20191023'.
wa_zpokemon-INITIALS   = 'OS'.
wa_zpokemon-GENDER     = 'N'.
wa_zpokemon-SALARY     = '23525'.
wa_zpokemon-ECURRENCY  = 'USD'.
wa_zpokemon-ZZLOCATION = 'Warsaw'.
wa_zpokemon-ZZDEPT     = 'IT'.

INSERT zpokemon FROM wa_zpokemon. "Literally INSERT INTO zpokemon FROM wa_zpokemon.
  WRITE: 'INSERT.'.
IF sy-subrc = 0.
  WRITE: 'Record inserted correctly. The surname is: ', wa_zpokemon-surname. "It will throw 4, because the record already exists!
ELSE.
  WRITE: 'The return code is: ', sy-subrc.

ENDIF.
ULINE.



*CLEAR----------------------------------------
*Used mainly in loops. Just clear the area to make sure values are not assigned incorrectly.
*I can clear the entire structure or specific fields.
CLEAR wa_zpokemon. "Not really necessary in this case as I am covering every field anyway and so there won't be any value I would not want
                   "lingering in any field of the work area structure, but it just seems so elegant!



*UPDATE----------------------------------------
*Allows me to modify one or more existing records within a table.
wa_zpokemon-EMPLOYEE   = '80000'.
wa_zpokemon-SURNAME    = 'Tahar'.
wa_zpokemon-FORENAME   = 'Justinia'.
wa_zpokemon-TITLE      = 'Ms'.
wa_zpokemon-DOB        = '20191023'.
wa_zpokemon-INITIALS   = 'OS'.
wa_zpokemon-GENDER     = 'N'.
wa_zpokemon-SALARY     = '23525'.
wa_zpokemon-ECURRENCY  = 'USD'.
wa_zpokemon-ZZLOCATION = 'Warsaw'.
wa_zpokemon-ZZDEPT     = 'IT'.

UPDATE zpokemon FROM wa_zpokemon.
  WRITE: 'UPDATE.'.
IF sy-subrc = 0.
  WRITE: 'Record updated correctly. The surname is: ', wa_zpokemon-surname.
ELSE.
  WRITE: 'The return code is: ', sy-subrc.

ENDIF.
ULINE.



*MODIFY----------------------------------------
*Like a combination of INSERT and UPDATE - it can be used either to introduce a new record or modify an existing one. When I know I am inserting
*or I know I am updating a record, I should always use INSERT or UPDATE respectively. MODIFY is to be used when my code is to EITHER insert or
*update a record depending on the situation, so when I need a flexible soultion.

*MODIFY AS AN UPDATE********************
wa_zpokemon-EMPLOYEE   = '80000'.
wa_zpokemon-SURNAME    = 'Tahari'.
wa_zpokemon-FORENAME   = 'Justinia'.
wa_zpokemon-TITLE      = 'Ms'.
wa_zpokemon-DOB        = '20191023'.
wa_zpokemon-INITIALS   = 'OS'.
wa_zpokemon-GENDER     = 'N'.
wa_zpokemon-SALARY     = '23525'.
wa_zpokemon-ECURRENCY  = 'USD'.
wa_zpokemon-ZZLOCATION = 'Warsaw'.
wa_zpokemon-ZZDEPT     = 'IT'.

MODIFY zpokemon FROM wa_zpokemon. "When MODIFY is executed, the primary key fields from wa_pokemon will be checked against those records held
                                  "in the table.
                                  "If a record exists, it will be UPDATED with the content held in my work area.
                                  "If a record does not exist, a new one will be INSERTED at the end of the table!
  WRITE: 'MODIFY.'.
IF sy-subrc = 0.
  WRITE: 'Record modified correctly. The surname is: ', wa_zpokemon-surname.
ELSE.
  WRITE: 'The return code is: ', sy-subrc.

ENDIF.
ULINE.

*MODIFY AS AN INSERT********************

CLEAR wa_zpokemon.

wa_zpokemon-EMPLOYEE   = '333333'.
wa_zpokemon-SURNAME    = 'Hilieandil'.
wa_zpokemon-FORENAME   = 'Nurnirven'.
wa_zpokemon-TITLE      = 'Mr'.
wa_zpokemon-DOB        = '20191023'.
wa_zpokemon-INITIALS   = 'NH'.
wa_zpokemon-GENDER     = 'M'.
wa_zpokemon-SALARY     = '23525'.
wa_zpokemon-ECURRENCY  = 'USD'.
wa_zpokemon-ZZLOCATION = 'Warsaw'.
wa_zpokemon-ZZDEPT     = 'IT'.

MODIFY zpokemon FROM wa_zpokemon.

WRITE: 'MODIFY.'.
IF sy-subrc = 0.
  WRITE: 'Record modified correctly. The surname is: ', wa_zpokemon-surname.
ELSE.
  WRITE: 'The return code is: ', sy-subrc.

ENDIF.
ULINE.



*DELETE----------------------------------------
*It only needs to take into account the Primary Key. I give a primary key and in return receives the removal of the record of said primary key.
*My zpokemon table contains two Primary Keys, but the MANDT (Client) is handled automatically by the system so I don't need to feed my SQL statements
*the MANDT field.
wa_zpokemon-EMPLOYEE = '80000'.

DELETE zpokemon FROM wa_zpokemon. "Delete a record from zpokemon table that has the employee that equals 80000.

WRITE: 'DELETE.'.
IF sy-subrc = 0.
  WRITE: 'Record deleted correctly.'.
ELSE.
  WRITE: 'The return code is: ', sy-subrc.

ENDIF.
ULINE.



*I can delete records WHERE...
*START OF - Insert two exemplary records*******************************************

*EXAMPLE EHI
CLEAR wa_zpokemon.
wa_zpokemon-EMPLOYEE   = '777'.
wa_zpokemon-SURNAME    = 'Oongha'.
wa_zpokemon-FORENAME   = 'Siv'.
wa_zpokemon-TITLE      = 'Ms'.
wa_zpokemon-DOB        = '20191023'.
wa_zpokemon-INITIALS   = 'SO'.
wa_zpokemon-GENDER     = 'F'.
wa_zpokemon-SALARY     = '23525'.
wa_zpokemon-ECURRENCY  = 'USD'.
wa_zpokemon-ZZLOCATION = 'Warsaw'.
wa_zpokemon-ZZDEPT     = 'IT'.
INSERT zpokemon FROM wa_zpokemon.

WRITE: 'INSERT example Ehi.'.
IF sy-subrc = 0.
  WRITE: 'Ehi in place.'.
ELSE.
  WRITE: 'Lol, fail! You got ', sy-subrc, '!'.
ENDIF.
ULINE.

*EXAMPLE OCI
CLEAR wa_zpokemon.
wa_zpokemon-EMPLOYEE   = '778'.
wa_zpokemon-SURNAME    = 'Tharo'.
wa_zpokemon-FORENAME   = 'Siv'.
wa_zpokemon-TITLE      = 'Ms'.
wa_zpokemon-DOB        = '20191023'.
wa_zpokemon-INITIALS   = 'SO'.
wa_zpokemon-GENDER     = 'F'.
wa_zpokemon-SALARY     = '23525'.
wa_zpokemon-ECURRENCY  = 'USD'.
wa_zpokemon-ZZLOCATION = 'Warsaw'.
wa_zpokemon-ZZDEPT     = 'IT'.
INSERT zpokemon FROM wa_zpokemon.

WRITE: 'INSERT example Oci.'.
IF sy-subrc = 0.
  WRITE: 'Oci in place.'.
ELSE.
  WRITE: 'Lol, fail! You got ', sy-subrc, '!'.
ENDIF.
ULINE.
*END OF - Insert two exemplary records*********************************************

DELETE FROM zpokemon WHERE forename = 'Siv'. "In the case of using WHERE, FROM too must be utilized.

WRITE: 'DELETE TWO RECORDS.'.
IF sy-subrc = 0.
  WRITE: 'Two exemplary records deleted correctly.'.
ELSE.
  WRITE: 'The return code is: ', sy-subrc.
ENDIF.
ULINE.

*WARNING -> I need to be cautious with DELETE FROM table_name because such a statement without any WHERE will simply
*erase all records within the table.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------