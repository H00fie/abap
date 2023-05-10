*---------------------------------------------------------------------------------------------------------------------------------
*SELECT-OPTIONS.
*---------------------------------------------------------------------------------------------------------------------------------

*The purpose of SELECT-OPTIONS is to read a range of values from the user. I want an MP program that will accept the input of 
*customers' numbers in the form of SELECT-OPTIONS and display the sales orders of the provided customers in the form of TABLE 
*CONTROL. The TABLE CONTROL is a good choice because it will make it possible to have multiple sales orders displayed.
*If I simply used the SELECT-OPTIONS statement, a selection screen for reading a range of values would be automatically generated,
*much like using the PARAMETERS statement generates a selection screen for reading a single value.
*The thing is, if I want to have the SELECT-OPTIONS as part of my MP program, I am going to need to join the selection-screen
*programming with the module pool programming.
*I need to begin creating my program not in the object navigator (SE80), but in SE38 - it needs to be a regular executable program.
*I name it 'Z_BM_TEST_MPP8', provide a short description and set the 'Type' to 'Executable program' within the 'Attributes' section.
*I create the initial version of my program - so far, this will generate a selection screen:
**********************************************************************
REPORT Z_BM_TEST_MPP8.

DATA: lv_kunnr TYPE kna1-kunnr.
SELECT-OPTIONS so_kunnr FOR lv_kunnr DEFAULT '1000' TO '1010'.
**********************************************************************

*I do not want a selection screen as I also want the TABLE CONTROL component to be included and thus I need to make this an MP
*program. I need to work around this as SELECT-OPTIONS will always generate a selection screen.
*To make it happen, I can make the SELECT-OPTIONS statement be a part of the subscreen, like that:
**********************************************************************
SELECTION-SCREEN BEGIN OF SCREEN 100 AS SUBSCREEN.
  SELECT-OPTIONS so_kunnr FOR lv_kunnr DEFAULT '1000' TO '1010'.
SELECTION-SCREEN END OF SCREEN 100.
**********************************************************************

*By doing that, if I execute my program now, no selection screen will be generated. Now I am delving into handling Module Pool
*screens. In order to have my subscreen displayed, I need a normal screen. Thus, I 'CALL SCREEN 200' and double-click the number.
**********************************************************************
CALL SCREEN 200.
**********************************************************************

*I provide a short description and make sure the 'Screen Type' is 'Normal'. In order for my normal screen to be able to contain
*a subscreen, I need to provide it with a subscreen area. Hence, I go to 'Layout'. I choose the 'Subscreen Area' button from the
*toolbox (the fourth from the bottom) and draw my subscreen area. It's name is 'SAREA'. I also draw two pushbuttons. The first
*one's name is 'B1', text is 'Get sales orders' and the function code is 'FC1'. The second's parameters are 'B2', 'Exit' and 'FC2'.
*Now I move to write the logic of the 'Exit' button. Whenever a button is pushed, the PAI event is triggered. Thus I uncomment
*the 'user_command_0200' module in the flow logic section of screen 200 and double-click it. I do not have the TOP INCLUDE here
*so I choose the main program ('Z_BM_TEST_MPP8') as the destination. The module will hence be written in SE38.
**********************************************************************
MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN 'FC2'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
**********************************************************************

*I do not need to create the transaction code because this is a report program/an executable program (written in SE38). The
*SELECT-OPTIONS was moved into a subscreen will not generate a selection screen automatically anymore. Right now, if I executed
*the program, I would get a Module Pool screen with the two buttons I created. That is because of the 'CALL SCREEN 200' within
*my code. A selection screen is not being generated because the SELECT-OPTIONS statement is placed within a subscreen and a
*Module Pool screen is displayed instead... because I am calling it.
*Whenever a Module Pool screen is called the first event triggered is PBO. I need to inform SAP here that I want my subscreen
*'SAREA' displayed here. The INCLUDING keyword is followed by the name of the program where the subscreen is to be displayed
*(which is the calling program, so 'sy-repid') and the number of the subscreen.
*The entire flow logic section of screen 200 looks like this:
**********************************************************************
PROCESS BEFORE OUTPUT.
  CALL SUBSCREEN sarea INCLUDING sy-repid '100'.

PROCESS AFTER INPUT.
 MODULE USER_COMMAND_0200.
**********************************************************************

