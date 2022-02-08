*---------------------------------------------------------------------------------------------------------------------------------
*EVENTS.
*---------------------------------------------------------------------------------------------------------------------------------

*Events -> processing blocks. Sections of code specific for the selection-screens. The stretch of the event starts with the event
*keyword... and does not have an ending. It will be terminated by the start of the next event block. E.g. a sub-program or a report
*(program) ends.
*When I run my executable programs - they are controlled by a predefined process in the runtime environment. The series of processes
*are called one after another. These processes trigger events for which I can define event blocks in my programs.
*When the program is started there are certain events that get fired up in a certain order.
*The first thing is check if I have included any processing blocks (Initialization, At Selection Screen, Start-Of-Selection,
*End-Of-Selection, At-Line-Selection)- if so, it checks which ones I am using.
*Runtime environment will check if I have the Initilization event-block. This event block will only be run once at the very start.
*This block can include the setting of the initial values for fields in my selection screen.
*Then the Runtime Environment will see if the Selection-Screen has been defined. If at least one input field is being used, then
*control will be passed to the Selection Screen Processor which will display the screen to the user. When the user Executes the program,
*the Selection Screen Processor will trigger the At-Selection-Screen event block.
*In the At-Selection-Screen event block, I can write my own code to check the user's input. If the user entered the incorrect values,
*my code can capture these mistakes and, instead of processing the program, I can make the Selection-Screen to be displayed again
*to the user.
*I will use Error Messages to tell the user where the errors are. It can run in a loop until the input is correct.
*When there are no more errors, the Runtime Environment passes control to Start-Of-Selection event block. It can hold the code I create -
*e.g. setting up the values of internal tables, internal fields and so on used in my program and maybe writing out header information on
*the report.
*These are the main event blocks - used for displaying Selection-Screen and capturing user's input which can then be used to process the rest
*of my program.
*Once all my event blocks have been processed, the ABAP Processor will execute the rest of the program and pass control to List Processor
*to output my report! Hence comes the List screen (the effect of all previous processing), but also can be interactive.
*E.g. if I double-click a line, the List Processor will capture that action and fire the At-Selection-Screen event block -> here I can
*include more code to determine what was clicked and what needs to be done next.

TABLES: zbm_cust_02.

DATA itab TYPE STANDARD TABLE OF zbm_cust_02.

DATA: wa_cust LIKE zbm_cust_02-cust_num.

PARAMETERS: my_cust LIKE zbm_cust_02-cust_num DEFAULT 10 OBLIGATORY.

INITIALIZATION.

  SELECT * FROM zbm_cust_02.
    wa_cust = zbm_cust_02-cust_num.
    ENDSELECT.

AT SELECTION-SCREEN ON my_cust.
  IF my_cust > wa_cust.
    WRITE: / 'The number is greater.'.
    ULINE.
  ELSE.
    WRITE: / 'The number is lesser.'.
    ULINE.
  ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------