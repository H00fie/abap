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

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------