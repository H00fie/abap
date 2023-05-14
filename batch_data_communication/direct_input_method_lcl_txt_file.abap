*---------------------------------------------------------------------------------------------------------------------------------
*MIGRATING DATA FROM A LOCAL TEXT FILE USING DIRECT INPUT METHOD.
*---------------------------------------------------------------------------------------------------------------------------------

*BDC - Batch Data Communication, is used for migrating the data from legacy systems (non-SAP systems) to a SAP system. If a company,
*say - Fluffy Ponies, decided to migrate to SAP, people (me) responsible for making it happen, would need to create a BDC program
*that would read the data from Fluffy Ponies' legacy system and migrate it to SAP's database tables.
*The data to be migrated could be located on a local machine or a server. Irrespective of the location, I need to load the data into
*an internal table and to SAP database tables from there.
*There are many BDC techniques.
*
*TheDirect Input Method is just reading the data from the legacy system into an internal table and directly into SAP. There are no
*validations on the way. First, I need to understand what data is there in the legacy system, I need to know what database tables I
*will be migrating the data to (customer data, material data, vendor data, cost centre data, sales order data, invoice data, purchase
*order data, etc), how many fields there are per record, what is the separateor, what is the delimiter.
*E.g. I have a .txt file on a local machine. It contains the customer data, is named 'POKE' and looks like this:
********************
*666xyz,KA,Dedenne
*729abc,KT,Cubone
*695tal,JH,Cyndaquil
********************
*In this case, the first field is the customer number, the second is the customer's country key and the third is the customer's first
*name. This file contains customer data, has a maximum of three fields per record and fields are separated by a comma. I now need to
*analyse what is my target table within SAP. The database table for storing the customer master data is KNA1. It has 215 fields but
*the legacy system has data only for three fields. I need to understand what are those three fields within SAP.
*The DIM technique does not include checking if the data is valid, I am migrating everything as it is.

