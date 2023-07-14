*---------------------------------------------------------------------------------------------------------------------------------
*MIGRATING DATA FROM A LOCAL EXCEL FILE USING THE CALL TRANSACTION METHOD WITH A MANUAL LOGGING.
*---------------------------------------------------------------------------------------------------------------------------------

*First of all I need to read the data from a local Excel file into an internal table. In case of a text file, I would use the
*'GUI_UPLOAD' function module. In case of an Excel file I should use the 'TEXT_CONVERT_XLS_TO_SAP' function module. It has two
*mandatory parameters. One is of the 'TRUXS_T_TEXT_DATA' type. It is an internal table and the second is of the 'RLGRAP-FILENAME'
*type so it is a field of the 'RLGRAP' structure. That field is of the 'CHAR' type and of the length of 128.
*'TEXT_CONVERT_XLS_TO_SAP' returns a table.

*My Excel file is called 'POKE3' and looks like this:
***************************
*     A   |  B |   C
*-------------------------
*1 666xyz | KA | Dedenne
*-------------------------
*2 729abc | KT | Cubone
*-------------------------
*3 695tal | JH | Cyndaquil
**************************

*First I declare an internal table to receive the data from the local Excel file via the aforementioned function module. I need
*to understand what kind of data I am migrating and which SAP's database table and what fields of it should that data go to. I
*recognised here I am dealing with customer data. I have a customer number, country code and customer name. Thus, KNA1 it is as
*it is the customer master data database table of SAP.
TYPES: BEGIN OF t_kna1,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kna1-land1,
  name1 TYPE kna1-name1,
END OF t_kna1.
DATA: lt_kna1  TYPE TABLE OF t_kna1,
      lwa_kna1 TYPE t_kna1,
*The function module I will be using to load the data from the Excel file to my internal table requests a parameter of the
*'TRUXS_T_TEXT_DATA' type.
      lt_truxs TYPE truxs_t_text_data,
*It also required a parameter of the 'RLGRAP-FILENAME' type for the path to the Excel file.
      lv_filename TYPE rlgrap-filename VALUE 'c:\POKE3.xls'.

*The data from the Excel file found due to the provided path ('lv_filename') is loaded into the internal table that has been
*prepared to receive the data into specific fields. If my internal table was constructed in a way that the customer name would
*be the first column, then what is actually a customer number (the first information in the Excel file) would end up in that
*customer name field. The 'lt_truxs' internal table is kind of here for the ride. It is a part of the 'TRUXS' type group so,
*if I am working in an older version of SAP, I might be told that this structure is unknown. If it is so, I need to declare 
*the 'TYPE-POOLS: truxs.' at the top of the program. Once upon a time working with elements belonging to a type group required
*the declaring of that type group. It was the case until version 6.0.
CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
  EXPORTING
    i_tab_raw_data             = lt_truxs
    i_filename                 = lv_filename
  TABLES
    i_tab_converted_data       = lt_kna1.
	
*If the data is indeed present in 'lt_kna1', I need to map that data now to a BDCDATA structure which will then be going to
*the module pool screen which, suprisingly, needs to be created.
*Hence I need to develop a module pool program. I go to SE80 and create a new program ('Z_BM_TEST_MPP10' in this case) with the 
*TOP INCLUDE, it's 'Type' being 'Module Pool'. Then I create a screen (100), its 'Screen Type' being 'Normal'. Then I move to the 
*'Layout' so design the screen's layout. In this screen I need three fields - 'kunnr', 'land1' and 'name1' of the table KNA1 so 
*I choose GoTo -> Secondary Window -> Dictionary/Program Fields and provide the name of KNA1, take the three fields I require and 
*place them in my screen. Now I move to create three buttons and draw them beneath the screen fields. The first one's name is 'B1', 
*text 'Insert' and function code 'FC1', the second one is 'B2', 'Exit' and 'FC2' and the third 'B3', 'Cancel' and 'FC3'. The third 
*is to act as a cancel button and so I also need to set the 'FctType' (function type) property to 'E Exit command' - this will 
*allow me to perform a forecfull exit which means that even a failure to provide the obligatory input fields with values will not 
*prevent the end-user from leaving the program.

