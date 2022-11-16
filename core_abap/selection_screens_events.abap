*---------------------------------------------------------------------------------------------------------------------------------
*SELECTION SCREENS.
*---------------------------------------------------------------------------------------------------------------------------------
*Event (all these blocks) end only when another block starts.
TABLES: zpokemon.

DATA: wa_zpokemon LIKE zpokemon-employee.

*FORMATTING SELECTION SCREENS----------------------------------------
*Without this, system decided where it puts all of my selection screen objects. E.g. when I have a group of radiobuttons, I should organise them
*into their own group, visibly separate from other objects. The Selection-Screen statements requires Additions which specify the type of a layout option
*which I am defining.
PARAMETERS: my_emp   LIKE zpokemon-employee DEFAULT 333 OBLIGATORY,
            my_gend  LIKE zpokemon-gender VALUE CHECK, "Line 117.
            my_sur   LIKE zpokemon-surname DEFAULT 'Tatanka' LOWER CASE, "I can make sure the value will be in lower case. Otherwise, when I press enter on the parameter box - it defaults it to the upper case.
            my_box   AS CHECKBOX. "I think I could use it just like radiobuttons were used in ZR07MLBE -> a condition for an IF statement.
SELECTION-SCREEN SKIP 3. "ADDITION! Skips 3 lines here!
SELECTION-SCREEN ULINE.  "ADDITION! Underlines.
SELECTION-SCREEN ULINE /1(8). "ADDITION! SlASH means the new line, then comes the POSITION (how many characters to skip before printing the line) and in the brackets the LENGTH of the line.
SELECTION-SCREEN ULINE /40(8). "Skip 40 characters and then print a line!
*ADDITION! COMMENT allows me to add text to the Selection Screen. The comment itself can either be a Text Element or a variable name.
*These variables are NOT declared within the DATA block, but when the program is started, so - in the INITIALIZATION block.
SELECTION-SCREEN COMMENT /40(15) text-001.
SELECTION-SCREEN COMMENT 60(15) comm1. "The lack of the slash means it will be in the same line as the comment above.
*I can format a single line by creating a block with BEGIN OF LINE and END OF LINE.
*I will get a syntax error if I try to use a SLASH in any of these two comments. That's a single line and no more allowed!
*Also, if I define a parameter field within BEGIN OF LINE-END OF LINE section, it does not display its technical name. A COMMENT is to be used.
*I can also use POSITION to decide where the element following that statement will be positioned.



*ELEMENT BLOCKS ---
*To group fields together. I can nest element blocks within element blocks.
*They are similar to BEGIN OF LINE.
SELECTION-SCREEN BEGIN OF BLOCK my_block1 WITH FRAME TITLE text-001.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(15) text-001.
SELECTION-SCREEN COMMENT 20(20) comm2.
SELECTION-SCREEN POSITION pos_high. "This can either be a number or I can use pos_low or pos_high to place stuff right where LOW and HIGH in usual SELECT-OPTIONS is placed!
PARAMETER wtf(5).
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK my_block1.
PARAMETERS: wa_green RADIOBUTTON GROUP grp1,
            wa_blue  RADIOBUTTON GROUP grp1,
            wa_yell  RADIOBUTTON GROUP grp1. "Only one of these radiobuttons can be selected! CTRL+F "radiobuttons"

SELECT-OPTIONS: my_dob FOR zpokemon-dob NO-EXTENSION.



*INITIALIZATION----------------------------------------
INITIALIZATION.                  "When the program is run -> it will be recognized I have this good boy over here so everything in this block will be executed first.
  comm1 = 'Suuusuuumeeee!!!'.
  comm2 = 'Deeediiicaaateee!'.
  SELECT * FROM zpokemon.
    wa_zpokemon = zpokemon-employee.
  ENDSELECT.

*AT SELECTION SCREEN----------------------------------------
*Triggered when the user tries to execute the report. It's a good place to see what parameters have been provided.
*I can display a message for the user to tell them something isn't right if they provide incorrect parameters.
AT SELECTION-SCREEN ON my_emp. "ON indicates to the system that the event (AT SELECTION-SCREEN) is specifically for this parameter.

*Checking if employee number is not greater than the last employee number within the table.
*wa_employee has the last employee because the SELECT kept overwriting the results until it went through the entire table.
*MESSAGE e000(ZBM_MES1) is a Text Message (explained below). It's different than Text Elements. e stands for Error (there are various
*ohter types), 000 is the number of the messgae that I created and ZBM_MES1 is the name of the Message Class which I also created.
*These are not integral parts of any program and can be reused.
*WITH is an addition that can be included. It allows me to add up to 4 different paramaters that can be passed into the message.
*In this case I can display the value entered into the error message that is going to be displayed.
*For the error message to be able to accept the addition, it needs to contain "&" within its text in a place where the additions is to be
*displayed.
*Message 000 does NOT contain an "&" and Message 001 does.
  IF my_emp > wa_zpokemon.
    MESSAGE e001(ZBM_MES1) WITH my_emp. "This is the error/warning message at the bottom of my program!
  ENDIF.



*PARAMETERS----------------------------------------
*PARAMETERS: some_para TYPE i. <--- this will not work, because 'parameters cannot be defined locally (active FORM procedure or GET).
*                                   Basically, it will not allow me to declare any parameters after AT SELECTION-SCREEN has started.
*                                   Though, it's fine to declare it anywhere before or within INITIALIZATION.



*CHECKBOX----------------------------------------
*A checkbox always has to be of data type c. My data element 'my_box', if unchecked will hold a blank character. If ticked, it will hold an 'X'!
*Basically, a regular parameter allows me to enter any value. A checkbox allows either a blank or an 'X'.