*The result is a Module Pool screen and not a selection screen. At this point trying to select the 'Multiple selection'
*button will result in nothing and changing the default values ('1000' and '1010') in the input boxes and pressing Enter will
*result in default values being reintroduced. This is because so far the subscreen is being called only in PBO. To make it
*work correctly I need the subscreen called within the PAI event as well. It is the same situation as with the TABLE CONTROL
*which requires me to have LOOP...ENDLOOP in both MP events.
*The entire flow logic section of screen 200 looks like this:
**********************************************************************
PROCESS BEFORE OUTPUT.
  CALL SUBSCREEN sarea INCLUDING sy-repid '100'.

PROCESS AFTER INPUT.
  CALL SUBSCREEN sarea.
  MODULE USER_COMMAND_0200.
**********************************************************************

*Now I need to implemenet the TABLE CONTROL component. I go to the 'Layout' of screen 200 and choose the 'Table Control'
*button from the toolbox (the fourth from the bottom) and draw the table control below the previously created subscreen. I name
*the component 'TBCTRL' and check the 'Vertical' and 'Horizontal' checkboxes under the 'Separators' part of the 'Attributes'
*section. I need columns within my table control so I choose GoTo, Secondary Window and Dictionary/Program Fields. I provide the
*name of my custom VBAK structure ('zbmierzwi_test_vbak_struct') that has only the four fields that I desire. My custom structure
*looks like this within the dictionary:
*- VBELN type VBELN_VA,
*- ERDAT type ERDAT,
*- ERZET type ERZET,
*- ERNAM type ERNAM.
*I select all the fields and drop the structure within my table control component. It is also required that both the PBO and PAI
*events contain the LOOP statement. Without it being done, I will get a compilation error. Initially it is enough simply to declare
*a loop without anything in it.
*The entire flow logic section of screen 200 looks like this:
**********************************************************************
PROCESS BEFORE OUTPUT.
  CALL SUBSCREEN sarea INCLUDING sy-repid '100'.
  LOOP.
  ENDLOOP.            "WARNING - SAP still reports there is an error here and does not want to activate. I think I cannot have an
* MODULE STATUS_0200. "          empty loop after all. I need to loop through something.
*
PROCESS AFTER INPUT.
  CALL SUBSCREEN sarea.
  MODULE USER_COMMAND_0200.
  LOOP.
  ENDLOOP.
**********************************************************************
  
*Although if I tried to execute my program now, I would still get an error - a runtime one. That is because if I am calling a
*screen that has a table control component, I need to declare that component explicitly.
*The upper part of my program ('Z_BM_TEST_MPP8') now looks like this:
**********************************************************************
REPORT Z_BM_TEST_MPP8.

DATA: lv_kunnr TYPE kna1-kunnr.

CONTROLS: tbctrl TYPE TABLEVIEW USING SCREEN 200.
**********************************************************************

*Now, when an end-user pushes the 'Get sales orders' button, the PAI event is triggered and I should fetch the relevant data
*into an internal table. Then I need to loop through that table and load the data into the table control component. To that
*end, I first declare the internal table.
*The upper part of my program ('Z_BM_TEST_MPP8') now looks like this:
**********************************************************************
REPORT Z_BM_TEST_MPP8.

DATA: lv_kunnr TYPE kna1-kunnr.
CONTROLS: tbctrl TYPE TABLEVIEW USING SCREEN 200.
TYPES: BEGIN OF t_sales.
  INCLUDE TYPE zbmierzwi_test_vbak_struct.
TYPES END OF t_sales.
DATA: lt_sales  TYPE TABLE OF t_sales,
      lwa_sales TYPE t_sales.
**********************************************************************

*As mentioned, the clicking of the button will make the PAI event be triggered and there my module 'user_command_0200' decides
*what action is to be undertaken. The 'Get sales orders' button has the function code 'FC1' assigned to it, so when 'sy-ucomm'
*holds that value, I need to fetch the relevant data into my internal table based on the range of data the end-user has provided
*as input. When the 'sy-ucomm' variable contains the value of 'FC1' I am first making sure the input fields (select-options) are
*not initial. Perhaps the user is pushing the button without providing any input and it's reduntant to perform any operation. If
*the input has been indeed provided, I am selecting the data for my table control into my internal table with the condition of the
*particular record's KUNNR being present within the range of values provided by the end-user. If any data has been found, so if 
*the 'sy-subrc' variable equals 0, I refer to my table control component's 'line' property and set it to the number of records 
*that has been found. The 'sy-dbcnt' variable contains the number of records that have been retrieved by the previous SELECT
*statement. This actions allows the potentional vertical scrolling should the number of records demand it.
*The 'user_command_0200' module now looks like this:
**********************************************************************
MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN 'FC2'.
      LEAVE PROGRAM.
    WHEN 'FC1'.
      IF so_kunnr IS NOT INITIAL.
        SELECT vbeln erdat erzet ernam
          FROM vbak
            INTO lt_sales
              WHERE kunnr IN so_kunnr.
        IF sy-subrc = 0.
          tbctrl-lines = sy-dbcnt.
        ENDIF.
      ENDIF.
  ENDCASE.
