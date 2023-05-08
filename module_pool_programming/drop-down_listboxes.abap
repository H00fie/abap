*---------------------------------------------------------------------------------------------------------------------------------
*DROP-DOWN LISTBOXES.
*---------------------------------------------------------------------------------------------------------------------------------

*I go to SE80 and create a new MP program with a TOP INCLUDE - 'Z_BM_TEST_MPP7'. I create a new screen (100) and move to Layout to
*design the screen. I draw the 'Input/Output Field' (the third button from the top) in my screen and name it 'IO1'. I want that field
*to act like a drop-down list of values and to that end I need to set the 'Dropdown' property of that field. I can choose between
*the 'Listbox' and 'Listbox with key' options. The latter choice would make the possible values be displayed along with their key.
*That doesn't seem to be very helpful for the user so the former option it is. Next I draw a 'Text field' next to my input field, name
*it 'T1' and set its text to 'Select a value'. I draw a 'Pushbutton' that will give the user the option to exit the program. Its
*name is 'B1', its text is 'Exit' and its function code is 'FC1'.
*Now I move to the flow logic section of screen 100 and uncomment the 'user_command_0100' module. It is here that the logic for
*exitting the program is to be written as pressing a pushbutton trigges the PAI event.
*The 'user_command_0100' looks like this:
**********************************************************************
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
  	WHEN 'FC1'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
**********************************************************************

*Now I create the transaction code. The transaction's name is 'ZBMI9', its program is 'Z_BM_TEST_MPP7' and its screen number is 0100.
*As usual, I need to check the 'SAP GUI for Windows' checkbox.

*Now I would like to make my drop-down list actually display a set of values. In order to make it happen, I am to use a standard
*function module - 'vrm_set_values'. I need to pass two parameters into the function module. One is the ID and the second is an internal
*table of the 'vrm_values' type which is of the 'vrm' type group. That table type contains two fields - KEY and TEXT, both of C type.
*Thus I need to prepare a table of 'vrm_values' which I will pass into the function module to populate my drop-down list. I want the
*values to be present by default so the logic needs to be handled within the PBO event.
*Hence I uncomment the 'status_0100' module within the PBO event of the flow logic section of screen 100. I want the function providing
*values to my drop-down list to be executed only once which I can ensure by utilizing a flag variable. The function in question (the
*module responsible for populating the drop-down list) will be triggered at the beginning of the program's lifecycle (because it's in
*the PBO event) and also only if the flag variable is of its default value (0, due to being of I type). Given that right afterwards that
*default value is changed... it will occur only once. Afterwards I am appending the key-text pairs to the 'lt_values' internal table
*and finally calling the standard SAP function module - 'vrm_set_values' to finalize my custom value list for my drop-down listbox.
*I need to declare my flag variable and both the internal table and the work area that will be required to handle the data necessary
*for my drop-down list. 'lt_values' can just be the TYPE instead of TYPE TABLE because 'vrm_values' already is an internal table. In
*SAP 7.5 this should no longer be necessary but if 'vrm_values' was not recognised I would need to explicitly declare its type group
*('TYPE-POOLS: vrm.').
*The top part of my TOP INCLUDE now looks like this:
**********************************************************************
PROGRAM Z_BM_TEST_MPP7.

DATA: lv_flag    TYPE i,
      lt_values  TYPE vrm_values,
      lwa_values LIKE LINE OF lt_values.
**********************************************************************