*RADIOBUTTONS---
*The difference between them and checkboxes is that checkboxes are individual parameters in their own right and I can have many checkboxes and
*I can select many checkboxes on the screen.
*Radiobuttons have to belong to a group. Within those groups only a single radiobutton can be selected at any one time. Like checkboxes, they
*have to be of data type c and the length of one.
*So radiobuttons are to be used when I want to have a possibility of choosing between various options.



*SELECT-OPTIONS----------------------------------------
*Uses internal tables to store the provided values. These values need to be installed in a table in memory for our program to use.
*An internal table create thus has a similar restrction to parameters. They can only have a name that contains no more than eight characters.
*Select tables contain four separate fields which are defined when I create my SELECT-OPTIONS statement.
*These are:
* - sign <-- a data type c with one character's length. It determines for each record whether it should be included or excluded from the result set. The possible values that can be included here are 'I' and 'E'.
* - option <-- also type c, but the length of two. It holds the selection operator. Can contain EQ, NE, GT, LT, GE, LE, CP and NP. CP and NP.
* - low <-- the lower limit for a range of values that a user can enter.
* - high <-- the upper limit. Both low's and high's data types are determined by the database table to which my selection criteria is linked.

*When selection field is filled (whether a single value or multiple values), a record is generated and put into this internal table.
*There is no limit to how many records can be stored.



*VALUE CHECK----------------------------------------
*Allows me to include... value checking! :O Anything that is being entered is being checked against the valid value list that is
*defined in the ABAP dictionary (in the case of 'gender' up here, I created my own domain to which that data element belongs and
*that domain allows only three possible entries).

*To do some testing... <-- THIS DOESN'T WORK HERE! IT WORKS ONLY ABOVE INITIALIZATION! If I remove the Events, it works... but also works under START-OF-SELECTION!
*Which makes sense, given events are supposed to actually mark the blocks of code as doing specific tasks and they end only when the next one starts.
*START-OF-SELECTION.
*  SELECT * FROM zpokemon.
*    IF zpokemon-dob IN  my_dob.
*      WRITE: / zpokemon-dob.
*    ENDIF.
*  ENDSELECT.



*SELECT ADDITIONS----------------------------------------
*SELECT-OPTIONS can go with OBLIGATORY or LOWER CASE and so on.
*There is also a no extension addition. It allows me to prevent the use of multiple selections. Thus I can give a user the ability
*to make a value range selection, but stop them from entering multiple value ranges.
*It would look like:
*SELECT-OPTIONS: my_dob FOR zpokemon-dob NO-EXTENSION.



*TEXT ELEMENTS----------------------------------------
*Fields in the selection screen display their technical names unless I change that - 'Skok do' -> 'Elementy tekstowe' -> ...
*- The text elements responsible for the way fields' names are displayed are called Selection Texts.
*- If I try to copy a program copying of the Text Elements is obligatory, because when they are created they are an integral part of this program.
*- When Text Elements are created they belong to Text Pools - these pools hold all the text elements of my programs.
*- Every program I create is language independent which means Text Elements I create can be easily translated into other languages (??? Not sure how that works exactly ???).
*- There are three kinds of Text Elements that I can use: Selection Text, Text Symbols and List Headings.
*
*Text Symbols  -> give "flexibility" to a program allowing me to not have to code literals into the source code.
*List Headings -> when building reports, I also build report headers like the title, the fields' names the column headings etc. By using them instead of hardcoded headings,
*I can ensure they will be translated into any other required language. Also, if the headings need to change, I can just change the Text Elements instead of changing the source code.



*TEXT SYMBOLS ---
*E.g. when I want to WRITE: / "some message", I can use a Text Symbol instead and, by the grace of Lucifer - it will be automatically translated if need be.
*So in practice it could look like: WRTIE: / text-001. <- this is a pattern, it has too look like this, string 'text', a dash and a three digit number.

*WRITE: / text-001. " Susume?!



*MESSAGES----------------------------------------
*For providing feedback to the user in a way that is not a string literal. The concept of messages provides the facility to automatically translate such messages to other
*languages.
*First I need to store these messages in a message class which in turn is stored in database table t100. To create a message class -> se91.
*Messages are different from text elements in that they are NOT objects that are part of my program (unlike text elements). Messages are stored within t100. Due to that
*Text Messages can be resued in many programs.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*CONTROLLING SCREEN ELEMENTS WITH EVENTS.
*---------------------------------------------------------------------------------------------------------------------------------

*Depending on the parameter value selected, I want certain components of the screen hidden. In order to control the appearance of
*the screen, I need to use a structure called Screen Structure (SCREEN data type in SE11). It is a regular structure - a collection
*of fields. Based on this structure, SAP will create an internal table whenever a program is executed. It will contain the information
*about screen elements. Listboxes, blocks, checkboxes, radiobuttons are all screen elements. For example, the screen internal table
*has a column called 'name' and 'p_abc' will be placed there. There is also the 'invisible' column with the default value of 0.
*All the elements are visible by default. The value of 1 means the element is invisible.
*During the INITIALIZATION everything, including the screen elements and their invisibility are set up. When a value from the drop-down
*listbox is selected and enter is pressed the AT-SELECTION-SCREEN event is triggered. Afterwards the AT-SELECTION-SCREEN OUTPUT event
*is triggered. AT-SELECTION-SCREEN event's purpose is to validate the user's input. It is like PAI (process after input).
*AT-SELECTION-SCREEN OUTPUT is required whenever any screen elements need to be changed. It is like PBO (process before output).
*The screen refreshing logic should always be placed in the final event which is AT-SELECTION-SCREEN OUTPUT. AT-SELECTION-SCREEN
*houses the indicators (the values for 'gv_flag') for the following event.
*USER-COMMAND is being added to the listbox because I want a function call to be associated with it. Without it, certain blocks become
*visible upon choosing a value only when Enter is pressed. I want it to happen the moment the value is selected and for that I require
*a function call.