*In order to read the data from a local text file, SAP has provided a function module 'GUI_UPLOAD'. It's one mandatory import
*parameter is the filename, all other are optional. Although I also need to provide a table parameter because the function module
*reads the data into an internal table.
*I would like the end-user to be able to provide the file in the runtime of the program. To that end I am taking a path to the
*file as a parameter. To make the life of the end-user easier, I should provide a F4 Help functionality to the input box accepting
*the path. When F4 is pressed, an Open Dialog Box should be opened. When F4 is pressed, the AT SELECTION-SCREEN ON VALUE REQUEST
*event is triggered (it's defined at the bottom of the source code). I could, e.g. display a message here - it will be displayed
*upon hitting F4 within my input box. In order to present the user with an Open Dialog Box where user can choose the path to the
*file I am to use a standard SAP's function module - 'F4_FILENAME'. It will allow the user to conveniently choose the path to the
*file that the program will load. 'F4_FILENAME' has one export parameter (the value returned by the function module) of the type
*IBIPPARMS-PATH. This is the path to the file selected by the user.

*A parameter input box for the end-user to provide the path to the file that contains the data we want to be migrated to a SAP's
*database table.
PARAMETERS: p_fname TYPE string.

*I declare the variable 'lv_path' of the IBIPPARMS-PATH type in order to store the path to the file in a local variable.
DATA: lv_path TYPE ibipparms-path.

*I declare the internal table that will be the FIRST "middle man" between the legacy system's file and SAP's database table. The
*file's records consist of three fields each - customer number, country and name, but the entire record... is a string. So one
*variable within my internal table is enough. To begin with, I am essentially copying the local file's structure within my code.
TYPES: BEGIN OF t_temp,
  str TYPE string,
END OF t_temp.
DATA: lt_temp1  TYPE TABLE OF t_temp,
      lwa_temp1 TYPE t_temp.

*I declare the internal table that will be the SECOND "middle man" between the legacy system's file and SAP's database table. First,
*the data from the local file has been uploaded into 't_temp1' in a "raw" form - it was a text file and I just loaded the data into
*an internal table with a single field of the string type. Now I need to adjust the structure of the data so SAP knows what fields
*and in what way should receive the data within KNA1. The second "middle man" has the data properly split bewtween the correct
*fields but is still not the final "middle man". I can only MODIFY the database table FROM an internal table of an identical
*structure. The second "middle man" has only three fields and KNA1 has 215 of them.
TYPES: BEGIN OF t_temp2,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kna1-land1,
  name1 TYPE kna1-name1,
END OF t_temp2.
DATA: lt_temp2  TYPE TABLE OF t_temp2,
      lwa_temp2 TYPE t_temp2.

*I declare the third and final "middle man". The first one served as the receiver of the data in its raw form from the initial text
*file - its job was to simply load the data as it is into SAP. The second "middle man's" job was to organise the fields correctly -
*split the data into correct fields that correspond to those that will serve as the data's final destination within the database
*table. The third "middle man's" task is to receive the loaded and prepared data into the structure identical to that of the final
*database table's and transfer it into that table.
DATA: lt_temp3  TYPE TABLE OF kna1,
      lwa_temp3 TYPE kna1.

*When the Execute button is pressed, the START-OF-SELECTION event is triggered. So if at the moment of the program's execution
*the input box is not empty and thus a path to the file has indeed been provided - I should read the data from my local text
*file to the temporary internal table. I will use the 'GUI_UPLOAD' function module for this. If no path has been provided, a
*pop-up window with a message is displayed.
START-OF-SELECTION.
  IF p_fname IS NOT INITIAL.
    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING
        filename                      = p_fname
      TABLES
        data_tab                      = lt_temp1.
  ELSE.
    MESSAGE 'Please select a file.' TYPE 'I'.
  ENDIF.

*If the 'lt_temp1' indeed contains the data, I need to properly split it among the fields that I recognised as good destination
*fields within KNA1. So I need the first "middle man" who holds the data in its "raw" form to hand the data to the second "middle man"
*who splits the data into the fields that are the same as the fields of the database table in which that data will be put.
*I iterate through the first "middle man" and for every single one of its records, I am performing the operation of splitting that
*record at every occurence of a comma (since the initial text file had its data organised in this way) and placing the part of the
*string that was split first in the second "middle man's" work area's 'kunnr' field, then in the 'land1' field and then in the 'name1'
*field. The order of the fields is deliberate because that's how the data in the initial text file was organised. If it had the data
*starting with, say, the customer's name, then the 'name1' field should be the first to appear after the INTO keyword. At the end, I am
*appending the data stored within the work area to the second "middle man" and starting the loop anew for the next record of the
*first "middle man".
  IF lt_temp1 IS NOT INITIAL.
    LOOP AT lt_temp1 INTO lwa_temp1.
      CLEAR lwa_temp2.
      SPLIT lwa_temp1-str AT ',' INTO lwa_temp2-kunnr
                                     lwa_temp2-land1
                                     lwa_temp2-name1.
      APPEND lwa_temp2 TO lt_temp2.
    ENDLOOP.
  ENDIF.

*If the data indeed resides within the second "middle man" then it's time to transfer said data into the third "middle man" whose
*structure is identical to that of the target database table.
  IF lt_temp2 Is NOT INITIAL.
    LOOP AT lt_temp2 INTO lwa_temp2.
      CLEAR lwa_temp3.
      lwa_temp3-kunnr = lwa_temp2-kunnr.
      lwa_temp3-land1 = lwa_temp2-land1.
      lwa_temp3-name1 = lwa_temp2-name1.
      APPEND lwa_temp3 TO lt_temp3.
    ENDLOOP.
  ENDIF.

*Finally, I need to transfer the data to the target database table itself. I can do it now, because the third "middle man" has the
*structure identical to that of KNA1 where the data I am processing is going. Yet again, I am starting by making sure there actually
*is any data present with my internal table in order not to perform operations if there's nothing to perform them on.
IF lt_temp3 IS NOT INITIAL.
  MODIFY kna1 FROM TABLE lt_temp3.
  WRITE: / 'The number of records affected: ', sy-dbcnt.
ENDIF.

*In the case of my program, the data contains country keys that are not available in SAP (the list of the country keys that SAP
*recognises is within the T005 dataase table). Thus the keys are invalid, but the data will be blindly inserted into the system
*regardless as I am not performing any validations with the Direct Input Method of the Batch Data Communication. The lack of any 
*validations of the data improves performance but constitues a risk of storing invalid data.

*It is worth noting that the initial file's data isn't bound by any legal contract to have a comma as a separator. It could also
*use a tab as one. In that case my content of the legacy system's text file would look like that:
********************
*666xyz  KA  Dedenne
*729abc  KT  Cubone
*695tal  JH  Cyndaquil
********************
*If that was the case, my program would look slightly different. The 'GUI_UPLOAD' function module has an optional import parameter 
*of 'has_field_separator'. It is a parameter specifically designed to inform the function module if the file's data is separated
*by tabs. Thanks to that property, I can load the data directly into the second "middle man".
*The calling of the 'GUI_UPLOAD' function module would look like this:
*CALL FUNCTION 'GUI_UPLOAD'
*      EXPORTING
*        filename                      = p_fname
*         has_field_separator           = 'X'
*      TABLES
*        data_tab                      = lt_temp2.
*The function module would place the data within the second "middle man's" field according to the order of these fields within that
*internal table, so by creating the second "middle man" in a way that its columns are in the same order as the data within the
*legacy system's text file, I ensure the correct placement of said data.
*This method of handling this task is available only if the separator is a tab. If it's a comma, a semicolon or anything else, I
*need to stick to the original logic of first loading the legacy system's file data into an internal table in its "raw" form.

*To define what happens during the AT SELECTION-SCREEN ON VALUE REQUEST event. Hitting F4 in the parameter input box will display
*the Open Dialog Box allowing the end-user to select the file. The path to the chosen file is returned by the 'F4_FILENAME' function
*module and stored within my 'lv_path' variable. If the path was indeed chosen and a value is present within 'lv_path' - that value
*is assigned to the parameter input box.
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_fname.
*  MESSAGE 'Hello' TYPE 'I'. "This is testing. Upon hitting F4, that message should pop up.
  CALL FUNCTION 'F4_FILENAME'
    IMPORTING
      FILE_NAME           = lv_path.

  IF lv_path IS NOT INITIAL.
    p_fname = lv_path.
  ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------