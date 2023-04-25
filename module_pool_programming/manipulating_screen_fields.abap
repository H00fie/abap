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