*If I am using the USER-COMMAND option for the parameter statement, I cannot specify the offset or the length of the parameter.
*PARAMETERS p_abc(15) TYPE c AS LISTBOX VISIBLE LENGTH 12 USER-COMMAND fc1. "Throws the error.

*'gv_abc' is used so I can specify the length of the parameter even though I can't do it directly for 'p_abc' itself. Whenever I select
*a value in the drop-down listbox, AT-SELECTION-SCREEN event is triggered. So the logic of the function call is specified there.
DATA: gv_abc(15) TYPE c.
PARAMETERS p_abc LIKE gv_abc AS LISTBOX VISIBLE LENGTH 12 USER-COMMAND fc1.

DATA: lt_values TYPE TABLE OF vrm_value,
      wa_values TYPE vrm_value,
      gv_flag   TYPE i. "The variable for AT-SELECTION-SCREEN event to indicate what value was assumed by the parameter.

*MODIF ID adds the screen element to a screen group which allows me to refer to all the elements from the group at one instead of
*listing them one after another if I want e.g. to make all the elements of a block invisible. MODIF ID populates a property of
*the screen internal table - the column 'group1'. The screen group cannot be assigned to a block itself.
SELECTION-SCREEN BEGIN OF BLOCK bc1 WITH FRAME TITLE t1.
PARAMETERS: p_c1 AS CHECKBOX MODIF ID ID1,
            p_c2 AS CHECKBOX MODIF ID ID1,
            p_c3 AS CHECKBOX MODIF ID ID1.
SELECTION-SCREEN END OF BLOCK bc1.

*Radiobuttons belong in groupes so that the user might select only one of them.
SELECTION-SCREEN BEGIN OF BLOCK bc2 WITH FRAME TITLE t2.
PARAMETERS: p_r1 RADIOBUTTON GROUP g1 MODIF ID ID2,
            p_r2 RADIOBUTTON GROUP g1 MODIF ID ID2,
            p_r3 RADIOBUTTON GROUP g1 MODIF ID ID2.
SELECTION-SCREEN END OF BLOCK bc2.

SELECTION-SCREEN BEGIN OF BLOCK bc3 WITH FRAME TITLE t3.
SELECTION-SCREEN COMMENT 3(15) lb1 MODIF ID ID3.
SELECTION-SCREEN COMMENT /3(15) lb2 MODIF ID ID3. "The slash indicates a new line.
SELECTION-SCREEN COMMENT /3(15) lb3 MODIF ID ID3.
SELECTION-SCREEN END OF BLOCK bc3.

INITIALIZATION.
  PERFORM prepare_values.
*Initially I want the blocks hidden.
  PERFORM make_blocks_inv.
  t1 = 'Courses'.
  t2 = 'Institues'.
  t3 = 'Locations'.
  lb1 = 'Osgiliath'.
  lb2 = 'Dol Amroth'.
  lb3 = 'Umbar'.

*The moment the value is selected and Enter is hit, AT-SELECTION-SCREEN event is triggered. The key of the selected value is captured
*within the the parameter internally - it's performed within PREPARE_VALUES perform.
*By putting the logic responsible for making a particular block visible into the CASE block associated with the function call associated
*with the dropdown listbox - I am ensuring that the blocks will become visible upon selecting the value without having to hit Enter beforehand.
*Without it - I would need to hit Enter first, because AT-SELECTION-SCREEN event triggers as a result of doing that without an "external"
*stimulus in the form of the function call.
*It is specified here because AT-SELECTION-SCREEN event is what triggers when an action happens in the selection screen. The values of
*'K1', 'K2' and 'K3' are assigned to every parameter option during the INITIALIZATION. The function call's responsibility here is to trigger
*AT-SELECTION-SCREEN event without making the user hit Enter first.
AT SELECTION-SCREEN.
  CASE sy-ucomm.
    WHEN 'FC1'.
      IF p_abc = 'K1'.
        gv_flag = 1.
      ELSEIF p_abc = 'K2'.
        gv_flag = 2.
      ELSEIF p_abc = 'K3'.
        gv_flag = 3.
      ENDIF.
  ENDCASE.

*AT-SELECTION-SCREEN OUTPUT event is triggered automatically after AT-SELECTION-SCREEN event AND after the INITIALIZATION event.
*Any screen refreshing logic should be placed here.
AT SELECTION-SCREEN OUTPUT.
  IF gv_flag = 1.
    PERFORM make_bk1_visible.
  ELSEIF gv_flag = 2.
    PERFORM make_bk2_visible.
  ELSEIF gv_flag = 3.
    PERFORM make_bk3_visible.
  ENDIF.

*AT-SELECTION-SCREEN ON HELP-REQUEST FOR is an event that triggers when 'F1' is pressed on any selection screen element. For each
*of the screen elements the event needs to be handled separately. There is a standard function module for displaying a dialog box
*for displaying the documentation or a message for every screen element - POPUP_TO_INFORM.
AT SELECTION-SCREEN ON HELP-REQUEST FOR p_abc.
  CALL FUNCTION 'POPUP_TO_INFORM'
    EXPORTING
      titel         = 'F1 help for the dropdown listbox.' "This is the frame title of the box.
      txt1          = 'Select a value from the dropdown listbox.' "The first block of text of the dialog box.
      txt2          = 'Upon selecting the value, displays the appropriate block.'. "The second block of text of the dialog box.