ENDMODULE.
**********************************************************************

*Now I need to move the fetched data from my internal table to the table control. When the PAI event is finished, the control goes
*to the PBO event. Now comes the time for me to actually utilize the LOOP statement within PBO. I am iterating through my internal
*table with 'WITH CONTROL <table control name>' added at the end. Within the loop I am writing the logic that assigns every record's
*data to the table control's fields. This works despite the actual table control not being mentioned by its name ('tbctrl') because 
*the screen fields created in the Screen Painter tool are called 'zbmierzwi_test_vbak_struct-vbeln', 'zbmierzwi_test_vbak_struct-erdat',
*'zbmierzwi_test_vbak_struct-erzet' and 'zbmierzwi_test_vbak_struct-ernam' and so when I mention them, from my program's perspective, 
*I am talking about my table control's fields. 'CLEAR zbmierzwi_test_vbak_struct' will clear the work area as 'zbmierzwi_test_vbak_struct'
*needs to be declared, I am declaring it with the usage of the keyword TABLES which automatically creates a work area.

*The upper part of my program ('Z_BM_TEST_MPP8') now looks like this:
**********************************************************************
REPORT Z_BM_TEST_MPP8.

DATA: lv_kunnr TYPE kna1-kunnr.
CONTROLS: tbctrl TYPE TABLEVIEW USING SCREEN 200.
TYPES: BEGIN OF t_sales.
  INCLUDE TYPE zbmierzwi_test_vbak_struct.
TYPES END OF t_sales.
DATA: lt_sales  TYPE TABLE OF t_sales,
      lwa_sales TYPE t_sales.
TABLES: zbmierzwi_test_vbak_struct.
**********************************************************************
 
*The 'transfer_data' module looks like this:
**********************************************************************
MODULE transfer_data OUTPUT.
  CLEAR zbmierzwi_test_vbak_struct.
  zbmierzwi_test_vbak_struct-vbeln = lwa_sales-vbeln.
  zbmierzwi_test_vbak_struct-erdat = lwa_sales-erdat.
  zbmierzwi_test_vbak_struct-erzet = lwa_sales-erzet.
  zbmierzwi_test_vbak_struct-ermam = lwa_sales-ernam.
ENDMODULE.
**********************************************************************

*I would like to display the number of sales orders found. In order to do it, I go to the 'Layout' of screen 200 and draw a 'Text Field'
*next to the table control component. It's name is 'T1' and text 'Number of sales orders is:'. Then I draw a 'Input/Output Field' next
*to it and give it the name of 'IO1' and change the 'Format' property within the 'Attributes' section to 'INT4'. This field should be
*filled with the fetching of the data because it's dependent on it. I also need to declare that screen field explicitly as I am going
*to refer to it. The data type of 'io1' is 'i' because that's what I set when I changed the 'Format' property to 'INT4'. Then the 'io1'
*is assigned value after the data has been fetched in the 'user_command_0200' module.

*The 'user_command_0200' module now looks like this:
**********************************************************************
REPORT Z_BM_TEST_MPP8.

DATA: lv_kunnr TYPE kna1-kunnr.
CONTROLS: tbctrl TYPE TABLEVIEW USING SCREEN 200.
TYPES: BEGIN OF t_sales.
  INCLUDE TYPE zbmierzwi_test_vbak_struct.
TYPES END OF t_sales.
DATA: lt_sales  TYPE TABLE OF t_sales,
      lwa_sales TYPE t_sales.
TABLES: zbmierzwi_test_vbak_struct.
DATA: io1 TYPE i.
**********************************************************************

*The 'user_command_0200' looks like this:
**********************************************************************
MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN 'FC2'.
      LEAVE PROGRAM.
    WHEN 'FC1'.
      IF so_kunnr IS NOT INITIAL.
        SELECT vbeln erdat erzet ernam
          FROM vbak
            INTO TABLE lt_sales
              WHERE kunnr IN so_kunnr.
        IF sy-subrc = 0.
          tbctrl-lines = sy-dbcnt.
          io1 = sy-dbcnt.
        ENDIF.
      ENDIF.
  ENDCASE.
ENDMODULE.
**********************************************************************

*At the moment the field displaying the number of records fetched is available for providing input which should not be the case. The
*field should only display the number without allowing the end-user to interfere with said number. To that end, I go to the 'Layout'
*of screen 200, double-click the input field 'IO1' and select the checkbox 'Output Only' within the 'Attributes' section.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------