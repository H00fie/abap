*---------------------------------------------------------------------------------------------------------------------------------
*DESIGNING A NEW TRANSACTION WITH THE SCREEN PAINTER.
*---------------------------------------------------------------------------------------------------------------------------------

*A Transaction is a collection of one or more screens. Let's say I want a single screen Transaction with three fields - the client,
*employee's ID and the employee's name. I want some initial validations - the client field should be disabled and the employee's ID
*field should have a custom Search Help attached to it.
*Designing a new Transaction is called "Module Pool programming". To design a Transaction, I need to use the Screen Painter Tool
*(SE51).
*Firstly, I need to provide the program's name and the 'Screen number'. A Transaction might contain one or more screens and every
*screen should be uniquely identified. All Selection Screen's screen number is 1000. If I wanted to press the 'Create' button now, I
*would be told that the program does not exist.
*Instead, I should go to the Object Navigator (SE80). It is here that I need to start. Developping a new Transaction is Module Pool
*Programming. Whenever I want to engage in Module Pool Programming, in SE80, from the drop-down menu I should choose the 'Program'
*option and provide the name (in my example it's 'z_bm_test_mpp'). I should include the TOP Include when prompted about it. The name
*should be the name of the program the Include is being made for with the addition of '_TOP'. I can just save it now, because the
*type should remain with its default value of 'Module Pool'.
*Now I should create a screen. In order to do it, I need to open the Screen Painter Tool. To do it, I should right-click the program's
*name (in my case it's 'z_bm_test_mpp') -> Create -> Screen. Here SAP asks for the number of the screen. Any number between 1 and 9999
*is valid. Mine has 100. I now need to provide the short description and deicde the 'Screen Type'. The Normal one is good for now.
*Now I need to press the 'Layout' blue arrow in the Application Toolbar.
*Now I am in the Screen Painter tool.
*On the left hand side I have a toolbox. I can paint the 'Input/Output Field' with the third button from the top or the 'Text Field'
*with the second one from the top. After choosing an option, I need to click and draw the desired shape of the box. When I draw the
*'Text Fields' they will initially be filled with stars (the Fëanorian ones no doubt). In the Screen Painter, every Screen Element
*should contain a name. I need to double click on a created box, e.g. a 'Text Field' and provide the name, e.g. 'T1' and the text,
*e.g. 'Client' (if the field is supposed to contain MANDT).
*If I want the fields in my screen to come from a Database Table, I do not need to design all of it manually. Instead, I can choose
*the 'Goto' from the menu, go to 'Secondary Windows' and choose the 'Dictionary/Program Fields' option. Here I need to provide the
*name of the Database Table I want the fields to come from and either press Enter on my keyboard or the 'Get from Dictionary' button
*to the right. The list of the fields available in the Database Table will appear. For every field I can pick the 'Text' - the options
*depend on the labels specified for the specific Data Element. I can also choose what do I want the fields to be copied as - be it
*'Text', 'ChkB' (Checkbox) or 'RadB' (Radiobutton). I can either pick all fields I desire manually or, If I want all of them, I can
*click on the button in the upper-left corner of the list - it will select all fields at once.
*After I have made my choice, I need to select 'Continue' (the green check mark button) and I can decide the location of the boxes
*in my screen. I can move the generated screen elements manually and separately from one another.
*If I create a Pushbutton (another option from the toolbox), apart from the 'Name' and the 'Text', I also need to provide the Function
*Code as every button requires a Function Code. In a report I would attach a Function Code to a button with a USER-COMMAND, but in the
*Screen Painter I have the 'FctCode' option in the panel of my screen element, below 'Name' and 'Text'. It is here that I need to provide
*the Function Code of my choosing, e.g. 'FC1'.
*While report programs can be executed by pressing F8 in SE38, if I tried to execute my Module Pool Program in a similar fashion (right click
*the name of the program in SE80 -> Execute -> Direct Processing), I would get an error asking me to choose an executable object. This
*because Module Pool Programs require a Transaction Code to be executed. I can create one in SE93 and I can get there from SE80 by
*right clicking the name of my program, choosing 'Create' and then 'Transaction'. I need to provide the name of the transaction while
*remembering all custom ones should begin with a letter 'z'. After a mandatory Short Text swoops in, I need to choose the 'Initial Object'.
*If I am creating a Table Maintenance, I need to choose the 'Transaction with parameters' option. If I am creating a Transaction Code
*for an executable program (a report), I need to choose the 'Program and selection screen' option (the selection screen's number is always
*1000). When I am creating a Transaction Code for a Module Pool Program, I need to choose the first option - 'Program and screen'. Afterwards
*I need to provide the name of the program the Transaction Code is supposed to be for. I also should supply the screen number - I can
*browse this option because I defined the screen for my program previously (in my case it's the number of 100).
*Whenever I create a Transaction Code, I should also check the 'SAPGUI for Windows' checkbox in the 'GUI support' block at the bottom.
*If now I tried to execute my Module Pool Program in SE80 by right clicking the name of the program, choosing the 'Execute' and 'Direct
*Processing' options, it would work correctly.
Whenever I create my own screen, the back button (F3) is disabled. I coukd to enable it manually by defining my own GUI Status with
the SET PF-STATUS statement.
I can instead write the logic for my 'Exit' button. If the button is in the Selection Screen (Report Programs) and I click on it, the
event of AT SELECTION-SCREEN is triggered. This is Module Pool Programming though and the event triggered is PAI (Process After Input).
In order to create the logic for my button, I need to double click my screen (in my case it's '0100' within the 'Screens' folder). The
'Element List' tab contains information about my screen's elements. It shows me the names of the elements, their type, coordinates and
others. The 'Flow Logic' tab is the place where I can handle the logic of my button.
When a button is clicked on my screen, the PROCESS AFTER INPUT event is triggered. Every event in the Module Pool Programming is
associated with one or more Modules. Within these Modules, I write the business logic of the events (it's like PERFORMS/FORMS). After
providing the name of the Module (I am using the one suggested by SAP and provided by default - 'MODULE USER_COMMAND_0100') I should
double click it and create it, preferably inside a TOP INCLUDE program.
The code thus created for my 'Exit' button looks as follows:
*****************************************************************
*&---------------------------------------------------------------------*
*& Include Z_BM_TEST_MPP_TOP                                 Pula mod.        Z_BM_TEST_MPP
*&
*&---------------------------------------------------------------------*
PROGRAM Z_BM_TEST_MPP.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
*The Function Code is held within 'sy-ucomm' and in the Screen Painter Tool
*I assigned the code of 'FC1' to my 'Exit' button.
  CASE sy-ucomm.
    WHEN 'FC1'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*****************************************************************

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*FIELDS - DISABLING AND ENABLING, MAKING VISIBLE AND INVISIBLE.
*---------------------------------------------------------------------------------------------------------------------------------

*I would like to have a MP program loading the data of an employee from 'ZBMIERZWITEST4'. The screen should contain the field of
*the Database Table (I am leaving out MANDT).
*I would like the ID to be the only visible field by default and to be a mandatory one. In the runtime, after the value has been
*provided and a 'Get data' button has been pushed, I want the corresponding data of an employee to be displayed within the remaining
*fields complete with making them visible and the ID made invisible.
*In order to create an MP program, I need to go to SE80, choose 'Program' option in the upper input field and provide the name of
*my program in the lower input field. I should create my program complete with the TOP INCLUDE. The program's type should be set
*to a default 'Module Pool' and I don't need to add anything here. Save and continue.
*I need to design a screen in the Screen Painter. Right-click the program's name -> 'Create' -> 'Screen'. The number of the screen
*if for me to choose (e.g. 100). Now I need to go to 'Layout' and within it select 'Goto' -> 'Secondary Window' -> 'Dictionary/Program
*Fields' because I want the fields to be loaded from my Database Table of ZBMIERZWITEST4.
*I should provide the name of the Database Table and press the 'Get from dictionary' button. Now I need to select the fields I want
*in my screen and Continue. The labels of the fields will be picked from the Data Element level. Now I need to create two pushbuttons
*by selecting a correct option from the toolbox to the left and dragging and drawing the buttons. I need to set the properties for
*my pushbuttons. I need to double click one, give it a 'Name' (e.g. 'B1'), a 'Text' (e.g. 'Get data') to be displayed on it and
*the Function Code (e.g. 'FC1'). The second is 'B2', 'Exit' and 'FC2'. I now need to save and activate the screen.
*For a Module Pool program to work - it requires a transaction. Right-click the name of the program in SE80 -> 'Create' -> 'Transaction'.
*The name I gave is 'ZBMI4' and, like all Module Pool Programming transactions - I need to select the first radiobutton
*('Program and screen (dialog transaction)'). Now I need to supply the name of my program and the screen I created previously as
*well as check the 'GUI for Windows' radiobutton. Now I should save and right click the name of my program and activate it.
*My MP program is now executable which can be done either by opening a newly created transaction or by right-clicking the name of my
*program, choosing 'Execute' and 'Direct Processing'.
*Whenever I design a custom transaction, SAP will not provide the back button (F3). I either need to enble it or make my custom button
*for exitting.
*In case of the Selection Screen (report programs), two events are triggered before one is displayed - INITIALIZATION and
*AT SELECTION-SCREEN OUTPUT. In case of the Module Pool programs before showing the screen for the first time, the PBO (Process Before
*Output) event is triggered. It is in PBO where I need to write the logic of my exitting button.
*In order to do it, I need to double-click the screen I've created in SE80 and go to the 'Flow logic' tab. Under the PROCESS BEFORE
*OUTPUT event I should see a greyout out Module suggestion by SAP - I should create a Module here (with whatever name I prefer). I can
*place my newly created Module in the previously created TOP INCLUDE. *Whenever I create my own screen, the back button (F3) is disabled.
*I can to enable it manually by defining my own GUI Status with the SET PF-STATUS statement and that is why it is automatically suggested
*in the Module I've just created.
*The Module created looks like this:
******************************************************************
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*All PBO Modules have the OUTPUT addition while the PAI ones have the
*INPUT one.
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'ABC'.
*  SET TITLEBAR 'xxx'.
ENDMODULE.
******************************************************************

*I provided my PF-STATUS the name of 'ABC' and created it with a short description. The 'Status type' should remain as the default option
*('Normal Screen'). A Menu Painter is opened now (SE41). I want to enable the 'Back' button so I need to open the 'Function Keys' section
*and provide a Function Code above the icon of the standard SAP's 'Back' button (the Function Code I assigned is 'BACK'). Now I need to save
*and activate everything.
*When my MP program is executed, the PBO event is triggered at first. Within it I have a Module that "declares" my custom GUI Status. Within
*that status I have a Function Code assigned to the 'Back' button. At this stage, if I execute my MP program, the 'Back' button will be
*enabled, but still greyed out. The button itself has been enabled, but not the functionality.
*In case of the Selection Screen (report programs) when a button is clicked, the event of AT SELECTION-SCREEN is triggered. In case of MPP,
*the event is PROCESS AFTER INPUT (PAI). Within the 'Flow logic' tab of my screen, below the PROCESS BEFORE OUTPUT section, I also have
*the PROCESS AFTER INPUT section. I can use the suggested Module of 'USER_COMMAND_0100'.
*The Module created looks like this:
******************************************************************
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE PROGRAM.
*The 'FC2' is the Function Code I assigned to my custom 'Exit' button in the Screen Painter tool. It does the same thing as the one above,
*but the 'BACK' Function Code is related to re-activating the standard SAP 'Back' button while 'FC2' to my own new custom button.
    WHEN 'FC2'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
******************************************************************

*Now I would like all the input fields save for the 'Employ no' to be invisible to begin with. In order to do it I need to loop through
*the Screen Structure. During the runtime in every program the Internal Table of 'Screen' is available and it contains all the screen's
*elements allowing me to modify them. Since I want a few screen elements invisible by default, the logic is to be written in PBO. It can
*be done within the same Module I have already created previously ('STATUS_0100') by creating a PERFORM therein whose FORM is defined
*within the same TOP INCLUDE.
*In case of my program, the FORM itself looks like this:
******************************************************************
*&---------------------------------------------------------------------*
*&      Form  MAKE_FIELDS_INVISIBLE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM make_fields_invisible .
  LOOP AT SCREEN.
*The names of the fields I can check within the Screen Painter tool - the 'Name' part
*I can see after double-clicking an element.
    IF screen-name = 'ZBMIERZWITEST4-ENAME' OR
       screen-name = 'ZBMIERZWITEST4-EMPDESIG' OR
       screen-name = 'ZBMIERZWITEST4-EMPSAL' OR
       screen-name = 'ZBMIERZWITEST4-JDATE' OR
       screen-name = 'ZBMIERZWITEST4-JTIME'.
      screen-invisible = '1'.
*If I left it at that the chosen fields would be encrypted but not invisible (they would have stars as input). In order to actually make the
*fields invisible, I also need to add a part about the 'input'. For the rest of the screen elements, it would not be necessary, but it's
*required for the input fields.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.
******************************************************************

*And the PBO's module looks like that:
******************************************************************
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'ABC'.
  PERFORM make_fields_invisible.
ENDMODULE.
******************************************************************

*Now I would like for the remaining fields to become visible and filled with data retrieved from the database upon clicking the 'Get Data'
*button. When the button is pressed, the PAI event is triggered (the MPP's equivalent of the selection screen program's AT SELECTION-SCREEN)
*and so it's within it I need to define the business logic for fetching the data from the database. I need to link the Function Code of the
*'Get Data' button ('FC1' - defined in the Screen Painter tool) to the particular action.
*My module in PAI now looks like this:
******************************************************************
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE PROGRAM.
    WHEN 'FC2'.
      LEAVE PROGRAM.
    WHEN 'FC1'.
*SINGLE is used because in the WHERE clause the comparison is based on the primary key field so there will
*only be a single record.
      SELECT SINGLE ename empdesig empsal jdate jtime
        FROM  zbmierzwitest8
*These are the names of input fields created in the Screen Painter tool.
          INTO (zbmierzwitest4-ename,
                zbmierzwitest4-empdesig,
                zbmierzwitest4-empsal,
                zbmierzwitest4-jdate,
                zbmierzwitest4-jtime)
            WHERE empno = zbmierzwitest4-empno.
  ENDCASE.
ENDMODULE.
******************************************************************

*If I left it at that, I would get the error telling me "until runtime, you cannot specify a field list." In order to prevent it, I need
*to explicitly declare the screen fields of my program if I want to refer to them.
*Thus, at the top of my TOP INCLUDE, I added the below. Regardless of how ridiculous it looks. I think that if I want my SELECT query to
*insert the values into the screen fields, I need to provide their names (e.g. 'zbmierzwitest8-ename') and, since they need to be declared
*explicitly... I need to declare their names like that.
******************************************************************
DATA: zbmierzwitest4-ename    TYPE zbmierzwitest4-ename,
      zbmierzwitest4-empdesig TYPE zbmierzwitest4-empdesig,
      zbmierzwitest4-empsal   TYPE zbmierzwitest4-empsal,
      zbmierzwitest4-jdate    TYPE zbmierzwitest4-jdate,
      zbmierzwitest4-jtime    TYPE zbmierzwitest4-jtime,
      zbmierzwitest4-empno    TYPE zbmierzwitest4-empno.
******************************************************************

*Now, when the data has been fetched from the database, I need to make the fields holding that data visible, so I create the FORM for this.
*The PERFORM is placed at the end of the SELECT - the fields are to be made visible only if the data has been fetched successfully.
*The FORM that makes the fields visible needs to be called within PBO even though the logic that fetches the data from the database is located
*within PAI. That is because PBO serves as MPP's equivalent of selection-screen programs' AT SELECTION-SCREEN OUTPUT event and thus the logic
*that refreshes the screen, needs to be put here.
*PBO, like AT SELECTION-SCREEN OUTPUT is always the final event processed before displaying the screen/refreshing the screen.
*In report programs, the user performs an action while in the selection-screen, e.g. pushing a pushbutton and thus SAP triggers
*AT SELECTION-SCREEN event and then AT SELECTION-SCREEN OUTPUT event afterwards. In an MPP when a user e.g. pushes a pushbutton, SAP triggers
*PAI and then PBO afterwards to refresh the screen. So when the data is fetched from the database within PAI, PBO will automatically be
*processed again. I need PBO to perform different actions depending on what has been requested. If a user wants to 'Get Data', I need to fetch
*said data and make the fields visible. So my data fetching logic needs to inform the PBO what needs to happen during its following processing.
*For this reason I am creating a flag. If its value is the default one, PBO makes all the fields invisible and if the value is changed, the fields
*are made visible - that is because the value can be changed only by the SELECT in PAI so if the value is changed that means this is the
*processing of PBO following the PAI during which the data has been requested.
*I am adding the flag at the top of the TOP INCLUDE, below the magnificently named screen fields:
******************************************************************
*It will be 0 by default.
DATA: lv_flag TYPE i.
******************************************************************

*The PBO's module looks like that:
******************************************************************
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  IF lv_flag = 0.
    SET PF-STATUS 'ABC'.
    PERFORM make_fields_invisible.
  ENDIF.
    PERFORM make_fields_visible.
ENDMODULE.
******************************************************************

*The module in PAI now looks as follows. If the data is fetched properly from the database, the flag is changed. Like AT SELECTION-SCREEN
*OUTPUT in case of report programs, PBO will be triggered again in case of MPP and, due to the switch case based on that flag -
*'make_fields_visible' will trigger instead of 'make_fields_invisible'.
******************************************************************
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE PROGRAM.
    WHEN 'FC2'.
      LEAVE PROGRAM.
    WHEN 'FC1'.
      SELECT SINGLE ename empdesig empsal jdate jtime
        FROM  zbmierzwitest8
          INTO (zbmierzwitest4-ename,
                zbmierzwitest4-empdesig,
                zbmierzwitest4-empsal,
                zbmierzwitest4-jdate,
                zbmierzwitest4-jtime)
            WHERE empno = zbmierzwitest4-empno.
      IF sy-subrc = 0.
        lv_flag = 1.
      ENDIF.
  ENDCASE.
ENDMODULE.
******************************************************************

*And the FORM itself:
******************************************************************
*&---------------------------------------------------------------------*
*&      Form  MAKE_FIELDS_VISIBLE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM make_fields_visible .
  LOOP AT SCREEN.
    IF screen-name = 'ZBMIERZWITEST4-ENAME' OR
       screen-name = 'ZBMIERZWITEST4-EMPDESIG' OR
       screen-name = 'ZBMIERZWITEST4-EMPSAL' OR
       screen-name = 'ZBMIERZWITEST4-JDATE' OR
       screen-name = 'ZBMIERZWITEST4-JTIME'.
      screen-invisible = '0'.
      screen-input = '1'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.
******************************************************************

*At this stage, I would still not get any data... because of the names of my screen fields. Due to them being created automatically
*by the Screen Painter tool, their names consist of the table's name and the field's name joined by a hyphen. So, if I want my SELECT
*to populate these screen fields, I need to refer to them by their names. And if I attempt to do that, I would get no results because
*if a field's name contains a hyphen, it will just not work and my 'zbmierziwtest8-empno' will hold the value of 0 regardless of what
*value I actually provide.
*So I need to go back to the Screen Painter tool and change the names of the fields manually. After that change I also need to change
*the names of the fields within my code itself.
*The explicitly declared screen fields now look like that:
******************************************************************
DATA: lv_ename    TYPE zbmierzwitest4-ename,
      lv_empdesig TYPE zbmierzwitest4-empdesig,
      lv_empsal   TYPE zbmierzwitest4-empsal,
      lv_jdate    TYPE zbmierzwitest4-jdate,
      lv_jtime    TYPE zbmierzwitest4-jtime,
      lv_empno    TYPE zbmierzwitest4-empno.
******************************************************************

*The form making fields invisible now has more elements because the ones prefixed with 'zbmierzwitest8' are labels and the ones 
*prefixed with 'lv' are the actualy screen fields. It now looks like this:
******************************************************************
*&---------------------------------------------------------------------*
*&      Form  MAKE_FIELDS_INVISIBLE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM make_fields_invisible .
  LOOP AT SCREEN.
    IF screen-name = 'ZBMIERZWITEST4-ENAME' OR
       screen-name = 'ZBMIERZWITEST4-EMPDESIG' OR
       screen-name = 'ZBMIERZWITEST4-EMPSAL' OR
       screen-name = 'ZBMIERZWITEST4-JDATE' OR
       screen-name = 'ZBMIERZWITEST4-JTIME' OR
       screen-name = 'LV_ENAME' OR
       screen-name = 'LV_EMPDESIG' OR
       screen-name = 'LV_EMPSAL' OR
       screen-name = 'LV_JDATE' OR
       screen-name = 'LV_JTIME'.
      screen-invisible = '1'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.
******************************************************************

*The PAI's Module, which, among others, contains the SELECT query looks like that:
******************************************************************
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE PROGRAM.
    WHEN 'FC2'.
      LEAVE PROGRAM.
    WHEN 'FC1'.
      SELECT SINGLE ename empdesig empsal jdate jtime
        FROM  zbmierzwitest8
          INTO (lv_ename,
                lv_empdesig,
                lv_empsal,
                lv_jdate,
                lv_jtime)
            WHERE empno = lv_empno.
      IF sy-subrc = 0.
        lv_flag = 1.
      ENDIF.
  ENDCASE.
ENDMODULE.
******************************************************************

*The form making the fields visible looks as below. I am also making sure that, if the other fields
*are made visible, the 'empno' one is locked.
******************************************************************
*&---------------------------------------------------------------------*
*&      Form  MAKE_FIELDS_VISIBLE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM make_fields_visible .
  LOOP AT SCREEN.
    IF screen-name = 'ZBMIERZWITEST4-ENAME' OR
       screen-name = 'ZBMIERZWITEST4-EMPDESIG' OR
       screen-name = 'ZBMIERZWITEST4-EMPSAL' OR
       screen-name = 'ZBMIERZWITEST4-JDATE' OR
       screen-name = 'ZBMIERZWITEST4-JTIME' OR
       screen-name = 'LV_ENAME' OR
       screen-name = 'LV_EMPDESIG' OR
       screen-name = 'LV_EMPSAL' OR
       screen-name = 'LV_JDATE' OR
       screen-name = 'LV_JTIME'.
      screen-invisible = '0'.
      screen-input = '1'.
      MODIFY SCREEN.
*When the fields are being made visible, I want the 'empno' field to be greyed out.
    ELSEIF screen-name = 'LV_EMPNO'.    
      screen-input = 0.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.
******************************************************************

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------


*---------------------------------------------------------------------------------------------------------------------------------
*A PROGRAM CONTAINING THE TABLE CONTROL COMPONENT.
*---------------------------------------------------------------------------------------------------------------------------------

*When I generate the Table Maintenance, I need to specify the Maintenance Type - either One Step or Two Step. The Two Step means
*that two screens will be generated - the Overview Screen and the Single Screen. In the Overview Screen I can perfom operations
*like View, Delete and Update and in the Single Screen I can Insert the data.
*If I open SM30 transaction, provide a table's name and click the 'Maintain' button, the Overview Screen will be displayed. If
*I select 'New Entries', the Single Screen will be displayed.
*In the Overview Screen I can see the records displayed. This section is called Table Control. My transactions might contain the
*screen element called Table Control. Its purpose is to display the records in the form of rows and columns. In the Single Screen
*I can see only Input Fields. Input Fields can show only one value.

*I want to create a program which takes the sales document's number as a parameter and when Enter is pressed, the corresponding
*header and item data should be provided and displayed. The header data needs to be displayed in separate fields and the item
*data needs to be displayed in Table Control.
*I need to go to SE80, pick the 'Program' option and provide the name of my program. In my case it's 'Z_BM_TEST_MPP3'. Now I am
*to press Enter and create the object with the TOP INCLUDE. The 'Type' is the 'Module Pool'. I need to create a Screen now. In
*order to do it, I should right-click my program's name, select Create and then Screen. A short description and the number of the
*screen should be provided (100 in my case). In the Layout I will be using the fields of the VBAK and VBAP tables. I could refer
*to these tables directly, but I will require only four fields from each table so for the sake of performance I elect to trade
*the entire tables for my custom structures each of whom contains the aforementioned four fields - one from VBAK and one from VBAP.
*1) The structure containing VBAK's fields is called: 'ZBMIERZWI_TEST_VBAK_STRUCT' and its field are:
*- VBELN type VBELN_VA,
*- ERDAT type ERDAT,
*- ERZET type ERZET,
*- ERNAM type ERNAM.
*2) The structure containing VBAP's fields is called: 'ZBMIERZWI_TEST_VBAP_STRUCT' and its field are:
*- VBELN type VBELN_VA,
*- POSNR type POSNR_VA,
*- MATNR type MATNR,
*- NETWR type NETWR_AP.
*I should go to the Screen Painter tool now by pressing the 'Layout' button. I now need to go to Goto (hehe) -> Secondary Window ->
*Dictionary/Program Fields. In the input box that takes the tables' names I can also provide the names of the structures, so I can
*type in 'ZBMIERZWI_TEST_VBAK_STRUCT' and push the 'Get from Dictionary' button. Now I should press the book icon in the upper left
*hand corner of the list of the displayed fields and proceed with that. I would now like to make the EMPNO field a mandatory one.
*In the SELECTION-SCREEN kind of a program, I would use the addition of OBLIGATORY. In an MPP, I need to double click the input field,
*go to the 'Program' tab of the 'Attributes' section and next to the 'Input' label I can see a drop-down list - I need to select the
*'required' option. An MPP indicated that a field is mandatory by having a question mark placed within its input box in the Screen
*Painter tool.
*Now I proceed to create the 'Exit' button. Within the Screen Painter tool I need to select the 'Button' option and draw my button
*in my preferred place in the screen. I name the button 'B1', the text is 'Exit' and the function code is 'FC1'. Now I write the
*logic for the 'Exit' button. I move to the Screen in SE80, uncomment the 'MODULE USER_COMMAND_0100' and create the object within the
*TOP INCLUDE.
*The logic looks as follows:
*******************************************************************
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'FC1'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*******************************************************************

*Now to create the transaction. I need to right-click the name of my program in SE80, select 'Create' and then select 'Transaction'.
*The name I gave is 'ZBMI5' and the 'Start object' is 'Program and screen (dialog transaction)' as it always the case for MPP. I then
*need to provide the name of the program the transaction is for, the screen number (100) and check the 'SAPGUI for Windows' checkbox
*in the 'GUI Support' section.

*I want all the screen fields to be filled with data associated with the provided sales document's number upon pressing Enter. In case
*of selection screen programs, pressing the Enter key in the selection screen input field the AT SELECTION-SCREEN ON <field> event is
*triggered and then followed by AT SELECTION-SCREEN and AT SELECTION-SCREEN OUTPUT. In case of MP, the PAI comes first and the PBO comes
*afterwards. Since PAI comes first when Enter is pressed it is within PAI that I should write the logic for fetching the data for all
*input fields.
*To request that SAP triggers that piece of code when Enter is pressed in the particular input field, I need to name that field (the name
*comes from the Screen Painter tool) before specifying the module that should be triggered.
*The syntax looks as below:
*******************************************************************
PROCESS AFTER INPUT.
 MODULE USER_COMMAND_0100.
 FIELD zbmierzwi_test_vbak_struct-vbeln MODULE get_sales_header_data.
*******************************************************************
 
*The module needs to be double-clicked and created within the TOP INCLUDE. Now, based on the value of VBELN, I should get the rest of
*the data. The sales document (VBELN) is a primary key field in VBAK so I will get only one record's data as a result of my query, thus
*I use SELECT SINGLE.
*The module looks as follows:
*******************************************************************
 MODULE get_sales_header_data INPUT.
  SELECT SINGLE vbeln erdat erzet ernam
    FROM vbak
      INTO (zbmierzwi_test_vbak_struct-vbeln,
            zbmierzwi_test_vbak_struct-erdat,
            zbmierzwi_test_vbak_struct-erzet,
            zbmierzwi_test_vbak_struct-ernam)
        WHERE vbeln = zbmierzwi_test_vbak_struct-vbeln.
ENDMODULE.
*******************************************************************

*Whenever I am using screen fields in a program, I need to declare them explicitly. I need to add the below at the top of the INCLUDE:
*******************************************************************
DATA: zbmierzwi_test_vbak_struct-vbeln TYPE zbmierzwi_test_vbak_struct-vbeln,
      zbmierzwi_test_vbak_struct-erdat TYPE zbmierzwi_test_vbak_struct-erdat,
      zbmierzwi_test_vbak_struct-erzet TYPE zbmierzwi_test_vbak_struct-erzet,
      zbmierzwi_test_vbak_struct-ernam TYPE zbmierzwi_test_vbak_struct-ernam.
*******************************************************************

*The names of the fields seem bizzare because they need to be the same as the screen fields' names created in the Screen Painter tool
*and this is what they look like.
*If I want to use the screen fields in my program, I need to declare them in my program but I cannot have a variable name containing
*a hyphen and if the data for the fields in the Screen Painter is loaded from the database, then SAP automatically gives the fields
*names consisting of the database's name and the field's name joined by a hyphen. Thus, I won't be able to refer to that field
*because my declared field cannot be named e.g. 'kna1-kunnr' and such will be the screen field's name is the data was loaded from
*KNA1.
*I can either change the names of the screen fields in the Screen Painter or I can utilize the TABLES declaration. The TABLES declaration 
*counts as the explicit declaration of the screen fields. The TABLES statement will create a work area with all the table's/structure's
*fields. I could declare VBAK here... but that would create a work area with over 200 fields which is unnecessary. My structure has only
*the four fields that I require and is thus perfect here.
*Thus the top part of my TOP INCLUDE looks like that:
*******************************************************************
*DATA: zbmierzwi_test_vbak_struct-vbeln TYPE zbmierzwi_test_vbak_struct-vbeln,
*      zbmierzwi_test_vbak_struct-erdat TYPE zbmierzwi_test_vbak_struct-erdat,
*      zbmierzwi_test_vbak_struct-erzet TYPE zbmierzwi_test_vbak_struct-erzet,
*      zbmierzwi_test_vbak_struct-ernam TYPE zbmierzwi_test_vbak_struct-ernam.
TABLES: zbmierzwi_test_vbak_struct.
*******************************************************************

*Now I need to design the Table Control component. I need to go to the Screen Painter tool and in the panel with tools on the left hand
*side of the window I will see the 'Table Control' button. I need to draw it on the screen. When that's done, I double-click the newly
*created component and name it 'TBCTRL' (there's no convention). The colour of the Table Control doesn't change yet because there's still
*no fields associated with it. As much as the fields above the Table Control contain the header data of a sales document, I want my
*Table Control to contain the item data of that document. The data I want is this in VBAP and I could take the data from there but
*I have created my own structure and populated it beforehand so that SAP would need to handle only a few columns instead of lots. I can
*have the Screen Painter tool use my Structure's structure to create its own columns' structure (hehe). 
*I need to go to Goto -> Secondary Window -> Dictionary/Program Fields, provide the name of my structure ('ZBMIERZWI_TEST_VBAP_STRUCT'), 
*select the 'Get from Dictionary' button, click the button in the upper left hand side of the window with the columns to select everything 
*that's just been displayed and proceed.
*Now I need to drop it on the Table Control and the proper columns will appear there. I can reduce the size of the Table Control to fit
*the columns just right. I can now double-click the Table Control (e.g. the space in the bottom right hand corner in front of the two
*arrows at the ends of the sliders - I need to make sure I am double-clicking the Table Control and not the columns and it can be a little
*bit tricky) and in the 'Attributes' section check the 'Vertical' and 'Horizontal' checkboxes. Due to that the fields in my Table Control
*will be neatly separated and thus the readability will be improved.
*If I tried to activate my MP program now, I would get an error saying that "the field ZBMIERZWI_TEST_VBAK_STRUCT-VBELN is not assigned to
*a loop. 'LOOP ... ENDLOPP' must appear in 'PBO' and 'PAI'." Whenever my screen contains a Table Control component, the loop is required
*in both PAI and PBO. Even simply declaring "LOOP. ENDLOOP" below both of these will do and the program will activate... but if I try to
*execute it, a runtime error will occur. That is because whenever my screen contains a Table Control component, that component needs to be
*declared explicitly within my program.
*This needs to be done within my TOP INCLUDE program (good practice, it could be declared elsewhere if I didn't want my Code Clean. Hehe)
*by using the CONTROLS keyword. Special controls like Table Control need to be declared using the CONTROLS and not DATA keyword. The data
*type for Table Control is 'tableview' and 'using screen' indicated on which screen the Table Control will be displayed.
*The upper part of my TOP INCLUDE program now looks like this:
*******************************************************************
TABLES: zbmierzwi_test_vbak_struct.
CONTROLS: tbctrl TYPE TABLEVIEW USING SCREEN 100.
*******************************************************************

*Now I need to populate my Table Control with item data for the sales document. Of course, only if the sales document has been found and
*its header data has been thus placed in the input boxes above the Table Control. So - if the 'sy'-subrc' after the SELECT fetching the header
*data yields 0. I need to declare the internal table for storing the item data.
*In this case I am first declaring a type and instead of mentioning every field separately, I am using the INCLUDE TYPE syntax, so all the
*fields present in my custom structures that is being thus included will become part of the new type. Here the TYPES keyword also needs to
*appear in front of the END OF because there's a full stop before it and that full stop is required because I am using the INCLUDE keyword
*as part of the TYPES I am creating. Instead of INCLUDE TYPE I could also use INCLUDE STRUCTURE but this syntax is obsolete in OOP.
*It's worth noting that the TYPES declaration is optional, it's just another level of abstraction, I could declare my internal table and
*work area directly on my custom structure instead (ZBMIERZWI_TEST_VBAP_STRUCT).
*The upper part of my TOP INCLUDE now looks as below:
*******************************************************************
TABLES: zbmierzwi_test_vbak_struct.
CONTROLS: tbctrl TYPE TABLEVIEW USING SCREEN 100.
TYPES: BEGIN OF t_items.
  INCLUDE TYPE zbmierzwi_test_vbap_struct.
TYPES END OF t_items.
DATA: lt_items  TYPE TABLE OF t_items,
      lwa_items TYPE t_items.
*******************************************************************

*The module for getting the data - adhering to the idea of the item data being fetched only if the header data has been found, looks like that:
*******************************************************************
MODULE get_sales_header_data INPUT.
  SELECT SINGLE vbeln erdat erzet ernam
    FROM vbak
      INTO (zbmierzwi_test_vbak_struct-vbeln,
            zbmierzwi_test_vbak_struct-erdat,
            zbmierzwi_test_vbak_struct-erzet,
            zbmierzwi_test_vbak_struct-ernam)
        WHERE vbeln = zbmierzwi_test_vbak_struct-vbeln.
*If the header data is found, I need to populate the Table Control with
*all the item data for that sales document.
  IF sy-subrc = 0.
    SELECT vbeln posnr matnr netwr
      FROM vbap
        INTO TABLE lt_items
          WHERE vbeln = zbmierzwi_test_vbak_struct-vbeln.
  ENDIF.
ENDMODULE.
*******************************************************************

*Now I need to move the data from the internal table (lt_items) to the table control. After executing PAI, PBO comes. The data is fetched
*in PAI. The screen refreshing logic should always be written in the final event that is being triggered. That is PBO in MP programs.
*That is why there has to be a LOOP within a MP program that contains a table control. I need to loop through the internal table that
*contains the item data (lt_items) and, obviously, into a work area as that is the way of ABAP. In order to have my table control populated
*I also need to add WITH CONTROL <table_control_name> at the end. That syntax means that while I am looping through the internal table, I
*also want to loop through the table control at the same time. That syntax can ONLY be in the PBO event in the flow logic section so I cannot
*move the loop itself into a module to modularize it, but I can modularize the logic happening for every iteration of the loop instead. I
*cannot write the entirety of the logic within the flow logic section as only a few keywords (e.g. loop, field, module) will be recognised
*here.
*The PBO part of my flow logic section looks like that:
*******************************************************************
PROCESS BEFORE OUTPUT.
LOOP AT lt_items INTO lwa_items WITH CONTROL tbctrl.
  MODULE transfer_item_data.
ENDLOOP.
*******************************************************************

*Now, in the 'transfer_item_data' module I will be referring to the table control fields and they, much like all the screen fields, need to
*be declared explicitly in my MP program.
*Thus, the upper part of my TOP INCLUDE now looks like that:
*******************************************************************
TABLES: zbmierzwi_test_vbak_struct,
        zbmierzwi_test_vbap_struct.
CONTROLS: tbctrl TYPE TABLEVIEW USING SCREEN 100.
TYPES: BEGIN OF t_items.
  INCLUDE TYPE zbmierzwi_test_vbap_struct.
TYPES END OF t_items.
DATA: lt_items  TYPE TABLE OF t_items,
      lwa_items TYPE t_items.
*******************************************************************

*The 'transfer_item_data' module itself looks like shown below. Within the flow logic I am looping through the internal table ('lt_items') that
*holds the previously fetched data. With every loop, a new record appears in the work area. For every record the below module is executed. Data is
*here assigned to the table control's fields. Whenever I am referring to the screen fields, I should declare them (that includes the table control
*fields) - they are declared with the TABLES keyword (instead of mentioning every field separately after the DATA and having to worry about the
*name containing a hyphen as that's how the Screen Painter tool names the screen fields). Using the TABLES keyword also creates a work area, hence
*when I type 'CLEAR zbmierzwi_test_vbap_struct' - it will clear the work area of that structure.
*This works despite the actual table control not being mentioned by its name ('tbctrl') because the screen fields created in the Screen Painter
*tool are called 'zbmierzwi_test_vbap_struct-vbeln', 'zbmierzwi_test_vbap_struct-posnr', 'zbmierzwi_test_vbap_struct-matnr' and
*'zbmierzwi_test_vbap_struct-netwr' and so when I mention them, from my program's perspective, I am talking about my table control's fields.
*******************************************************************
MODULE transfer_item_data OUTPUT.
  CLEAR zbmierzwi_test_vbap_struct. "Clearing a work area.
  zbmierzwi_test_vbap_struct-vbeln = lwa_items-vbeln.
  zbmierzwi_test_vbap_struct-posnr = lwa_items-posnr.
  zbmierzwi_test_vbap_struct-matnr = lwa_items-matnr.
  zbmierzwi_test_vbap_struct-netwr = lwa_items-netwr.
ENDMODULE.
*******************************************************************

*Now, when I provide the sales document's number and press Enter, the PAI event will be executed. The 'get_sales_header_data' module will be triggered
*and the data will be fetched - the header data will be put directly into the screen fields and, if that happens, the item data will land in an
*internal table. When that is finished the control goes to the PBO event. Here I have written the logic to populate the table control component. This is
*the only place where this action can occur. The item data from the internal table is assigned to the table control component in a loop.

*The data should now be displayed in the table control component. At this moment I have the ability to scroll horizontally through the table control
*component but not vertically. SAP does not provide the vertical scrolling by default and it needs to be enabled programatically. I am going to do
*it in the data fetching module because extending the length (height?) of the table control component is dependent on the number of lines it will
*contain. If any data has been found, so if the 'sy-subrc' variable equals 0, I refer to my table control component's 'line' property and set it
*to the number of records that has been found. The 'sy-dbcnt' variable contains the number of records that have been retrieved by the previous SELECT
*statement.
*The data fetching module in the PAI event now looks like this:
*******************************************************************
MODULE get_sales_header_data INPUT.
  SELECT SINGLE vbeln erdat erzet ernam
    FROM vbak
      INTO (zbmierzwi_test_vbak_struct-vbeln,
            zbmierzwi_test_vbak_struct-erdat,
            zbmierzwi_test_vbak_struct-erzet,
            zbmierzwi_test_vbak_struct-ernam)
        WHERE vbeln = zbmierzwi_test_vbak_struct-vbeln.
  IF sy-subrc = 0.
    SELECT vbeln posnr matnr netwr
      FROM vbap
        INTO TABLE lt_items
          WHERE vbeln = zbmierzwi_test_vbak_struct-vbeln.
    IF sy-subrc = 0.
      tbctrl-lines = sy-dbcnt.
    ENDIF.
  ENDIF.
ENDMODULE.
*******************************************************************

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------