*Instead of using local messages like below, I can define a global message class in transaction SE91. Many programs can use the
*same set of messages then. One global message class can contain up to 1000 messages.
*The 's' stand for 'status' - this message will be displayed as a status message at the bottom of SAP GUI. Afterwards comes the
*number of the message and in the brackets is the name of the message class I want the message from. The number of the message
*can also start with an 'i' - and it is then displayed in a dialogbox.
AT SELECTION-SCREEN ON HELP-REQUEST FOR p_c1.
*MESSAGE 'F1 help for the first checkbox' TYPE 'I'. - this is a regular local message.
 MESSAGE s000(ZBMIERZWI_TEST_MSG). "This is a message from the global class.
AT SELECTION-SCREEN ON HELP-REQUEST FOR p_c2.
  MESSAGE 'F1 help for the second checkbox' TYPE 'I'.
AT SELECTION-SCREEN ON HELP-REQUEST FOR p_c3.
  MESSAGE 'F1 help for the third checkbox' TYPE 'I'.
AT SELECTION-SCREEN ON HELP-REQUEST FOR p_r1.
  MESSAGE i001(ZBMIERZWI_TEST_MSG). "This is a message from the global class.
AT SELECTION-SCREEN ON HELP-REQUEST FOR p_r2.
  MESSAGE 'F1 help for the second radiobutton' TYPE 'I'.
AT SELECTION-SCREEN ON HELP-REQUEST FOR p_r3.
  MESSAGE 'F1 help for the third radiobutton' TYPE 'I'.

*&---------------------------------------------------------------------*
*&      Form  PREPARE_VALUES
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM prepare_values.
  CLEAR wa_values.
  wa_values-key  = 'K1'.
  wa_values-text = 'Courses'.
  APPEND wa_values TO lt_values.

  CLEAR wa_values.
  wa_values-key  = 'K2'.
  wa_values-text = 'Institutes'.
  APPEND wa_values TO lt_values.

  CLEAR wa_values.
  wa_values-key  = 'K3'.
  wa_values-text = 'Locations'.
  APPEND wa_values TO lt_values.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = 'p_abc'
      values          = lt_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.
  IF sy-subrc = 1.
    MESSAGE 'Exception ID Illegal name raised.' TYPE 'I'.
  ELSEIF sy-subrc = 2.
    MESSAGE 'An unknown exception raised.' TYPE 'I'.
  ENDIF.
ENDFORM.                    " PREPARE_VALUES
*&---------------------------------------------------------------------*
*&      Form  MAKE_BLOCKS_INV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM make_blocks_inv.
*By default I want all blocks to be invisible. LOOP AT SCREEN will loop through the internally created screen internal table that
*holds all the screen elements. The parameter is to remain visible. The screen's table's 'invisible' column is of CHAR data type so the
*value needs to be a string literal. screen is a header of the screen internal table. MODIFY SCREEN updates the actual body
*of the table with the value previously placed within the header.
*MODIF ID allows me to put every screen element into a group which I can refer to here. For example "screen-group1 = 'ID1" replaces
*"screen-name = 'BK1' OR screen-name = 'P_C1' OR screen-name = P_C2' OR screen-name = 'P_C3'". The blocks themselves ('BC1', 'BC2', 'BC3')
*and their titles ('T1', 'T2', 'T3') cannot be assigned to screen groups (cannot have MODIF ID). Apparently, the frame titles are
*more relevant here, because refering to "screen-name = 'T1'" in 'make_visible' subroutines encompasses both the block and the title
*whereas refering only to 'BC' doesn't actually even work - the block will not be made visible. Basically, adding "screen-name = 'BC1'"
*and others of the sort is reduntant.
  LOOP AT SCREEN.
    IF screen-group1 = 'ID1' OR screen-group1 = 'ID2' OR screen-group1 = 'ID3'.
      screen-invisible = '1'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.                    " MAKE_BLOCKS_INV

*&---------------------------------------------------------------------*
*&      Form  MAKE_BK1_VISIBLE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM make_bk1_visible.
  LOOP AT SCREEN.
    IF screen-group1 = 'ID1' OR
       screen-name = 'BC1' OR
       screen-name = 'T1' OR
       screen-name = 'P_ABC'.
      screen-invisible = '0'.
      MODIFY SCREEN.
    ELSE.
      screen-invisible = '1'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.                    " MAKE_BK1_VISIBLE

*&---------------------------------------------------------------------*
*&      Form  MAKE_BK2_VISIBLE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM make_bk2_visible.
  LOOP AT SCREEN.
    IF screen-group1 = 'ID2' OR
       screen-name = 'BC2' OR
       screen-name = 'T2' OR
       screen-name = 'P_ABC'.
      screen-invisible = '0'.
      MODIFY SCREEN.
    ELSE.
      screen-invisible = '1'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.                    " MAKE_BK2_VISIBLE

*&---------------------------------------------------------------------*
*&      Form  MAKE_BK3_VISIBLE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM make_bk3_visible.
  LOOP AT SCREEN.
    IF screen-group1 = 'ID3' OR
       screen-name = 'BC3' OR
       screen-name = 'T3' OR
       screen-name = 'P_ABC'.
      screen-invisible = '0'.
      MODIFY SCREEN.
    ELSE.
      screen-invisible = '1'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.                    " MAKE_BK3_VISIBLE

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*ON-CHANGE-OF. A HIERARCHIAL REPORT.
*---------------------------------------------------------------------------------------------------------------------------------