*And the 'status_0100' module itself looks like this:
**********************************************************************
MODULE status_0100 OUTPUT.
  IF lv_flag = 0.
    lv_flag = 1.
    CLEAR: lwa_values.
    lwa_values-key  = 'K1'.
    lwa_values-text = 'Czavoska'.
    APPEND lwa_values TO lt_values.
    CLEAR: lwa_values.
    lwa_values-key  = 'K2'.
    lwa_values-text = 'Minnos'.
    APPEND lwa_values TO lt_values.
    CLEAR: lwa_values.
    lwa_values-key  = 'K3'.
    lwa_values-text = 'Tardhaghar'.
    APPEND lwa_values TO lt_values.
    CLEAR: lwa_values.
    lwa_values-key  = 'K4'.
    lwa_values-text = 'Attos'.
    APPEND lwa_values TO lt_values.
    CLEAR: lwa_values.
    lwa_values-key  = 'K5'.
    lwa_values-text = 'Dumuzdin'.
    APPEND lwa_values TO lt_values.
    CLEAR: lwa_values.
    lwa_values-key  = 'K6'.
    lwa_values-text = 'Ivariar'.
    APPEND lwa_values TO lt_values.
    CLEAR: lwa_values.
    lwa_values-key  = 'K7'.
    lwa_values-text = 'Nasfahlenii'.
    APPEND lwa_values TO lt_values.
    CLEAR: lwa_values.
    lwa_values-key  = 'K8'.
    lwa_values-text = 'Rodgalikan'.
    APPEND lwa_values TO lt_values.
    CLEAR: lwa_values.
    lwa_values-key  = 'K9'.
    lwa_values-text = 'Tragida'.
    APPEND lwa_values TO lt_values.
    CLEAR: lwa_values.
    lwa_values-key  = 'K10'.
    lwa_values-text = 'Ezzah'.
    APPEND lwa_values TO lt_values.
    CALL FUNCTION 'VRM_SET_VALUES'
      EXPORTING
        id                    = 'IO1'
        values                = lt_values. "WARNING: despite the drop-down listox type set to 'Listbox' and not 'Listbox with keys',
  ENDIF.                                   "         the keys are visible during runtime.
ENDMODULE.
**********************************************************************

*Now I'd also like to implement three additional blocks in my screen - one with radiobuttons, one with checkboxes and the third
*one with text fields.
*I move to the Layout of screen 100, choose the 'Checkbox' button (the fourth from the top in the toolbox on the left hand side
*of the screen) and draw three checkboxes in a column. The first one's name is 'C1', text 'Attalos', the second's 'C2' and 'Abydon
*and the thirds' 'C3' and 'Torcali'. Now I select the 'Box' option from the toolbox (the sixth option from the bottom) and draw
*it around the checkboxes. I double-click the created box, give it the name 'BX1' and text 'Plushies'.
*Now to create radiobuttons - I select the 'Radio button' option from the toolbox and create three of those in a column below the
*checkboxes. Their properties are 'RB1' and 'Roganon', 'RB2' and 'Njord' and 'RB3' and 'Bor'. I create a 'Box' around them - 'BX2'
*and 'More plushies'.
*I move to create the text fields. I select the 'Text Field' button and draw three of those below the radiobuttons. They are 'T2'
*('T1' already exists) with 'Amenouzume', 'T3' with 'Amyntas' and 'T4' with 'Salem'. The box around them is 'BX3' and 
*'Even more plushies'.

*Right now, the user can select all three radiobuttons at the same time. I want only one of them to be able to be active at any
*given time. In order to do it I need to group them. In case of selection screen programs I would use the syntax RADIOBUTTON GROUP
*followed by the group's name. In case of MP programs I need to select the first radiobutton, hold the CTRL key and select the
*two remaining radiobuttons. Then I need to right-click the area of the selected elements and choose 'Radio Button Group' and then
*'Define'. Now if I click the thus created area I can attach the function code to the created group. It was not possible to attach
*a function code to a single radiobutton. As a side note, I can attach a function code to a single checkbox and to a drop-down listbox
*(created for an input field) but I cannot attach a function code to a regular input field.
*Now, the first radiobutton within a group will be checked by default, but selecting another will disable the previously checked one.
*Only a single radiobutton within a group can be active at a time.

*I want all the checkboxes, radiobuttons, text fields and their boxes to be invisible by default. To start the process, I select
*every one of these elements separately (including the boxes) and assign the 'Groups' property to them. This refers to the concept
*of the screen group - it will allow me to make the elements invisible by refering to the 'screen' internal table. The checkboxes
*and their box are of group 'G1', radiobuttons 'G2' and text fields 'G3'.
*The first event triggered upon the execution of the program is PBO. Hence I write the logic for making my chosen screen elements
*invisible within the 'status_0100' module.
*If a screen element belongs to a group 'G1', 'G2' or 'G3 - that element's 'invisible' property is set to '1', which makes it
*invisible.
*The 'status_0100' module now looks as below. The populating of the 'lt_values' and the calling of the 'vrm_set_values' have been 
*extracted to the 'prepare_values' form.
**********************************************************************
MODULE status_0100 OUTPUT.
  IF lv_flag = 0.
    lv_flag = 1.
    PERFORM prepare_values.
    PERFORM make_blocks_invisible.
  ENDIF.
