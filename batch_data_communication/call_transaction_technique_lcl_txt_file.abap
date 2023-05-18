*---------------------------------------------------------------------------------------------------------------------------------
*MIGRATING DATA FROM A LOCAL TEXT FILE USING THE CALL TRANSACTION TECHNIQUE.
*---------------------------------------------------------------------------------------------------------------------------------

*While the Direct Input Method consists of three levels - the legacy system, an internal table and SAP, the Call Transaction technique
*consist of five - the legacy system -> an internal table -> a BDCDATA internal table -> MP transaction -> SAP.
*First I need to get the data from the legacy system to an internal table, then into a BDCDATA internal table from which I need to
*map the data into a Module Pool dialog transaction from which I need to migrate the data to SAP itself.
*First I need to analyse the file containing the data - in my case it will be a text file stored locally with the customer data with
*three fields - customer number, country code and customer name. The target database table is thus KNA1.
*The file looks like that:
********************
*666xyz  KA  Dedenne
*729abc  KT  Cubone
*695tal  JH  Cyndaquil
********************
*To perform the Call Transaction technique, I need a module pool transaction. Hence I need to develop a module pool program. I go
*to SE80 and create a new program ('Z_BM_TEST_MPP9' in this case) with the TOP INCLUDE, it's 'Type' being 'Module Pool'. Then I
*create a screen (100), its 'Screen Type' being 'Normal'. Then I move to the 'Layout' so design the screen's layout. In this screen
*I need three fields - 'kunnr', 'land1' and 'name1' of the table KNA1 so I choose GoTo -> Secondary Window -> Dictionary/Program Fields
*provide the name of KNA1, take the three fields I require and place them in my screen.
*Now I move to create three buttons and draw them beneath the screen fields. The first one's name is 'B1', text 'Insert' and function
*code 'FC1', the second one is 'B2', 'Exit' and 'FC2' and the third 'B3', 'Cancel' and 'FC3'. The third is to act as a cancel button and
*so I also need to set the 'FctType' (function type) property to 'E Exit command' - this will allow me to perform a forecfull exit which
*means that even a failure to provide the obligatory input fields with values will not prevent the end-user from leaving the program.

*The idea of the Call Transaction technique is that, when the program is executed its Module Pool part's screen will be repeatedly called
*for every record  (thanks to the 'CALL TRANSACTION' part) separately during runtime, that record's data being inserted into the prepared 
*screen fields and the end-user will decide what to do - either 'Insert' the data or 'Cancel' it. The Call Transaction technique allows 
*for all the validations to take place, unlike the Direct Input Method of migrating the data. Every record needs to pass through the 
*transaction so SAP will perform the Automatic Field Validation, Flow Logic Validation and Module Pool Validation.

*When a screen button is pushed in a Module Pool program, the PAI event is triggered. Thus I move to the flow logic section of screen 100, 
*uncomment the 'user_command_0100' module, double-click it, place it within the TOP INCLUDE and proceed to write the logic for the buttons.
*The area for the 'FC1' function code is left void so far, it will be done later. The 'FC2' function code is responsible for the
*"gracious" exit - one that will not be possible if any validation in the screen is failed.
*The "forceful" exit - one that will be possible even if there are failed validations in the screen requires me to define a separate
*module in the flow logic section of the screen. This module will be executed when a button with the function type of 'E' is pressed.
*Thus I create the 'exit_forcefully' module in the PAI event and define it within the TOP INCLUDE. The logic is the same as in the case
*of the "gracious" exit but the "forceful" requires a module with the AT EXIT-COMMAND part.
*The flow logic section of screen 100 looks like this so far:
**********************************************************************
PROCESS BEFORE OUTPUT.
* MODULE STATUS_0100.
*
PROCESS AFTER INPUT.
 MODULE USER_COMMAND_0100.
 MODULE exit_forcefully AT EXIT-COMMAND.
**********************************************************************

*The 'user_command_0100' looks like that:
**********************************************************************
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'FC1'.

    WHEN 'FC2'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
**********************************************************************

*And the 'exit_forcefully' module looks like that:
**********************************************************************
MODULE exit_forcefully INPUT.
  CASE sy-ucomm.
    WHEN 'FC3'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
**********************************************************************

*Now I create the transaction for the program. Its name is 'ZBMI10' and its 'Start object' is 'Program and dynpro (dialog transaction'
*as is always the case for Module Pool programs. Next I need to provide the name of my program ('Z_BM_TEST_MPP9') and the screen
*number (0100). I also need to check the 'SAP GUI for Windows' checkbox in the 'GUI support' section.

