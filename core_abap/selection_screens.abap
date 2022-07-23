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