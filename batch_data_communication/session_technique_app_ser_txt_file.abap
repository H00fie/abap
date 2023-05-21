*---------------------------------------------------------------------------------------------------------------------------------
*MIGRATING DATA FROM A TEXT FILE STORED IN APPLICATION SERVER USING THE SESSION METHOD.
*---------------------------------------------------------------------------------------------------------------------------------

*Application server is where SAP is installed. If I want to know the IP Address of my application server I need to go to SAP Logon
*and right-click the name of the server  (e.g. BOD, QMR, MMX) and go to its 'Properties'. I have the Application Server's IP address
*here, e.g. 666.666.666.666. I can access the Application Server's drive from my local system by running the Run command
*(Windows key + R) and providing e.g. "\\666.666.666.666\c" .
*I am most likely going to be asked for the admin's ID and password. The data will be uploaded from a text file stored in the
*Application server - it contains the customer data and looks like this:
********************
*666xyz,KA,Dedenne
*729abc,KT,Cubone
*695tal,JH,Cyndaquil
********************
*The Session technique is similar to the Call Transaction technique but has one additional level. First the data is uploaded from
*the legacy system to an internal table. Then it is mapped from that table to a BDCDATA internal table, but before the data is
*further mapped to the Module Pool transaction, it is mapped from the BDCDATA structure to a Session Object from which the data
*is mapped to the Module Pool transaction.

*To perform the Session technique, I need a module pool transaction. Hence I need to develop a module pool program. I go to SE80
*and create a new program ('Z_BM_TEST_MPP10' in this case) with the TOP INCLUDE, it's 'Type' being 'Module Pool'. Then I create a
*screen (100), its 'Screen Type' being 'Normal'. Then I move to the 'Layout' so design the screen's layout. In this screen I need
*three fields - 'kunnr', 'land1' and 'name1' of the table KNA1 so I choose GoTo -> Secondary Window -> Dictionary/Program Fields
*provide the name of KNA1, take the three fields I require and place them in my screen.
*Now I move to create three buttons and draw them beneath the screen fields. The first one's name is 'B1', text 'Insert' and function
*code 'FC1', the second one is 'B2', 'Exit' and 'FC2' and the third 'B3', 'Cancel' and 'FC3'. The third is to act as a cancel button and
*so I also need to set the 'FctType' (function type) property to 'E Exit command' - this will allow me to perform a forecfull exit which
*means that even a failure to provide the obligatory input fields with values will not prevent the end-user from leaving the program.

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

*Now, that the Module Pool program is complete, I need to perform the actual Session technique to migrate the data from the legacy
*system. First, I need to read the data from the legacy system into an internal table. The data is stored within within a text file in
*an application server. A comma is the separator. To proceed, I now need to create an executable program (SE38).

*Below begins the structure of the aforementioned executable program.
*If the file was stored locally, I could use the 'GUI_UPLOAD' function module to load the data. However it is placed in an application
*server so I declare a variable to store the path to the file which includes the IP address of the application server. 'hedgehog.txt'
*is my file. The 'lv_msg' variable is here to store the possible return message if the reading of the file has not been successful.
*The internal table 'lt_legacy' is the one I will be loading the data into from the legacy system's file.
DATA: lv_path TYPE string VALUE '\\666.666.666.666\c\hedgehog.txt',
      lv_msg  TYPE string.
TYPES: BEGIN OF t_legacy,
  str TYPE string,
END OF t_legacy.
DATA: lt_legacy  TYPE TABLE OF t_legacy,
      lwa_legacy TYPE t_legacy.
*The final internal table is where the above internal table 'lt_legacy' will be chucking the data over. While 'lt_legacy' has one
*field of the string type because it just takes in the "raw" lines of text from the legacy system's file in their entirety, the
*'lt_final' table needs to have a structure that differentiates between the desired fields ('kunnr', 'land1', 'name1' in my case).
TYPES: BEGIN OF t_final,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kna1-land1,
  name1 TYPE kna1-name1,
END OF t_final.
DATA: lt_final  TYPE TABLE OF t_final,
      lwa_final TYPE t_final.
*I also need an internal table of the BDCDATA type. In this case my session object will be giving it the data.
DATA: lt_bdcdata  TYPE TABLE OF bdcdata,
      lwa_bdcdata TYPE bdcdata.

*If the file containing the data is stored locally (so in the "presentation server"), I can use the 'GUI_UPLOAD' function module to
*upload the data, but reaching the file in the application system requires a different mechanism. The OPEN DATASET statement allows
*me to reach the application server, the FOR INPUT part means it's for reading, the IN TEXT MODE means the reading will be done
*line by line. The MESSAGE part of the statement needs to be followed by a variable of the string type. If the file I am trying to
*reach is not reached, the operating system's message will be stored within that variable.
OPEN DATASET lv_path FOR INPUT IN TEXT MODE ENCODING DEFAULT MESSAGE lv_msg.