*An exercise program with the following requirements:
*- default the sales document input values to from 10 to 100,
*- restrict the user to enter only a single range,
*- fetch the corresponding header and item data of sales orders and display it in a hierarchial sequential list.

DATA: v_vbeln TYPE vbak-vbeln.

SELECT-OPTIONS so_vbeln FOR v_vbeln DEFAULT 10 TO 100 NO-EXTENSION. "Both 'I' and string value types will do for DEFAULT.

*I will be taking 'vbeln', 'erdat', 'erzet' and 'ernam' from VBAK and 'vbeln', 'posnr', 'matnr' and 'netwr' from VBAP.
*It is recommended that the fields are selected in the same sequence they are placed within the database table.
*I will need two internal tables, because I need multiple header records and multiple item records.
TYPES: BEGIN OF t_sales_header,
        vbeln TYPE vbak-vbeln,
        erdat TYPE vbak-erdat,
        erzet TYPE vbak-erzet,
        ernam TYPE vbak-ernam,
END OF t_sales_header.

DATA: it_sales_header TYPE TABLE OF t_sales_header,
      wa_sales_header TYPE t_sales_header.

TYPES: BEGIN OF t_sales_items,
        vbeln TYPE vbap-vbeln,
        posnr TYPE vbap-posnr,
        matnr TYPE vbap-matnr,
        netwr TYPE vbap-netwr,
END OF t_sales_items.

DATA: it_sales_items TYPE TABLE OF t_sales_items,
      wa_sales_items TYPE t_sales_items.

START-OF-SELECTION.
*First I am getting the data for the header of every document.
  PERFORM get_header_data.
*If data is there, for every document that's in the header table - I am getting the data for all the items included in that document.
  IF it_sales_header IS NOT INITIAL.
    PERFORM get_item_data.
  ENDIF.

*Both of the above functions simply select the data. So I've got two tables, hopefully filled with data, prepared for me to process
*further.
*I want to display a record from the header table, all the items for that document and only then the next record from the header table
*and so on.
  PERFORM display_data.

*&---------------------------------------------------------------------*
*&      Form  get_header_data
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM get_header_data.
  SELECT vbeln erdat erzet ernam
    FROM vbak
    INTO TABLE it_sales_header
    WHERE vbeln IN so_vbeln.
ENDFORM.                    "get_header_data

*&---------------------------------------------------------------------*
*&      Form  get_item_data
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*This is the optimal solution, without a SELECT in a LOOP.
*FOR ALL ENTRIES does the same thing, but does not require a loop. The SELECT statement is performed only once and SAP, instead of taking
*'vbelns' from 'wa_sales_header' one by one and performing a separate loop for them all, carries out a single SELECT during which it takes
*all desired data in one fell swoop.
FORM get_item_data.
  SELECT vbeln posnr matnr netwr
    FROM vbap
    INTO TABLE it_sales_items
    FOR ALL ENTRIES IN it_sales_header
    WHERE vbeln = it_sales_header-vbeln.
ENDFORM.

**The below solution is correct and gives the expexted results, but performing a SELECT statement inside the loop is not recommended. If
**a loop goes around 300 times, SELECT will be performed 300 times, increasing the network traffic, increasing the load on the database
**server and thus decreasing the overall performance.
*FORM get_item_data.
*  LOOP AT it_sales_header INTO wa_sales_header.
*    SELECT vbeln posnr matnr netwr
*      FROM vbap
**If I used INTO TABLE here, it would be overwriting the previously selected record
**with every loop. APPENDING TABLE appends every selected records to the table before
**moving on to the next one.
*      APPENDING TABLE it_sales_items
**INTO TABLE it_sales_items
*      WHERE vbeln = wa_sales_header.
*  ENDLOOP.
*ENDFORM.                    "get_item_data

*&---------------------------------------------------------------------*
*&      Form  display_data
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*In the below solution I am looping through the item table data only and every time a 'vbeln' changes (when the loop takes on a new 'vbeln'),
*ON CHANGE OF event is triggered. When that happens, READ TABLE places a record of the header table into the header work area and chooses what
*record it picks by comparing it to the currently processed 'vbeln' in the item table. Due to this section being placed at the start of the code,
*the data from the header table will be displayed first.
*When this is done, the loop proceeds to print out the data of the currently processed record from the item table. When the loop ends and goes
*back to the beginning - a new record is selected and if a change of 'vbeln' occurs - ON CHANGE OF is triggered again. Item table can contain
*many rows for the same 'vbeln' (document number) so making the reaching for the data from the header table dependant on the change of 'vbeln'
*makes sure that all the data for the current 'vbeln' from the item table will be printed out one after another.
*This solution loops only through the item table and "injects" the data about the same 'vbeln' from the item data table as is being currently
*processed at the beginning of the processing of every new document number ('vbeln').
FORM display_data.
  LOOP AT it_sales_items INTO wa_sales_items.
    ON CHANGE OF wa_sales_items-vbeln.
      CLEAR wa_sales_header.
      READ TABLE it_sales_header INTO wa_sales_header WITH KEY vbeln = wa_sales_items.
      IF sy-subrc = 0.
        FORMAT COLOR 3.
        WRITE: / wa_sales_header-vbeln,
                 wa_sales_header-erdat,
                 wa_sales_header-erzet,
                 wa_sales_header-ernam.
      ENDIF.
    ENDON.
    FORMAT COLOR 7.
    WRITE: / wa_sales_items-vbeln,
             wa_sales_items-posnr,
             wa_sales_items-matnr,
             wa_sales_items-netwr.
    FORMAT COLOR OFF.
  ENDLOOP.
