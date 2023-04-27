*---------------------------------------------------------------------------------------------------------------------------------
*TABSTRIP CONTROL.
*---------------------------------------------------------------------------------------------------------------------------------

*Tabstrip control is a collection of tab buttons. E.g. if I went to SE11 and opened the KNA1 database table, all the tabs I could see -
*'Attributes', 'Fields' etc constitute the tabstrip control. Selecting each tab results in a different screen being displayed - these are
*called subscreens. At any given time one of the tabs has to be the active tab. A subscreen cannot be positioned directly on the "main"
*screen, it always needs to be placed within the bounds of a subscreen area. A subscreen area is thus a container of subscreens. One
*subscreen area can contain multiple subscreens.
*Tabstrip control can be used if instead of grouping all fields together in one screen I want to logically separate them, e.g. Tab 1
*could display the employee fields, Tab 2 could display the department fields, Tab 3 could display the address fields.

*I want to design a screen with the tabstrip control with two tabs each of which associated with a subscreen. I want the second tab to
*be active by default. Thus my MP program will consist of three screens - a normal screen and two subscreens.
*I go to SE80, create a program 'Z_BM_TEST_MPP5' with the TOP INCLUDE. Now I create the screen (100) and go to the Layout. First, I design
*the normal screen - here the tabstrip control will reside. The panel on the left hand side of the screen contains the 'Tabstrip Control'
*button - it's the seventh button from the top. I draw the element in the screen and double click it (every element in the screen needs
*its own name). The name I give is 'TBSTR'. In the 'Attributes' section down below There's a 'Tab Title' option with an input box to
*the right. That box contains a number and it represents the number of tabs my tabstrip control contains. Whatever number I provide here,
*that many tabs will appear as part of my tabstrip control.
*I need to set the properties of my tabs separately. In case of pushbuttons I need to set the name, text and function code. All of these
*also need to be set in case of tabbuttons but they also require the setting of the 'Ref. Field' property. It should contain the name
*of the subscreen area.
*I double click the first tabbutton and set its name to 'T1', text to 'Nezuko', function code to 'FC1' and reference field to 'SAREA1'.
*Now I choose the fifth button from the bottom from the panel on the left hand side of the Screen Painter tool ('Subscreen Area') and draw
*the subscreen area under the 'Nezuko' tabbutton. I double click it and realize the subscreen's name is automatically set to 'SAREA1'.
*Now I move to the second tab. I set its name to 'T2', text to 'Halibel', function code to 'FC2' and reference field is again 'SAREA1'.
*My tabbuttons share the same subscreen area.

*I now move on to create the Exit button. The name is 'B1', text 'Exit' and function code 'FC3'. Clicking a pushbutton triggers the PAI
*event - it's here I will write the logic for my button. As for now I only have one screen so it's obvious in which flow logic section
*I need to write the code for my button. I uncomment the 'Module USER_COMMAND_0100' and create it within the TOP INCLUDE.
*The logic looks like that:
********************************************************************
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'FC3'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
********************************************************************

*Now I need a transaction. I name it 'ZBMI7'. The screen number for it is '0100' (the main screen of my program), and GUI support is
*'SAP GUI for Windows'.

*My program now activates without problems but trying to run it results in a runtime error. When a screen contains a table control
*component, it needs to be explicitly declared using the keyword CONTROLS. The tabstrip control works in the same manner - it needs to
*be declared explicitly with CONTROLS. The data type of a tabstrip control is TABSTRIP.
*The top of my TOP INCLUDE now looks like this:
********************************************************************
PROGRAM Z_BM_TEST_MPP5.

CONTROLS: tbstr TYPE TABSTRIP.
********************************************************************

*By default the first tab is active. Every tabbutton needs to be associated with a subscreen so I need to create these two subscreens.
*In order to do that I double click the name of my MP program, select Create and pick Screen. I provide the number '200' and set
*the 'Screen Type' radiobutton to 'Subscreen'. I immediately go to Layout (the Screen Painter tool, quite obviously, is separate for
*every screen of my program) and lower the size of the screen - I can grab its corner and resize it. I draw a 'Text field', name it
*'T1' and give it the text of 'Nezuko best girl'. I could design it differently, of course, for instance I could place database table's
*fields here if I so desired.
*Now I create the second subscreen. Its number is '300' and its 'Text field' goes by the name of 'T2' and displays the text
*'Halibel best girl'.