*If the program has failed to open the file, the appropriate message is contained within the 'lv_msg' variable, so if the 'sy-subrc'
*is not 0, I simply display the message as it tells the end-user what went wrong. If the file has been reached properly, I need to
*start reading it from the first line to the last line. I don't know how long is the file so, to make sure, all the records are read,
*I am writing the logic for reading the file's content within a loop (DO..ENDO LOOP) that is going to be finished only when the reading
*of a line has failed, so when 'sy-subrc' is not 0. If it has been successful and the line has been placed within my work area, I am
*appending the current content of the work area to my internal table. The 'READ DATASET lv_path' changes the lines of the file it reads
*thanks to the concept of the "file pointer". If the file has been successfully read, the file pointer is placed at the beginning of the
*first line. The loop is entered. The 'READ DATASET' statement reads the entire line of the file because it has been opened in the
*'TEXT MODE'. If the reading operation was successful, 'sy-subrc' is set to 0, the content of the work area is appended to the internal
*table and the file pointer automatically goes to the next row of the file because it is within a loop. It will keep repeating over and
*over again until there are no more records to read which is indicated by the failure ('sy-subrc' not being 0) of the READ DATASET. When
*that happenes, the EXIT keyword will make the control leave the current loop.
*When all the lines of the file have been read and the loop is finished, I should use the statement of 'CLOSE DATASET' to close the
*file that I was reading. It should be done before leaving the loop altogether.
IF sy-subrc = 0.
  DO.
    CLEAR lwa_legacy.
    READ DATASET lv_path INTO lwa_legacy-str.
    IF sy-subrc = 0.
      APPEND lwa_legacy TO lt_legacy.
    ELSE.
      CLOSE DATASET lv_path.
      EXIT.
    ENDIF.
  ENDDO.
ELSE.
  WRITE: / lv_msg.
ENDIF.

*Now, if my temporary internal table indeed has records within it, I need to transfer the data from it to the final internal table.
*I iterate through 'lt_legacy' and for every single one of its records, I am performing the operation of splitting that record at
*every occurence of a comma (since the initial text file had its data organised in this way) and placing the part of the string that
*was split first in 'lt_final's' work area's 'kunnr' field, then in the 'land1' field and then in the 'name1' field. The order of
*the fields is deliberate because that's how the data in the initial text file was organised. If it had the data starting with, say,
*the customer's name, then the 'name1' field should be the first to appear after the INTO keyword. At the end, I am appending the
*data stored within the work area to 'lt_final' and starting the loop anew for the next record of 'lt_legacy'.
IF lt_legacy IS NOT INITIAL.
  LOOP AT lt_legacy INTO lwa_legacy.
    CLEAR lwa_final.
    SPLIT lwa_legacy-str AT ',' INTO lwa_final-kunnr
                                     lwa_final-land1
                                     lwa_final-name1.
    APPEND lwa_final TO lt_final.
  ENDLOOP.
ENDIF.

*Now, before I map the data to the BDCDATA intenal table, I need to create the session object given the 'lt_final' internal table
*indeed has values stored within it. To do it, I need to utilize the 'BDC_OPEN_GROUP' function module. The 'group' property is the
*name of the session object and can be named whatever. The 'holddate' property indicates until when the object is not processable.
*The 'keep' property with the 'X' means the session object will be available even after processing.
IF lt_final IS NOT INITIAL.
  CALL FUNCTION 'BDC_OPEN_GROUP'
    EXPORTING
      CLIENT                    = SY-MANDT
      GROUP                     = 'S1'
      HOLDDATE                  = '20230530'
      KEEP                      = 'X'
      USER                      = SY-UNAME.

*Now to map the data from 'lt_final' to 'lt_bdcdata'. To populate the BDCDATA structure, I need to map the program's information
*first and then map the individual fields. To map the program's information, I create the 'map_program_info' perform which is
*USING my module pool program's name and its screen's number.
*Afterwards I need to map all the fields' data as well. My perform takes in the name of the field and the value of the field as
*parameters.
  LOOP AT lt_final INTO lwa_final.
    PERFORM map_program_info USING 'Z_BM_TEST_MPP10' '100'.
    PERFORM map_field_info USING 'KNA1-KUNNR' lwa_final-kunnr.
    PERFORM map_field_info USING 'KNA1-LAND1' lwa_final-land1.
    PERFORM map_field_info USING 'KNA1-NAME1' lwa_final-name1.