ENDFORM.

**Below solution is correct, but not optimal due to nested loops.
*FORM display_data.
*  SORT it_sales_header BY vbeln.
*  SORT it_sales_items BY vbeln posnr.
*  LOOP AT it_sales_header INTO wa_sales_header.
*    FORMAT COLOR 3.
*      WRITE: / wa_sales_header-vbeln,
*               wa_sales_header-erdat,
*               wa_sales_header-erzet,
*               wa_sales_header-ernam.
**     WHERE clause is possible here! Due to that I will get only the items for the same document
**     that is being processed at the time. Without the WHERE, all items would be displayed,
**     regardless of their document number.
*      LOOP AT it_sales_items INTO wa_sales_items WHERE vbeln = wa_sales_header-vbeln.
*        FORMAT COLOR 7.
*          WRITE: /5 wa_sales_items-vbeln, "'5' means 'leave 5 spaces first'.
*                    wa_sales_items-posnr,
*                    wa_sales_items-matnr,
*                    wa_sales_items-netwr.
*       ENDLOOP.
*  ENDLOOP.
*ENDFORM.                    "display_data

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*INTERACTIVE REPORTING. TOP-OF-PAGE, END-OF-PAGE, TOP-OF-PAGE DURING LINE SELECTION, AT LINE-SELECTION.
*---------------------------------------------------------------------------------------------------------------------------------

*If my program is just generating a report and I cannot interact in any way with the results - I get only "one level" of a report
*- it's static reporting. If I get one list of results, it's static reporting.
*Results of a report can be interactive - based on a user's interaction, I can display additional data in the next list. That's called
*interactive reporting.
*When a static report is at work - upon execution I might get a selection screen and, when the parameters are provided, the report is
*displayed. This is a one level report.
*When an interactive reporting is being deployed - the first report/list I am getting is called Basic List (it has an index of 0). When
*a user interacts with the list (e.g. double-clicks a row), I get a second level of report. This operation can be 21 levels deep. From
*the second list onwards, they are called Secondary Lists (indexes from 1 to 20).
*Whenever I run the program, I should get a selection screen where I should be able to provide a range of customer numbers. Results
*from KNA1 should be displayed. This is the Basic List (index 0). Whenever I interact with any of the displayed rows, e.g. double-click
*a customer number, I should check if that customer has any sales orders associated with them. If so - then I should get them and
*display them in the next list - Secondary List (index 1). Again, upon double-clicking a sales order - I should have the sales items
*associated displayed in the next list - Secondary List (index 2). Whenever a MATNR in that list is clicked, I should display a standard
*transaction - MM03 (responsible for displaying the material data).
*The INCLUDE for data declarations.
INCLUDE Z_BMIERZWINSKI_DEV_TEST_TOP.
INCLUDE Z_BMIERZWINSKI_DEV_TEST_SUB.

START-OF-SELECTION.
*Subroutines are defined in the INCLUDE Z_BMIERZWINSKI_DEV_TEST_SUB.
  PERFORM get_customers.
  IF it_customers IS NOT INITIAL.
    PERFORM display_customers.
  ELSE.
    MESSAGE 'No customers have been found.' TYPE 'I'.
  ENDIF.

*TOP-OF-PAGE is an event triggered in the Basic List to generate a heading. If I have a single statement there
*(WRITE), it means one line per page is reserved for that statement. If I added ULINE there too, that would be
*two lines reserved. It related to "LINE-COUNT" specified next to the name of the report. If i have it as 10(3),
*it means the page is 10 lines long and 3 of them are reserved for the footer. There are 7 lines left, one of them
*(just the WRITE) is taken by the header. So the results themselves will take only 6 lines out of 10. If I set
*the LINE-COUNT to say 4(2) and then made my header have two lines, I would get a runtime error if there were
*any records to be displayed, because there's no space for them left.
TOP-OF-PAGE.
  WRITE: /(20) 'CUSTOMER MASTER DATA' COLOR 1.
  
*END-OF-PAGE works just like TOP-OF-PAGE but generates a footer instead. This event is triggered only when
*control reaches the end of the page. I need to instruct SAP how many lines I want reserves for a page. This
*is done by adding LINE-COUNT to the name of the report. E.g. LINE-COUNT 10(3) which means I want 10 lines per
*page and the last 3 are for the footer (7 for the body). Basically - after every seventh line a footer will
*appear. In this case I am generating three lines for the footer - the ULINE and two WRITES. If I reserved
*only two lines for the footer - 10(2), I wouldn't be able to have all three lines generated and
*Hoofie Technologies" would be lost.
*LINE-COUNT added to the name of the report is mandatory for END-OF-PAGE to display anything.
END-OF-PAGE.
  FORMAT COLOR 2.
  ULINE.
  WRITE: /15 'SAP training.',
         /1  'Hoofie Technologies'.
  FORMAT COLOR OFF.

*TOP-OF-PAGE DURING LINE SELECTION event is the same as above, but works for the Secondary Lists. If I want
*only specific Secondary Lists, I need to differentiate between them with the CASE statement and indexes.
*'sy-lsind' contains the index of the next available Secondary List.
TOP-OF-PAGE DURING LINE-SELECTION.
  CASE sy-lsind.
    WHEN 1. "Secondary List index 1 (after the Basic List's row has been double-clicked).
      WRITE: /(20) 'SALES ORDERS' COLOR 1.
    WHEN 2. "Secondary List index 2 (after the Secondary List index 1's row has been double-clicked).
      WRITE: /(20) 'SALES ITEMS' COLOR 1.
  ENDCASE.