*Now I create the logic for the created buttons. Within the flow logic section of screen 100 I uncomment the 'user_command_0100' module
*and define the behaviour for particular function codes. When it's 'FC1' (so when the 'Insert' button has been pressed), the target
*database table is to be modified based on the values present within the screen fields. The syntax 'MODIFY kna1' is enough because I
*declared the 'TABLES kna1' which creates a work area so the 'FROM kna1' part of the MODIFY statement is inferred and the 'TABLES kna1'
*also serves as an explicit declaration of my screen fields because their names are 'KNA1-KUNNR', 'KNA1-LAND1' AND 'KNA1-NAME1'. A
*pop-up window with a message is displayed based on whether the modification was successful or not. If the function code is 'FC2', then
*the 'Exit' button has been pushed and the program should be closed. However this exit will be prevented if any validations have been
*failed in the screen. The 'Cancel' button's ('FC3') logic is defined in a separate module as it has the function type property set to
*'E' ('Exit Command') and thus I need to create a separate module with the 'AT EXIT-COMMAND' addition which handles the function codes
*that had the function type set to 'E'. This button will allow the end-user to leave the program even if the validations have failed.
*The flow lofic section of screen 100 looks like this:
**********************************************************************
PROCESS BEFORE OUTPUT.

PROCESS AFTER INPUT.
 MODULE USER_COMMAND_0100.
 MODULE exit_forcefully AT EXIT-COMMAND.
**********************************************************************

*The TOP INCLUDE looks like this:
**********************************************************************
PROGRAM Z_BM_TEST_MPP10.

TABLES: kna1.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'FC1'.
      MODIFY kna1.
      IF sy-subrc = 0.
        MESSAGE 'A record has been affected.' TYPE 'I'.
      ELSE.
        MESSAGE 'A record has not been affected.' TYPE 'I'.
      ENDIF.
    WHEN 'FC2'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  EXIT_FORCEFULLY  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit_forcefully INPUT.
  CASE sy-ucomm.
    WHEN 'FC3'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
**********************************************************************

*Now I create the transaction for the program. Its name is 'ZBMI11' and its 'Start object' is 'Program and dynpro (dialog transaction'
*as is always the case for Module Pool programs. Next I need to provide the name of my program ('Z_BM_TEST_MPP10') and the screen
*number (0100). I also need to check the 'SAP GUI for Windows' checkbox in the 'GUI support' section.

*Now, that the Module Pool program is complete, I need to populate the BDCDATA structure. In order to do it I need to map the program's
*information first and then map the individual fields. To map the program's information, I create the 'map_program_info' perform which
*is USING my module pool program's name and its screen's number. Afterwards I need to map all the fields' data as well. My perform takes
*in the name of the field and the value of the field as parameters.
*Afterwards I am calling the module pool screen created beforehand with the addition of "USING lt_bdcdata" to ensure that with every
*iteration of the loop, I will have the module pool screen displayed and its fields filled with the data previously mapped into the
*BDCDATA structure. Additionally, the "MESSAGES INTO lt_bdcmsgcoll" addition (hehe) ensures that the internal table will contain all
*the messages' IDs and using these IDs I can collect the messages.
IF lt_kna1 IS NOT INITIAL.
  LOOP AT lt_kna1 INTO lwa_kna1.
    PERFORM map_program_info USING 'Z_BM_TEST_MPP10' '100'.
    PERFORM map_field_info USING 'KNA1-KUNNR' lwa_kna1-kunnr.
    PERFORM map_field_info USING 'KNA1-LAND1' lwa_kna1-land1.
    PERFORM map_field_info USING 'KNA1-NAME1' lwa_kna1-name1.
    CALL TRANSACTION 'ZBMI11' USING lt_bdcdata MESSAGES INTO lt_bdcmsgcoll. 
  ENDLOOP.
ENDIF.

*Now the program works in terms of migrating the data from the Excel file to one of SAP's database tables, but I also want the logging
*to take place. In order to generate a log in the Call Transaction technique I need to employ the Error Handling jutsu. In this case
*at least "Error handling" means "generating a log". Just like I have the BDCDATA structure, SAP has also provided me with the BDCMSGCOLL
*structure and I can use it to collect messages in the SAP system. The structure has first been declared and then populated due to the
*"MESSAGES INTO lt_bdcmsgcoll" code above, in the "CALL TRANSACTION" statement. That operation though provides the BDCMSGCOLL structure
*only with the IDs of the messages and now I need to collect the messages themselves.
*In order to do it I am to iterate through the BDCMSGCOLL structure and for every ID stored within call a standard SAP's function module
*'FORMAT_MESSAGE'. This function module returns a message based on the parameters stored previously within 'lt_bdcmsgcoll'. In order to
*know what fields of the internal table I need to assign to the particular fields of the function module I am comparing their descriptions
*or names, e.g. 'no' wants a number and the BDCMSGCOLL structure has a field called "message number" so this one goes there.
*Previously I have created an internal table - 'lt_log' on which a file with log on the application server will be based. This internal
*table has two fields - one of the string type to store the message and one of the alphanumeric type to store the number of the record. 
*While the function module returns the message, I can simply use 'sy-tabix' to number my records as the system variable auto-increments
*with every iteration of the loop. 
IF lt_bdcmsgcoll IS NOT INITIAL.
  LOOP AT lt_bdcmsgcoll INTO lwa_bdcmsgcoll.
    CLEAR lwa_log.
    CALL FUNCTION 'FORMAT_MESSAGE'
      EXPORTING
        id              = lwa_bdcmsgcoll-msgid
        lang            = sy-lang
        no              = lwa_bdcmsgcoll-msgnr
        v1              = lwa_bdcmsgcoll-msgv1
        v2              = lwa_bdcmsgcoll-msgv2
        v3              = lwa_bdcmsgcoll-msgv3
        v4              = lwa_bdcmsgcoll-msgv4
      IMPORTING
        msg             = lwa_log-msg.
    lwa_log-recno = sy-tabix.  
  ENDLOOP.