*I now have a normal screen and two subscreens. The first tab of the two is active and I want the second to be. The '200' subscreen
*is to be assigned to 'Nezuko' and '300' to 'Halibel'.
*In my TOP INCLUDE I declare a variable ('v_scrno') that's to hold the screen number. It's value is '300' to begin with so that the second tab
*might be the default one.
*The upper part of my TOP INCLUDE now looks like this:
********************************************************************
PROGRAM Z_BM_TEST_MPP5.

CONTROLS: tbstr TYPE TABSTRIP.

DATA: v_scrno TYPE sy-dynnr VALUE '300'.
********************************************************************

*My transaction code is linked to the normal screen of my MP program and whenever a MP screen is called, the first event triggered is PBO.
*I can have the subscreen of my choosing be called at this stage and thus have it as the default subscreen displayed. The following
*syntax is recognised only within the flow logic and cannot be written anywhere else. The keywords CALL SUBSCREEN are followed by the
*name of the subscreen area. The INCLUDING keyword comes afterwards with the name of the subscreen's program (the program in which the
*subscreen is designed. So in my case it's the program I am currently working on so its name is stored in the system variable) and the
*number of the subscreen (stored in a custom variable).
*The PBO section in the flow logic of my screen '100' now looks like this:
********************************************************************
PROCESS BEFORE OUTPUT.
CALL SUBSCREEN saera1 INCLUDING sy-repid v_scrno.
********************************************************************

*The subscreen '300' is now called by default but I still cannot change between the tabs. I cannot move to subscreen '200' yet. PBO
*is triggered both to begin with and every time after PAI. So I can have the variable that holds the number of the subscreen to display
*contain '300' (the second subscreen I want displayed) and have a function that will trigger only once in PBO and change the value of
*the active tab to the second one by setting a correct (FC2 in this case) function code (tabs and subscreens needs to be managed separately!).
*In order to achieve this one time occurence, I declare a flag variable whose value is changed within the function next to the setting of
*the active tab to 'FC2'). The condition says that the code within is to be executed only if 'v_flag' is equal to 0... which it will be
*only at the very execution of the program and there it will be changed for good immediately so that logic will never trigger again. Thus,
*I am making the 'Halibel' tab the default one.
*The upper part of my TOP INCLUDE (housing the flag variable from now on) looks like this:
********************************************************************
PROGRAM Z_BM_TEST_MPP5.

CONTROLS: tbstr TYPE TABSTRIP.

DATA: v_scrno TYPE sy-dynnr VALUE '300'.

DATA: v_flag TYPE i.
********************************************************************

*The PBO event of my screen 100's flow logic looks like this:
********************************************************************
PROCESS BEFORE OUTPUT.
MODULE change_flag_if_default.
CALL SUBSCREEN saera1 INCLUDING sy-repid v_scrno.
********************************************************************

*And the module responsible for handling the default behaviour (placed in the TOP INCLUDE) looks like this:
********************************************************************
MODULE change_flag_if_default OUTPUT.
  IF v_flag = 0.
    v_flag = 1.
    tbstr-activetab = 'FC2'.
  ENDIF.
ENDMODULE.
********************************************************************

*I now need the logic to allow for switching between the tabs and screens associated with them. I can change tabs themselves directly here
*by referring to my tabstrip control's property but the CALL SUBSCREEN syntax for the changing of the subscreens can only be written within
*the flow logic, so every time a particular tab is selected (a particular function code is passed into the function), my CALL SUBSCREEN
*function needs to be informed what subscreen is to be called. The 'v_scrno' variable is the messanger. The CALL SUBSCREEN function will
*trigger every time the PBO event triggers which happens after every iteration of the PAI event and it will set the currently displayed
*subscreen to the one whose number is currently stored within the 'v_scrno' variable. So by pairing the changing of the value of that
*variable with the changing of the function code I ensure that the subscreen will change alongside the tab which changes according to the
*function codes passed into the function. What function code is passed into the function depends on which tabbutton has been clicked.
*Whenever a tabbutton is clicked, the PAI event is triggered. The tabbuttons are part of the tabstrip control which is in the main screen
*(100). I can create that logic by expanding the 'USER_COMMAND_0100' module as it already handles what actions are to be performed depending
*on the function code stored within 'sy-ucomm' (so far it handled only the exitting functionality).
*The 'USER_COMMAND_0100' module now looks like this:
********************************************************************
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'FC3'.
      LEAVE PROGRAM.
    WHEN 'FC1'.
      tbstr-activetab = 'FC1'.
      v_scrno = '200'.
    WHEN 'FC2'.
      tbstr-activetab = 'FC2'.
      v_scrno = '300'.
  ENDCASE.
ENDMODULE.
********************************************************************

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------