*AT LINE-SELECTION is an event triggered whenever I click on any value in the list in the Basic List.
AT LINE-SELECTION.
*'sy-lisel' stores the content of the selected line.
*  WRITE: 'The selected line is ', sy-lisel.
*'sy-lsind' contains the index of the next available Secondary List.
CASE sy-lsind.
  WHEN 1.
*To extract the customer number from 'sy-lisel' which stores the content of any selected line.
*I am using a previously declared variable. 'sy-lisel' contains the entire line, but 'kunnr' is at the very beginning
*of it. I am making it 20 characters' long despite 'kunnr' being of only 10 chracters' long because I already reserved
*20 first spaces of a line for 'kunnr' in the displaying perform. Blanks will be ignored anyway.
    CLEAR v_kunnr.
    v_kunnr = sy-lisel+0(20). "Extracting a portion of a string is called 'offset logic'.
*    WRITE: / 'Customer number: ', v_kunnr.
    IF v_kunnr IS NOT INITIAL.
*If a customer is found and then clicked - it will be stored in 'sy-lisel'. Clicking it will trigger the Secondary List
*of the index 1 and I want that List to contain a list of sales orders for the chosen customer.
      PERFORM get_sales_orders.
      IF it_sales_orders IS NOT INITIAL.
        PERFORM display_sales_orders.
      ELSE.
        MESSAGE 'No sales orders have been found for the selected customer.' TYPE 'I'.
      ENDIF.
    ENDIF.
*When I am in the Secondary List index 1 and I double-click any of the lines (with Sales Orders), I want to move to
*the Secondary List index 2 which contains sales orders' items (one sales order might contain many items).
*VBAK and VBAP are linked via 'vbeln'.
*There are three ways for me to achieve this (the third is described in 'WHEN 3' section).
  WHEN 2.
*1. I need to extract it from 'sy-lisel' just like I was doing it before to get 'kunnr' for the first Secondary List.
*    CLEAR v_vbeln.
*'v_vbeln' might, like 'kunnr' above, not be of ten characters so the database query based on it, will require the UNPACK.
*    v_vbeln = sy-lisel+0(10).
*    IF v_vbeln IS NOT INITIAL.
*2. Use Hide Memory Area. It's a hidden memory area which can have values put into it by using HIDE keyword. I am doing
*   that in the 'display_sales_orders' perform in the Basic List - all values are displayed in the List Processing Screen,
*   BUT every 'vbeln' is also placed within Hide Memory Area. Upon the changing of the screens (from the Basic List to
*   the Secondary List index 1 or from the Secondary List index 1 to Secondary List index 2 and so on) - so upon the
*   triggering of AT LINE-SELECTION event, the Hide Memory Area is cleared with the exception of the value associated with
*   the line the user has clicked. Thus, I can place a value I will need to get more values in the following Secondary List
*   into Hide Memory Area (e.g. place all 'vbelns' there) and when the user clicks a line, the same work area I was using
*   to display the values in the previous List will now contain the value associated with the selected line.
      PERFORM get_sales_items.
      IF it_sales_items IS NOT INITIAL.
        PERFORM display_sales_items.
      ELSE.
        MESSAGE 'No sales items have been found for the selected sales document.' TYPE 'I'.
      ENDIF.
*     ENDIF.
*When 'matnr' is double-clicked, I want the transaction MM03 displayed. The selected material number should be automatically
*placed within MM03's input box. I need the 'Parameter ID' of the input box for that. I can check it via F1 -> Technical Details.
*In this case, it's 'MAT'.
  WHEN 3.
*I could extract 'matnr' from 'sy-lisel'. 'matnr' starts from the 19th character, so the index would be 18, because the indexing
*starts at 0. Two previous values in the line took up 10 and 6 characters respectively, but there's also two blanks there.
*18 is the length of the data element of 'matnr'. Instead of extracting 'matnr' from 'sy-lisel', I could again use Hide Memory
*Area. During the 'display_sales_items' perform, I would need to HIDE every 'matnr' there. Thus it would be sufficient for me to
*simply refer to the work area that was used during the hiding.
*3. Instead, I am doing the third way.
*   I need to get the field's name and field's value the user has interacted with. GET CURSOR FIELD will save the name of the field
*   that has been clicked and VALUE will save its value. I have declared my custom variables to hold both of these. If the name
*   of the field clicked is equal to the work area's field holding material, then I am placing its value into the input box of
*   MM03 transaction. If any other field is clicked - a message will pop up.
*   'v_matnr' has been declared as a specific data type (vbap-matnr) because SET PARAMETER ID requires either a character, an
*   alphanumeric or a specific data type and string ('v_fvalue' is a string) will not suffice.
      GET CURSOR FIELD v_fname VALUE v_fname.
      IF v_fname EQ 'WA_SALES_ITEMS-MATNR'.
        CLEAR v_matnr.
        v_matnr = v_fvalue.
        SET PARAMETER ID 'MAT' FIELD v_matnr.
        CALL TRANSACTION 'MM03'.
      ELSE.
        MESSAGE 'Please, select material only.' TYPE 'I'.
      ENDIF.
ENDCASE.

********************************************
*THE INCLUDES ARE DEFINED BELOW
********************************************

*&---------------------------------------------------------------------*
*&  Include           INTERACTIVE_REPORTING_TOP
*&---------------------------------------------------------------------*