ENDMODULE.
**********************************************************************

*The 'make_blocks_invisible' module looks like this:
**********************************************************************
FORM make_blocks_invisible .
  LOOP AT SCREEN.
    IF screen-group1 = 'G1' OR
       screen-group1 = 'G2' OR
       screen-group1 = 'G3'.
      screen-invisible = '1'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.
**********************************************************************

*I want certain blocks of elements to become visible depending on what value is chosen from the drop-down listbox. In order to
*make it happen I first assign my drop-down listbox a function code 'FC2' within the Layout of screen 100. When a value from a
*drop-down listbox is selected, the PAI event is triggered, so it is here where I need to proceed. The 'user_command_0100' module
*handles the actions depending on the value of 'sy-ucomm' so I expand this function. So whenever a value in a drop-down listbox
*is selected the function code of 'FC2' (in my case) will be assigned to the 'sy-ucomm' variable... AND that chosen value's key
*will be placed within the listbox internally. My listbox's (the input field's) name is 'IO1' and I can refer to it (after having
*explicitly declared it since I need to do this if I want to refer to any screen fields) to determine what value has been chosen.
*The data type of that drop-down listbox is C and it is of the length of two.
*Now, in the 'user_command_0100' module I can request SAP, if a value of the drop-down list has been selected (if 'sy-ucomm'
*is 2), to check the value of the drop-down listbox screen field (as it now holds the key of the chosen option) and, based on that,
*I can set the 'gv_flag' variable to have a value that will inform the screen refreshing logic (in PBO) how the screen needs to be
*adjusted. Having done that I go to augment the 'status_0100' module within PBO - since it is PBO, that module will triggered at
*the very execution of the program and after every run of the PAI module. Thus that module can both hold the logic that sets the
*default layout of the screen (by making some screen elements invisible) and the logic that makes appropriate screen elements
*visible - always depending on what value has been assigned to 'gv_flag' during the PAI event (so what option has been chosen).
*In order to ensure that the drop-down listbox, the 'Select a value' text field and the 'Exit' button remain visible at all times,
*I assign the value of 'G4' to each of these elements' 'Groups' property and explicitly inform SAP, within the forms making certain
*screen elements visible, that these three elements ('G4') are ever to remain visible.
*
*The top part of my TOP INCLUDE now looks like this:
**********************************************************************
PROGRAM Z_BM_TEST_MPP7.

DATA: lv_flag    TYPE i,
      lt_values  TYPE vrm_values,
      lwa_values LIKE LINE OF lt_values,
      io1(2)     TYPE c.
**********************************************************************

*The 'user_command_0100' looks like this:
**********************************************************************
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'FC1'.
      LEAVE PROGRAM.
    WHEN 'FC2'.
      IF io1 = 'K1'.
        gv_flag = 2.
      ELSEIF io1 = 'K2'.
        gv_flag = 3.
      ELSEIF io1 = 'K3'.
        gv_flag = 4.
      ENDIF.
  ENDCASE.
ENDMODULE.
**********************************************************************

*And the 'status_0100' module looks as follows:
**********************************************************************
MODULE status_0100 OUTPUT.
  IF lv_flag = 0.
    lv_flag = 1.
    PERFORM prepare_values.
    PERFORM make_blocks_invisible.
  ELSEIF lv_flag = 2.
    PERFORM make_block_one_visible.
  ELSEIF lv_flag = 3.
    PERFORM make_block_two_visible.
  ELSEIF lv_flag = 4.
    PERFORM make_block_three_visible.
  ENDIF.
ENDMODULE.
**********************************************************************

*The 'make_block_one_visible' form:
**********************************************************************
FORM make_block_one_visible .
  LOOP AT SCREEN.
    IF screen-group1 = 'G1' OR
       screen-group1 = 'G4'.
      screen-invisible = '0'.
      MODIFY SCREEN.
    ELSEIF screen-group1 = 'G2' OR
           screen-group1 = 'G3'.
      screen-invisible = '1'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.
**********************************************************************