ENDIF.

*When my custom internal table ('lt_log') is filled with the collected messages, I need to write the log into local a text file. Much like
*the 'GUI_UPLOAD' function module is used for reading, the 'GUI_DOWNLOAD' function module is used for writing. The 'filename' field is the
*path to where the file is to be created and its name. The 'write_field_separator' field is used to indicate if the separator should be a 
*tab. The 'data_tab' field is the table that contains the information that is to be written. The function module will create a text file
*containing all the previously collected messages.
IF lt_log IS NOT INITIAL.
  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
      filename                        = 'C:\Users\bartosz.mierzwinski\Desktop\test_log'
      write_field_separator           = 'X'
    TABLES
      data_tab                        = lt_log.
ENDIF.

*Now I need to move the file to the application server as per the initial requirement. The 'lv_path' variable is the path to the location
*in the application server where I want the file stored and the name of the file. The 'lv_msg' variable is used by the "MESSAGE(...) part
*of the OPEN DATASET statement. If there is a problem with the creating of the file the operating system's message will be stored within
*'lv_msg'. When I was reaching to an application server in order to read a file, the "FOR INPUT" addition was used. Now I want to write a
*file into the application server so "FOR OUTPUT" it is. 'sy-subrc' will assume the value of 0 if the file is successfully created for
*writing purposes by the "OPEN DATASET(...)" part. I need to actually transfer the data from my internal table to the created file. This
*is done by looping through my internal table that contains the number of every message and the message itself. Within the loop I am
*concatenating both the number and the message to my string variable ('lv_msg') and then, courtesy of the TRANSFER statement, transferring
*every record of the internal table into the file created by the OPEN DATASET statement. When it's done, I need to CLOSE DATASET to close
*the connection.
  DATA: lv_path TYPE string VALUE '666.666.666.666\c\test_log',
        lv_msg  TYPE string.
  OPEN DATASET lv_path FOR OUTPUT IN TEXT MODE ENCODING DEFAULT MESSAGE lv_msg.
*If the creation of the file in the application server is successful...
  IF sy-subrc = 0.
    LOOP AT lt_log INTO lwa_log.
      CLEAR lv_msg.
      CONCATENATE lwa_log-recno lwa_log-msg INTO lv_msg SEPARATED BY space.
      TRANSFER lv_msg TO lv_path.
    ENDLOOP.
    CLOSE DATASET lv_path.
  ELSE.
*If the creation of the file in the application server is not successful - print out the operating system's message to tell me what is wrong.
    WRITE lv_msg.
  ENDIF.
ENDIF.

*The Call Transaction Technique is asynchronous while the Session Technique is synchronous. That means the Call Transaction Technique
*will not wait to see the status of the migrated record before migrating the next one. The Session Technique will check the status of
*the record before migrating another. The Session Technique also automatically generates logs while in the case of the Call Transaction
*Technique I need to create it manually.

*&---------------------------------------------------------------------*
*&      Form  MAP_PROGRAM_INFO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM map_program_info USING p_program_name p_screen_number.
  REFRESH lt_bdcdata.
  CLEAR lwa_bdcdata.
  lwa_bdcdata-program = p_program_name.
  lwa_bdcdata-dynpro = p_screen_number.
  lwa_bdcdata-dynbegin = 'X'.
  APPEND lwa_bdcdata TO lt_bdcdata.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  MAP_FIELD_INFO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM map_field_info USING p_field_name p_field_number.
  CLEAR lwa_bdcdata.
  lwa_bdcdata-fnam = p_field_name.
  lwa_bdcdata-fval = p_field_number.
  APPEND lwa_bdcdata TO lt_bdcdata.
ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------