*Here I am inserting one record at a time. In order to store the data provided in the screen, I need to declare a work area with
*the type compatibility with KNA1. I will be collecting the data from the screen fields and their names are 'kna1-kunnr',
*'kna1-land1' and 'kna1-name1'. Thus I can simply declare 'TABLES kna1' and that statement will both create the correct work area,
*compatibile with the KNA1 database table AND serve as the explicit declaration of my program's screen fields.
*So now, when the 'Insert' button is pressed (so if the function code is 'FC1') I can simply state 'MODIFY kna1'. That's it. I don't
*need to specify 'FROM kna1' because the work area's name is exactly the same as database table's name. 'FROM kna1' is thus inferred.
*As per the aforementioned idea of the Call Transaction technique - that the Module Pool screen is to be called separately for every
*record that needs to be processed - whatever operation takes place at this stage, I need to 'LEAVE PROGRAM' so the control leaves the 
*Module Pool screen, goes back here (to the executable part of the program) and into the loop (that will be created earlier) which will
*start processing the next record and call the Module Pool screen again but for that next record.
*The top part of my TOP INCLUDE now looks like this:
**********************************************************************
PROGRAM Z_BM_TEST_MPP9.

TABLES: kna1.
**********************************************************************

*And the 'user_command_0100' looks like that:
**********************************************************************
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'FC1'.
      MODIFY kna1.
      IF sy-subrc = 0.
        MESSAGE 'A record has been affected.' TYPE 'I'.
      ELSE.
        MESSAGE 'A record has not been affected.' TYPE 'I'.
      ENDIF.
      LEAVE PROGRAM.
    WHEN 'FC2'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
**********************************************************************

*The recommended way of doing the above is a BAPI instead of MODIFY, INSERT statements.

*Now, that the Module Pool program is complete, I need to perform the actual Call Transaction technique to migrate the data from the
*legacy system. First, I need to read the data from the legacy system into an internal table. The data is stored within the 'POKE2'
*text file. A tab is the separator. *To proceed, I now need to create an executable program (SE38).

*Below begins the structure of the aforementioned executable program.
*To begin with I am to read data from the local text file and into an internal table which I am declaring.
TYPES: BEGIN OF t_kna1,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kna1-land1,
  name1 TYPE kna1-name1,
END OF t_kna1.
DATA: lt_kna1     TYPE TABLE OF t_kna1,
      lwa_kna1    TYPE t_kna1,
*Below is an internal table of the type of a standard SAP structure that is used in this technique of migrating the data. When
*the data is loaded from the legacy system's local text file and into the 'lt_kna1' internal table, I will be mapping that data
*from 'lt_kna1' to the below table.
      lt_bdcdata  TYPE TABLE OF bdcdata,
      lwa_bdcdata TYPE bdcdata.

*Now I need to read the data from the local text file. I am to use the 'GUI_UPLOAD' function module for it. The path to the file
*is hardcoded. I need to inform the function module that the field separator (tab) is indeed present.
CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename                      = 'C:\Users\bartosz.mierzwinski\Desktop\POKE2.txt'
    has_field_separator           = 'X'
  TABLES
    data_tab                      = lt_kna1.

*When the data is present within 'lt_kna1', I am to map the data to the BDCDATA internal table. BDCDATA is a standard SAP structure
*(like SCREEN). If the data is indeed present within 'lt_kna1', I need to map it to 'lt_bdcdata'. I am using PERFORMs here for the
*sake of modularization. My first PERFORM is taking two parameters - the module pool program's name and the screen's number. This
*PERFORM will set the 'lt_bdcdata's' fields that are shared by all the records.
*The second PERFORM - 'map_field_data' populates the 'fnam' and 'fval' fields of the BDCDATA structure. It is called to action for
*every field.
*After all PERFORMs have finished their task for the particular record - the data of that record is successfully mapped to the
*BDCDATA internal table and now I need to call the transaction I created before ('ZBMI10') and provide it with the BDCDATA internal
*table.
IF lt_kna1 IS NOT INITIAL.
  LOOP AT lt_kna1 INTO lwa_kna1.
    PERFORM map_program_data USING 'Z_BM_TEST_MPP9' '100'.
    PERFORM map_field_data USING 'KNA1-KUNNR' lwa_kna1-kunnr.
    PERFORM map_field_data USING 'KNA1-LAND1' lwa_kna1-land1.
    PERFORM map_field_data USING 'KNA1-NAME1' lwa_kna1-name1.
    CALL TRANSACTION 'ZBMI10' USING lt_bdcdata.
  ENDLOOP.
ENDIF.

*&---------------------------------------------------------------------*
*&      Form  MAP_PROGRAM_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*The two passed parameters 'Z_BM_TEST_MPP9' and '100' are received in formal parameters 'p_prgname' and 'p_scrnr' respectively.
*The BDCDATA structure expect me to provide it with five fields per record - 'program', 'dynpro', 'dynbegin', 'fnam' and 'fval'.
*Both 'program' and 'dynpro' are present within the PERFORM due to the parameters passed. 'dynbegin' is an indicator of the
*occurence of a new screen.
FORM map_program_data USING p_prgname p_scrnr.
  REFRESH lt_bdcdata.
  CLEAR lwa_bdcdata.
  lwa_bdcdata-program = p_prgname.
  lwa_bdcdata-dynpro = p_scrnr.
  lwa_bdcdata-dynbegin = 'X'.
  APPEND lwa_bdcdata TO lt_bdcdata.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  MAP_FIELD_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM map_field_data USING p_field_name p_field_value.
  CLEAR lwa_bdcdata.
  lwa_bdcdata-fnam = p_field_name.
  lwa_bdcdata-fval = p_field_value.
ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------