*In case of the Call Transaction technique, when the BDCDATA structure is populated, I call the transaction directly
*(CALL TRANSACTION <program_same> USING <my_bdcdata_internal_table). In case of the Session technique, I need to map the data to
*the session object first. In order to do it, I use the 'BDC_INSERT' function module. I need to provide it with the transaction
*code of the module pool part of my program ('ZBMI11') and the name of the BDCDATA internal table I populated with the data
*previously.
    CALL FUNCTION 'BDC_INSERT'
      EXPORTING
        TCODE                  = 'ZBMI11'
      TABLES
        DYNPROTAB              = lt_bdcdata.   
  ENDLOOP.
  
*When all the data has been processed (the loop ended), I should close the session object. The 'BDC_CLOSE_GROUP' function module
*does not require any parameters and is smart enough to know what session object I want closed.
  CALL FUNCTION 'BDC_CLOSE_GROUP'.
ENDIF.

*When the program here is executed the transaction will NOT be displayed like it was in case of the Call Transaction technique.
*Instead of calling the transaction after having populated the BDCDATA structure, I am mapping the data to the session object and
*executing the program creates that session object. In order to process the session object, I need to go to the SM35 transaction.
*I should see 'Batch Input: Session Overview' at the top of the screen and my session object in the table control below. In case
*of my program here, I should see the 'Lock Date' field with the value of 30.05.2023 because when creating the session object with
*the help of the 'BDC_OPEN_GROUP' function module I set the 'HOLDDATE' property to that date. If I want to process the session
*object, I need to press the 'Process' button (F8). If I tried to do that before 30.05.2023, I wouldn't be able to due to the
*lock date being set. I can unlock the object by pressing the 'Unlock' button in the application toolbar in SM35 (or simply by
*not adding any 'HOLDDATE' in the frist place).
*When I hit the 'Process' button and there's no active lock, SAP will ask me whether I want to process the session object in the
*'foreground' or 'background' mode. If I check the 'Process/foreground' radiobutton and push the 'Process' button, my module pool
*transaction will be triggered and I will be at the same stage I would be in if I used the CALL TRANSACTION statement after
*having populated the BDCDATA structure.
*When all the data has been processed, I should see a pop-up window with a text message of 'Processing of batch input session
*completed'. If I choose the 'Session overview' button I will be taken back to SM35. My session object should have a white box
*with a green checkmark icon in the 'Status' columns which means the session object is processed. I am still able to see the session
*object here even after the processing because while I was creating the session object I set the 'KEEP' property to 'X'. Without
*it, the session object would not be visible here after the processing. I think it's a good idea to have the 'KEEP' property have
*the 'X' value because that will allow me to see the log.

*An advatnge of the session technique is that a log is generated automatically here. If my session object is still here after the
*processing (if it's been KEPT, hehe), I can choose the 'Log' option from the application toolbar. Then I can go deeper by choosing
*the 'Analyze session' button. Here I have a tab called 'Log created on <date>'. If I enter that tab I can see the entire history
*of processing the session object. E.g. if there were any errors on the way, e.g. one of the records had a country code unknown to
*SAP, I will see a proper message here within the log, informing me what went wrong. The changes made in the screen are neatly
*tracked here, e.g. I have the information at what exact time the 'KNA1-KUNNR' screen field changed the value from one to another.

*The Session technique is not an immediate process, while the Call Transaction technique acts immediately. In case of the Session
*technique the data is held within the session object and I can process it at a later point in time by accessing SM35.
*The Call Transaction technique is an asynchronous process while the Session technique is a synchronous process. In case of a
*synchronous process internally an acknowledgement is noted after every record has been processed and the next record is processed
*only after said acknowledgement has been noted. In case of an asynchronous process, no such acknowledgement is had SAP immediately
*starts processing the next record after being done with the previous one. The Call Transaction technique is thus faster than the 
*Session technique.
*On the other hand, in case of the Session technique an automatic log is generated which I can analyse later. If I want a log with
*the Call Transaction I would need to generate it manually.

*&---------------------------------------------------------------------*
*&      Form  MAP_PROGRAM_INFO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*The internal table itself is refreshed because, after all the program's data and all the fields' data have been placed within,
*the module pool part of the program is called using that table, the data housed within is placed into proper screen fields based
*on the fields' names that the BDCDATA structure is provided with and when the record is processed, the cycle repeats itself so
*the BDCDATA structure is always to contain just one record at a time.
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
FORM map_field_info USING p_field_name p_field_value.
  CLEAR lwa_bdcdata.
  lwa_bdcdata-fnam = p_field_name.
  lwa_bdcdata-fval = p_field_valie.
  APPEND lwa_bdcdata TO lt_bdcdata.
ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------