*The 'make_block_two_visible' form:
**********************************************************************
FORM make_block_two_visible .
  LOOP AT SCREEN.
    IF screen-group1 = 'G2' OR
       screen-group1 = 'G4'.
      screen-invisible = '0'.
      MODIFY SCREEN.
    ELSEIF screen-group1 = 'G1' OR
           screen-group1 = 'G3'.
      screen-invisible = '1'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.
**********************************************************************

*The 'make_block_three_visible' form:
**********************************************************************
FORM make_block_three_visible .
  LOOP AT SCREEN.
    IF screen-group1 = 'G3' OR
       screen-group1 = 'G4'.
      screen-invisible = '0'.
      MODIFY SCREEN.
    ELSEIF screen-group1 = 'G1' OR
           screen-group1 = 'G2'.
      screen-invisible = '1'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.
**********************************************************************

*Now I would like to have a pop-up window displayed every time a checkbox or a radiobutton is selected or deselected with the
*information which screen element is being interacted with.
*Whenever a checkbox is selected or deselected, in case of selection screens, the AT SELECTION-SCREEN event is triggered. In
*case of MP programs, that is the PAI event. To be able to identify what screen element is being interacted with, I need to
*make sure every of these elements has a function code assigned to it. When that's the case - the switch case (hehe) within the
*PAI event can determine what action is to be performed based on the current value of 'sy-ucomm'. I move to the Layout of screen
*100 and assign the following screen elements the following function codes: 'Attalos' - 'FC3', 'Abydon' - 'FC4', 'Torcali' - 'FC5',
*'Roganon', 'Njord' and 'Bor' - 'FC6'. The last three share a single function code because they are radiobuttons grouped together.
*Next, based on the value of 'sy-ucomm', I am checking if the corresponding screen element has been selected (has the value of 'X')
*or deselected (has no value). I am referring to the screen elements by their names and, in order to refer to the screen elements
*at all - I need to declare them explicitly. At last, based on whether the screen element is selected or deselected a proper
*information is displayed in the form of a pop-up window. The radiobuttons do not display the information about having been
*deselected because they form a group - at any point in time only one of them can be selected and selecting one automatically
*deselects others.

*The top part of my TOP INCLUDE now looks like this:
**********************************************************************
PROGRAM Z_BM_TEST_MPP7.

DATA: lv_flag    TYPE i,
      lt_values  TYPE vrm_values,
      lwa_values LIKE LINE OF lt_values,
      io1(2)     TYPE c,
      c1         TYPE c,
      c2         TYPE c,
      c3         TYPE c,
      rb1        TYPE c,
      rb2        TYPE c,
      rb3        TYPE c.
**********************************************************************

*The 'user_command_0100' module now looks like this:
**********************************************************************
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'FC1'.
      LEAVE PROGRAM.
    WHEN 'FC2'.
      IF io1 = 'K1'.
        lv_flag = 2.
      ELSEIF io1 = 'K2'.
        lv_flag = 3.
      ELSEIF io1 = 'K3'.
        lv_flag = 4.
      ENDIF.
    WHEN 'FC3'.
      IF c1 = 'X'.
        MESSAGE 'Attalos selected!' TYPE 'I'.
      ELSE.
        MESSAGE 'Attalos deselected.' TYPE 'I'.
      ENDIF.
    WHEN 'FC4'.
      IF c2 = 'X'.
        MESSAGE 'Abydon selected!' TYPE 'I'.
      ELSE.
        MESSAGE 'Abydon deselected.' TYPE 'I'.
      ENDIF.
    WHEN 'FC5'.
      IF c3 = 'X'.
        MESSAGE 'Torcali selected!' TYPE 'I'.
      ELSE.
        MESSAGE 'Torcali deselected.' TYPE 'I'.
      ENDIF.
    WHEN 'FC6'.
      IF rb1 = 'X'.
        MESSAGE 'Amenouzume selected!' TYPE 'I'.
      ELSEIF rb2 = 'X'.
        MESSAGE 'Amyntas deselected.' TYPE 'I'.
      ELSEIF rb3 = 'X'.
        MESSAGE 'Salem deselected.' TYPE 'I'.
      ENDIF.
  ENDCASE.
ENDMODULE.
**********************************************************************

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------