DATA: v_kunnr TYPE kna1-kunnr, "To be used by the first method of retaining the value of what use has interacted with for the following Secondary Lists.
      v_fname TYPE string, "To be used by the third (yes, third, not second) method of retaining the value of what use has interacted with for the following Secondary Lists.
      v_fvalue TYPE string, "To be used by the third (yes, the second doesn't need a variable) method of retaining the value of what use has interacted with for the following Secondary Lists.
      v_matnr TYPE vbap-matnr. "Required for SET PARAMETER ID to place a value into the input box of MM03 transaction as a string will not suffice. Character, alphanumeric or a certain data
                               "type will be accepted.
SELECT-OPTIONS so_kunnr FOR v_kunnr DEFAULT '1000' TO '1010'.

TYPES: BEGIN OF ty_customers,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kna1-land1,
  name1 TYPE kna1-name1,
END OF ty_customers.
DATA: it_customers TYPE STANDARD TABLE OF ty_customers,
      wa_customers TYPE ty_customers.

TYPES: BEGIN OF ty_sales_orders,
  vbeln TYPE vbak-vbeln,
  erdat TYPE vbak-erdat,
  erzet TYPE vbak-erzet,
  ernam TYPE vbak-ernam,
END OF ty_sales_orders.
DATA: it_sales_orders TYPE STANDARD TABLE OF ty_sales_orders,
      wa_sales_orders TYPE ty_sales_orders.

TYPES: BEGIN OF ty_sales_items,
  vbeln TYPE vbap-vbeln,
  posnr TYPE vbap-posnr,
  matnr TYPE vbap-matnr,
  netwr TYPE vbap-netwr,
END OF ty_sales_items.
DATA: it_sales_items TYPE STANDARD TABLE OF ty_sales_items,
      wa_sales_items TYPE ty_sales_items.

*----------------------------------------------------------------------*
***INCLUDE INTERACTIVE_REPORTING_SUB.
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Form  GET_CUSTOMERS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_customers .
  SELECT kunnr land1 name1
    FROM kna1
    INTO TABLE it_customers
    WHERE kunnr IN so_kunnr.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  DISPLAY_CUSTOMERS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM display_customers.
  ULINE.
  FORMAT COLOR 3.
  WRITE: /(21) 'Customer number', (14) 'Country key', (40) 'Customer name'.
  FORMAT COLOR OFF.
  ULINE.
  FORMAT COLOR 7.
  LOOP AT it_customers INTO wa_customers.
    WRITE: /(20) wa_customers-kunnr,
                 sy-vline, "Prints a vertical line.
            (12) wa_customers-land1,
                 sy-vline,
            (40) wa_customers-name1.
  ENDLOOP.
  FORMAT COLOR OFF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  GET_SALES_ORDERS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_sales_orders.
*VBAK requires 'kunnr' to be of 10 characters' length, but 'kunnr' coming from KNA1 not necesserily will.
*In order to have it work correctly, I need to supply leading zeros in case the 'kunnr' is shorter than
*10 characters. If it's 1234, I need to make it 0000001234 - the number of zeroes I might need to add will
*vary.
*UNPACK is one way to achieve this. It will prefix the given variable with as many zeroes as is needed to
*achieve the length of the data type of another provided variable.
*  UNPACK v_kunnr TO v_kunnr.
*'CONVERSION_EXIT_ALPHA_INPUT' function module is another way of achieving the same result.
  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input         = v_kunnr
    IMPORTING
      output        = v_kunnr.

  SELECT vbeln erdat erzet ernam
    FROM vbak
    INTO TABLE it_sales_orders
    WHERE kunnr = v_kunnr.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  DISPLAY_SALES_ORDERS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM display_sales_orders .
  LOOP AT it_sales_orders INTO wa_sales_orders.
    WRITE: / wa_sales_orders-vbeln,
             wa_sales_orders-erdat,
             wa_sales_orders-erzet,
             wa_sales_orders-ernam.
*HIDE places a chosen variable within Hide Memory Area which is an invisible memory area. First 'vbeln' is
*displayed on the List Processing Screen just like any other variable, but additionally I am putting every
*'vbeln' into Hide Memory Area. Upon changing the screens, SAP will clear the entire Hide Memory Area and
*will retain only the value associated with the line with which the user has interacted.
    HIDE wa_sales_orders-vbeln.
  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  GET_SALES_ITEMS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_sales_items.
*To make sure 'v_vbeln' has ten characters and zeroes are prefixed if necessary to reach the length of 10.
*It would be required if I was utilizing 'sy-lisel' for this task, but I am trading it for HIDE, so I will
*be getting 'vbeln' from Hide Memory Area instead. No need to UNPACK it thus. The 'vbeln' will come
*directly from the work area too, as this is where the mechanism of Hide Memory Area will store the value
*associated with the line the user has clicked!
*  UNPACK v_vbeln TO v_vbeln.
*  SELECT vbeln posnr matnr netwr
*    FROM vbap
*    INTO TABLE it_sales_items
*    WHERE vbeln = v_vbeln.

  SELECT vbeln posnr matnr netwr
    FROM vbap
    INTO TABLE it_sales_items
    WHERE vbeln = wa_sales_orders-vbeln.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DISPLAY_SALES_ITEMS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM display_sales_items.
*HOTSPOT ON means the hand symbol will be displayed when the cursor hovers over that field. Also, just a single click will
*be required to trigger AT LINE-SELECTION event.
  LOOP AT it_sales_items INTO wa_sales_items.
    WRITE: / wa_sales_items-vbeln,
             wa_sales_items-posnr,
             wa_sales_items-matnr HOTSPOT ON,
             wa_sales_items-netwr.
*    HIDE wa_sales_items-matnr.
  ENDLOOP.
ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------