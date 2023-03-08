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

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------