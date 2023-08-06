*&---------------------------------------------------------------------*
*& Report  Learning_field
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  Learning_field LINE-SIZE 255. "Self-explanatory, but this can, apparently, cut the results of tables short. See 1565.

*Comments are fine to explain stuff.

*---------------------------------------------------------------------------------------------------------------------------------
*Below is my first program written with Udemy course.
*---------------------------------------------------------------------------------------------------------------------------------

*DATA d_times TYPE i VALUE 4.
**I can add colon to WRITE and make it a 'statement chain' -> instead of writing WRITE every new line.
*WRITE: '--------------------------'.
*WRITE / '| Invoice number. | Date.|'.
*WRITE / '--------------------------'.
*
*DO 20 TIMES.
*  WRITE / d_times.
*  d_times = d_times + 1.
*  WRITE 15 '3'. "15 means the value will be pushed 15 characters to the right.
*ENDDO.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*Below is my first program written with Udemy course.
*---------------------------------------------------------------------------------------------------------------------------------

*TABLES t005t. "'I will be looking at this table!'

*SELECT * FROM t005t WHERE SPRAS = 'EN'. "Self-explanatory.
*  WRITE: / t005t-LAND1,  "The slash makes sure the results will be written in a column, not in a single line.
*         t005t-LANDX. "I am first selecting table and after a hyphen, comes the field I want to chosen.
*ENDSELECT.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*Below is a program listing materials.
*---------------------------------------------------------------------------------------------------------------------------------

*TABLES mara.

*PARAMETERS: p_name TYPE mara-ERNAM. "A parameter for the selection-screen! Add the prefix 'p_' to the names of parameters. Thanks to this convention, it's clear that a variable comes from the selection screen.

*SELECT * FROM mara UP TO 20 ROWS WHERE ERNAM EQ p_name. "EQ and '=' are used like in Java.
*  WRITE: / mara-MATNR, mara-ERSDA, mara-ERNAM, '|'. "The parameter in the selection-screen is changed because I asked SAP to add the name of the field it's referencing. Skok do -> Elementy tekstowe -> teksty wyboru.
*ENDSELECT.
*WRITE: / '--------------------------------------------'.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*Below is yet another program listing materials.
*---------------------------------------------------------------------------------------------------------------------------------

*TABLES: zbm_mat.

*SELECT * FROM zbm_mat.
*  WRITE: / zbm_mat-material,
*         zbm_mat-description.
*ENDSELECT.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*Below is my first exercise program with Udemy course.
*---------------------------------------------------------------------------------------------------------------------------------

*TABLES: zbm_cust_02.
*
*SELECT * FROM zbm_cust_02 WHERE cust_num = 2.
*  WRITE: / zbm_cust_02-cust_num,
*           zbm_cust_02-cust_name,
*           'Yeah'.
*  ENDSELECT.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*Arithmethic stuff.
*---------------------------------------------------------------------------------------------------------------------------------

*DATA integer01 TYPE i VALUE 22. "Value determines the initial value of the variable.
*DATA decimal01 TYPE p DECIMALS 1 VALUE '-5.7'.
*
*DATA result LIKE decimal01. "That means result is like the type of decimal01.
*
*integer01 = 10. "Changing the value of the variable.
*
*result = integer01 + decimal01.
*
*WRITE: result.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*Character strings -> there are two elementary data types used for character strings. C and N. THESE ARE GENERIC CHARACTER STRING DATA TYPES.
*---------------------------------------------------------------------------------------------------------------------------------

*TABLES: zbm_cust_02.

*C holds 'alpha numeric' characters. Minimum 1 char, max 65.535 chars.
*DATA mychar(10) TYPE c.

*DATA mychar2. "Default value of the size of the field is one character. If I want the length to be of one character, I don't need to decalre
*the size in the brackets.
*Because the character field is the default type used by the system to declare the field, I can not decalre any type.
*mychar2 is the short version for 'DATA mychar2(1) TYPE c.

*DATA zcusts LIKE zbm_cust_02-cust_name. "Character field like the provided variable from the provided table.
*Instead of the above, I could use: 'DATA zcusts(100) TYPE c.' - and it would be the same as the column in the
*table. It's a character field, it's not like Java, I don't need specifically defined types...

*DATA znumber LIKE zbm_cust_02-ord_num.
*Similar as above but refers to the data type NUMC. It's treated like a character type but there's an in-built mechanism that will only
*allow numeric characters to be included.  When data is moved in, it is right aligned just like a regular numeric type field.
*Also, it is perfect to be used when I only want number within the field and have no intention of carrying out any calculations.
*It would be the same if I typed: 'DATA znumber TYPE n.'

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*Logical flow.
*---------------------------------------------------------------------------------------------------------------------------------
*I can have the predefined structure of the if-statement inserted for me with Wzorzec -> mark the Inny Wzorzec at the bottom -> type in
* 'if' and hit enter.

*DATA name(15) TYPE c.
*
*name = 'Dazikiri'.
*
*IF name EQ 'Dazikiri'.
*  WRITE / 'Lancer'.
*ELSEIF name EQ 'Halasibel'.
*  WRITE / 'Shaman'.
*ELSE.
*    WRITE / 'Dont know!'.
*ENDIF.
*
*name = 'Halasibel'.
*
*IF name EQ 'Dazikiri'.
*  WRITE / 'Lancer'.
*ELSEIF name EQ 'Halasibel'.
*  WRITE / 'Shaman'.
*ELSE.
*    WRITE / 'Dont know!'.
*ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------








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

*TABLES: zbm_cust_02.
*
*DATA itab TYPE STANDARD TABLE OF zbm_cust_02.
*
*DATA: wa_cust LIKE zbm_cust_02-cust_num.
*
*PARAMETERS: my_cust LIKE zbm_cust_02-cust_num DEFAULT 10 OBLIGATORY.
*
*INITIALIZATION.
*
*  SELECT * FROM zbm_cust_02.
*    wa_cust = zbm_cust_02-cust_num.
*    ENDSELECT.
*
*AT SELECTION-SCREEN ON my_cust.
*  IF my_cust > wa_cust.
*    WRITE: / 'Number jest wiêkszy.'.
*    ULINE.
*  ELSE.
*    WRITE: / 'Numer jest mniejszy.'.
*    ULINE.
*  ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*HOW TO GET THE CURRENT DATA AND TIME.
*---------------------------------------------------------------------------------------------------------------------------------

*I can get the current date with the below!
*DATA d_date TYPE d.
*
*d_date = sy-datum.
*
*WRITE / d_date.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*FIRST INCLUDE USING PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------

*INCLUDE zbm_include_test.

*I am basically calling an independent block of code to be used/executed here.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*FIRST FUNCTION MODULE USING PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------

*DATA result LIKE spell.
*
*SELECTION-SCREEN BEGIN OF LINE.
*SELECTION-SCREEN COMMENT 1(15) text-001. "Pula tekstów/informacji do u¿ytku w ekranach wyboru. Istnieje podobny mechanizm dla okienek z komunikatami, ale to coœ innego. NIE SZUKAÆ porównañ do Javy. To jest stricte ABAPikowa rzecz.
*
*PARAMETER num_1 TYPE i.
*
*SELECTION-SCREEN END OF LINE.
*
*CALL FUNCTION 'SPELL_AMOUNT' "Funkcja, która pisze w s³owach liczby podane jako integery.
*  EXPORTING
*    amount   = num_1 "Parametr liczbowy...
*  IMPORTING
*    in_words = result. "Zmienna do przechowania wyniku dzia³ania funkcji.
*.
*IF sy-subrc <> 0. "Jeœli sy-subrc jest inna ni¿ 0, to coœ posz³o nie tak...
*  WRITE: 'Wartoœæ zwrócona to: ', sy-subrc. "Wiêc wydrukuj mi wartoœæ sy-subrc. Np. 4 mo¿e oznaczaæ b³¹d.
*ELSE.
*  WRITE: 'Podana liczba w s³owach to: ', result-word. "Jeœli sy-subrc nie jest ró¿ne od 0 (a wiêc ma wartoœæ 0 - czyli wszystko posz³o jak nale¿y), wtedy wydrukuj mi resultat.
*ENDIF.                                                "Dodatek -word wynika z samej funkcji. Zamiast result móg³bym nazwaæ zmienn¹ np. osio³ek i sk³adnia bêdzie wygl¹daæ: osio³ek-word.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*FIRST ABAP OOP USING PROGRAM -> exercising. CLASSES.
*---------------------------------------------------------------------------------------------------------------------------------

*CLASS my_first_class DEFINITION.
*  PUBLIC SECTION. "Instead of specifying the access modifier for every variable and method separately, I am defining sections. Everything in this section will be public. The public section will end e.g. when I define private section.
*    DATA: text(45) VALUE 'My First Object'.
*
*    METHODS: display.
*ENDCLASS.                    "my_first_class DEFINITION
*
**----------------------------------------------------------------------*
**       CLASS my_first_class IMPLEMENTATION
**----------------------------------------------------------------------*
**
**----------------------------------------------------------------------*
*CLASS my_first_class IMPLEMENTATION.
*
*  METHOD display.
*
*    WRITE: / 'This is the Display method! My first ABAP OOP method!'.
*  ENDMETHOD.                    "display
*ENDCLASS.                    "display
*
*START-OF-SELECTION.
**The creation of ABAP's object is basically the same as in Java, but looks a bit different.
**In Java, the first thing I do is a reference (Dog dogOne) and THEN I create the object itself (= new Dog();)
**Below is basically the equivalent of Java's: Dog dogOne = new Dog();
*  DATA: my_first_class TYPE REF TO my_first_class. "First I create a reference to the class... This is the 'Dog dogOne' part.
*  CREATE OBJECT: my_first_class. "Then I create the object itself... this is the '= new Dog();' part.
*  WRITE: / my_first_class->text. "Here I am reaching for the variable of the object.
*  CALL METHOD: my_first_class->display. "Here I am reaching for the method of the object.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*SECOND ABAP OOP USING PROGRAM -> exercising. CLASSES.
*---------------------------------------------------------------------------------------------------------------------------------

*CLASS armoury DEFINITION.
*  PUBLIC SECTION.
*    DATA: lol(25) VALUE 'Forging a weapon...'. "lol is just a name. This is basically a field of the class and it can only be defined in the DEFINITION.
*
*    METHODS: forge, call_for_supplies. "If a method is defined here, it has to have an implementation. So, similar to interfaces. Implement all methods.
*ENDCLASS.                    "armoury DEFINITION
*
**----------------------------------------------------------------------*
**       CLASS armoury IMPLEMENTATION
**----------------------------------------------------------------------*
**
**----------------------------------------------------------------------*
**IMPLEMENTATION can only define methods! Variables cannot be defined here... unless they are within a method -> a local variable.
*CLASS armoury IMPLEMENTATION. "ABAP classes are created in two steps, I always have to create a definition and an implementation. In the implementation I just decide what methods will do and I call upon them
*  "then, to answer the call of Gondor, wherever I please within the boundaries of the program.
*  METHOD forge.
*    WRITE: / 'The weapon has been forged!'.
*  ENDMETHOD.                    "forge
*
*  METHOD call_for_supplies.
*    WRITE: / 'Sending the wee lad for more ingots.'.
*  ENDMETHOD.                    "call_for_supplies
*ENDCLASS.           "forge
*
*START-OF-SELECTION.
*  DATA: armoury TYPE REF TO armoury.
*  CREATE OBJECT: armoury.
*  WRITE: / armoury->lol.
*  CALL METHOD: armoury->forge.
*
*  CALL METHOD: armoury->call_for_supplies.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*THIRD ABAP OOP USING PROGRAM -> exercising. ACCESS SECTIONS.
*---------------------------------------------------------------------------------------------------------------------------------

*CLASS army DEFINITION.
*  PUBLIC SECTION.
*    DATA: official_numbers TYPE i VALUE 1000. "In the ABAP code, I need to specify a pre-defined data type (I cannot create mu custom ones, like Data Element in tables).
*    DATA: info TYPE char25 VALUE 'yay'.
*    METHODS: charge.
*
*  PROTECTED SECTION.
*    DATA: protected_numbers TYPE i VALUE 700.
*
*  PRIVATE SECTION.
*    DATA: actual_numbers TYPE i VALUE 400.
*ENDCLASS.                    "army DEFINITION
*
**----------------------------------------------------------------------*
**       CLASS army IMPLEMENTATION
**----------------------------------------------------------------------*
**
**----------------------------------------------------------------------*
*CLASS army IMPLEMENTATION.
*  METHOD charge.
*    WRITE: / 'Charge method called: ',
*       official_numbers,
*       protected_numbers,
*       actual_numbers.
*  ENDMETHOD.                    "charge
*ENDCLASS.         "charge
*
*START-OF-SELECTION.
*  DATA: army TYPE REF TO army.
*  CREATE OBJECT army.
*  CALL METHOD: army->charge. "Here I am calling the method from the object - army.
*  WRITE: / army->official_numbers.
*  WRITE: / army->info. "This will work, because 'info' is defined in the PUBLIC SECTION, thus, it is accessible from whatever.
*WRITE: / army->actual_numbers. "This is not going to work, because actual_numbers is defined in the PRIVATE SECTION. Thus, I cannot just grab it from the level of the object, I need to access it via a method.
"In this case, my method 'charge', basically, assumes the role of... a getter. I access the private field of the class via a method of that class called on an object of the class.
"Just like Java, only a little bit different.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*FOURTH ABAP OOP USING PROGRAM -> exercising. STATIC ATTRIBUTES.
*---------------------------------------------------------------------------------------------------------------------------------

*CLASS rune DEFINITION.
*  PUBLIC SECTION.
*    CLASS-DATA: rune_name TYPE char45,
*                rune_number TYPE i.
*    METHODS: forge_rune.
*ENDCLASS.                    "rune DEFINITION
*
**----------------------------------------------------------------------*
**       CLASS rune IMPLEMENTATION
**----------------------------------------------------------------------*
**
**----------------------------------------------------------------------*
*CLASS rune IMPLEMENTATION.
*  METHOD forge_rune.
*    DO 4 TIMES.
*      rune_number = 1 + rune_number.
*      WRITE: / rune_number, rune_name.
*    ENDDO.
*    SKIP. "Thanks to this, I will see in the output the distinction between rune1's and rune2's callings of the method.
*  ENDMETHOD.                    "forge_rune
*ENDCLASS.                    "rune IMPLEMENTATION
*
*START-OF-SELECTION.
*  rune=>rune_name = 'Fire Rune'. "This way of assigning values will work ONLY for CLASS-DATA (static attributes), it will not work for non-statics (simple DATA).
*  rune=>rune_number = 0.
*
*  DATA: rune1 TYPE REF TO rune,
*        rune2 TYPE REF TO rune.
*
*  CREATE OBJECT: rune1, rune2.
*  CALL METHOD: rune1->forge_rune,
*               rune2->forge_rune. "rune_number is a static attribute, so, despite the default value being set to 0, rune2 will write 5, 6, 7 and 8, because it's a shared attribute and already has been incremented by rune1.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*FIFTH ABAP OOP USING PROGRAM -> exercising. CONSTRUCTOR.
*---------------------------------------------------------------------------------------------------------------------------------

*CLASS dog DEFINITION.
*  PUBLIC SECTION.
*    METHODS: bark, constructor.
*ENDCLASS.                    "dog DEFINITION
*
**----------------------------------------------------------------------*
**       CLASS dog IMPLEMENTATION
**----------------------------------------------------------------------*
**
**----------------------------------------------------------------------*
*CLASS dog IMPLEMENTATION.
*  METHOD bark.
*    WRITE: / 'The dog is barking from a regular method.'.
*  ENDMETHOD.                    "bark
*
*  METHOD constructor. "Constructor makes sure that the logic within the method will be carried out upon the creation of the object.
*    WRITE: / 'The dog is barking from a constructor method!.'.
*  ENDMETHOD.                    "constructor
*ENDCLASS.                    "dog IMPLEMENTATION
*
*START-OF-SELECTION.
*  DATA dog TYPE REF TO dog.
*  CREATE OBJECT dog. "Method 'bark' is never executed because it's never called. 'Constructor' is executed because it happens upon the very creation of an object.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*SIXTH ABAP OOP USING PROGRAM -> exercising. ME operator.
*---------------------------------------------------------------------------------------------------------------------------------

*CLASS example DEFINITION.
*  PUBLIC SECTION.
*    DATA text_initial TYPE char100 VALUE 'This is the initial value of the attribute!'.
*    METHODS: method1.
*ENDCLASS.                    "example DEFINITION
*
**----------------------------------------------------------------------*
**       CLASS example IMPLEMENTATION
**----------------------------------------------------------------------*
**
**----------------------------------------------------------------------*
*CLASS example IMPLEMENTATION.
*  METHOD method1.
*    DATA text_initial TYPE char100 VALUE 'This is the same attribute, but changed by the method!'.
*    WRITE: / me->text_initial, "Operator 'me' allows me to see what was the value of the attribute before it was changed.
*           /     text_initial.
*  ENDMETHOD.                    "method1
*ENDCLASS.                    "example IMPLEMENTATION
*
*
*START-OF-SELECTION.
*  DATA object TYPE REF TO example.
*  CREATE OBJECT object.
*  CALL METHOD object->method1.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*SEVENTH ABAP OOP USING PROGRAM -> exercising. INHERITANCE.
*---------------------------------------------------------------------------------------------------------------------------------

*CLASS warrior DEFINITION.
*  PUBLIC SECTION.
*    DATA: warrior_message(45) VALUE 'I am a warrior!'.
*    METHODS: warrior_method.
*ENDCLASS.                    "warrior DEFINITION

*----------------------------------------------------------------------*
*       CLASS axeman DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*CLASS axeman DEFINITION INHERITING FROM warrior.
*  PUBLIC SECTION.
*    METHODS: axeman_method.
*ENDCLASS.                    "axeman DEFINITION
*
**----------------------------------------------------------------------*
**       CLASS warrior IMPLEMENTATION
**----------------------------------------------------------------------*
**
**----------------------------------------------------------------------*
*CLASS warrior IMPLEMENTATION.
*  METHOD warrior_method.
*    WRITE: / warrior_message.
*  ENDMETHOD.                    "warrior
*ENDCLASS.                    "warrior IMPLEMENTATION
*
**----------------------------------------------------------------------*
**       CLASS axeman IMPLEMENTATION
**----------------------------------------------------------------------*
**
**----------------------------------------------------------------------*
*CLASS axeman IMPLEMENTATION.
*  METHOD: axeman_method.
*    WRITE: / 'From the axeman class: ', warrior_message. "Axeman reaches for a variable it never defined itself but which is defined in Warrior (its parent class).
*  ENDMETHOD.                    "axeman
*ENDCLASS.                    "axeman IMPLEMENTATION
*
*START-OF-SELECTION.
*  DATA: warrior TYPE REF TO warrior,
*        axeman TYPE REF TO axeman.
*  CREATE OBJECT: warrior, axeman.
*  CALL METHOD: warrior->warrior_method,
*               axeman->axeman_method. "Axeman's method reaches for the attribute defined in Warrior.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*SEVENTH ABAP OOP USING PROGRAM -> exercising. INHERITANCE.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*FIELD-SYMBOLS.
*---------------------------------------------------------------------------------------------------------------------------------
*Field-symbol is a placeholder for a data object which points to the value present at the memory address of a data object. The field-symbol does not reserve any
*physical memory itself when declared. It only points to a data object at run time. There are two types: typed field-symbols and generic field-symbols.

*--------------------------------------------
*FIELD-SYMBOLS AS A REPLACEMENT FOR WORK AREA PROGRAM.
*--------------------------------------------
*I can declare a field-symbol of type any structure, which can be used while looping through the internal table.
*DATA: it_mara TYPE STANDARD TABLE OF mara.
*FIELD-SYMBOLS: <fs_mara> TYPE mara.
*
*SELECT * FROM mara INTO TABLE it_mara UP TO 50 ROWS. "Fetching the data into the internal table.
*
*LOOP AT it_mara ASSIGNING <fs_mara>. "Assiging what's in the internal table into the field-symbol. I think that with field-symbols, I always have to ASSIGN stuff to it...
*  IF <fs_mara> IS ASSIGNED. "I think this might be generally redundant. Maybe just to be one the safe side?
*    WRITE: / <fs_mara>-matnr, "Fields from the MARA table.
*             <fs_mara>-mtart,
*             <fs_mara>-meins.
*  ENDIF.
*ENDLOOP.
*If I change any field of structure in field-symbol, the corresponding field in the internal table will get updated. MODIFY statement is not required (it would be if
*I was using work area instead of field-symbols. Work area stores a copy of the internal table row, whereas field-symbol references the internal table row directly.
*Processing the internal table with field-symbols is thus faster than using work area.



*--------------------------------------------
*APPENDING TO INTERNAL TABLE PROGRAM.
*--------------------------------------------
*DATA it_mara TYPE  STANDARD TABLE OF mara.
*FIELD-SYMBOLS: <fs_mara> TYPE mara.
*
*APPEND INITIAL LINE TO it_mara ASSIGNING <fs_mara>.
*IF <fs_mara> IS ASSIGNED.
*  <fs_mara>-matnr = 'MAT1'.
*  <fs_mara>-matkl = '001'.
*  UNASSIGN <fs_mara>.
*ENDIF.
*
*APPEND INITIAL LINE TO it_mara ASSIGNING <fs_mara>.
*IF <fs_mara> IS ASSIGNED.
*  <fs_mara>-matnr = 'MAT2'.
*  <fs_mara>-matkl = '001'.
*  UNASSIGN <fs_mara>.
*ENDIF.
**-----CALLING THE FUNCTION-----
*CALL FUNCTION 'SRTT_TABLE_DISPLAY' "I am calling this function to be able to WRITE the content of the table to a screen!
*  EXPORTING
*    table               = 'MARA'"I think that's the table we're basing our internal table on.
**   IV_TITLE            =
*  tables
*    table_content       = it_mara. "This is what we want written. The content of what we want displayed.
** EXCEPTIONS
**   INVALID_INPUT       = 1
**   OTHERS              = 2
*          .
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.
**-----FINISHING THE FUNCTION-----


*I should always perform a check on a field-symbol seeing if it is indeed assigned (IF <fs_mara> IS ASSIGNED.) before doing
*any operation in order to avoid a 'short dump'. After doing the opertaion, I should also unassign the field-symbol.

*READ TABLE it_mara ASSIGNING <fs_mara> WITH KEY matnr = 'MAT1'. "This should technically read the table as well, but tough luck, IT DOSN'T!

*----------------------------
*TYPED FIELD SYMBOLS' PROGRAM
*----------------------------
*DATA var TYPE i VALUE 2.
*FIELD-SYMBOLS: <fs_num> TYPE i. "My field-symbol assumes a certain type of data.
*ASSIGN var TO <fs_num>. "My field-symbol assumes the concrete value of the variable var.
*WRITE: / <fs_num>. "My field-symbol has now the value of 2, because it was assigned the value of var which initially had 2 as its value.
*<fs_num> = 4.
*WRITE: / var. "var now has the value of 4 because my field-symbol is a placeholder for it, a representation of it. If my field-symbols chagnes so does the value it points at.

*Typed field-symbols can only point to the data object of a specified type. Changes done to the field-symbol will be also done to the variable which was ASSIGNed to my field-symbol.
*----------------------------
*GENERIC FIELD SYMBOLS' - TYPE ANY PROGRAM
*----------------------------
*Dynamic programming is usually implemented using generic field-symbols. The most commonly used generic types are
*TYPE ANY and TYPE ANY TABLE.

*FIELD-SYMBOLS: <fs_str> TYPE any.
*FIELD-SYMBOLS: <fs_data> TYPE any.
*
**I can assign any data object to the TYPE ANY and any internal table to TYPE TABLE ANY.
*
*DATA lw_mara TYPE mara.
*ASSIGN lw_mara TO <fs_str>. "Assigning internal table's data to <fs_str> which is of whatever type I want it to be.
*IF <fs_str> IS ASSIGNED.
*  ASSIGN COMPONENT 'MATNR' OF STRUCTURE <fs_str> TO <fs_data>.
**Above I am adding component named 'matnr' from the structure <fs_str> to <fs_data>. This is done in such a stiff manner, because
**I cannot directy access the field <fs_str>-matnr... It's declared at runtime!
**By doing it that way, I am creating an abstraction, a workaround - I am assigning a component named MATNR of <fs_str> (which is basically
**lw_mara which is like mara) to <fs_data> and then, below, I am giving the value of MAT001 to <fs_data>... so to a field named MATNR in
**<fs_str> because field-symbols are references! I am thus assigning a value to a field that I cannot access yet because it's done decalred
**yet (will be at runtime)!
*  IF <fs_data> IS ASSIGNED.
*    <fs_data> = 'MAT001'.
*    UNASSIGN <fs_data>. "Also a supposedely regular thing to do. Clean code thing maybe?
*  ENDIF.
*  UNASSIGN <fs_str>.
*ENDIF.
*
**After I've assigned lw_mara to <fs_str>, I cannot directly use '-' operator on the field-symbol to access mara's
**structure (e.g. <fs_str>-matnr), because that would cause a syntax error - and that is because field-symbol type is
**declared only at runtime, not at compile time! Which means that until then... <fs_str> does not have the content of what's
**been assigned to it?
**After all that, the above code will make lw_mara-matnr have the value of 'MAT001', which is kewl.

*----------------------------
*GENERIC FIELD SYMBOLS' - TYPE ANY TABLE PROGRAM
*----------------------------
*I can assign any internal table to such a symbol.

*FIELD-SYMBOLS: <fs_tab> TYPE ANY TABLE. "Remember, field-symbols are references to data objects.
*FIELD-SYMBOLS: <fs_str> TYPE any.
*FIELD-SYMBOLS: <fs_data> TYPE any.
*
*DATA: lt_mara TYPE STANDARD TABLE OF mara. "Creating an internal table based on database table mara.
*
*SELECT * FROM mara INTO TABLE lt_mara UP TO 30 ROWS. "Populating the internal table with records from mara... which means that declaring lt_mara there makes the internal table look LIKE (structure) mara, not have the values.
*ASSIGN lt_mara TO <fs_tab>. "Making <fs_tab> refer to lt_mara.
*
*LOOP AT <fs_tab> ASSIGNING <fs_str>."Looping through lt_mara (referenced by <fs_tab>!) ASSIGNing it's records (one record per iteration of the loop) to <fs_str>. Which means that <fs_str> is a reference to a single record.
*  IF <fs_str> IS ASSIGNED.
*    ASSIGN COMPONENT 'MATKL' OF STRUCTURE <fs_str> TO <fs_data>. "ASSIGN COMPONENT "which looks like 'MATKL' from <fs_str> (which is a reference to a single record of lt_mara) to <fs_data>.
**So <fs_data> is now a refernce to a component (field) named 'MATKL' taken from <fs_str> which is a reference to a single record from <fs_tab> which is lt_mara.
*    IF <fs_data> IS ASSIGNED.
*      IF <fs_data> EQ '01'. "If that field equals '01' then do stuff...
*************DO STUFF************
*      ENDIF.
*      UNASSIGN <fs_data>.
*    ENDIF.
*  ENDIF.
*ENDLOOP.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM
*---------------------------------------------------------------------------------------------------------------------------------

*TABLES: zbm_order.
*
*PARAMETERS: p_order TYPE zbm_order-order_num, "Variable names has to be maximum of 8 characters' length.
*            p_mat TYPE zbm_order-material.
*
*SELECT * FROM zbm_order WHERE order_num = p_order AND material = p_mat.
*  WRITE: zbm_order-order_num, zbm_order-creation_date, 25(20) zbm_order-cust_name, 44 zbm_order-item.
*ENDSELECT.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> PURCHASE ORDER TABLE -> TWO PRIMARY KEYS
*---------------------------------------------------------------------------------------------------------------------------------
*The table had two columns set as Primary Keys, it is then called a Composite Primary Key.
*TABLES: zbm_porder.
*
*PARAMETERS: p_order TYPE zbm_porder-order_num,
*            p_mat   TYPE zbm_porder-material.
*
*SELECT * FROM zbm_porder WHERE order_num = p_order AND material = p_mat.
*  WRITE: / zbm_porder-order_num, zbm_porder-line, zbm_porder-material.
*ENDSELECT.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> MATERIAL MASTER TABLE -> MARA
*---------------------------------------------------------------------------------------------------------------------------------

*MARA is a standard SAP table and contains most of the field related to material master. Material master is a base table that
*stores all the materials. There are other tables associated with materials, but MARA is the base table which stores all the materials.
*There is a parameter called MATERIAL GROUP used to manage the materials (e.g. electronics).

*TABLES: mara. "I don't need ALL the columns of mara (245). There is a lot of data that I might not need, I just want some of it.
*When I am declaring the  TABLES mara and then creating a SELECT * FROM mara WHERE xyz, I would receive all 245 columns selected.
*This requires an optimization. I don't need all these fields... I only need three fields - matnr, ersda and matkl.
*So, instead of declaring the entire table (which will in turn create a work area internally...) - I am declaring a TYPES statement.
*Thus I am creating a structure that will contain whatever number of fields I want it to, e.g. just 3.
*A structure all by itself is no good since it cannot hold any data, it's just a definition of a structure. It's a blueprint for something
*that WILL hold the data.
*The actual data is held by an internal table.
*
*TYPES: BEGIN OF ty_mara, "TYPE declares a structure. It cannot hold any data yet. It's ONLY a structure. In order for it to hold the data...
*                matnr TYPE matnr, "... I have to DECLARE it using a DATA statement!
*                ersda TYPE ersda,
*                matkl TYPE matkl,
*  END OF ty_mara.
*
**Below I am creating an internal table which is of the type of previously declared structure ty_mara (it has the mentioned columns).
**Internal table is a table in memory which can hold any number of records.
*DATA: it_mara TYPE TABLE OF ty_mara, "This is a "grid" - it can contain any number of rows.
*      wa_mara TYPE ty_mara. "It's exactly the same in structure as it_mara, but it only has a single row.
*
*PARAMETERS: p_matkl TYPE matkl.
*
*SELECT matnr ersda matkl FROM mara INTO TABLE it_mara WHERE matkl = p_matkl.
**If I leave the statement as "INTO mara", it says I cannot use the internal table as a work area. Which means that
**INTO xyz means getting that data into a work_area.
*  LOOP AT it_mara INTO wa_mara. "By that, I am grabbing a single record.
*    WRITE: / wa_mara-matnr, wa_mara-ersda, wa_mara-matkl. "I need to specify WHAT matnr, ersda and matkl I want. And they are already assigned to the work_area.
*  ENDLOOP.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> DIFFERENT LANGUAGES -> JOINING TABLES (INNER JOIN)
*---------------------------------------------------------------------------------------------------------------------------------
*The table MAKT contains the descriptions of all the materials in different languages are stored. I need data from at least two
*tables... e.g. matnr and matkl from mara as well as description and language from makt.
*TABLE JOIN is used.
*I need to make sure there is a common field between two tables (like Primary Key... really?) - when the join is joined (xD), SAP
*internally creates a "complicated data set" called Cartesian Product... which means data combined from both tables. All columns
*are combined. Then I have that huge piece of data from which I can choose stuff.
*Internal tables come in handy here... If I just go TABLES: MARA. and SELCT... - it's a huge waste of memory (using just TABLES: MARA
*is already a waste). Internal tables allow me to choose just the fields I require so they make that process very efficient.
*I can just e.g. four tables. Then I use SELECT *... without an internal table, the system "goes crazy".

*TYPES : BEGIN OF ty_mara,
*              matnr TYPE matnr,
*              matkl TYPE matkl,
*              spras TYPE spras,
*              maktx TYPE maktx,
*  END OF ty_mara.
*
*DATA: it_mara TYPE TABLE OF ty_mara,
*      wa_mara TYPE ty_mara.
*
*PARAMETERS: p_matnr TYPE matnr,
*            p_spras TYPE spras.
*
**Below I am choosing four fields spread across multiple tables. So I am doing an INNER JOIN!
*SELECT mara~matnr mara~matkl makt~spras makt~maktx
*  FROM mara AS mara INNER JOIN makt AS makt "AS -> an alias.
*  ON mara~matnr = makt~matnr "The common field of all tables, I am joining the tables ON this field (by it/thanks to it/through it). These are the common columns.
*  INTO TABLE it_mara "Into my beautiful internal table.
*  WHERE mara~matnr = p_matnr "These and below is the narrowing of the selection...
*  AND makt~spras = p_spras. "...Which basically means I want to join matnr, matkl, spras and maktx from two tables, so join these tables
*"on their common column which is matnr, put the result into my internal table and do all of these only for these
*"records that meet my criteria, so where mara in matnr column has a record with the value I provided and makt
*"in spras column has a record with the value I provided.
*LOOP AT it_mara INTO wa_mara.
**Below the fields I want already belong to the work_area because they now belong there. With every loop, my work_area contains and thus
**provides one row of data that exists in it_mara... and it exists there because I put it there via my SELECT above.
*  WRITE: / wa_mara-matnr, wa_mara-matkl, wa_mara-spras, wa_mara-maktx.
*ENDLOOP.
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> MATERIAL STOCK -> JOINING TABLES (LEFT OUTER JOIN)
*---------------------------------------------------------------------------------------------------------------------------------
*When I want to join two tables and one is missing a row for a particular plant (because MARD is designed in such a way that if there
*is no stock for the plant, there's no row) -> I'd rather use OUTER JOIN, because INNER JOIN will drop everything it gathered so far
*from table MARA if it couldn't find data in table MARD and there's no information at all.
*OUTER JOIN will still return everything that was available and add a null or a zero for what was missing.

*TYPES: BEGIN OF ty_mara,
*          matnr TYPE matnr,
*          werks TYPE werks,
*          lgort TYPE lgort,
*          labst TYPE labst,
*  END OF ty_mara.
*
*DATA: it_mat TYPE TABLE OF ty_mara,
*      wa_mat TYPE ty_mara.
*
*PARAMETERS: p_matnr TYPE matnr.
*
**Looks like SQL requires '~' instead of '-' when specifying the table~column relationship.
*SELECT mara~matnr mard~werks mard~lgort mard~labst
*  FROM mara AS mara LEFT OUTER JOIN mard AS mard
*  ON mara~matnr = mard~matnr
*  INTO TABLE it_mat
*  WHERE mara~matnr = p_matnr.
*
*LOOP AT it_mat INTO wa_mat.
*  WRITE: / wa_mat-matnr, wa_mat-werks, wa_mat-lgort, wa_mat-labst. "Everything taken from MARA and MARD has already been put into it_mat and then, with every loop, is handed by wa_mat. wa_mat holds every new row every loop.
*ENDLOOP.
**There is an error trying to compile the program but the course's author doesn't seem to have it. LGORT must have changed in the meantime.
**Without lgort, it compiles.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> JAPANESE MATERIAL STOCK -> JOINING THREE TABLES (INNER JOIN)
*---------------------------------------------------------------------------------------------------------------------------------
*As I am pulling in more tables into the pool included in my JOIN, the LEFT OUTER JOIN is not recommended as it pulls in more
*rows than are needed.

*TYPES: BEGIN OF ty_mat,
*         matnr TYPE matnr, "This is the material number, my key-field.
*         matkl TYPE matkl, "The material group.
*         spras TYPE spras, "That's the language.
*         maktx TYPE maktx, "The description.
*         werks TYPE werks, "Currency?
*         labst TYPE labst, "The quantity!
*  END OF ty_mat.
*
*DATA: it_mat TYPE TABLE OF ty_mat,
*      wa_mat TYPE ty_mat.
*
*PARAMETERS: p_matnr TYPE matnr,
*            p_spras TYPE spras.
*
*SELECT mara~matnr mara~matkl makt~spras makt~maktx mard~werks mard~labst
*  FROM mara AS mara
*  INNER JOIN makt AS makt ON mara~matnr = makt~matnr
*  INNER JOIN mard AS mard ON mara~matnr = mard~matnr
*  INTO TABLE it_mat
*  WHERE mara~matnr = p_matnr
*  AND makt~spras = p_spras.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> PETE MOXTON'S OOP -> THE SIMPLEST METHODS
*---------------------------------------------------------------------------------------------------------------------------------
*CLASS smith DEFINITION.
*
*  PUBLIC SECTION.
*    DATA: name TYPE c LENGTH 40,
*          age TYPE i,
*          gender TYPE c LENGTH 1.
*    CLASS-DATA: count TYPE i.
*
*    METHODS: setname
*              IMPORTING namein TYPE c, "This means this method takes in a 'namein' as a parameter. It's 'importing' input.
*
*             getname
*              EXPORTING nameout TYPE c,
*
*             setgender
*              CHANGING newgender TYPE c.
*ENDCLASS.                    "smith DEFINITION
*
**----------------------------------------------------------------------*
**       CLASS smith IMPLEMENTATION
**----------------------------------------------------------------------*
**
**----------------------------------------------------------------------*
*CLASS smith IMPLEMENTATION.
*
*  METHOD setname. "In the implementation it's Method, not Methods.
*    name = namein. "This method imports input and sets the data defined in the class definition accordingly. It's basically a simple setter.
*  ENDMETHOD.                    "setname
*
*  METHOD getname.
*    nameout = name. "As in the definition it is EXPORTING data, it means it's 'returning' the parameter nameout... and that parameter that is being 'returned' is data defined in the class definition. So it's basically a simple getter.
*  ENDMETHOD.                    "getname
*
*  METHOD setgender.
*    IF newgender CO 'MF'. "If the parameter being passed into the method contains (CO) 'M' or 'F', then we are setting the data defined in the class deifinition to the parameter being passed into the method.
*      gender  = newgender.
*      newgender = '1'. "Set the returning value to 1, which means the gender was set correctly.
*    ELSE.
*      newgender = '2'. "Means the gender was not set.
*    ENDIF.
*  ENDMETHOD.                    "setgender
*
*ENDCLASS.                    "smith IMPLEMENTATION

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> PETE MOXTON'S OOP -> THE FUNCTIONAL METHOD
*---------------------------------------------------------------------------------------------------------------------------------

*CLASS singingman DEFINITION.
*  PUBLIC SECTION.
*    DATA: status TYPE c.
*
*    METHODS: getstatustext
*        IMPORTING value(statcode) TYPE c
*        RETURNING value(stattext) TYPE string.
*
*ENDCLASS.                    "singingman DEFINITION
*
**----------------------------------------------------------------------*
**       CLASS singingman IMPLEMENTATION
**----------------------------------------------------------------------*
**
**----------------------------------------------------------------------*
*CLASS singingman IMPLEMENTATION.
*  TO BE FINISHED!!!!!!!!!!!!!!!!!!!!
*ENDCLASS.


*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> PETE MOXTON'S OOP -> A CLASS CREATING EXERCISE
*---------------------------------------------------------------------------------------------------------------------------------

*CLASS car DEFINITION.
*  PUBLIC SECTION.
*    CLASS-DATA: numofcars TYPE i. "This is a static attribute! It is... static. Class-wide, amirite? Because calling methods on objects is so last season, kek.
*
**Constructors can also be static.
**-they always need to be in a PUBLIC SECTION,
**-there never is an interface -> I don't use any parameters at all,
**-it can only access static attributes of its class (because if I haven't instantiated an object, there's no data assigned to fields while static attributes are already there).
**Static constructors are executed the first time either an object of a class is created, either a static attribute of a class is used or a static method of a class is used.
*
*    CLASS-METHODS class_constructor.
*
*    METHODS constructor "Constructor is above other methods for visibility, whatever, it's not necessary.
*      IMPORTING "IMPORTING is the only thing a constructor can do. Soooo... like a Java constructor. It's all coming together.
*        make TYPE c "Initializing fields. Speed is not initialized, because I have other methods to decide the speed. Basically, there is no default speed.
*        model TYPE c
*        seat_num TYPE i
*        max_spd TYPE i.
*
*    METHODS: setnumseats IMPORTING newseatnum TYPE i, "The method sets the number of seats. So I am passing said new number of seats the method should set.
*             gofaster    IMPORTING increment  TYPE i EXPORTING result TYPE i,
*             goslower    IMPORTING decrement  TYPE i RETURNING value(result) TYPE i,
*             viewcar.
**The difference between EXPORTING and RETURNING VALUE seems... non-existent. Just two different ways of doing it.
*
*
**Attributes are here so that only the methods of the class can update them. If a calling program wants to access them, it will need to do it by calling the
**methods of this class. So basically simple and obvious encapsulation. It's the same as in Java.
*  PRIVATE SECTION.
*    DATA: make     TYPE c LENGTH 20, "The lengths are whatever, really.
*          model    TYPE c LENGTH 20,
*          seat_num TYPE i,
*          speed    TYPE i,
*          max_spd  TYPE i.
*
*    CLASS-DATA carlog TYPE c LENGTH 40. "My class_constructor uses it!
*
*
**    METHODS: setnumseats, gofaster, goslower.
*ENDCLASS.                    "car DEFINITION
*
**----------------------------------------------------------------------*
**       CLASS car IMPLEMENTATION
**----------------------------------------------------------------------*
**
**----------------------------------------------------------------------*
*CLASS car IMPLEMENTATION.
*
*  METHOD class_constructor.
*    carlog = 'Car class has been used'.
*    WRITE: / carlog.
*  ENDMETHOD.                    "class_constructor
*
**This is just a simple Java-like constructor, it's just shared between DEFINITION and IMPLEMENTATION. In the definition I pass the parameters and here I assign them to 'this' fields.
**If a parameter is called, e.g. make, I'd need to make the assigning look like: make = make. This causes ambiguity. There is an option to just not name parameters I am passing into
**the method the same as the arguments of my class... BUT I still can do things like in Java and I think it's the default solution for ABAP.
**There is a mechanism called SELF REFERENCE.
*  METHOD constructor.
*    me->make = make.
*    me->model = model.
*    me->seat_num = seat_num.
*    me->max_spd = max_spd. "I think that all these 'me->s' are an equivalent to Java's 'this'.
*    numofcars = numofcars + 1. "This is a static field, so each time a new car is created, the overall number of them is incremented.
*  ENDMETHOD.                    "constructor
*
*  METHOD setnumseats.
*    seat_num = newseatnum.
*  ENDMETHOD.                    "setnumseats
*
*  METHOD gofaster. "I am going to declare a local variable to help my calculations (I think it's 'theresult' added to store the value of 'result'! Its structure is a new concept for me - it's 'result = theresult'...
*    IF speed + increment > max_spd.                                                                                               "...which applies the value of 'result' to the 'theresult', not the other way around.
*      speed = max_spd.
*    ELSE.
*      speed = speed + increment.
*    ENDIF.
*    result = speed.
*  ENDMETHOD.                    "gofaster
*
*  METHOD goslower.
*    IF speed - decrement <= 0.
*      speed = 0.
*    ELSE.
*      speed = speed - decrement.
*    ENDIF.
*    result = speed.
*  ENDMETHOD.                    "goslower
*
*  METHOD viewcar. "Both the numeric values down there and the LEFT JUSTIFIED are just for placement of the data being written as the output.
*    WRITE: / 'Make = ', 19 make.
*    WRITE: / 'Model = ', 19 model.
*    WRITE: / 'Number of seats = ', 19 seat_num LEFT-JUSTIFIED.
*    WRITE: / 'Max speed = ', 19 max_spd LEFT-JUSTIFIED.
*    WRITE: / 'Speed = ', 19 speed LEFT-JUSTIFIED.
*  ENDMETHOD.                    "viewcar
*
*ENDCLASS.                    "car IMPLEMENTATION
*
*START-OF-SELECTION. "That's how I tell the system where I want it to start processing my code.
*
*  DATA: theresult TYPE i.
*
*  DATA: car_one TYPE REF TO car,
*        car_two TYPE REF TO car.
*  CREATE OBJECT: car_one "If there's no more code than this, I will get an error... because I made a constructor and it requires me to pass in parameters.
*    EXPORTING "This is how I pass in the parameters that constructor requires me to upon the creation of an object -> EXPORTING -> field -> gib valius.
*      make = 'AUDI'
*      model = 'A4'
*      seat_num = 5
*      max_spd = 120.
*
*  CALL METHOD: car_one->viewcar.
*  ULINE.
*
*  CREATE OBJECT: car_two
*    EXPORTING
*      make = 'BMW'
*      model = '320'
*      seat_num = 5
*      max_spd = 130.
*
*  CALL METHOD: car_two->viewcar.
*  ULINE.
*
**To see if the number of seats change.
*  CALL METHOD: car_one->setnumseats( 8 ).
*  CALL METHOD: car_one->viewcar.
*
**Another way of using the same method.
*  CALL METHOD: car_one->setnumseats( newseatnum = 12 ).
*  CALL METHOD: car_one->viewcar.
*  ULINE.
*
**Playing around with gofaster method.
*  CALL METHOD: car_one->gofaster( EXPORTING increment = 30 IMPORTING result = theresult ). "In here, somehow, 'result = theresult' means that the value of 'result' is stored in 'theresult', not the other way around.
*  CALL METHOD: car_one->viewcar.
*  WRITE: / 'The result of gofaster is:', theresult LEFT-JUSTIFIED.
*  ULINE.
*
**Playing around with the goslower method.
*  CALL METHOD: car_one->goslower( EXPORTING decrement = 10 RECEIVING result = theresult ). "goslower method has RETURNING instead of EXPORTING so it's RECEIVING, not IMPORTING).
*  CALL METHOD: car_one->viewcar.
*  WRITE: / 'The result of goslower is:', theresult LEFT-JUSTIFIED.
*  ULINE.
*
*  WRITE: / 'The number of cars created is:', car=>numofcars.
*  ULINE.
*
**Supposedely the 'Old Way' of calling methods is: CALL METHOD classname=>methodname. and the 'New Way' is: classname=>methodname(). but I do not understand it.
**Methods are called upon objects of classes, not classes and it cannot be applied, to say, constructors (regular or static), because they are... constructors.
**Perhaps it applies only to static methods.
**INSTANCE METHODS USES '->' INSTEAD OF '=>' USED BY STATIC ONES.
*
**If I want to access a static attribute, I do it like that:
**  DATA some_var TYPE i.
**  some_var = car=>numofcars.
**  WRITE: / some_var.
*
**FUNCTIONAL METHOD------------------------------------------------------------------------------
**Basically this:
**CALL METHOD: car_one->goslower( EXPORTING decrement = 10 RECEIVING result = theresult ).
**Is equal to this:
**theresult = car_one->goslower( 10 ).
**The RECEIVING part is traded for assigning the method directly to the predefined variable and that leaves me with a single parameter... so the word EXPORTING can be omitted.
*
*  theresult = car_one->goslower( 3 ).
*  car_one->viewcar( ).
*  WRITE: / 'The result of goslower (functional method) is:', theresult LEFT-JUSTIFIED.
*  ULINE.


*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*ATTEMPTING TO EXTRACT INVOICE DATA FROM VBFA BY REFERENCE NUMBER
*---------------------------------------------------------------------------------------------------------------------------------
*TABLES: vbfa.
*
*TYPES: BEGIN OF ty_vbf,
*  vbeln TYPE vbfa-vbeln,
*  END OF ty_vbf.
*
*DATA: wa_vbf TYPE ty_vbf.
*
*SELECT vbeln
*FROM vbfa
*INTO wa_vbf
*WHERE vbelv = BKPF-XBLNR "VBELV is the reference number in VBFA (Sales Documents Flow) and XBLNR is its corresponding field in BKPF.
*  AND VBTYP_N = 'M' "That's the type of the document. 'M' is for invoices.
*  AND erdat = ( select MAX( erdat )
*                from vbfa
*                where vbelv = BKPF-XBLNR
*                and erdat LE sy-datum ).
*  ENDSELECT.
*
*NRFAKTURYDOWZ = wa_vbf-vbeln. "In SQ02 I needed to assign the output of my code to the field that's about to display the data I am processing.

*---AND I AM BACK HERE AND THAT CRAP AIN'T WORKING NO NO NO WHY WOULD IT FUCK---

*TABLES: vbfa, bkpf.
*
*TYPES: BEGIN OF ty_vbf,
*  vbelv TYPE vbfa-vbelv,
*  END OF ty_vbf.
*
*TYPES: BEGIN OF ty2_vbf,
*  vbeln TYPE vbfa-vbeln,
*  END OF ty2_vbf.
*
*DATA: wa_ini TYPE ty_vbf,   "To hold the initial VBELV.
*      wa_prev TYPE ty_vbf,  "To hold the VBELV within the loop while going 'backwards' for invoices.
*      wa_next TYPE ty2_vbf, "To hold VBELN within the loop while going 'backwards' for invoices.
*      wa_v178 TYPE ty_vbf,  "To hold VBELV for 178% invoices.
*      wa_n178 TYPE ty2_vbf. "To hold VBELN for 178% invoices.
*
*SELECT SINGLE vbelv
*FROM vbfa
*INTO wa_ini
*WHERE vbeln = bkpf-xblnr
*  AND vbeln >= '1000000000'
*  AND vbeln <= '9999999999'.
*
*SELECT SINGLE vbeln
*FROM vbfa
*INTO wa_next
*WHERE vbelv = wa_ini-vbelv.
*
*IF wa_ini-vbelv BETWEEN '1000000000' AND '2999999999'." AND BKPF-BLART = 'WA'.
*
*  IF wa_ini-vbelv BETWEEN '1700000000' AND '1789999999'. "TO NIE DZIA£A
*    SELECT SINGLE vbelv
*    FROM vbfa
*    INTO wa_v178
*    WHERE vbeln = wa_ini-vbelv.
*    SELECT SINGLE vbeln
*      FROM vbfa
*      INTO wa_n178
*      WHERE vbelv = wa_v178-vbelv
*      AND vbeln BETWEEN '1880000000' AND '1889999999'.
*    IF NOT wa_n178 IS INITIAL.
*      WRITE: / wa_n178-vbeln.
*    ELSE.
*      WRITE: / ''.
*    ENDIF.
*  ENDIF.
*  WRITE: / wa_ini-vbelv.
*
*ELSEIF wa_next-vbeln BETWEEN '1000000000' AND '2999999999'." AND BKPF-BLART = 'WA'.
*  IF wa_next-vbeln BETWEEN '1700000000' AND '1789999999'.
*    SELECT SINGLE vbelv
*    FROM vbfa
*    INTO wa_v178
*    WHERE vbeln = wa_next-vbeln.
*    SELECT SINGLE vbeln
*    FROM vbfa
*    INTO wa_n178
*    WHERE vbelv = wa_v178-vbelv
*    AND vbeln BETWEEN '1880000000' AND '1889999999'.
*    IF NOT wa_n178 IS INITIAL.
*      WRITE: / wa_n178-vbeln.
*    ELSE.
*      WRITE: / ''.
*    ENDIF.
*  ENDIF.
*  WRITE: / wa_next-vbeln.
*
*ELSE.
*  DO 10 TIMES.
*    SELECT SINGLE vbelv
*    FROM  vbfa
*    INTO  wa_prev
*    WHERE vbeln = wa_ini-vbelv.
*    IF wa_prev-vbelv BETWEEN '1000000000' AND '2999999999'." AND BKPF-BLART = 'WA'.
*      IF wa_ini-vbelv BETWEEN '1700000000' AND '1789999999'.
*        SELECT SINGLE vbelv
*          FROM vbfa
*          INTO wa_v178
*          WHERE vbeln = wa_ini-vbelv.
*        SELECT SINGLE vbeln
*        FROM vbfa
*        INTO wa_n178
*        WHERE vbelv = wa_v178-vbelv
*        AND vbeln BETWEEN '1880000000' AND '1889999999'.
*        IF NOT wa_n178 IS INITIAL.
*          WRITE: / wa_n178-vbeln.
*        ELSE.
*          WRITE: / ''.
*        ENDIF.
*      ENDIF.
*      WRITE: / wa_prev-vbelv.
*    ENDIF.
*
*    wa_ini-vbelv = wa_prev-vbelv.
*    CLEAR wa_prev.
*    CLEAR wa_next.
*  ENDDO.
*ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*TRYING NOT TO DIE
*---------------------------------------------------------------------------------------------------------------------------------
*TABLES: likp, knb1.
*
*TYPES: BEGIN OF ty_why,
*  ERNAM TYPE knb1-ERNAM,
*  END OF ty_why.
*
*DATA: omfg TYPE ty_why.
*DATA: ld_kunnr TYPE knb1-kunnr.
*
*SELECT SINGLE ERNAM
*  INTO omfg
*  FROM knb1
*  WHERE ld_kunnr = 'K00140005'.
*
*WRITE: omfg-ernam.

*DATA: tu TYPE c LENGTH 10.
*
*select single kunnr into tu from knb1
*       where kunnr = 'K00140005'.
*
*WRITE: / tu.

*TABLES: knb1, likp.
*
*TYPES: BEGIN OF ty_knb,
*  kunnr TYPE knb1-kunnr,
*  END OF ty_knb.
*
*DATA: wa_knb TYPE ty_knb.
*
*SELECT SINGLE kunnr
*FROM knb1
*INTO wa_knb
*WHERE kunnr = 'K00140005'.
*
*WRITE: / wa_knb-kunnr.

*'K94012000' -> TO JEST W KNB1 NA BOD -> NR TELEFONU, MOGÊ TUTAJ TESTOWAÆ <3

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> PETE MOXTON'S ABAP (but in reality, exercising internal tables' handling)
*---------------------------------------------------------------------------------------------------------------------------------
*TABLES: zpokemon. "'Tables' keyword creates a table structure in memory based on the structure defined in ABAP dictionary.
**                  It will contains all records created.
*
*TYPES: BEGIN OF it_pok, "Declaration of structure...
*  employee TYPE zpokemon-employee,
*  surname TYPE zpokemon-surname,
*  forename TYPE zpokemon-forename,
*  title TYPE zpokemon-title,
*  dob TYPE zpokemon-dob,
*  END OF it_pok.
*
*DATA: t_pok TYPE STANDARD TABLE OF it_pok, "Declaration of data types...
*      s_pok TYPE it_pok.
*
*SELECT * FROM zpokemon INTO CORRESPONDING FIELDS OF TABLE t_pok. "Populating the table...
*
*LOOP AT t_pok INTO s_pok. "Loop at the populated table and into WA.
*  WRITE: / s_pok-forename,
*           s_pok-dob.
*ENDLOOP.
*******************************************************************************************************************************************
**If the LINE-SIZE is set to a value lower than the number of characters required to display all the output, the content of the line is cut.
*SELECT * FROM zpokemon.
*  WRITE zpokemon.
*  ENDSELECT.
*******************************************************************************************************************************************

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> PETE MOXTON'S ABAP -> VARIABLES
*---------------------------------------------------------------------------------------------------------------------------------
*A field is a temporary area of memory I can assign a name to and reference in my programs.
*A variable is a field whose value change during the program execution. Its name must start with a letter, 30 chars is the max size, no plus,
*comma, colon, parentheses and no reserved words.
*DATA: integer_one TYPE i,
*      packed_decimal_1 TYPE p DECIMALS 3 VALUE '0.9', "Stores numbers with decimal places. It can have up to 14 decimal places.
*      packed_decimal_2 LIKE packed_decimal_1, "LIKE makes the new variable take on exactly the same properties defined for the other variable.
**So changing packed_decimal_1 also changes packed_decimal_2.
*      packed_decimal_3 LIKE packed_decimal_1.
*
*WRITE packed_decimal_3. "When printed, shows 0.000???
*WRITE packed_decimal_1. "This shows '0.900' which makes sense because DECIMALS is 3... So perhaps LIKE gives properties, but not values.
*ULINE.
*
*integer_one = 10.
*WRITE integer_one.
*ADD 7 TO integer_one. "Lol, this works.
*WRITE integer_one.
*MULTIPLY integer_one BY 2.
*WRITE integer_one.



*TABLES zpokemon.
*
*DATA mychar(10) TYPE c. "(10) sets the length of the string.
*
*DATA mychar2. "The default length is one character... And the character field is the default type used by ABAP when declaring a field so I don't even need to declare the type. It's a c!
*              "This is the same as DATA mychar2(1) TYPE c.
*
*"DATA zpokemon(40) TYPE c. IS THE SAME AS DATA zpokemon LIKE ZPOKEMON-SURNAME. Because the surname is a CHAR with the length of 40.
*
*DATA stuff TYPE n. "NUMC -> 'number data type'. It is treated just like a character type, but only numeric characters are allowed. When data is moved in to the field, they are automatically
*                   "right-aligned just like a normal numeric type field. It's useful when I want a number but no plans for performing any calculations.
*                   "The initial value of this field is 0, not a space like a character's!
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> PETE MOXTON'S ABAP -> CONVERSION RULES
*---------------------------------------------------------------------------------------------------------------------------------

*DATA: number_one TYPE p DECIMALS 2 VALUE '2',
*      number_two TYPE p DECIMALS 2 VALUE '8',
*      result TYPE i,
*      result2 TYPE p DECIMALS 2.
*
*result = number_one.
*WRITE: / result.
**Result will be 3.
*
*result = number_two.
*WRITE: / result.
**Result will be 5.
*
**************************************************
**Regular division.
*result2 = number_one / number_two.
*WRITE: / result2.
*
**Integer division.
*result2 = number_one DIV number_two. "DIV converts values to integers.
*WRITE: / result2.
*
**Remainder division.
*result2 = number_one MOD number_two. "Modulo in theory, but if the second value is higher than the previous one, it just gives the first value???
*WRITE: / result2.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> PETE MOXTON'S ABAP -> OPERATIONS ON CHARACTER STRINGS
*---------------------------------------------------------------------------------------------------------------------------------
**CONCATENATE----------------------------------------
*DATA: title(15)         TYPE c VALUE 'High King',
*      forename(40)      TYPE c VALUE 'Rasta',
*      surname(40)       TYPE c VALUE 'Khan',
*      sep, "This is the separator field. No length or type are declared, so default ones are used! These are (1) and C!
*      destination1(200) TYPE c.
*CONCATENATE title forename surname INTO destination1 SEPARATED BY sep.
**First, I decide what I want concatenated and then into what. I can separate the incoming values by whatever I deem fit.
**If the sum of lengths of concatenated fields is larger than the number of destination1's available characters -> it will be truncated.
**I should be using string data type for it. It can hold over 65.000 characters.
*WRITE destination1.
**Program some! <3 -> programmed some! <3
*ULINE.
*
*
*
*
*
**CONDENSE----------------------------------------
**Removes leading and closing blanks characters. All directly consecutive blanks are all replaced by exactly one space character.
**If NO-GAPS additions is used -> removes all blank spaces.
*DATA: spaced_name(50) TYPE c VALUE ' Hand    of     Argus     Halasibel '. "Without specifying the length, it won't print it!
*WRITE: / spaced_name. "No changes.
*ULINE.
*CONDENSE spaced_name.
*WRITE: / spaced_name. "Simple CONDENSE.
*ULINE.
*CONDENSE spaced_name NO-GAPS.
*WRITE: spaced_name. "No blanks.
*ULINE.
*
*
*
*
*
**FINDING THE LENGTH OF A STRING----------------------------------------
*DATA: len TYPE i. "To hold the length of a string.
*len = strlen( surname ). "strln is a function, not a statement. So basically string.length()
*WRITE: 'The length of the surname is ', len.
*ULINE.
*
*
*
*
*
**REPLACE----------------------------------------
*DATA full_name(40). "No type defined, so this is the default type - c!
*full_name = 'Corsair, King Castamir'.
*WRITE full_name.
*ULINE.
*REPLACE ',' WITH '' INTO full_name. "This replaces only the first comma!
*WRITE full_name.
*ULINE.
*
**I can replace all occurences of a thing:
*DATA: name1(20). "At first, I didn't add here the length and so the data element had the value of 'A'.
*name1 = 'Ash, Ketchum,'.
*WRITE name1.
*ULINE.
*REPLACE ',' WITH '' INTO name1. "The second comma remains.
*REPLACE ALL OCCURRENCES OF ',' IN name1 WITH ''.
*WRITE name1. "Both commas are removed.
*ULINE.
*
*
*
*
*
**SEARCH----------------------------------------
**... for specific characters.
**I am not specifying a variable here to hold any result. Instead, two system variables are used:
**1) sy-subrc -> identifies whether the search was successful or not.
**2) sy_fdpos -> if the search was successful, this variable is set to the position of the character string I am searching for
**in another_name.
*DATA another_name(30) TYPE c VALUE 'Herumor the Black Dread'.
*
*WRITE: 'Searching: Herumor the Black Dread'.
*SKIP.
*
**Blank spaces are ignored.
*SEARCH another_name FOR 'Herumor       '.
*WRITE: / 'Searching for "Herumor       " ...'.
*WRITE: / 'sy-subrc: ', sy-subrc, / 'sy-fdpos: ', sy-fdpos.
*ULINE.
*
**Blank spaces are taken into account.
*SEARCH another_name FOR '.Herumor'. "NOTE <-- this makes no sense at all. This isn't any actual functionality that tells ABAP to take blanks into consideration. It treats points like regular characters.
*                                    "Even '.Herumor' does not work, so this point literally does nothing.
*WRITE: / 'Searching for ".Herumor      ." ...'.
*WRITE: / 'sy-subrc: ', sy-subrc, / 'sy-fdpos: ', sy-fdpos.
*ULINE.
*
**Wild card search -> ending.
*SEARCH another_name FOR '*ead'.
*WRITE: / 'Searching for "*ead" ...'.
*WRITE: / 'sy-subrc: ', sy-subrc, / 'sy-fdpos: ', sy-fdpos. "Gives the index of 18 because the index of the word '*ead' is a part of starts at 18th index.
*ULINE.
*
**Wild card search -> beginning.
*SEARCH another_name FOR 'He*'.
*WRITE: / 'Searching for "Bla*" ...'.
*WRITE: / 'sy-subrc: ', sy-subrc, / 'sy-fdpos: ', sy-fdpos. "SAME.
*ULINE.
**Wild cards show the starting index of the word that contains the sought for value. Blank spaces have indexes too. So both 'He*' and '*or' will give sy-fdpos = 0, because they are both parts of
**the word 'Herumor' which starts after the index 0.
*
*
*
*
*
**SHIFT----------------------------------------
**Allows me to move the content of the character string left or right character by character.
*DATA: emp_num(10) TYPE c VALUE '0000654321'. "When I didn't specify the length of C, it was set to default 1... and the result was 1?
*SHIFT emp_num LEFT DELETING LEADING '0'.
*WRITE: / emp_num.
*ULINE.
*
*SHIFT emp_num. "The output here will be '54321', because previously I deleted the 0s and the defult shift is by 1. So 6 gets yeeted.
*WRITE: / emp_num.
*ULINE.
*
*SHIFT emp_num CIRCULAR. "Shifts the string by the default 1, but does not yeet 5 out (6 got yeeted out before), but yeets it to the other side of the string.
*WRITE: / emp_num.       "So the result is '4321     5'. The blanks are there because it's still of the length 10.
*ULINE.
**I can always use -> CONDENSE emp_num NO-GAPS. -> if I want to remove the blank spaces!
*WRITE: / emp_num.
*ULINE.
*
*
*
*
*
**SPLIT----------------------------------------
*DATA: mystring(30) TYPE c,
*      a1(10)       TYPE c,
*      a2(10)       TYPE c,
*      a3(10)       TYPE c,
*      sep2(2)      TYPE c VALUE '**'.
*
*mystring = ' 1234** ABCD **6789'.
*WRITE: / mystring.
*ULINE.
*SKIP.
*
*SPLIT mystring AT sep2 INTO a1 a2 a3. "This means -> SPLIT the provided string AT the position where you find whatever value 'sep2' holds INTO the following data elements.
*WRITE: / a1.
*WRITE:/  a2. "Retains the blank space before it, as only '**' are removed.
*WRITE: / a3. "SAME.
*ULINE.
*SKIP.
*
*DATA: mystring2(30) TYPE c.
*
*mystring2 = 'looool**omg **wtf**rofl'.
*WRITE mystring2.
*ULINE.
*SKIP.
*
*SPLIT mystring2 AT sep2 INTO a1 a2 a3. "SPLIT will try to divide the string into four pieces, because there are three occurences of its separator within the string.
*                                       "Since there are only three fields provided, the remainder (the one that would go into the fourth) will be assigned to the last
*                                       "field provided, so a3.
*WRITE: / a1.
*WRITE:/  a2.
*WRITE: / a3.
*ULINE.
*SKIP.
**If the separator is not found at all within the string, the entirety of the string will be moved to the first of the provided fields that were to receive the pieces of the string!
*
*
*
*
*
**SUB-FIELDS----------------------------------------
**Used to refer to specific characters within the field - "processing sub-fields". There is no SUB-FIELD keyword/function. The syntax of 'string+6(2)' is what makes SUB-FIELD operations.
*DATA: int_telephone_num(17) TYPE c,
*      country_code(3)       TYPE c,
*      telephone_num(14)    TYPE c.
*
*int_telephone_num = '+44-(0)207-123456'.
*WRITE: / int_telephone_num.
*SKIP.
*
*country_code = int_telephone_num(3). "country_code assumes the value of the first three characters of int_telephone_num.
*
*telephone_num = int_telephone_num+4(13). "telephone_num assumes the value of the 13 characters of int_telephone_num and their count begins after the 4th character.
*
*WRITE: / 'country_code: ', country_code.
*WRITE: / 'telephone_num: ', telephone_num.
*
*country_code+1(2) = '01'.
*
*WRITE: / 'country_code: ', country_code.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> PETE MOXTON'S ABAP -> DATE AND TIME FIELDS
*---------------------------------------------------------------------------------------------------------------------------------
**Date and time fields are NOT defined as numeric data types, but character data types. They are characeter strings that can be used in calculations. It's possible
**thanks to automatic data types' conversions.
*DATA: my_date TYPE d. "D is always 8 characters -> first four a year, next two a month and the last two a day. Much like sy-datum then. If I do not specify the value, defaults to 0 (00000000).
*DATA: my_date2 LIKE sy-datum. "I can use LIKE if I already know a date data type and want to copy its structure.
*
**Time fields are 6 character long -> HHMMSS (default 000000).
*DATA: my_time TYPE t.
*DATA my_time2 LIKE sy-uzeit. "System time, like sy-datum being system date.
*
**Both my_date2 and my_time2 are all 0s, because the data types are LIKE them (structure-wise), they do not assume their values.
*WRITE: / my_date.
*ULINE.
*WRITE: / my_date2.
*ULINE.
*WRITE: / my_time.
*ULINE.
*WRITE: / my_time2.
*ULINE.
*
**Below will be displayed as '16.05.1989' because WRITE applies its own formatting which is associated with my user logon.
*my_date = '19890516'.
*WRITE: / my_date.
*ULINE.
*
*
*
**CALCULATIONS WITH DATE FIELDS----------------------------------------
*DATA: empl_sdate TYPE d,
*      todays_date TYPE d,
*      length_of_service TYPE i.
*
*empl_sdate = '20210607'.
*todays_date = sy-datum.
*length_of_service = todays_date - empl_sdate. "On 23.10.2021 I worked for CEDC for 138 days!
*WRITE: length_of_service.
*ULINE.
*
***********************************
*
*DATA: days_count TYPE i,
*      future_date TYPE d.
*
*days_count = 20.
*future_date = todays_date + days_count. "The date is calculated correctly just by adding an integer (which here represents days) <3
*WRITE: future_date.
*ULINE.
*
***********************************
*
**Subfield ->I can change the date like that to, say, represent the 20th of the current month instead of an actual date.
*todays_date = sy-datum.
*todays_date+6(2) = '20'.
*WRITE todays_date.
*ULINE.
*
**Subtracking the value -> e.g. choosing the last day of the previous month.
*todays_date = sy-datum.
*todays_date+6(2) = '01'. "Set the current month's day to the first...
*todays_date = todays_date - 1.
*WRITE todays_date.
*ULINE.
*
*
*
**CALCULATIONS WITH TIME FIELDS----------------------------------------
*DATA: clock_in TYPE t,
*      clock_out TYPE t,
*      seconds_diff TYPE i,
*      minutes_diff TYPE i,
*      hours_diff TYPE p DECIMALS 2.
*
*clock_in = '073000'. "This is 07:30:00 (HHMMSS).
*clock_out = '160000'.
*
**SECONDS:
*seconds_diff = clock_out - clock_in.
*WRITE: 'Clock-in time is: ', clock_in, 'Clock-out time is: ', clock_out.
*WRITE: / 'The time spent in seconds is: ', seconds_diff.
*
**MINUTES:
*minutes_diff = seconds_diff / 60.
*WRITE: / 'The time spent in minutes is: ', minutes_diff.
*
**HOURS:
*hours_diff = minutes_diff / 60.
*WRITE: / 'The time spent in hours is: ', hours_diff.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> PETE MOXTON'S ABAP -> QUANTITY AND CURRENCY
*---------------------------------------------------------------------------------------------------------------------------------
**Treated just like pack number fields (p). They need thus be declared as such...
**But it may be better to associate my fields with those already existing in ABAP dictionary. So LIKE will be used.
*
*TABLES: zpokemon. "I need this declaration here because I will be selecting data from it via a SELECT.
*
*DATA: my_salary      LIKE zpokemon-salary, "ABAP will keep my field's and my table's data type of salary in sync.
*                                           "There are two aspects to it: a number of decimals places and the associated currency or quantity fields.
*
*      tax_amount     LIKE zpokemon-salary, "This is also a currency with two decimal places so it can reference the same ABAP dictionary field.
*      net_pay        LIKE zpokemon-salary,
*      tax_percentage TYPE p DECIMALS 2.
*
*tax_percentage = '0.20'. "20% tax rate.
*
*SELECT * FROM zpokemon.
*  WRITE: / 'Surname: ', zpokemon-surname, 'Salary: ', zpokemon-salary, zpokemon-ecurrency.
*  tax_amount = tax_percentage * zpokemon-salary.
*  net_pay = zpokemon-salary - tax_amount.
*  WRITE: / 'Tax amount is: ', tax_amount, zpokemon-ecurrency,
*           'Net pay is: ', net_pay, zpokemon-ecurrency.
*  ULINE.
*ENDSELECT.
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> OPEN SQL
*---------------------------------------------------------------------------------------------------------------------------------
**Pete wants me to get into the habit of checking whether the action I've been executing has been executed successfully. Sy-subrc will come in handy.
*
*
*
**INSERT----------------------------------------
*DATA: wa_zpokemon LIKE zpokemon. "WA is a record structure, not a table structure -> stores one record.
*
*wa_zpokemon-EMPLOYEE = '80000'.
*wa_zpokemon-SURNAME = 'Taha'.
*wa_zpokemon-FORENAME = 'Justinia'.
*wa_zpokemon-TITLE = 'Ms'.
*wa_zpokemon-DOB = '20191023'.
*wa_zpokemon-INITIALS = 'OS'.
*wa_zpokemon-GENDER = 'N'.
*wa_zpokemon-SALARY = '23525'.
*wa_zpokemon-ECURRENCY = 'USD'.
*wa_zpokemon-ZZLOCATION = 'Warsaw'.
*wa_zpokemon-ZZDEPT = 'IT'.
*
*INSERT zpokemon FROM wa_zpokemon. "Literally INSERT INTO zpokemon FROM wa_zpokemon.
*  WRITE: 'INSERT.'.
*IF sy-subrc = 0.
*  WRITE: 'Record inserted correctly. The surname is: ', wa_zpokemon-surname. "It will throw 4, because the record already exists!
*ELSE.
*  WRITE: 'The return code is: ', sy-subrc.
*
*ENDIF.
*ULINE.
*
*
*
**CLEAR----------------------------------------
**Used mainly in loops. Just clear the area to make sure values are not assigned incorrectly.
**I can clear the entire structure or specific fields.
*CLEAR wa_zpokemon. "Not really necessary in this case as I am covering every field anyway and so there won't be any value I would not want
*                   "lingering in any field of the work area structure, but it just seems so elegant!
*
*
*
**UPDATE----------------------------------------
**Allows me to modify one or more existing records within a table.
*wa_zpokemon-EMPLOYEE = '80000'.
*wa_zpokemon-SURNAME = 'Tahar'.
*wa_zpokemon-FORENAME = 'Justinia'.
*wa_zpokemon-TITLE = 'Ms'.
*wa_zpokemon-DOB = '20191023'.
*wa_zpokemon-INITIALS = 'OS'.
*wa_zpokemon-GENDER = 'N'.
*wa_zpokemon-SALARY = '23525'.
*wa_zpokemon-ECURRENCY = 'USD'.
*wa_zpokemon-ZZLOCATION = 'Warsaw'.
*wa_zpokemon-ZZDEPT = 'IT'.
*
*
*UPDATE zpokemon FROM wa_zpokemon.
*  WRITE: 'UPDATE.'.
*IF sy-subrc = 0.
*  WRITE: 'Record updated correctly. The surname is: ', wa_zpokemon-surname.
*ELSE.
*  WRITE: 'The return code is: ', sy-subrc.
*
*ENDIF.
*ULINE.
*
*
*
**MODIFY----------------------------------------
**Like a combination of INSERT and UPDATE - it can be used either to introduce a new record or modify an existing one. When I know I am inserting
**or I know I am updating a record, I should always use INSERT or UPDATE respectively. MODIFY is to be used when my code is to EITHER insert or
**update a record depending on the situation, so when I need a flexible soultion.
*
**MODIFY AS AN UPDATE********************
*wa_zpokemon-EMPLOYEE = '80000'.
*wa_zpokemon-SURNAME = 'Tahari'.
*wa_zpokemon-FORENAME = 'Justinia'.
*wa_zpokemon-TITLE = 'Ms'.
*wa_zpokemon-DOB = '20191023'.
*wa_zpokemon-INITIALS = 'OS'.
*wa_zpokemon-GENDER = 'N'.
*wa_zpokemon-SALARY = '23525'.
*wa_zpokemon-ECURRENCY = 'USD'.
*wa_zpokemon-ZZLOCATION = 'Warsaw'.
*wa_zpokemon-ZZDEPT = 'IT'.
*
*MODIFY zpokemon FROM wa_zpokemon. "When MODIFY is executed, the primary key fields from wa_pokemon will be checked against those records held
*                                 "in the table.
*                                 "If a record exists, it will be UPDATED with the content held in my work area.
*                                 "If a record does not exist, a new one will be INSERTED at the end of the table!
*  WRITE: 'MODIFY.'.
*IF sy-subrc = 0.
*  WRITE: 'Record modified correctly. The surname is: ', wa_zpokemon-surname.
*ELSE.
*  WRITE: 'The return code is: ', sy-subrc.
*
*ENDIF.
*ULINE.
*
**MODIFY AS AN INSERT********************
*
*CLEAR wa_zpokemon.
*
*wa_zpokemon-EMPLOYEE = '333333'.
*wa_zpokemon-SURNAME = 'Hilieandil'.
*wa_zpokemon-FORENAME = 'Nurnirven'.
*wa_zpokemon-TITLE = 'Mr'.
*wa_zpokemon-DOB = '20191023'.
*wa_zpokemon-INITIALS = 'NH'.
*wa_zpokemon-GENDER = 'M'.
*wa_zpokemon-SALARY = '23525'.
*wa_zpokemon-ECURRENCY = 'USD'.
*wa_zpokemon-ZZLOCATION = 'Warsaw'.
*wa_zpokemon-ZZDEPT = 'IT'.
*
*MODIFY zpokemon FROM wa_zpokemon.
*
*WRITE: 'MODIFY.'.
*IF sy-subrc = 0.
*  WRITE: 'Record modified correctly. The surname is: ', wa_zpokemon-surname.
*ELSE.
*  WRITE: 'The return code is: ', sy-subrc.
*
*ENDIF.
*ULINE.
*
*
*
**DELETE----------------------------------------30.10.2021
**It only needs to take into account the Primary Key. I give a primary key and in return receives the removal of the record of said primary key.
**My zpokemon table contains two Primary Keys, but the MANDT (Client) is handled automatically by the system so I don't need to feed my SQL statements
**the MANDT field.
*wa_zpokemon-EMPLOYEE = '80000'.
*
*DELETE zpokemon FROM wa_zpokemon. "Delete a record from zpokemon table that has the employee that equals 80000.
*
*WRITE: 'DELETE.'.
*IF sy-subrc = 0.
*  WRITE: 'Record deleted correctly.'.
*ELSE.
*  WRITE: 'The return code is: ', sy-subrc.
*
*ENDIF.
*ULINE.
*
*
*
**I can delete records WHERE...
**START OF - Insert two exemplary records*******************************************
*
**EXAMPLE EHI
*CLEAR wa_zpokemon.
*wa_zpokemon-EMPLOYEE = '777'.
*wa_zpokemon-SURNAME = 'Oongha'.
*wa_zpokemon-FORENAME = 'Siv'.
*wa_zpokemon-TITLE = 'Ms'.
*wa_zpokemon-DOB = '20191023'.
*wa_zpokemon-INITIALS = 'SO'.
*wa_zpokemon-GENDER = 'F'.
*wa_zpokemon-SALARY = '23525'.
*wa_zpokemon-ECURRENCY = 'USD'.
*wa_zpokemon-ZZLOCATION = 'Warsaw'.
*wa_zpokemon-ZZDEPT = 'IT'.
*INSERT zpokemon FROM wa_zpokemon.
*
*WRITE: 'INSERT example Ehi.'.
*IF sy-subrc = 0.
*  WRITE: 'Ehi in place.'.
*ELSE.
*  WRITE: 'Lol, fail! You got ', sy-subrc, '!'.
*ENDIF.
*ULINE.
*
**EXAMPLE OCI
*CLEAR wa_zpokemon.
*wa_zpokemon-EMPLOYEE = '778'.
*wa_zpokemon-SURNAME = 'Tharo'.
*wa_zpokemon-FORENAME = 'Siv'.
*wa_zpokemon-TITLE = 'Ms'.
*wa_zpokemon-DOB = '20191023'.
*wa_zpokemon-INITIALS = 'SO'.
*wa_zpokemon-GENDER = 'F'.
*wa_zpokemon-SALARY = '23525'.
*wa_zpokemon-ECURRENCY = 'USD'.
*wa_zpokemon-ZZLOCATION = 'Warsaw'.
*wa_zpokemon-ZZDEPT = 'IT'.
*INSERT zpokemon FROM wa_zpokemon.
*
*WRITE: 'INSERT example Oci.'.
*IF sy-subrc = 0.
*  WRITE: 'Oci in place.'.
*ELSE.
*  WRITE: 'Lol, fail! You got ', sy-subrc, '!'.
*ENDIF.
*ULINE.
**END OF - Insert two exemplary records*********************************************
*
*DELETE FROM zpokemon WHERE forename = 'Siv'. "In the case of using WHERE, FROM too must be utilized.
*
*WRITE: 'DELETE TWO RECORDS.'.
*IF sy-subrc = 0.
*  WRITE: 'Two exemplary records deleted correctly.'.
*ELSE.
*  WRITE: 'The return code is: ', sy-subrc.
*ENDIF.
*ULINE.
*
**WARNING -> I need to be cautious with DELETE FROM table_name because such a statement without any WHERE will simply
**erase all records within the table.
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> PROGRAM FLOW CONTROL AND LOGICAL EXPRESSIONS
*---------------------------------------------------------------------------------------------------------------------------------
**IF----------------------------------------
*DATA: item TYPE string.
*item = 'mug'.
*
*IF item = 'mug'.
*  WRITE: 'I can make if statements.'.
*ELSE.
*  WRITE: 'I cannot.'.
*ENDIF.
*ULINE.
*
*
*
**Linking logical expressions together----------------------------------------
**There is the old way of writing logical operators:
**EQ - equals,
**NE - not equals,
**LT - less than,
**GT - greater than,
**LE - less or equal,
**GE - greater or equal.
*
**I am doing OOP for fun <3
*CLASS dog DEFINITION.
*  PUBLIC SECTION.
*
*    CLASS-DATA: num_of_dogs TYPE i.
*    CLASS-METHODS class_constructor. "A static constructor.
*
*    METHODS constructor
*      IMPORTING
*         name            TYPE c
*         age             TYPE i
*         breed           TYPE c
*         happiness_level TYPE i.
*
*    METHODS: pet IMPORTING increment TYPE i EXPORTING result TYPE i,
*             view_dog,
*             show_the_dog_log,
*             get_happiness_level            EXPORTING result TYPE i,
*             get_name                       EXPORTING result TYPE c.
*
*  PRIVATE SECTION.
*    DATA: name(30)            TYPE c,
*          age                 TYPE i,
*          breed(30)           TYPE c,
*          happiness_level     TYPE i.
*
*    CLASS-DATA: dog_log TYPE i. "Used by my static constructor.
*ENDCLASS.                    "dog DEFINITION
**----------------------------------------------------------------------*
**       CLASS dog IMPLEMENTATION
**----------------------------------------------------------------------*
**
**----------------------------------------------------------------------*
*CLASS dog IMPLEMENTATION.
*  METHOD class_constructor. "The calculations do not really make sense, I think. I declared dog_log in a private section. I would need to prepare a method to reach for it.
*    IF dog_log NE 0.
*      dog_log = dog_log + 1.
*    ELSE.
*      dog_log = 1.
*    ENDIF.
*    WRITE: / 'Class dog (a classy dog!) has been used!'.
*    WRITE: / 'Current number of good bois is: ', dog_log.
*  ENDMETHOD.                    "class_constructor
*
*  METHOD constructor.
*    me->name = name.
*    me->age = age.
*    me->breed = breed.
*    me->happiness_level = happiness_level.
*    num_of_dogs = num_of_dogs + 1.
*  ENDMETHOD.                    "constructor
*
*  METHOD pet.
*    happiness_level = happiness_level + increment.
*  ENDMETHOD.                    "pet
*
*  METHOD view_dog.
*    WRITE: 'Name: ', name.
*    WRITE: 'Age: ', age.
*    WRITE: 'Breed: ', breed.
*    WRITE: 'Happiness level: ', happiness_level.
*  ENDMETHOD.                    "view_dog
*
*  METHOD show_the_dog_log.
*    WRITE: dog_log.
*  ENDMETHOD.                    "show_the_dog_log
*
*  METHOD get_happiness_level.
*    result = happiness_level.
*  ENDMETHOD.                    "get_happiness_level
*
*  METHOD get_name.
*    result = name.
*  ENDMETHOD.                    "get_name
*
*ENDCLASS.                    "dog IMPLEMENTATION
*
*
*START-OF-SELECTION. "Telling ABAP where I want to start the processing of my program.
*
*  DATA: dog_bravo TYPE REF TO dog,
*        dog_delta TYPE REF TO dog.
*
*  CREATE OBJECT: dog_bravo "The consturctor requires parameters so I need to pass them here. Shocking, innit?!
*    EXPORTING
*      name            = 'Attalos'
*      age             = 2
*      breed           = 'Huskylamute'
*      happiness_level = 10.
*  CREATE OBJECT: dog_delta
*    EXPORTING
*      name            = 'Kasztanek'
*      age             = 1
*      breed           = 'Huskylamute'
*      happiness_level = 10.
*
*  CALL METHOD: dog_bravo->view_dog.
*  ULINE.
*  CALL METHOD: dog_delta->view_dog.
*  ULINE.
*
*  DATA: the_result TYPE i.
*
**Below means - on dog_bravo call a method 'pet', put into the method 'increment' which has the value of 4, and take out
**the 'result' (both 'increment' and 'result' are the innards of the 'pet' method and upon the extraction of the result
**assign it to 'the_result'.)
*  CALL METHOD: dog_bravo->pet( EXPORTING increment = 4 IMPORTING result = the_result ).
*  CALL METHOD: dog_bravo->view_dog.
*  ULINE.
**Both good bois deserve petting.
*  CALL METHOD: dog_delta->pet( EXPORTING increment = 4 IMPORTING result = the_result ).
*  CALL METHOD: dog_delta->view_dog.
*  ULINE.
*
**CALL METHOD dog_bravo->show_the_dog_log. <---- technically, it works, but seems pointless. I basically require a method called on an object here
*  "because I declared 'dog_log' in private section. And it's always one anyway, I think, since it's
*  "used by the static constructor, it only can be called upon the creation of the first object
*  "and that value will just not increment... because the incrementation is defined within the class
*  "constructor.
*
**To call a static attribute of 'num_of_dogs'.
*  DATA: the_number_that_matters TYPE i.
*  the_number_that_matters = dog=>num_of_dogs.
*  WRITE: / 'There are currently ', the_number_that_matters, ' good bois around.'.
*
**And now about that linkage of logical expressions...
*  DATA: new_result1 TYPE i.
*  DATA: new_result2 TYPE i.
*  CALL METHOD: dog_bravo->get_happiness_level( IMPORTING result = new_result1 ).
*  CALL METHOD: dog_delta->get_happiness_level( IMPORTING result = new_result2 ).
*
*  IF new_result1 EQ 14 AND new_result2 EQ 14.
*    WRITE: / 'Both puppers are happy!'.
*  ELSE.
*    WRITE: / 'Fix that method, mate.'.
*  ENDIF.
*  ULINE.
*
*
*
**Nested IFs----------------------------------------
*  DATA: name_keeper(30) TYPE c,
*        name_holder(30) TYPE c.
*
*  CALL METHOD: dog_bravo->get_name( IMPORTING result = name_keeper ).
*  CALL METHOD: dog_delta->get_name( IMPORTING result = name_holder ).
*  IF name_keeper EQ 'Attalos'.
*    IF name_holder EQ 'Kasztanek'.
*      WRITE: 'Pupperino victoria.'.
*    ELSE.
*      WRITE: 'Second condition failed.'.
*    ENDIF.
*  ELSE.
*    WRITE: 'First condition failed.'.
*  ENDIF.
*  ULINE.
*
*
*
**Case statement----------------------------------------
**Kind of a Java's switch. They can be nested too.
*  CASE name_holder.
*    WHEN 'Attalos'.
*      WRITE: / 'A little pup!'.
*      CASE name_holder.               "A nested case.
*        WHEN 'Kasztanek'.             "A nested case.
*          WRITE: / 'A little pup 2!'. "A nested case.
*        WHEN OTHERS.                  "A nested case.
*          WRITE: 'Fix, lol!'.         "A nested case.
*      ENDCASE.                        "A nested case.
*    WHEN 'Kasztanek'.
*      WRITE: 'A little doggy!'.
*    WHEN OTHERS.
*      WRITE: 'Fix that method so that it shows DOGS.'.
*  ENDCASE.
*  ULINE.
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> LOOPS
*---------------------------------------------------------------------------------------------------------------------------------
**SELECT----------------------------------------
*  TABLES: zpokemon.
*
**SELECT * FROM zpokemon.
**  WRITE: / zpokemon.                               "This will print out all the records within the table... Or it should, according to Pete. It doesn't work here.
**  ENDSELECT.
*
**  SELECT * FROM zpokemon WHERE surname = 'ANIKAR'.
**    WRITE: / zpokemon.                              "It doesn't want to print 'zpokemon' without me specifying the fields!
**  ENDSELECT.
*
*
*
**DO LOOP----------------------------------------
**sy-index keeps the index of the loop's iteration.
*DATA: a TYPE i.
*
*a = 0.
*
*DO 10 TIMES.
*  a = a + 1.
*  WRITE: / 'Dog.', a.
**  WRITE sy-index. "This will print out the same number set as 'a'. Outside of the loop, it's back to 0.
*ENDDO.
*ULINE.
*
*
**NESTED DO LOOP----------------------------------------
**Each DO LOOP has its own sy-index.
*DATA: b TYPE i,
*      c TYPE i,
*      d TYPE i.
*
*DO 3 TIMES.
*  b = b + 1.
*  WRITE: / 'Outer loop is at: ', b.
*  c = 0.
*  DO 3 TIMES.
*    c = c + 1.
*    WRITE: / 'Inner loop is at: ', c.
*  ENDDO.
*  d = d + c.
*ENDDO.
*  d = d + b.
*ULINE.
*WRITE: 'The total number of iterations is: ', d.
*ULINE.
*
*
*
**WHILE LOOP----------------------------------------
*DATA: u TYPE i,
*      y TYPE i.
*
*u = 0.
*y = 0.
*
*WHILE u <> 10.
*  WRITE: / 'Haha, lol!', u.
*    WHILE y <> 5.
*      WRITE: 'Nested rotfl!'.
*      y = y + 1.
*    ENDWHILE.
*  u = u + 1.
*ENDWHILE.
*ULINE.
*
*
*
**CONTINUE---------------------------------------- 03.11.2021
**Termination statements allow me to terminate a loop prematurely. There are two kinds of such statements:
**-those that apply to the loop,
**-those that apply to the processing block in which the loop occurs.
**CONTINUE is the doom of the processing of a loop. I can cut down the loop unconditionally using this statement.
*DATA: omg TYPE i VALUE 1.
*
*DO 15 TIMES.
*  omg = omg + 1.
*  IF sy-index = 2.          "When it's on the index 2...
*    CONTINUE.
*  ENDIF.
*  WRITE: / 'Omg is: ', omg. "... this will not be written down. Because CONTINUE aborts the processing of anything
*ENDDO.                      "left to process within the loop AND RETURNS TO THE BEGINNING OF THE LOOP.
*ULINE.
*
*
*
**CHECK----------------------------------------
**Allows for the termination of the loop passes, but also for the checking of the certain conditions first.
**It is kind of a combination of an IF statements and a CONTINUE statement.
*DATA: wtf TYPE i VALUE 0.
*
*DO 10 TIMES.
*  wtf = wtf + 1.
*  CHECK sy-index <> 2.      "Basically - 'If the system variable is at the second index, abandon the rest of the current
*  WRITE: / 'Wtf is: ', wtf. "loop and go back to the beginning of the loop.
*ENDDO.
*ULINE.
**CHECK can also be used outside of the loops, e.g. in subroutines (function modules?). It's essentially a very nice
**big red 'Do not press!' button.
*
*
*
**EXIT----------------------------------------
**Allows me to assasinate the loop without any conditions provided. The loop. It stops the entirety of the loop,
**unlike CONTINUE which terminates just the ongoing roll of the loop.
**If I use it in a subroutine then it will just abandon it and return to the main program.
*DATA: lmao TYPE i VALUE 0.
*
*DO 10 TIMES.
*  lmao = lmao + 1.
*  IF sy-index = 3.
*    EXIT.
*  ENDIF.
*  WRITE: / 'Lmao is: ', lmao. "Just two of those are written, because when it's index 3's time to shine
*ENDDO.                        "it just exits the loop altogether.
*WRITE: / 'Almost no lmaos written!'.
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> SELECTION SCREENS
*---------------------------------------------------------------------------------------------------------------------------------
**Event (all these blocks) end only when another block starts.
*TABLES: zpokemon.
*
*DATA: wa_zpokemon LIKE zpokemon-employee.
*
**FORMATTING SELECTION SCREENS----------------------------------------
**Without this, system decided where it puts all of my selection screen objects. E.g. when I have a group of radiobuttons, I should organise them
**into their own group, visibly separate from other objects. The Selection-Screen statements requires Additions which specify the type of a layout option
**which I am defining.
*PARAMETERS: my_emp   LIKE zpokemon-employee DEFAULT 333 OBLIGATORY,
*            my_gend  LIKE zpokemon-gender VALUE CHECK, "Line 2679.
*            my_sur   LIKE zpokemon-surname DEFAULT 'Tatanka' LOWER CASE, "I can make sure the value will be in lower case. Otherwise, when I press enter on the parameter box - it defaults it to the upper case.
*            my_box   AS CHECKBOX. "I think I could use it just like radiobuttons were used in ZR07MLBE -> a condition for an IF statement.
*SELECTION-SCREEN SKIP 3. "ADDITION! Skips 3 lines here!
*SELECTION-SCREEN ULINE.  "ADDITION! Underlines.
*SELECTION-SCREEN ULINE /1(8). "ADDITION! SlASH means the new line, then comes the POSITION (how many characters to skip before printing the line) and in the brackets the LENGTH of the line.
*SELECTION-SCREEN ULINE /40(8). "Skip 40 characters and then print a line!
**ADDITION! COMMENT allows me to add text to the Selection Screen. The comment itself can either be a Text Element or a variable name.
**These variables are NOT declared within the DATA block, but when the program is started, so - in the INITIALIZATION block.
*SELECTION-SCREEN COMMENT /40(15) text-001.
*SELECTION-SCREEN COMMENT 60(15) comm1. "The lack of the slash means it will be in the same line as the comment above.
**I can format a single line by creating a block with BEGIN OF LINE and END OF LINE.
**I will get a syntax error if I try to use a SLASH in any of these two comments. That's a single line and no more allowed!
**Also, if I define a parameter field within BEGIN OF LINE-END OF LINE section, it does not display its technical name. A COMMENT is to be used.
**I can also use POSITION to decide where the element following that statement will be positioned.
**ELEMENT BLOCKS ---
**To group fields together. I can nest element blocks within element blocks.
**They are similar to BEGIN OF LINE.
*SELECTION-SCREEN BEGIN OF BLOCK my_block1 WITH FRAME TITLE text-001.
*SELECTION-SCREEN BEGIN OF LINE.
*SELECTION-SCREEN COMMENT 1(15) text-001.
*SELECTION-SCREEN COMMENT 20(20) comm2.
*SELECTION-SCREEN POSITION pos_high. "This can either be a number or I can use pos_low or pos_high to place stuff right where LOW and HIGH in usual SELECT-OPTIONS is placed!
*PARAMETER wtf(5).
*SELECTION-SCREEN END OF LINE.
*SELECTION-SCREEN END OF BLOCK my_block1.
*PARAMETERS: wa_green RADIOBUTTON GROUP grp1,
*            wa_blue  RADIOBUTTON GROUP grp1,
*            wa_yell  RADIOBUTTON GROUP grp1. "Only one of these radiobuttons can be selected! CTRL+F "radiobuttons"
*
*SELECT-OPTIONS: my_dob FOR zpokemon-dob NO-EXTENSION.
*
**INITIALIZATION----------------------------------------
*INITIALIZATION.                  "When the program is run -> it will be recognized I have this good boy over here so everything in this block will be executed first.
*  comm1 = 'Suuusuuumeeee!!!'.
*  comm2 = 'Deeediiicaaateee!'.
*  SELECT * FROM zpokemon.
*    wa_zpokemon = zpokemon-employee.
*  ENDSELECT.
*
**AT SELECTION SCREEN----------------------------------------
**Triggered when the user tries to execute the report. It's a good place to see what parameters have been provided.
**I can display a message for the user to tell them something isn't right if they provide incorrect parameters.
*AT SELECTION-SCREEN ON my_emp. "ON indicates to the system that the event (AT SELECTION-SCREEN) is specifically for this parameter.
*
**Checking if employee number is not greater than the last employee number within the table.
**wa_employee has the last employee because the SELECT kept overwriting the results until it went through the entire table.
**MESSAGE e000(ZBM_MES1) is a Text Message (explained below). It's different than Text Elements. e stands for Error (there are various
**ohter types), 000 is the number of the messgae that I created and ZBM_MES1 is the name of the Message Class which I also created.
**These are not integral parts of any program and can be reused.
**WITH is an addition that can be included. It allows me to add up to 4 different paramaters that can be passed into the message.
**In this case I can display the value entered into the error message that is going to be displayed.
**For the error message to be able to accept the addition, it needs to contain "&" within its text in a place where the additions is to be
**displayed.
**Message 000 does NOT contain an "&" and Message 001 does.
*  IF my_emp > wa_zpokemon.
*    MESSAGE e001(ZBM_MES1) WITH my_emp. "This is the error/warning message at the bottom of my program!
*  ENDIF.
*
*
*
**PARAMETERS----------------------------------------
**PARAMETERS: some_para TYPE i. <--- this will not work, because 'parameters cannot be defined locally (active FORM procedure or GET).
**                                   Basically, it will not allow me to declare any parameters after AT SELECTION-SCREEN has started.
**                                   Though, it's fine to declare it anywhere before or within INITIALIZATION.
*
*
*
**CHECKBOX----------------------------------------
**A checkbox always has to be of data type c. My data element 'my_box', if unchecked will hold a blank character. If ticked, it will hold an 'X'!
**Basically, a regular parameter allows me to enter any value. A checkbox allows either a blank or an 'X'.
*
**RADIOBUTTONS---
**The difference between them and checkboxes is that checkboxes are individual parameters in their own right and I can have many checkboxes and
**I can select many checkboxes on the screen.
**Radiobuttons have to belong to a group. Within those groups only a single radiobutton can be selected at any one time. Like checkboxes, they
**have to be of data type c and the length of one.
**So radiobuttons are to be used when I want to have a possibility of choosing between various options.
*
*
*
**SELECT-OPTIONS----------------------------------------
**Uses internal tables to store the provided values. These values need to be installed in a table in memory for our program to use.
**An internal table create thus has a similar restrction to parameters. They can only have a name that contains no more than eight characters.
**Select tables contain four separate fields which are defined when I create my SELECT-OPTIONS statement.
**These are:
** - sign <-- a data type c with one character's length. It determines for each record whether it should be included or excluded from the result set. The possible values that can be included here are 'I' and 'E'.
** - option <-- also type c, but the length of two. It holds the selection operator. Can contain EQ, NE, GT, LT, GE, LE, CP and NP. CP and NP.
** - low <-- the lower limit for a range of values that a user can enter.
** - high <-- the upper limit. Both low's and high's data types are determined by the database table to which my selection criteria is linked.
*
**When selection field is filled (whether a single value or multiple values), a record is generated and put into this internal table.
**There is no limit to how many records can be stored.
*
*
*
**VALUE CHECK----------------------------------------
**Allows me to include... value checking! :O Anything that is being entered is being checked against the valid value list that is
**defined in the ABAP dictionary (in the case of 'gender' up here, I created my own domain to which that data element belongs and
**that domain allows only three possible entries).
*
**To do some testing... <-- THIS DOESN'T WORK HERE! IT WORKS ONLY ABOVE INITIALIZATION! If I remove the Events, it works... but also works under START-OF-SELECTION!
**Which makes sense, given events are supposed to actually mark the blocks of code as doing specific tasks and they end only when the next one starts.
**START-OF-SELECTION.
**  SELECT * FROM zpokemon.
**    IF zpokemon-dob IN  my_dob.
**      WRITE: / zpokemon-dob.
**    ENDIF.
**  ENDSELECT.
*
*
*
**SELECT ADDITIONS----------------------------------------
**SELECT-OPTIONS can go with OBLIGATORY or LOWER CASE and so on.
**There is also a no extension addition. It allows me to prevent the use of multiple selections. Thus I can give a user the ability
**to make a value range selection, but stop them from entering multiple value ranges.
**It would look like:
**SELECT-OPTIONS: my_dob FOR zpokemon-dob NO-EXTENSION.
*
*
*
**TEXT ELEMENTS----------------------------------------
**Fields in the selection screen display their technical names unless I change that - 'Skok do' -> 'Elementy tekstowe' -> ...
**- The text elements responsible for the way fields' names are displayed are called Selection Texts.
**- If I try to copy a program copying of the Text Elements is obligatory, because when they are created they are an integral part of this program.
**- When Text Elements are created they belong to Text Pools - these pools hold all the text elements of my programs.
**- Every program I create is language independent which means Text Elements I create can be easily translated into other languages (??? Not sure how that works exactly ???).
**- There are three kinds of Text Elements that I can use: Selection Text, Text Symbols and List Headings.
**
**Text Symbols  -> give "flexibility" to a program allowing me to not have to code literals into the source code.
**List Headings -> when building reports, I also build report headers like the title, the fields' names the column headings etc. By using them instead of hardcoded headings,
**I can ensure they will be translated into any other required language. Also, if the headings need to change, I can just change the Text Elements instead of changing the source code.
*
**TEXT SYMBOLS ---
**E.g. when I want to WRITE: / "some message", I can use a Text Symbol instead and, by the grace of Lucifer - it will be automatically translated if need be.
**So in practice it could look like: WRTIE: / text-001. <- this is a pattern, it has too look like this, string 'text', a dash and a three digit number.
*
**WRITE: / text-001. " Susume?!
*
**MESSAGES----------------------------------------
**For providing feedback to the user in a way that is not a string literal. The concept of messages provides the facility to automatically translate such messages to other
**languages.
**First I need to store these messages in a message class which in turn is stored in database table t100. To create a message class -> se91.
**Messages are different from text elements in that they are NOT objects that are part of my program (unlike text elements). Messages are stored within t100. Due to that
**Text Messages can be resued in many programs.
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------






*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> INTERNAL TABLES
*---------------------------------------------------------------------------------------------------------------------------------
**There are two methods of dealing with internal tables. The old way is HEADER LINE and the new way is WORK AREA.
**Internal tables can be defined using any number of other defined structures. This allows me to have many normal table structures
**grouped together and placed into a single internal table (something akin to a multidimensional array).
**The basic form of an internal table consists of a table body (all the records within the table) and a header record OR a table
**body and a separate work area.
**A header line or a work area is used when I want to read a single record from my internal table. When I read a record from the
**old style table, that record is placed into the header record and for the new style it is read into a work area (which is separate).
**Similarly, when creating a new record, it is first placed in the header/work area and then transferred into the body of the internal
**table.
**The introduction of work area allowed us to create multi-dimensional tables - tables within tables.
**The architecture of SAP limits the size of internal tables to around 2GB.
*
**There are different kinds of internal tables:
**1. Standard tables: give me an option to access the records via a table key or an index. When I access records using a key, the larger
**                    table is, the longer it will take to read the records. This is why I can use an index.
**                    Standard tables do not give me the option of defining a unique key, so I might have identical lines repeated. A
**                    standard internal table can thus hold many identical records.
**                    Accessing records using a table key may take a long time, but a standard table can also be filled with record very
**                    quickly because the system doesn't have to check the table for any duplicate records.
**2. Sorted tables:   a unique key can be defined and a duplication of records can be avoided. Records can be accessed using the table key
**                    or the table index. A table key can also be used to find records. Much like with the standard tables, it's not the
**                    fastest way possible, but a lot better for the sorted ones nonetheless.
**                    The usage of a sorted table over a standard table is preferred due to the increased speed of accessing records and
**                    because sorted tables sort my records into a specific sequence which gives me a performance increase when accessing
**                    the data.
**3. Hashed tables:   records are not accessed via an index. Only a unique key is to be used. Hashed tables are usually preferred when
**                    it comes to speed. When I know my internal table is going to be huge, a hashed table might be my best bet.
**                    Hash tables use a hash algorithm which makes them fast.
*
**OCCURS 0 tells SAP we are declaring an internal table with no records initially (even if I use OCCURS 5, I can easily add more than just
**5 records. OCCURS is basically obsolete). Using OCCURS automatically tells the system this is an internal table with a header record.
*DATA: BEGIN OF itab01 OCCURS 0,
*        surname LIKE zpokemon-surname,
*        dob     LIKE zpokemon-dob,
*      END OF itab01.
*
**Below internal table should be used because it complies with ABAP objects!
**I am just defining a LINE of an internal table here. No OCCURS also kind of means it's not yet a table. It's but a line of a table.
*TYPES: BEGIN OF line01_typ,
*        surname LIKE zpokemon-surname,
*        dob     LIKE zpokemon-dob,
*  END OF line01_typ.
*
**Below I am defining the table type. This is going to be a standard table. So it can have multiple identical records so no unique key
**needs to be included in the table type definition. There's no OCCURS here, but I can use INITIAL SIZE if I chose to, but it's optional.
*TYPES itab02_typ TYPE STANDARD TABLE OF line01_typ.
**Below table is sorted and so it requires the information of what it's going to be sorted by. In this case - a surname.
*TYPES itab03_typ TYPE SORTED TABLE OF line01_typ WITH UNIQUE KEY surname.
*
**The above are just blueprints. Now I declare an actual table based on the table type. Technically, I could add WITH HEADER LINE at the
**end, but I should not as this would make the table unusable with ABAP objects.
*DATA itab02 TYPE itab02_typ.
**And I need a WORK AREA! It will be used in conjunction with the table I just defined. WA is not part of the internal table. I move
**data to my WA, I work with it and then I update my table from the WA. WA is a completely separate entity - if I have multiple
**tables of the same structure, I can use a single work area to read and write data to and from them.
*DATA wa_itab02 TYPE line01_typ.
*
**POPULATING AN INTERNAL TABLE WITH A HEADER LINE----------------------------------------
**When I read or write data to or from an internal table that has a header line, said data is always moved through the header line itself.
**When I read a record from the internal table, that record is moved to the header line and I access it there. When I want to add a record
**to the internal table, I move it to the header line which then gets appended to the internal table.
*TABLES: zpokemon.
**
*DATA: BEGIN OF very_tab OCCURS 0,
*  employee LIKE zpokemon-employee,
*  surname  LIKE zpokemon-surname,
*  forename LIKE zpokemon-forename,
*  title    LIKE zpokemon-title,
*  dob      LIKE zpokemon-dob,
*  los      TYPE i VALUE 3, "Length of service.
*END OF very_tab.
*
**FIRST METHOD ---> ARRAY FETCH----------------------------------------
*
**Below means the records from zpokemon will be moved to very_tab by matching them by their names.
**It is called an 'array fetch' -> it picks up records and puts them in my table all at once. It is different than performing a SELECT
**within a loop, because then it grabs every record one at a time. An 'array fetch' goes big and grabs them all at once. An 'array fetch'
**does not have an ENDSELECT statement.
**The extra field, 'los', will be added to every record and assigned the value of 3.
**Using an array fetch I am not populating my table line by line and I am taking away the loop generated by the SELECT and ENDSELECT
**statements. Only fields that correspond to those within the strucutre they are to move to are moved. This type of a SELECT statement is
**much faster than using a loop.
**Also no header record is being used here - I am using a block by block array fetch method to fill my table.
*SELECT * FROM zpokemon
*  INTO CORRESPONDING FIELDS OF TABLE very_tab.
*
**In the debugger -  a hat symbol represents the header line. When I F5 this good boy, all records will be placed inside in one fell swoop,
**because it's an array fetch!
*WRITE very_tab-surname.
*
**SECOND METHOD ---> APPEND----------------------------------------
*
**Append is another way of filling an internal table. Instead of doing an array fetch, this is a loop and I am grabbing every record one
**at a time. Essentially, the first record will be selected and then I am performing individual MOVE statements to move the data, field by
**field to the corresponding fields of very_tab. APPEND tells the system to take the values from the header record and add them to the body
**of the internal table.
**It is a good practice to clear the header record as soon as the data held within is appended to the body of the internal table. Otherwise
**SAP will have to keep overwriting the data previously held within every field of the header record.
**Every record, upon being appended to the table, will also be given a default value of 3 to 'los' field as per the definition of the table.
**WITHOUT THE APPEND IT WILL JUST KEEP OVERWRITING THE CONTENT OF THE HEADER LINE BECAUSE THE DATA IS NOT BEING PASSED FURTHER ON TO
**THE ACTUAL TABLE. In the debugger, if I F5 it, at the end of the loop (when all the fields are filled with MOVE statement), SAP will just
**start overwriting the data already present within the header record.
*SELECT * FROM zpokemon.
*  MOVE zpokemon-employee TO very_tab-employee.
*  MOVE zpokemon-surname  TO very_tab-surname.
*  MOVE zpokemon-forename TO very_tab-forename.
*  MOVE zpokemon-title    TO very_tab-title.
*  MOVE zpokemon-dob      TO very_tab-dob.
*  APPEND very_tab.
*ENDSELECT.
*
*WRITE very_tab-surname.
*
**THIRD METHOD ---> MOVE-CORRESPONDING----------------------------------------
*
**Similar to the above, but way shorter. I also need to specify the name of the table again within the operation itself. This method matches up the
**technical name of each field from the zpokemon with a matching field in very_tab - when such a match is found, contents are moved. With
**this method I need to make sure the fields are named alike in both tables. Fields moved to and from also need to be of the same data type
**and length.
**Just for the record - this is NOT an array fetch. It grabs record by record, not all at once.
*SELECT * FROM zpokemon.
*  MOVE-CORRESPONDING zpokemon TO very_tab.
*  APPEND very_tab.
*ENDSELECT.
*
*WRITE very_tab-surname.
*
**ANOTHER WAY OF CREATING AN INTERNAL TABLE ---> INCLUDE STRUCTURE.
**A statement that I can use to add various structures that I've already defined or have already been defined to build up my own internal table.
**Other data elements can also be added (e.g. count).
*DATA: BEGIN OF very_tab2 OCCURS 0.
*        INCLUDE STRUCTURE very_tab.
**       INCLUDE STRUCTURE zpokemon. "Field would be repeated because very_tab and zpokemon have similar ones, but that's just an example. It throws an error due to that repeat!
*        DATA count TYPE i.
*DATA END OF very_tab2.
*
*
*
*
***FILLING AN INTERNAL TABLE WITH A WORK AREA----------------------------------------
**The fundamental difference is that when selecting records from the table I am using a SEPARATE work area instead of the internal table's
**OWN header line.
*
**Declaring a line type... I think this is basically the equivalent of a database table. Like having tables TYPE STANDARD TABLE OF mara.
*TYPES: BEGIN OF line03_typ,
*  surname LIKE zpokemon-surname,
*  dob     LIKE zpokemon-dob,
*END OF line03_typ.
*
**Declaring a 'table type' based on the 'line type'. (I think that this could be omitted and I could go straight to declaring the table itself.)
*TYPES itab03_typ TYPE STANDARD TABLE OF line03_typ.
*
**Declaring the table itself based on the 'table type'. (I think I could just do a DATA itab03 TYPE STANDARD TABLE OF line03_typ. here.)
*DATA itab03    TYPE itab03_typ.
*DATA itab04    TYPE STANDARD TABLE OF line03_typ. "I think that's literally the same as above, but with fewer steps.
*DATA wa_itab03 TYPE line03_typ.
*
**I CAN EITHER FILL MY INTERNAL TABLE VIA MY WORK AREA...
**Works the same with both itab03 and itab04.
*SELECT surname dob FROM zpokemon
*  INTO wa_itab03.
*  APPEND wa_itab03 TO itab03.
*ENDSELECT.
*
**OR BY AN ARRAY FETCH...
***An array fetch is possible with Work Areas too!... And it skips the Work Area just like before, with Header Lines, it skipped the Header Line.
**SELECT * FROM zpokemon
**  INTO CORRESPONDING FIELDS OF TABLE itab03.
**
**Confirming if records are indeed inserted into the table. It was declared with the Work Area, so I am moving records from itab to wa.
*LOOP AT itab03 INTO wa_itab03.
*  WRITE wa_itab03-surname.
*ENDLOOP.
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------







*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> LOOPING THROUGH INTERNAL TABLES
*---------------------------------------------------------------------------------------------------------------------------------
*Reading through the records of an internal table line by line using a loop. Standard ABAP Dictionary Table's records are accessed
*via SELECT and ENDLSELECT statements (unless it's an array fetch!) while internal table's records are accessed via LOOP and ENDLOOP
*statements.

*STEPS FOR THE TABLE WITH THE HEADER LINE:
*Without declaring the Standard ABAP Dictionary Table here, it throws an error in the SELECT statement claiming that
*the 'destination area' needs to be inserted directly by INTO clause or indirectly by TABLES instruction.
*Which means that the Standard ABAP Dictionary Table from which I am extracting data is considered 'destination' here.
TABLES: zpokemon.

*1) This is my internal table.
DATA: BEGIN OF very_tab OCCURS 0,
  employee LIKE zpokemon-employee,
  surname  LIKE zpokemon-surname,
  forename LIKE zpokemon-forename,
  title    LIKE zpokemon-title,
  dob      LIKE zpokemon-dob,
  los      TYPE i VALUE 3, "Length of service.
END OF very_tab.

*2) This is how I access Standard ABAP Dictionary Table's records and put them within my internal table.
SELECT * FROM zpokemon.
  MOVE zpokemon-employee TO very_tab-employee.
  MOVE zpokemon-surname  TO very_tab-surname.
  MOVE zpokemon-forename TO very_tab-forename.
  MOVE zpokemon-title    TO very_tab-title.
  MOVE zpokemon-dob      TO very_tab-dob.
  APPEND very_tab.
ENDSELECT.

*3) Perform whatever I want to do with internal table's records within my loop. When I access records of an internal
*table with a header line, each record gets transferred one record at a time from the body of the internal table to the
*header line.
LOOP AT very_tab.
  WRITE: / very_tab-surname, very_tab-forename. "Underneath, the WRITE accessed the header line here.
ENDLOOP.



*MODIFY----------------------------------------
*If the IF statement is true, then MODIFY will take the content of the header line that has just been updated and update
*the record in the internal table that was originally read into the header record.
*Without the MODIFY, it will still WRITE the updated value, but, I believe, only the content of the header line is updated
*this way and the internal table itself still holds the original value.
*MODIFY, when used inside a loop of an internal table, has some specific features. It changes only the content of the existing
*line in the internal table that I've read and does not create a new record. It is always the current line that is changed when
*MODIFY is within a loop. It should not be used to modify the key fields that use a unique key.
*If MODIFY is used outside of a loop - I must specify a record's index number that I want to modify. It's not required within
*loops, because, while in a loop, the system monitors the index number automatically.
*MODIFY can be used like that only with index tables and tables with header lines.
LOOP AT very_tab.
  IF very_tab-surname = 'TOHANA'.
    very_tab-surname = 'Taehana'.
*    MODIFY very_tab.
  ENDIF.
  WRITE very_tab-surname.
ENDLOOP.



*DESCRIBE----------------------------------------
*Used to find out the content of the internal table - the number of records the table holds, the reserved memory space used and the
*type of a table (standard, sorted, hash). Usually used just to check how many records are there within the internal table.
*Below statement will return an integer value that represents the number of lines contained in my internal table. The value will be
*stored in line_cnt.
DATA line_cnt TYPE i.
DESCRIBE TABLE very_tab LINES line_cnt.



*INSERT----------------------------------------
*While the APPEND statement adds lines to the end of the table, INSERT allows me to insert a record into any position I choose inside
*my internal table by specifying the table's index number.
*Due to DESCRIBE putting the number of records into line_cnt variable and INSERT inserting a value at that index, the new value will be
*placed between the last record in the internal table and the one before it - shifting the previously last record forward index-wise.
INSERT very_tab INDEX line_cnt.



*READ----------------------------------------
*In order to access the records of an internal table, a READ statement can also be used. It allows me to specifically read individual
*records from the table. Because I am using a header line, when I use READ, the record will be read into that header line.
*When I use the READ statement, I need to be aware of how has my table been decalred - that will affect how I will be using my
*READ (whether it's a standard, a sorted or a hash table).
*The READ statement is the fastest way of accessing records of an internal table and using the index specifically is the fastest form
*of READ itself. I is about three times faster than using the hash algorithm and up to 14 times faster than using a normal table key.
*But, obviously, I do not always know the index number of the record that I want read - that's why usually table keys are used.

*STANDARD TABLE WITH A NON-UNIQUE STANDARD KEY.
READ TABLE very_tab INDEX 5. "I am reading the fifth record of my internal table into my header record.

*WITH A TABLE KEY.
*WITH KEY accepts unique table keys, but also other fields as well. But then it's difficult to know which record exactly
*I will be reading. If I specify a surname and I have three records sharing it, no clue which one will be taken... Actually,
*there is a clue, a certainty even - with a non-unique key, READ statement reads sequentially through the table and will take
*the first record it encounters.
*The READ statement can also be used for sorted and hash tables. When I specify the key fields to use in my search, the system
*will run the binary search for sorted tables and use a hash algorithm for hash tables. If the fields used are not key fields,
*the system will carry out a sequential search for both the sorted and hash tables.
READ TABLE very_tab WITH KEY employee = 10000007.



*DELETE----------------------------------------
*I can use it to delete individual records or groups of records from my internal table. The fastest way is by using the
*table index, just like with READ. This only applies to standard tables and sorted tables, not hash tables, because
*only these two have an index.
*I make no use of the header line here.
DELETE very_tab INDEX 5.

*DELETE can also be used within a loop.
LOOP AT very_tab.
  IF very_tab-surname = 'Tohana'.
    DELETE very_tab INDEX sy-index. "This variable gets updated automatically by the system, so always points at the index of the current record!
  ENDIF.
ENDLOOP.

*DELETE should not be used without the index addition. If outside a loop - I will get a run time error. If I am within a loop,
*I need to make sure the index addition is included in order to be compliant with the future releases of ABAP syntax.

*WHERE addition to DELETE statement.
*I can use it when I don't know the exact index of the record I want to delete. I should always try to be as specific as possible
*when trying to identify the records I want deleted.
*Below ALL records with the surname 'Tohana' will be deleted.
DELETE very_tab WHERE surname = 'Tohana'.



*SORT----------------------------------------
*Below (no additions) means that the data will be sorted in an ascending order based on the defined table key. This works for
*sorted tables and hash tables.
SORT very_tab.

*If I want to sort a standard internal table, then I need to use BY addition. Moreover, SAP caters to all sorts of languages
*and this needs to be taken into account if I am working for a company whose systems are used throughout the world. In order to
*make sure that the internal table is sorted according to language specific criteria, I use AS TEXT addition directly after the
*name of my internal table.
SORT very_tab AS TEXT BY surname.

*I am not limited to using just one field while using SORT. I can use up to 250 fields. Below, AS TEXT will be applied to all
*specified fields because of where the statement is placed.
SORT very_tab AS TEXT BY surname forename.

*If I want AS TEXT applied only to the forename.
SORT very_tab BY surname AS TEXT forename.

*The default way of sorting is the ascending one, but I can specify it.
SORT very_tab DESCENDING AS TEXT BY surname forename.



*FOR THE TABLE WITH THE WORK AREA:--------------------------------------------------------------------------------------------
*An example table for work area's usage.
TYPES: BEGIN OF line01_typ,
  surname LIKE zemployees-surname,
  dob     LIKE zemployees-dob,
  END OF line01_typ.
  
TYPES itab02_typ TYPE STANDARD TABLE OF line01_typ.
  
DATA itab02 TYPE itab02_typ.
  
DATA wa_itab02 TYPE line01_typ.
  
SELECT * FROM zpokemon
  INTO CORRESPONDING FIELDS OF TABLE itab02.



*LOOP----------------------------------------
*Looping through an internal table with work area.
LOOP AT itab02 INTO wa_itab02.
  WRITE wa_itab02-surname.
ENDLOOP.



*MODIFY----------------------------------------
LOOP AT itab02 INTO wa_itab02.
  IF wa_itab02-surname = 'Tohana'.
    wa_itab02-surname = 'Taehna'.
    MODIFY itab02 FROM wa_itab02.
  ENDIF.
ENDLOOP.



*INSERT----------------------------------------
*Check how many records I have in itab02 and hold that value in line_cnt.
DATA line_cnt TYPE i.
DESCRIBE TABLE itab02 LINES line_cnt.
INSERT wa_itab02 INTO itab02 INDEX line_cnt.



*READ----------------------------------------
*If I know the index of the record I want read...
READ TABLE itab02 INDEX 5 INTO wa_itab02.

*If I do not know the index of the record I want read, I need to use the WITH KEY addition.
*Like before (with the header record), tables without unique keys can have multiple records that match
*the criteria specified with the WITH KEY addition.
READ TABLE itab02 INTO wa_itab02 WITH KEY surname = 'Tohana'.



*DELETE----------------------------------------
*Just like with the internal tables with the header record, with work area ones, I do not need to actually use
*the work area, so the syntax is the same for both types of tables. 
DELETE itab02 WHERE surname = 'Tohana'.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> DELETING INTERNAL TABLES.
*---------------------------------------------------------------------------------------------------------------------------------

*Sometimes I will seek to delete all records of an internal table in one fell swoop. For example, if I were to fill in an internal
*table while I am inside a higher level loop, more often than not, I will need to make sure that the loop is empty at the start of
*the loop so that when the next iteration of the loop comes around, I am not left with any records from the previous iteration.

*HEADER LINE TABLES-----------------------
*There is a certain sequence of tasks I need to adhere to when deleting the contents of the internal table with a header line.
*I need to make sure I clear out the header line and then the body of the internal table.
TABLES: zpokemon.

DATA: BEGIN OF itab01 OCCURS 0,
  employee LIKE zpokemon-employee,
  surname  LIKE zpokemon-surname,
  forename LIKE zpokemon-forename,
  title    LIKE zpokemon-title,
  dob      LIKE zpokemon-dob,
  los      TYPE i VALUE 3,
END OF itab01.

SELECT * FROM zpokemon.
  MOVE zpokemon-employee TO itab01-employee.
  MOVE zpokemon-surname  TO itab01-surname.
  MOVE zpokemon-forename TO itab01-forename.
  MOVE zpokemon-title    TO itab01-title.
  MOVE zpokemon-dob      TO itab01-dob.
  APPEND itab01.
ENDSELECT.

*Clear out the header line. Below will clear out the header line ONLY!
*The header line will be wiped clear, which means all fields will be set to their initial value.
CLEAR itab01.

*To deal with the table body that contains all the records, I need to place square brackets at the end of
*the table's name. This will result in all the records from the body of the table to be deleted.
CLEAR itab01[].



*REFRESH----------------------------------------
*There is another way of clearing out the records of a table - by using a REFRESH statement.
*By using the below statement, I delete all records in the table, but my header record still contains values - it is
*unscathed as the REFRESH does not touch it.
*So below is the alternative to CLEAR itab01[], but CLEAR itab01 should still be used beforehand.
REFRESH itab01.



*FREE----------------------------------------
*The FREE statement -  not only does it empty the records out of my internal table, but also frees up the memory being
*used by my program. My internal table still exists, but ut's been emptied out of memory - which means that, if I want
*to fill my table with records again, I can do so. It's just when the program accesses that table again, it needs to
*reserve the memory space again.
*FREE itab01 does the same thing as CLEAR itab01[] and REFRESH itab01, but it has the added benefit of emptying out the
*memory used from my program. It does not affect the header line either, so CLEAR itab01 is still required.
FREE itab01.



*WORK AREA TABLES-----------------------
*Work areas are fundamentally different structures that I set up in my program. Thus, the code that I write that affects
*my internal table, it will never affect my work area at the same time and the reverse is true.

*CLEAR----------------------------------------
*It will clear all the table contents. No square brackets are needed!
CLEAR itab01. 

*My work area is separate and I need to clear that out as well.
CLEAR wa_itab01.



*REFRESH----------------------------------------
REFRESH itab01.
CLEAR wa_itab01.



*FREE----------------------------------------
FREE itab01.
CLEAR wa_itab01.
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> SUBROUTINES.
*---------------------------------------------------------------------------------------------------------------------------------

*WARNING! -> a PERFORM will not work correctly if declared beneath another PERFORM's FORM.

*EVENT BLOCKS are a modularization technique as well.

*INCLUDE----------------------------------------
*They are made available globally within a SAP system. Their sole purpose is to modularize code. They accept no parameters. An include
*file/program is a separate file in SAP system and can be included in any other program.
*A syntax check within my main program, it is also carried out automatically in my includes. They work in tandem.
*INCLUDE some_include.


*PROCEDURES----------------------------------------
*Processing blocks that are called from the main ABAP program. Procedures come in the form of SUBROUTINES or SUBPROGRAMS and
*FUNCTION MODULES.
*They are used mainly for local modularization of the code - to contain a small modular unit of code that is self-contained to be
*called from program in which they are defined (so basically methods).
*Such subroutines can be used to write functions that are used many times in the program. Any ABAP program can include subroutines.
*Function modules allow me to create modular blocks of code that are held separately from my ABAP program and can be called by any
*other program.
*So SUBROUTINES are local to the program in which they are defined abd FUNCTION MODULES are global.
*FUNCTION MODULES are used the most often.
*Procedures are different from INCLUDES as they have an interface for trasnferring data from the calling program to the procedure
*itself. Thus, I can pass parameters into procedures.
PERFORM test_subroutine.

*Variables can be used in the interface of my form. When I do that, I am telling the system I am going to transfer the data
*throughout the subroutine data interface - by using USING.
DATA: z_field1 LIKE zpokemon-surname,
      z_field2 LIKE zpokemon-forename.
z_field1 = 'Ayen'. "Making sure the passed fields have an actual value.
z_field2 = 'Tranok'.
PERFORM test_subroutine_two USING z_field1 z_field2.
WRITE / z_field1. "This will NOT be 'Ayen' - see the subroutine's interface.

DATA modu_tab TYPE STANDARD TABLE OF zpokemon.
PERFORM test_subroutine_three TABLES modu_tab.

*Below is my subroutine created automatically by the forward navigation. It is not considered a part of the actual report, the report
*itself is finishing upon the calling of the perform (because there's nothing else afterwards).
*&---------------------------------------------------------------------*
*&      Form  TEST_SUBROUTINE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM TEST_SUBROUTINE .

  DATA zpoke LIKE zpokemon-surname. "This is a local variable and can only be referenced from within the subroutine.

ENDFORM.                    " TEST_SUBROUTINE


*My form is declaring two fields that will be used in the interface of the form, but they have no data type. That is
*because they are copied from my main program.
*The global field (DATA in the main program) will be updated along with the local field that corresponds to it if it's
*updated itself within the subroutine. Any fields used by USING statement will be changed like that.
*&---------------------------------------------------------------------*
*&      Form  TEST_SUBROUTINE_TWO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_Z_FIELD1  text
*      -->P_Z_FIELD2  text
*----------------------------------------------------------------------*
FORM TEST_SUBROUTINE_TWO  USING    p_zsurname
                                   p_zforename.

WRITE / p_zsurname.
WRITE / p_zforename.

p_zsurname = 'Toka'. "This will change the value of the corresponding variable in the main program!

ENDFORM.                    " TEST_SUBROUTINE_TWO

*Internal tables as well as a combination of individual fields can also be passed into subroutines.
*The sequence of the passed fields and tables has to be the same as in the main program because it's
*the sequence of the fields when I create my perform statement that determines which field is passed to
*the interface variable of my form.
DATA modu_tab TYPE STANDARD TABLE OF zpokemon.
PERFORM test_subroutine_three TABLES modu_tab.

*USING is here replaced with TABLES. When the program is executed, the perform makes sure that contents
*of my internal table are transferred to the subroutine and stored within p_modu_tab.
*One the processing reaches the end of the form, the contents of the local internal table are then passed
*back to the global internal table. This is so for the tables without a header line. If I was using a table
*with a header line, my perform would only pass the header line into the subroutine.
*If I am using an internal table with a header line, I need to add square brackets to the table's name.

*When the internal table is passed into the subroutine, this local internal table is ALWAYS declared with a
*header line!
*I can declare a local Work Area and still loop at the local internal table into it in order to bypass the
*fact that the local internal table is with a header line.
*&---------------------------------------------------------------------*
*&      Form  TEST_SUBROUTINE_THREE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_MODU_TAB  text
*----------------------------------------------------------------------*
FORM TEST_SUBROUTINE_THREE  TABLES   p_modu_tab.
*Test structures for "bypassing" the header line.
*  DATA wa_tmp TYPE some_table.
*  LOOP AT p_modu_tab INTO wa_tmp.
*    WRITE wa_tmp-some_value.
*  ENDLOOP.
endform.                    " TEST_SUBROUTINE_THREE

*The combination of fields and tables can also be passed into subroutines at the same time.
PERFORM test_subroutine_four TABLES modu_tab USING z_field1 z_field2.

*&---------------------------------------------------------------------*
*&      Form  TEST_SUBROUTINE_FOUR
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_MODU_TAB  text
*      -->P_Z_FIELD1  text
*      -->P_Z_FIELD2  text
*----------------------------------------------------------------------*
FORM TEST_SUBROUTINE_FOUR  TABLES   p_modu_tab
                           using    p_z_field1
                                    p_z_field2.

ENDFORM.                    " TEST_SUBROUTINE_FOUR

*Subroutines were desgined for modularizing and structurizing programs, but they can be extended in such a way, that they can
*be called externally from other programs.
*If my goal is to make my function available throughout SAP system, I should rather use Function Modules though.
*There are two ways in which I can call a subroutine over an external program, but the first one is preferable, because it's
*required when using ABAP objects!

*FIRST WAY
PERFORM external_sub IN PROGRAM external_program USING z_field1 z_field2.

*SECOND WAY - UNAVAILABLE IN THE CONTEXT OF ABAP OBJECTS
*PERFORM external_sub (external_program) USING z_field1 z_field2. <--- the first bracker is red anyway.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*UDEMY'S PROGRAM -> FUNCTION MODULES.
*---------------------------------------------------------------------------------------------------------------------------------

*A Function Module is a specific procedure that are defined within function groups and can be called from any other ABAP program.
*A function group acts like a container for all the function modules that logically belong together.

*Attributes tab.
*Here I can see the function group my function module belongs to and its descriptions. The processing type section defines the
*actual type of function module, e.g. Remote-enabled module mean it can get triggered from an external system.
*Import tab.
*Lists the individual fields I will use as my data interface for data I pass into the function module. This is the information
*that my function module will be importing in order to process it. Fields can be set as optional. The pass by value means (if checked)
*that I will be passing the actual value into the function module.
*Export tab.
*Once the function module does its work, the fields defined in the export tab constitues what is being sent back to the calling program.
*Changing tab.
*Lists fields that would be changed by the function module. Import is what is being received, export what is being returned and changing
*what is being received, changed and sent back.
*Tables tab.
*Internal tables, as they also can be passed, are set up here.
*Exceptions tab.
*All function modules have the ability to pass back exception information to indicate whether the function module was executed successfully
*or not. Specific error messages can also be determined here.
*Source code.
*This is where ABAP is!

*Because function modules are created separate to normal programs, there are various tools to test out them without having to write the
*code to call them.
*If I have the function module open (or am in SE37), I can just press F8. The initial screen will look a little bit different for every
*function module, because it is dependant on import, changing and tables parameters.

*Coding example.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(15) text-003. "Start at the first position and have 15 characters' length.
PARAMETER my_num TYPE i.
SELECTION-SCREEN END OF LINE.

*When I call a function module, all its optional fields are automatically commented out. The finishing dot is placed in its own line
*because all other lines might be commented out to begin with and that last dot is, obviously, required.
*I am coding the actions of the module upon its execution myself in the IF section. Firstly, what's it supposed to do if there's an
*error and what to do ELSE, if everything went fine.

*I need to create a variable to hold the result. I will add it to IMPORTING part (in Function Module editor it's actually in export tab!
*It's a matter of perspective. I am calling this FM, so I am importing a result from it, but the FM is exporting it to me).
*I learn how to declare my result variables by checking FM editor, the export tab - there I can find what the FM is supposed to return.
*SPELL is a structure, so my WRITE statement cannot convert it just like that to text. I can check what's the result of the FM made of by testing
*the FM in its editor and I can check which field of SPELL I need to focus on by checking the structure of SPELL.
DATA result LIKE spell.
CALL FUNCTION 'SPELL_AMOUNT'
 EXPORTING
   AMOUNT          = my_num
*   CURRENCY        = ' '
*   FILLER          = ' '
*   LANGUAGE        = SY-LANGU
 IMPORTING
   IN_WORDS        = result
* EXCEPTIONS
*   NOT_FOUND       = 1
*   TOO_LARGE       = 2
*   OTHERS          = 3
          .
IF sy-subrc <> 0.
  WRITE: 'The function module returned a value of ', sy-subrc.
ELSE.
  WRITE: 'The amount in words is ', result-word.
ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*BASIC ARITHMETICS WITH SELECTION SCREEN FEATURES AND EVENTS.
*---------------------------------------------------------------------------------------------------------------------------------
*A variable to keep the result.
DATA: v_z TYPE i.

SELECTION-SCREEN BEGIN OF BLOCK bk1 WITH FRAME TITLE t1.
SELECTION-SCREEN BEGIN OF LINE.
*My label (lbl1) should start at the position of 8 and I want 20 spaces reserved for it.
  SELECTION-SCREEN COMMENT 8(20) lb1.
*In the same line... Obligatory is one of the possible Additions to the keywords.
  PARAMETERS p_x TYPE i DEFAULT 20 OBLIGATORY.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT 8(20) lb2.
  PARAMETERS p_y TYPE i DEFAULT 15 OBLIGATORY.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK bk1.

*All radiobuttons belong to the same group. Their names are specified at Goto -> Text Elements -> Selection Text. In a group of
*radiobuttons, by default - the first one will be checked to begin with.
*A radiobutton can contain either an 'X' or a space. If I want a specific radiobutton within a group to be the default one, I need
*to add "DEFAULT = 'X'" to it.
*I can enclose sections of the screen in my Selection Screen with Blocks. The title's name (t2) is specified within the Initialization
*section.
SELECTION-SCREEN BEGIN OF BLOCK bk2 WITH FRAME TITLE t2.
PARAMETERS: p_r1 RADIOBUTTON GROUP grp1,
            p_r2 RADIOBUTTON GROUP grp1,
            p_r3 RADIOBUTTON GROUP grp1,
            p_r4 RADIOBUTTON GROUP grp1,
            p_r5 RADIOBUTTON GROUP grp1 DEFAULT 'X'.
SELECTION-SCREEN END OF BLOCK bk2.

*Evenets can be handled at the end of the program. I think like that they'd work like methods. I am deciding what happens when away
*from the place where it actually happens. When the program is executed, SAP will check whether the Initialization has been handled.
*If it has - it will be processed first. The the AT-SELECTION-SCREEN event is triggered and only then the actual Selection Screen is
*displayed...
INITIALIZATION.
  lb1 = 'Enter the 1st number'.
  lb2 = 'Enter the 2nd number'.
  t1 = 'Numbers for the calculations'.
  t2 = 'Arithmetic operations'.

*START-OF-SELECTION is triggered by SAP after the program has been executed in the Selection Screen.
  START-OF-SELECTION.
*Checking which radiobutton has been checked.
  IF p_r1 = 'X'.
    v_z  = p_x + p_y.
    WRITE: / 'The sum is: ', v_z.
  ELSEIF p_r2 = 'X'.
    v_z  = p_x - p_y.
*If the result is below 0, SAP will display it as e.g. '3-'. If I want to display the minus sign in
*front of the result, I can do it as shown below.
*NO-GAP is added so there's no gap between the minus and the actual value. LEFT-JUSTIFIED is used so
*there's no huge gap between the result and the string literal as, by default, all numeric variables
*are right-justified.
      IF v_z >= 0.
        WRITE: / 'The difference is: ', v_z.
      ELSE.
        WRITE: / 'The difference is: -' NO-GAP, v_z NO-SIGN LEFT-JUSTIFIED.
      ENDIF.
  ELSEIF p_r3 = 'X'.
    v_z  = p_x * p_y.
*COLOR allows me to set a color for what's being displayed, each element separately.
    WRITE: / 'The product is: ' COLOR 1, v_z COLOR 5.
  ELSEIF p_r4 = 'X'.
    v_z  = p_x / p_y.
*Below allows me to colour the entire sections of what's being displayed.
    FORMAT COLOR 7.
    WRITE: / 'The division is: ', v_z.
    FORMAT COLOR OFF.
  ELSE.
*WRITE statement makes the result be displayed on the List Processing Screen. I can use MESSAGE instead
*for the NONE option and have it function as a pop-up instead. There are various TYPEs of MESSAGEs I can
*display - 'I' is a pop-up, 'S' is a status bar
    MESSAGE 'No radiobutton has been checked.' TYPE 'I'.
  ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*BASIC ARITHMETICS WITH AT SELECTION SCREEN FUNCTION CALLS ON RADIOBUTTONS.
*---------------------------------------------------------------------------------------------------------------------------------

*A variable to keep the result of the calculations.
DATA: v_z TYPE i.
*Variables for the MESSAGE output.
DATA: v_str1 TYPE string,
      v_str2 TYPE string,
      v_msg  TYPE string.
*A variable to hold the length of the result string in case the result is negative and the trailing '-' needs removal.
DATA: v_len  TYPE i.

SELECTION-SCREEN BEGIN OF BLOCK bk1 WITH FRAME TITLE t1.
SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT 8(20) lb1.
  PARAMETERS p_x TYPE i DEFAULT 20 OBLIGATORY.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT 8(20) lb2.
  PARAMETERS p_y TYPE i DEFAULT 15 OBLIGATORY.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK bk1.
SELECTION-SCREEN BEGIN OF BLOCK bk2 WITH FRAME TITLE t2.
*In runtime, If I want elements to be interactive - they need to have their unique identity (a name) and have a function call assigned to them.
*When a user clicks a push-button, SAP will trigger the AT-SELECTION-SCREEN event. In order to identify which button has been pushed, a system
*variable can be used.
*sy-ucomm <--- is a variable that contains the function call of a button which the user interacted with. It's always in the upper case.
*The function call can be assigned to the Radiobutton Group by using USER-COMMAND next to the first member of the group. If I tried to specify
*a different USER-COMMAND for another radiobutton within the same group, I would receive an error.
PARAMETERS: p_r1 RADIOBUTTON GROUP grp1 USER-COMMAND fc1,
            p_r2 RADIOBUTTON GROUP grp1,
            p_r3 RADIOBUTTON GROUP grp1,
            p_r4 RADIOBUTTON GROUP grp1,
            p_r5 RADIOBUTTON GROUP grp1 DEFAULT 'X'.
SELECTION-SCREEN END OF BLOCK bk2.

INITIALIZATION.
  lb1 = 'Enter the 1st number'.
  lb2 = 'Enter the 2nd number'.
  t1  = 'Numbers for the calculations'.
  t2  = 'Arithmetic operations'.

*Below is a definition of the event to manage the function call assigned to 'grp1' radiobutton group.
AT SELECTION-SCREEN ON RADIOBUTTON GROUP grp1.
*A system variable that holds the name of the function call being called. The function calls' names are always captured in an upper case.
*In this case, I do not want the results displayed in the List Processing Screen and that's where WRITE statement will take me. Thus, I
*am using a MESSAGE statement instead.
*MESSAGE needs to contain both the message and the value. MESSAGE accepts only strings, so my integer value needs to be converted into
*a string. Becuse I am reusing the same variables, it is prudent to CLEAR them before assigning any new value.
  CASE sy-ucomm.
    WHEN 'FC1'.
      IF p_r1 = 'X'.
        v_z  = p_x + p_y.
        v_str1 = 'The sum of the numbers is '.
      ELSEIF p_r2 = 'X'.
        v_z  = p_x - p_y.
         IF v_z >= 0.
           v_str1 = 'The difference of the numbers is '.
         ELSE.
           v_str1 = 'The difference of the numbers is -'.
         ENDIF.
      ELSEIF p_r3 = 'X'.
        v_z  = p_x * p_y.
        v_str1 = 'The product of the numbers is '.
      ELSEIF p_r4 = 'X'.
        v_z  = p_x / p_y.
        v_str1 = 'The divisiob of the numbers is '.
      ELSE.
        v_str1 = 'No radiobutton has been selected!'.
      ENDIF.
        v_str2 = v_z.
*Below logic exists to remove the trailing '-' that is concatenated by SAP by deault to negative numbers.
        IF v_z < 0.
          v_len = strlen( v_str2 ) - 1.
          v_str2 = v_str2+0(v_len).
        ENDIF.
        CONCATENATE v_str1 v_str2 INTO v_msg SEPARATED BY space.
        MESSAGE v_msg TYPE 'I'.
        CLEAR v_z.
  ENDCASE.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*BASIC ARITHMETICS WITH CHECKBOXES.
*---------------------------------------------------------------------------------------------------------------------------------

*The difference between radiobuttons and checkboxes is that a user can select any number of checkboxes.
PARAMETERS: p_x TYPE i DEFAULT 10 OBLIGATORY,
            p_y TYPE i DEFAULT 20 OBLIGATORY.

DATA v_z TYPE i.

*In case of the checkboxes, there is no concept of a group (like radiobutton group).
PARAMETERS: p_c1 AS CHECKBOX DEFAULT 'X',
            p_c2 AS CHECKBOX,
            p_c3 AS CHECKBOX DEFAULT 'X',
            p_c4 AS CHECKBOX.

*When the program is executed, START-OF-SELECTION is triggered.
*In the case of radiobuttons, I was using ELSEIF because only one radiobutton can be checked at a time. With
*checkboxes - any number can be checked at the same time, so "else" would not do. Every checkbox needs to be
*validated separately.
START-OF-SELECTION.
  IF p_c1 = 'X'.
      v_z = p_x + p_y.
      WRITE: / 'The sum is ', v_z.
  ENDIF.
  IF p_c2 = 'X'.
      v_z = p_x - p_y.
      WRITE: / 'The difference is ', v_z.
  ENDIF.
  IF p_c3 = 'X'.
      v_z = p_x * p_y.
      WRITE: / 'The product is ', v_z.
  ENDIF.
  IF p_c4 = 'X'.
      v_z = p_x / p_y.
      WRITE: / 'The division is ', v_z.
  ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*BASIC ARITHMETICS WITH AT SELECTION SCREEN FUNCTION CALLS ON CHECKBOXES.
*---------------------------------------------------------------------------------------------------------------------------------

*Checkboxes do not belong to any group, so each checkbox needs to have its own function call assigned to it unlike radiobuttons
*that shared a function call, if within a radiobutton group.
PARAMETERS: p_x TYPE i DEFAULT 10 OBLIGATORY,
            p_y TYPE i DEFAULT 20 OBLIGATORY.

DATA: v_z    TYPE i,
      v_str1 TYPE string, "To convert the integer result into a string.
      v_str2 TYPE string, "To display the proper message based on the type of arithmetic operation.
      v_msg  TYPE string.

PARAMETERS: p_c1 AS CHECKBOX USER-COMMAND fc1,
            p_c2 AS CHECKBOX USER-COMMAND fc2,
            p_c3 AS CHECKBOX USER-COMMAND fc3,
            p_c4 AS CHECKBOX USER-COMMAND fc4.

AT SELECTION-SCREEN.
  CASE sy-ucomm.
    WHEN 'FC1'.

      IF p_c1 = 'X'.
        v_z = p_x + p_y.
        v_str1 = v_z.
        v_str2 = 'The addition checkbox selected. The result is'.
        CONCATENATE v_str2 v_str1 INTO v_msg SEPARATED BY space.
        MESSAGE v_msg TYPE 'I'.
      ELSE.
        MESSAGE 'The addition checkbox deselected.' TYPE 'I'.
      ENDIF.
    WHEN 'FC2'.
      IF p_c2 = 'X'.
        v_z = p_x - p_y.
        v_str1 = v_z.
        v_str2 = 'The substraction checkbox selected. The result is'.
        CONCATENATE v_str2 v_str1 INTO v_msg SEPARATED BY space.
        MESSAGE v_msg TYPE 'I'.
      ELSE.
        MESSAGE 'The substraction checkbox deselected.' TYPE 'I'.
      ENDIF.
    WHEN 'FC3'.
      IF p_c3 = 'X'.
        v_z = p_x * p_y.
        v_str1 = v_z.
        v_str2 = 'The multiplication checkbox selected. The result is'.
        CONCATENATE v_str2 v_str1 INTO v_msg SEPARATED BY space.
        MESSAGE v_msg TYPE 'I'.
      ELSE.
        MESSAGE 'The multiplication checkbox deselected.' TYPE 'I'.
      ENDIF.
    WHEN 'FC4'.
      IF p_c4 = 'X'.
        v_z = p_x / p_y.
        v_str1 = v_z.
        v_str2 = 'The division checkbox selected. The result is'.
        CONCATENATE v_str2 v_str1 INTO v_msg SEPARATED BY space.
        MESSAGE v_msg TYPE 'I'.
      ELSE.
        MESSAGE 'The division checkbox deselected.' TYPE 'I'.
      ENDIF.

  ENDCASE.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*BASIC ARITHMETICS WITH AT SELECTION SCREEN FUNCTION CALLS ON PUSHBUTTONS.
*---------------------------------------------------------------------------------------------------------------------------------

PARAMETERS: p_x TYPE i DEFAULT 20 OBLIGATORY,
            p_y TYPE i DEFAULT 10 OBLIGATORY,
            p_z TYPE i.

*SELECTION-SCREEN SKIP <number_of_lines> or the slash after the 'PUSHBUTTON' is necessary, because, without one of them, I am getting an activation
*error due to elements of my Selection Screen overlapping. That is because SAP tries to place the pushbutton in the place already
*occupied by 'p_z' variable. By adding the slash/skip I am requesting that the pushbutton is placed in the new line.
SELECTION-SCREEN SKIP 2.
SELECTION-SCREEN PUSHBUTTON 6(12) b1 USER-COMMAND fc1.
SELECTION-SCREEN PUSHBUTTON 20(12) b2 USER-COMMAND fc2.
SELECTION-SCREEN SKIP 2.
SELECTION-SCREEN PUSHBUTTON 13(12) b3 USER-COMMAND fc3.

INITIALIZATION.
b1 = 'Addition'.
b2 = 'Clear'.
b3 = 'Exit'.

*When any of the pushbuttons is clicked, AT-SELECTION-SCREEN event is triggered, just like with checkboxes and radiobuttons. Again as well - the
*function call is captured by the system field, sy-ucomm.
AT SELECTION-SCREEN.
  CASE sy-ucomm.
    WHEN 'FC1'.
      p_z = p_x + p_y.
    WHEN 'FC2'.
      CLEAR: p_x,
             p_y,
             p_z.
    WHEN 'FC3'.
*A graceful exit! It will not work if the parameter fields are cleared, because they are mandatory and the program cannot proceed with to the next
*step - in this case, an exit, without obligatory parameters provided at this step.
      LEAVE PROGRAM.
  ENDCASE.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*LOOPING STATEMENTS.
*---------------------------------------------------------------------------------------------------------------------------------

PARAMETERS p_x TYPE i OBLIGATORY.

DATA: v_y   TYPE i VALUE 1,
      v_res TYPE i.

WRITE: / 'A regular loop.'.
WHILE v_y <= 10.
*Skipping the calculations if the variable is 5 because reasons.
  IF v_y NE 5.
    v_res = p_x * v_y.
  WRITE: / p_x, ' * ', v_y,' = ', v_res.
  ENDIF.
*Still need to increment though. I just don't want the results for v_y of 5 displayed.
  v_y = v_y + 1.
ENDWHILE.

*Utilising CONTINUE keyword.
*Below code will not work properly, because whenever the CONTINUE statement is executed inside a loop, the statements after the CONTINUE
*will be bypassed and the control jumps to the next condition check. Thus everything after ENDIF is ignored and control is passed to
*'WHILE v_y <= 10' again. Thus, v_y is never incremented and the WHILE loop can never end.
*ULINE.
*v_y = 1.
*WHILE v_y <= 10.
*  IF v_y EQ 5.
*    CONTINUE.
*  ENDIF.
*  v_res = p_x * v_y.
*  WRITE: / p_x, ' * ', v_y,' = ', v_res.
*  v_y = v_y + 1.
*ENDWHILE.

*Below will work properly, because, if v_y is equal to 5, then, first thing, the variable will increment anyway and only then the
*CONTINUE will jump back to the condition check, bypassing the logic for newly acquired value of 5 by the variable v_y.
ULINE.
v_y = 1.
WRITE: / 'A loop with CONTINUE.'.
WHILE v_y <= 10.
  IF v_y EQ 5.
    v_y = v_y + 1.
    CONTINUE.
  ENDIF.
  v_res = p_x * v_y.
  WRITE: / p_x, ' * ', v_y,' = ', v_res.
  v_y = v_y + 1.
ENDWHILE.

*EXIT statement will make the control come out of the current loop.
ULINE.
v_y = 1.
WRITE: / 'A loop with EXIT.'.
WHILE v_y <= 10.
  IF v_y EQ 5.
    v_y = v_y + 1.
    EXIT.
  ENDIF.
  v_res = p_x * v_y.
  WRITE: / p_x, ' * ', v_y,' = ', v_res.
  v_y = v_y + 1.
ENDWHILE.

*A DO loop.
ULINE.
v_y = 1.
WRITE: / 'A DO loop'.
DO 10 TIMES.
  v_res = p_x * v_y.
  WRITE: / p_x, ' * ', v_y,' = ', v_res.
  v_y = v_y + 1.
ENDDO.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*SUBMIT.
*---------------------------------------------------------------------------------------------------------------------------------

*SUBMIT is a keyword used for calling one program from another program.
*In the below case -  the SUBMIT left just at 'SUBMIT ZBM_TEST3', I would just receive the List Processing Screen of the called
*program as my only result (assuming the called program only prints a WRITE) - I will not have either of the below two WRITEs.
*When SUBMIT is reached, the control is shifted to ZBM_TEST3 which generates output into its own List Processing Screen. Once
*the execution in the called program is finished, the control remains there and will not be returned to the calling program.
*Each program has its own output screen, the outputs of two programs cannot be merged - every program has its own LPS.
*The 'Start of the program...' WRITE statement below has also been executed internally, in the background, but it cannot be
*seen, because only the latest output generated will be displayed (in this case - of the called program).
*WRITE: / 'Start of the program...'.
*SUBMIT ZBM_TEST3.
*WRITE: / 'End of the program...'.

*To make the program work the way it should, I need to add 'AND RETURN'.
*In the below case - the program will generate the first statement (in the background so far), the control shall be shifted to
*the called program, its LPS shall be displayed and (upon hitting F3), the LPS of the calling program will be shown.
WRITE: / 'Start of the program...'.
SUBMIT ZBM_TEST3 AND RETURN.
WRITE: / 'End of the program...'.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*SUBMIT - CALCULATIONS PERFORMED BY TWO PROGRAMS.
*---------------------------------------------------------------------------------------------------------------------------------

*The concept is to have one program accept the input from the user and display the result while the second program performs all
*the calculations. So the first program does only I/O operations (read the input, generate the output) and the second the business
*logic.
*Below variables should be possible to be used in the second program. By default, variables decalred in a program are local and
*only during that program's execution can they be used...
PARAMETERS: p_var1 TYPE i DEFAULT 10 OBLIGATORY,
            p_var2 TYPE i DEFAULT 20 OBLIGATORY.

*...Below is a remedy to that.
*Whenever a program is executed, 'ABAP Memory' is available for that program for the length of the program's execution. EXPORT
*pushes my variables into ABAP Memory as 'A1' and 'A2'.
EXPORT p_var1 TO MEMORY ID 'A1'.
EXPORT p_var2 TO MEMORY ID 'A2'.

*Now, that the variables were pushed into memory, I need to shift control to the program that will process them.
SUBMIT ZBM_SUBMIT_TEST AND RETURN.

*Now I declare the variable of the same name as the one that stores the result in the called program (even though it's good
*practice to have all variables declared in the same place).
DATA: v_result TYPE i.

*Import the actual value from the ABAP Memory, where it's been pushed by the called program.
IMPORT v_result FROM MEMORY ID 'A3'.

WRITE: / 'The sum of the numbers is ', v_result.

********************************************
*BELOW IS WHAT THE CALLED PROGRAM LOOKS LIKE.
********************************************

*REPORT  ZBM_SUBMIT_TEST.
*
**I need to delcare the variables first and they need to have the same names as those that have been
**pushed to ABAP Memory from the calling program.
*DATA: p_var1   TYPE i,
*      p_var2   TYPE i,
*      v_result TYPE i.
*
**Now, they need to be imported much like the calling program has EXPORTed them.
*IMPORT p_var1 FROM MEMORY ID 'A1'.
*IMPORT p_var2 FROM MEMORY ID 'A2'.
*
**Calculations are performed.
*v_result = p_var1 + p_var2.
*
**Now, the result needs to be returned to the calling program. Hence, the result is EXPORTed to ABAP
**Memory.
*EXPORT v_result TO MEMORY ID 'A3'.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*STRUCTURES.
*---------------------------------------------------------------------------------------------------------------------------------

*A structure is a user-defined data type which is a collection of different types of fields. Structures should be used when I want
*to store interrelated data one after the other.
*While in C language, the creation of the structure allocates no memory and the allocation takes place only when a variable of the
*structure is created, in ABAP the below already means the allocation.
*The amount of memory allocated depends on the structures' variables. All the fields of a structure are stored one after the other.
*empno will be initialized to 0 (default for numeric data types), ename and empdesign will be intialized to a space (character data
*types' default value is a space).
*If the starting address location for empno is 100, then it stretches to 104 because an integer in ABAP takes up 4 bytes. ename will
*take 15 bytes (119) and empdesign will take 20 bytes (139). All fields are one after the other if they are a part of the structure
*and the access is thus faster. If the fields were declared outside of the structure, there is no guarantee if they're going to be
*stored next to one another.

*SYNTAX 1 FOR DECLARING STRUCTURES.
DATA: BEGIN OF emp,
        empno         TYPE i,
        ename(15)     TYPE c,
        empdesign(20) TYPE c,
      END OF emp.

WRITE:/ 'EMP default values: '.
WRITE:/ emp-empno, emp-ename, emp-empdesign.

*In ABAP, the fields can now be accessed directly.
emp-empno     = 3.
emp-ename     = 'Tier'.
emp-empdesign = 'Vastolorde'.

*At any point in time, every structure's variable can contain only a single value. So a structure can contain only a single record at
*a time. So, in the below case, values of emp will be now updated.
WRITE:/ 'EMP values: '.
WRITE:/ emp-empno, emp-ename, emp-empdesign.
ULINE.

*SYNTAX 2 FOR DECLARING STRUCTURES.
*If I want to declare a structure based on existing structure, I can use LIKE. All the fields - their structure, of emp will be assigned
*to emp2, but not their values.
*There are three different ways to copy the data from one structure to another - an assignment operator, MOVE statement and MOVE-CORRESPONDING.
DATA emp2 LIKE emp.

*Fields will have default values.
WRITE:/ 'EMP2 default values: '.
WRITE:/ emp2-empno, emp2-ename, emp2-empdesign.
ULINE.

*Below assignment operator will copy the values from emp's to emp2's fields. It is possible for data exchange between similar structures
*(the same number of fields, the names of the fields, their data types).
emp2 = emp.
WRITE:/ 'EMP2 values after "=" from EMP: '.
WRITE:/ emp2-empno, emp2-ename, emp2-empdesign.
ULINE.

*Reverts all the fields' values to their default state.
CLEAR emp2.

*Another way of copying data from one structure to another.
MOVE emp TO emp2.
WRITE:/ 'EMP2 values after "MOVE... TO..." from EMP: '.
WRITE:/ emp2-empno, emp2-ename, emp2-empdesign.
ULINE.

CLEAR emp2.

*Yet another way of copying data from one structure to another.
MOVE-CORRESPONDING emp TO emp2.
WRITE:/ 'EMP2 values after "MOVE-CORRESPONDING... TO..." from EMP: '.
WRITE:/ emp2-empno, emp2-ename, emp2-empdesign.
ULINE.

*Another structure to present the differences between MOVE and MOVE-CORRESPONDING.
DATA: BEGIN OF dept,
        deptno TYPE i,
        dname(10) TYPE c,
      END OF dept.

WRITE:/ 'DEPT default structure:'.
WRITE:/ dept-deptno, dept-dname.
ULINE.

*The assignment operator will make some of the fields copied despite names being different. The assignment operator
*does not check if the number of fields of two structures match nor if the fields' names do. It only checks if the
*corresponding data types are the same.
*If the corresponding data types are the same, I can use the assignment operator.
dept = emp.
WRITE:/ 'DEPT values after "=" from EMP: '.
WRITE:/ dept-deptno, dept-dname.
ULINE.

CLEAR dept.

*MOVE works just like "=". I can use it when the corresponding data types are the same.
MOVE emp TO dept.
WRITE:/ 'DEPT values after "MOVE... TO..." from EMP: '.
WRITE:/ dept-deptno, dept-dname.
ULINE.

CLEAR dept.

*MOVE-CORRESPONDING will not copy the data because it tries to copy the data based on matching names of fields irrespective
*of the sequence.
MOVE-CORRESPONDING emp TO dept.
WRITE:/ 'DEPT values after "MOVE-CORRESPONDING... TO..." from EMP: '.
WRITE:/ dept-deptno, dept-dname.
ULINE.

*Another structure to present how various ways of copying data behave when fields of the two structures are different.
DATA: BEGIN OF dept2,
        loc(15) TYPE c,
        empno   TYPE i,
        deptno  TYPE i,
      END OF dept2.

*The corresponding data types do not match here, because dept2's a character and emp's an integer. It throws a syntax error.
*dept2 = emp.
*The same goes for MOVE...TO... as it works in the same way as the assignment operator and checks the corresponding data types.
*MOVE emp TO dept2.

*MOVE-CORRESPONDING doesn't care about the corresponding data types or the number of fields or the sequence of fields. It checks
*if there are any fields' names that match.
*In the below example, dept2-empno will have the copied value because it's the only field that has a match in emp.
MOVE-CORRESPONDING emp TO dept2.
WRITE:/ 'DEPT2 values after "MOVE-CORRESPONDING... TO..." from EMP: '.
WRITE:/ dept2-loc, dept2-empno, dept2-deptno.
ULINE.

*Using MOVE-CORRESPONDING frequently is discouraged as it degrades the performance. In order to perform its task - finding matching
*names, it needs to take every single field separately and compare it all all fields in the second structure. It is a time consuming
*process.
*MOVE-CORRESPONDING can also lead to a runtime error. If there are fields' names matching but their data types do not, MOVE-CORRESPONDING
*will attempt to move the value, because it only checks the names.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*NESTED STRUCTURES.
*---------------------------------------------------------------------------------------------------------------------------------

*NESTED STRUCTURES are structures within structures.
DATA: BEGIN OF emp,
        empno        TYPE i,
        ename(20)    TYPE c,
          BEGIN OF dept,
            deptno     TYPE i,
            dname(20) TYPE c,
          END OF dept,
        empdesig(20) TYPE c,
      END OF emp.

*I can access the fields of the outerstructure.
emp-empno  = 1.
emp-ename  = 'Dazikiri'.
*But trying to access a field of the inner structure will cause an error.
*emp-deptno = 10.
*In order to access a field of an inner structure...
emp-dept-deptno = 10.
emp-dept-dname  = 'IT'.
emp-empdesig    = 'Developer'.

WRITE:/'Employee no     : ', emp-empno,
      /'Employee name   : ', emp-ename,
      /'Department no   : ', emp-dept-deptno,
      /'Department name : ', emp-dept-dname,
      /'Designation     : ', emp-empdesig.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*INCLUDING STRUCTURES.
*---------------------------------------------------------------------------------------------------------------------------------

DATA: BEGIN OF dept,
        deptno     TYPE i,
        dname(20)  TYPE c,
      END OF dept.

*If I want emp to have the same fields as dept, I can just declare them yet again or I can use INCLUDING STRUCTURE.
*INCLUDING STRUCTURE is a new statement, which means that before I can declare it, I need to close the previous statement. So the
*field above it needs to be followed by a dot. Then, if I want more fields to be declared within emp, I need to start them with
*the DATA keyword again. END OF emp comes last still.
*In the below case I am including a local structure (present in the same program). Whenever I use the statement INCLUDING STRUCTURE,
*SAP will check if the structure is available in the local program. If it is not - it will check if it's available in the database.
*If it's there - it's included. If it's not in a database, an error will be thrown.
*Thus, by using INCLUDE STRUCTURE, both local and global structures can be included.
DATA: BEGIN OF emp,
        empno        TYPE i,
        ename(20)    TYPE c.
        INCLUDE STRUCTURE dept.
DATA:   empdesig(25) TYPE c,
      END OF emp.

*Fields of the included structure can now be accessed as if they were regular fields of the structure in which their actual structure
*is included.
emp-dname    = 'IT'.
emp-deptno   = '3'.
emp-empno    = '2'.
emp-ename    = 'Halasibel'.
emp-empdesig = 'Developer'.
WRITE:/ emp-empno,
      / emp-ename,
      / emp-deptno,
      / emp-dname,
      / emp-empdesig.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*TYPES STRUCTURES.
*---------------------------------------------------------------------------------------------------------------------------------

*This is a recommended way of declaring a structure. If I used DATA keyword, the memory would be allocated and all the structure's
*fields would be stored one after another.
*The TYPES keyword does not allocate any memory. It just creates a user-defined data type. Just like integers, strings, characters,
*etc are standard data types, so TYPES create my own (user-defined) data types.
*The TYPES keyword only provides the template, a blueprint.
TYPES: BEGIN OF t_emp,
        empno        TYPE i,
        ename(20)    TYPE c,
        empdesig(15) TYPE c,
       END OF t_emp.

*Since no memory is allocated for the TYPES alone, it's not possible to assign any values to the fields so far.
* t_emp-emname = 'Ere_we_go'.

*In order to utilize the structure declared as TYPES, I need to create a variable based on it - an instance of the template.
*Generally, a structure is a work area - which name starts either with 'wa_' or 'ls_' (local structure) or 'gs_' (global structure).
*In the below case, the memory is allocated because of the usage of the keyword DATA. The amount of data allocated depends on the
*fields declared in the TYPES declaration.
DATA: wa_emp1 TYPE t_emp.
wa_emp1-empno    = 3.
wa_emp1-ename    = 'Tahaka'.
wa_emp1-empdesig = 'Developer'.

WRITE:/ 'WA_EMP1 structure: ',
      / wa_emp1-empno,
      / wa_emp1-ename,
      / wa_emp1-empdesig.
ULINE.

*I can declare any number of structures based on the same TYPES.
DATA: wa_emp2 TYPE t_emp.
wa_emp2-empno    = 4.
wa_emp2-ename    = 'Oozua'.
wa_emp2-empdesig = 'Tester'.

WRITE:/ 'WA_EMP2 structure: ',
      / wa_emp2-empno,
      / wa_emp2-ename,
      / wa_emp2-empdesig.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*FIELD SYMBOLS.
*---------------------------------------------------------------------------------------------------------------------------------

*A FIELD-SYMBOL is a special data structure/variable that is capable of storing any kind of data. Without any initialization, it will
*have no value at all (not a 0, not a space).
DATA v_x TYPE i VALUE 10.
FIELD-SYMBOLS <abc>.

*<abc> will have no value.
WRITE:/ 'Variables upon their initialization:'.
WRITE:/ 'v_x is: ', v_x,
      / '<abc> is: ', <abc>.
ULINE.

*If I try to assign a value to a field-symbol like below, I will get an assignment error.
*<abc> = v_x.

*In order to properly assign a value to a field-symbol, I need to use the ASSIGN keyword. Once a variable is assigned to a field-symbol, that
*variable is known as a reference variable.
ASSIGN v_x TO <abc>.
*<abc> will have the same value as v_x..
WRITE:/ 'Variables upon the assignment of v_x to <abc>:'.
WRITE:/ 'v_x is: ', v_x,
      / '<abc> is: ', <abc>.
ULINE.

*Once the assignment has been performed, a link will be established between the reference variable and the field-symbol variable. Any change
*made to the data of one of the variables will automatically be also applied to the other one.
*Below only v_x is being changed, but <abc> will also have its value updated.
v_x = 3.
WRITE:/ 'Variables upon modifying the value of v_x alone:'.
WRITE:/ 'v_x is: ', v_x,
      / '<abc> is: ', <abc>.
ULINE.

*Likewise, a change made to the field-symbol will affect the reference variable.
<abc> = 7.
WRITE:/ 'Variables upon modifying the value of <abc> alone:'.
WRITE:/ 'v_x is: ', v_x,
      / '<abc> is: ', <abc>.
ULINE.

*I can assign any kind of a variable to a field-symbol. Previously, it held an integer value of v_x, but now I am assigning a string value of
*v_y to it. Upon doing that, the link between <abc> and v_x is broken and a new link, between <abc> and v_y is established.
DATA: v_y TYPE string VALUE 'Cubone is the best pokemon!'.
ASSIGN v_y TO <abc>.
WRITE:/ 'Variables upon assigning the value of v_y to <abc>:'.
WRITE:/ 'v_x is ', v_x,
      / 'v_y is: ', v_y,
      / '<abc> is: ', <abc>.
ULINE.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*TABBED BLOCKS AND SUBSCREENS.
*---------------------------------------------------------------------------------------------------------------------------------

*SELECTION-SCREEN TABBED BLOCK is a collection of tab buttons. They allow my screen to be divided into many subscreens (sheets that
*can be switched between). Tabbed Blocks are to be used when I don't want to place all the elements in a single screen and want them
*logically separated.
*LINES keyword refers to the number of lines in every subscreen. In this case, every subscreen will be of the height of 5 lines.
*Whenever I load a screen which contains a tabbed block, I need to make one of the tabs the active one.
*If left like below, that's a tabbed block without any tab buttons and so it's not clear which tab has to be activated by default,
*which subscreen should be associated with the particular tab and in which program the particular subscreen is available. That's
*why a runetime error will occur.
*----------
*SELECTION-SCREEN BEGIN OF TABBED BLOCK tb1 FOR 5 LINES.
*SELECTION-SCREEN END OF BLOCK tb1.
*----------
*Whenever I try to load a screen containing a tabbed block, one of the tabs should be made active, it should be associated with a
*subscreen and that subscreen needs to be designed either in the same program or in an external one.
*A tab button is similar to a pushbutton, but is always a part of a tabbed block while a pushbutton is there on the screen.
SELECTION-SCREEN BEGIN OF TABBED BLOCK tb1 FOR 5 LINES.

*Every tab button requires a function call associated with it.
  SELECTION-SCREEN TAB (15) t1 USER-COMMAND fc1.
  SELECTION-SCREEN TAB (15) t2 USER-COMMAND fc2.

SELECTION-SCREEN END OF BLOCK tb1.

*Every tab button requires its own subscreen designed. Every screen (including subscreens) requires a number. Whenever a parameter
*statement is used, SAP will generate the Selection Screen which will always have the number of 1000.
*Below, the number provided refers to the number of the screen (subscreen) which can be any number from the range of from 1 to 9999
*with the exception of 1000 which is reserved for the Selection Screen.
SELECTION-SCREEN BEGIN OF SCREEN 100 AS SUBSCREEN.

*Everything that's supposed to be available in the subscreen should be included here, be it checkboxes, radiobuttons,
*input screen or anything else. Here, I am creating a comment/label. *A static message within the subscreen starting from the 8th
*position with 30 following spaces reserved for it.
  SELECTION-SCREEN COMMENT 8(30) lb1.

SELECTION-SCREEN END OF SCREEN 100.

SELECTION-SCREEN BEGIN OF SCREEN 200 AS SUBSCREEN.

  SELECTION-SCREEN COMMENT 8(30) lb2.

SELECTION-SCREEN END OF SCREEN 200.

*----------
*BELOW, AT THE END OF THE PROGRAM, WHICH IS A CUSTOM, ARE DEFINED ALL ACTIONS ASSOCIATED WITH PARTICULAR EVENTS.
*----------

*On the stage of the INITIALIZATION, if I need to perform any default activities, I must perform them. It's here that I am setting
*one of the tabs of my tabbed block as active.
INITIALIZATION.
*tb1 is a name of my tabbed block and it has properties. 'activetab' is one of them and thus, as it's a property, I am referring to it
*by a hyphen. The value I am assigning is the name of the function call associated with the proper tab.
tb1-activetab = 'FC2'.
*I also need to create a link between the active tab and a subscreen. The property of 'dynnr' holds the number of the screen.
tb1-dynnr = '200'.
*I also need to tell SAP in which program that particular subscreen (200) is designed. sy-repid is a system variable that holds the
*name of the current program.
tb1-prog = sy-repid.

*Setting the names of the tabs.
t1 = 'Ishgard'.
t2 = 'Gridania'.

*Setting the values of the comments in the subscreens.
lb1 = 'Welcome to Ishgard!'.
lb2 = 'Welcome to Gridania!'.

*The INITIALIZATION holds the information about the default behaviours of my program. What's set there is what the program does upon
*its execution. If I want to handle the backend logic of any actions that happen in the Selection Screen after it's been displayed,
*then I need to specify it all in the AT-SELECTION-SCREEN event.
*My tabs have function calls associated with them, so if I want to decide what happens when a particular tab is selected, I need to
*specify the actions based on the current value of 'sy-ucomm' which holds the name of the chosen function call.
*Whenever a user clicks on a tab button, AT-SELECTION-SCREEN event is triggered and the function call of the button that's been
*clicked, will be captured in the sy-ucomm.  
AT SELECTION-SCREEN.
  CASE sy-ucomm.
    WHEN 'FC1'. "When the user pushes the t1 tab button...
      tb1-activetab = 'FC1'.    "tb1's active tab is the one that has the function call 'FC1'.
      tb1-dynnr    = '100'.    "The subscreen to be displayed is the one of the number of '100'.
      tb1-prog     = sy-repid. "The subscreen in question is available in the current program.
    WHEN 'FC2'. "When the user pushes the t2 tab button...
      tb1-activetab = 'FC2'.
      tb1-dynnr    = '200'.
      tb1-prog     = sy-repid.
  ENDCASE.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*INTERNAL TABLES. APPEND LINES OF, ASSIGNMENT OPERATOR, CLEAR, REFRESH, FREE.
*---------------------------------------------------------------------------------------------------------------------------------

*Data is SAP is held within a database. Within a database there are tables whose purpose is to store data permanently.
*Internal tables are created in runtime in the Application Server, which means they are temporary - they exist only as long as
*the program runs.
*An example of the flow of a program with internal tables:
*--------------------------------------------------------------------*
*If my program contains internal tables, they are created in the Application Server upon the execution of the program. The Application
*Server is where the actual calculations take place, the entire business logic is executed here. Then a request to the Database Server
*is being sent and the data is being sent into the internal table. Here, it will be processed (e.g. delete unnecessary, modify some,
*insert new, perform calculations, sort) and sent back to the database or displayed on the output screen for the user to read.
*Upon the program's execution is finished, the memory allocated for the internal table is destroyed.
*--------------------------------------------------------------------*
*Internal tables can be standard (indexed), sorted (indexed) or hashed (non-indexed). By default, if not specified by the programmer,
*SAP considers tables standard. The index of an internal table always starts with 1.

TYPES: BEGIN OF t_emp,
         empno        TYPE i,
         ename(15)    TYPE c,
         empdesig(25) TYPE c,
       END OF t_emp.

*An internal table with a header.
*TYPE TABLE OF creates an internal table. Just TYPE would create a Work Area able to hold just a single record at a time.
*The type of the table is not specified so it's standard by default.
DATA: it_emp1 TYPE TABLE OF t_emp WITH HEADER LINE.

*Below CLEAR refers to the header line.
CLEAR it_emp1.

*Filling ing the header line.
it_emp1-empno = 3.
it_emp1-ename = 'Dazikiri'.
it_emp1-empdesig = 'Developer'.

*APPEND statement copies the data from the header line to the end of the internal table.
APPEND it_emp1.

CLEAR it_emp1.
it_emp1-empno = 6.
it_emp1-ename = 'Halasibel'.
it_emp1-empdesig = 'Developer'.
APPEND it_emp1.

CLEAR it_emp1.
it_emp1-empno = 9.
it_emp1-ename = 'Seinn'.
it_emp1-empdesig = 'Senior Developer'.
APPEND it_emp1.

CLEAR it_emp1.
it_emp1-empno = 12.
it_emp1-ename = 'Justinia'.
it_emp1-empdesig = 'Senior Developer'.
APPEND it_emp1.

*Below will print the data about Justinia because WRITE refers to the header record.
WRITE: / it_emp1-empno, it_emp1-ename, it_emp1-empdesig.
ULINE.

*In order to print all the data from the body of the internal table, I need to copy each record from the body to
*the header line, one by one.
*For this purpose, a LOOP is used. Below, due to the usage of the loop, the seemingly same operation as attempted
*above, will now print all the records of the internal table. The concept of a loop is to keep executing what's
*defined within until the condition is met. The cursor goes automatically from the previous record to the next.
*sy-tabix is a system variable that refers to the internal table's index for the current loop.
WRITE: / 'Data in the internal tables body: '.
LOOP AT it_emp1.
  WRITE: / it_emp1-empno, it_emp1-ename, it_emp1-empdesig, sy-tabix..
ENDLOOP.
ULINE.

*In the below case, I am telling SAP ("FROM 2 TO 4") what is the range of indexes it should take into considertaion
*within the loop.
WRITE: / 'Data in the internal tables body up to index 3: '.
LOOP AT it_emp1 FROM 2 TO 4.
  WRITE: / it_emp1-empno, it_emp1-ename, it_emp1-empdesig, sy-tabix..
ENDLOOP.
ULINE.

*WHERE clause in action. Data is case-sensitive. It will not display a record if it has 'senior developer' for instance.
WRITE: / 'Data in the internal tables body where "Senior Developer" is specified: '.
LOOP AT it_emp1 WHERE empdesig = 'Senior Developer'.
  WRITE: / it_emp1-empno, it_emp1-ename, it_emp1-empdesig, sy-tabix.
ENDLOOP.
ULINE.

*In order to count the number of records within an internal table, I can use DESCRIBE TABLE. The DESCRIBE statement will
*store the value in the system variable, sy-tfill.
DESCRIBE TABLE it_emp1.
WRITE: / 'The number of records within the internal table initially: ', sy-tfill.
ULINE.

*If I want to clear the body of an internal table with a header line, I need to add sqaure brackets after the name.
*'CLEAR it_emp1' clears just the header record.
CLEAR it_emp1[].
DESCRIBE TABLE it_emp1.
WRITE: / 'The number of records within the internal table atfer the clear is ', sy-tfill.
ULINE.

*The second internal table - this time without a header line. So I need to declare a work area for it.
DATA it_emp2 TYPE TABLE OF t_emp.
DESCRIBE TABLE it_emp2.
WRITE: / 'The number of records within the second internal table initially: ', sy-tfill.
ULINE.

*Refilling the first internal table a bit so I have data to copy to the second one.
it_emp1-empno = 6.
it_emp1-ename = 'Halasibel'.
it_emp1-empdesig = 'Developer'.
APPEND it_emp1.
CLEAR it_emp1.
it_emp1-empno = 9.
it_emp1-ename = 'Seinn'.
it_emp1-empdesig = 'Senior Developer'.
APPEND it_emp1.
CLEAR it_emp1.
it_emp1-empno = 12.
it_emp1-ename = 'Justinia'.
it_emp1-empdesig = 'Senior Developer'.
APPEND it_emp1.
DESCRIBE TABLE it_emp1.
WRITE: / 'The number of records within the first internal table after a refill: ', sy-tfill.
ULINE.

*Now I would like to copy the data from it_emp1 to it_emp2. There are multiple ways of doing that. Some of thme are:
*1. APPEND LINES OF... TO...
*2. The assignment operator.
*Below is the first method - APPEND LINES OF... TO...
*Copying data from a table with a header line to a table without a header line with both having the same internal structure.
APPEND LINES OF it_emp1 TO it_emp2.
DESCRIBE TABLE it_emp2.
WRITE: / 'The number of records within the second internal table after copying the data from the first: ', sy-tfill.
ULINE.

*The third internal table.
DATA it_emp3 TYPE TABLE OF t_emp.
DESCRIBE TABLE it_emp3.
WRITE: / 'The number of records within the third internal table initially: ', sy-tfill.
ULINE.

*Below is the second method - the assignment operator.
it_emp3 = it_emp2.
DESCRIBE TABLE it_emp3.
WRITE: / 'The number of records within the third internal table after copying data from the second: ', sy-tfill.
ULINE.

*REFRESH is an alternative to CLEAR. REFRESH always refers to the body and does not require the usage of the square brackets
*like CLEAR which, without the brackets, will CLEAR only the header line (interms of the internal tables with a header record).
REFRESH it_emp2.
DESCRIBE TABLE it_emp2.
WRITE: / 'The number of records within the second internal table after REFRESHing: ', sy-tfill.
ULINE.

*FREE is also an alternative to CLEAR... and REFRESH. FREE always refers to the body and does not require the usage of the square
*brackets like CLEAR which, without the brackets, will CLEAR only the header line (interms of the internal tables with a header record).
FREE it_emp3.
DESCRIBE TABLE it_emp3.
WRITE: / 'The number of records within the third internal table after FREEing: ', sy-tfill.
ULINE.

*Three ways of clearing the data:
*1. CLEAR   -> can be used on regular variavles, work areas and internal tables (including their header lines).
*2. REFRESH -> can be used only on the body of the internal table.
*3. FREE    -> can be used only on the body of the internal table. The difference is that REFRESH will clear the data, but not deallocate
*              the memory whereas FREE clears the data, deallocates the memory and gets the internal table back to its initial state.
*              FREE is recommended due to the fact it also clears the memory.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*INTERNAL TABLES. WORK AREAS, APPEND, INSERT, SORT.
*---------------------------------------------------------------------------------------------------------------------------------

*The standard way of declaring an internal table.
TYPES: BEGIN OF t_emp,
        empno        TYPE i,
        ename(20)    TYPE c,
        empdesig(25) TYPE c,
       END OF t_emp.

*An internal table without a default header line. Also, there's no work area specified.
DATA: t_emp1 TYPE TABLE OF t_emp.

*Below cannot be done, because 't_emp1' has just a body and no header line. The assignment operator attempts to assign the data of
*'5' to the default header line... which is not there.
*t_emp1-empno = 5.

*Below is a work area, to allow me to operate on internal tables without a header line.
*A declaration such as this, bereft of the 'TABLE' after the 'TYPE' means it's a work area being created. It is basically a
*separate header.
DATA: wa_emp TYPE t_emp.

*It is good practice to clear the work area before assigning any new data.
CLEAR wa_emp.
wa_emp-empno    = 3.
wa_emp-ename    = 'Dazikiri'.
wa_emp-empdesig = 'Developer'.
*In case of the internal tables with a header line, it'd just be 'APPEND t_emp1' because of the internal table itself and its
*header line being called the same. APPENDING in such a scenario can only mean one thing.
*Since work areas are separate and can handle multiple internal tables, I need to proclaim to what table exactly I am appending
*the current content of the work area. APPEND always appends the new record at the end of the internal table.
APPEND wa_emp TO t_emp1.

*More records for the internal table.
CLEAR wa_emp.
wa_emp-empno    = 4.
wa_emp-ename    = 'Asibal'.
wa_emp-empdesig = 'Junior Developer'.
APPEND wa_emp TO t_emp1.
CLEAR wa_emp.
wa_emp-empno    = 5.
wa_emp-ename    = 'Sasha'.
wa_emp-empdesig = 'Senior Developer'.
APPEND wa_emp TO t_emp1.

*If I want to reach multiple records within an internal table without a header line - I need to loop through the table with
*'INTO' clause and thus, transfer every record into the work area first.
FORMAT COLOR 2.
WRITE:/ 'Data in t_emp1 initially: '.
LOOP AT t_emp1 INTO wa_emp.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ENDLOOP.
ULINE.
FORMAT COLOR OFF.

*INSERT statement.
*INSERT works just like APPEND but additionally gives me an option to specify an index at which I want a
*record to be placed - as long as that internal table is a standard one.
*A simple INSERT.
CLEAR wa_emp.
wa_emp-empno    = 9.
wa_emp-ename    = 'Marchosias'.
wa_emp-empdesig = 'Senior Developer'.
INSERT wa_emp INTO TABLE t_emp1.
*An INSERT with an INDEX.
CLEAR wa_emp.
wa_emp-empno    = 5.
wa_emp-ename    = 'Vargothan'.
wa_emp-empdesig = 'Junior Developer'.
INSERT wa_emp INTO t_emp1 INDEX 3.

FORMAT COLOR 2.
WRITE:/ 'Data in t_emp1 after INSERTing a record: '.
LOOP AT t_emp1 INTO wa_emp.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ENDLOOP.
ULINE.
FORMAT COLOR OFF.

*When declaring the internal tables, the key field can be specified. That key can be either unique or non-unique.
*The unique one does not accept duplicate values within the internal table whereas the non-unique allows duplicates.
*Unique keys can only be used with SORTED and HASHED internal tables. A STANDARD table can only accept non-unique keys.
*For a STANDARD internal table, the key's specification is not mandatory, it can go well without it.
DATA: t_emp2 TYPE TABLE OF t_emp WITH NON-UNIQUE KEY empno.

*To copy the data from 't_emp1' to 't_emp2'.
APPEND LINES OF t_emp1 TO t_emp2.
FORMAT COLOR 5.
WRITE:/ 'Data in t_emp2 after copying it from t_emp1: '.
LOOP AT t_emp2 INTO wa_emp.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ENDLOOP.
ULINE.
FORMAT COLOR OFF.

*SORT is used for arranging data in a specifc order.
*If I do not specify by which column the sorting should take place, SAP will do it by 'ename'. That's because SAP,
*if there's a default SORT, will check if the internal table contains any key field. If there are no key fields, then
*SAP will go and find the first character field in the internal table and sort it by it. If there isn't any character
*field in the internal table, SAP will perform the SORT on the first field of the internal table.
FORMAT COLOR 2.
SORT t_emp1.
WRITE:/ 'Data in t_emp1 after a default SORT: '.
LOOP AT t_emp1 INTO wa_emp.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ENDLOOP.
ULINE.
FORMAT COLOR OFF.

*Again, a default SORT, but on a table with a key field specified.
*The column by which the sorting should take place is also not specified, but 't_emp2' is a table declared with a key
*field, so that's what the SORT is going to use.
FORMAT COLOR 5.
SORT t_emp2.
WRITE:/ 'Data in t_emp2 after a default SORT: '.
LOOP AT t_emp2 INTO wa_emp.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ENDLOOP.
ULINE.
FORMAT COLOR OFF.

*It is also possible to use SORT to sort the table by a particular field.
FORMAT COLOR 2.
SORT t_emp2 by ename.
WRITE:/ 'Data in t_emp2 after a SORT BY ename: '.
LOOP AT t_emp2 INTO wa_emp.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ENDLOOP.
ULINE.
FORMAT COLOR OFF.

*SORTing can be set as descending or ascending. Ascending is the default setting.
FORMAT COLOR 5.
SORT t_emp2 by ename DESCENDING.
WRITE:/ 'Data in t_emp2 after a SORT BY ename in a descending order: '.
LOOP AT t_emp2 INTO wa_emp.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ENDLOOP.
ULINE.
FORMAT COLOR OFF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------


*---------------------------------------------------------------------------------------------------------------------------------
*INTERNAL TABLES. READ, SY-SUBRC, INDEX.
*---------------------------------------------------------------------------------------------------------------------------------

*A typical internal table's declaration.
TYPES: BEGIN OF t_emp,
        empno        TYPE i,
        ename(20)    TYPE c,
        empdesig(25) TYPE c,
       END OF t_emp.

*An internal table without a default header line with a non-unique key.
DATA: t_emp1 TYPE TABLE OF t_emp WITH NON-UNIQUE KEY empno.

*An explicit work area is required for a table without a header.
DATA: wa_emp TYPE t_emp.

*APPENDing some data.
CLEAR wa_emp.
wa_emp-empno    = 3.
wa_emp-ename    = 'Dazikiri'.
wa_emp-empdesig = 'Developer'.
APPEND wa_emp TO t_emp1.

CLEAR wa_emp.
wa_emp-empno    = 4.
wa_emp-ename    = 'Heskit'.
wa_emp-empdesig = 'Junior Developer'.
APPEND wa_emp TO t_emp1.

CLEAR wa_emp.
wa_emp-empno    = 5.
wa_emp-ename    = 'Halasibel'.
wa_emp-empdesig = 'Senior Developer'.
APPEND wa_emp TO t_emp1.

*The initial data within the internal table.
WRITE: 'The initial records of the internal table:'.
LOOP AT t_emp1 INTO wa_emp.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ENDLOOP.

ULINE.

*Adding an additional record to the table of the same empno (the table's key field!) as that which one of the records of the table
*already has. It's possible because the table has been declared with the 'empno' as the NON-UNIQUE key.
CLEAR wa_emp.
wa_emp-empno    = 3.
wa_emp-ename    = 'Seinn'.
wa_emp-empdesig = 'Developer'.
APPEND wa_emp TO t_emp1.

WRITE: / 'After having added a record with a duplicate key field:'.
LOOP AT t_emp1 INTO wa_emp.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ENDLOOP.

*------------------------
*----------READ----------
*------------------------
*If I want to read a specific record of the internal table, I either need to know the position of the record or something else that
*uniquely identifies that record.
*To read a specific record, I can use READ statement.
*Say, I know what I am looking for is at the third position.
*READ will read the record from the body of the internal table and, if succesful - it will copy that record into the work area. Then
*sy-subrc will be set to '0'. sy-subrc stores the execution status of ABAP statements. '0' means a success, '4' means a failure.
CLEAR wa_emp.
READ TABLE t_emp1 INTO wa_emp INDEX 3.
*If the previous (read table) statement is successfully executed...
IF sy-subrc = 0.
  WRITE: / 'The third record of the internal table is:'.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ELSE.
  WRITE: / 'The third record was not found.'.
ENDIF.
ULINE.

*--------------------------------
*----------TRANSPORTING----------
*--------------------------------
*I can also read only a part of the particular record instead of all of it.
*The work area is not being cleared this time - the data of the third record is still present within.
*TRANSPORTING means I am only 'transporting' the values mentioned afterwards. Basically - read 't_emp1' table into 'wa_emp' work area
*from the index number three BUT TRANSPORT ONLY empno and ename.
*Because the work area was not cleared and empdeisgn is not being transported - the previously inserted value will be present!
*So I will have Seinn as a senior instead of a regular.
*TRANSPORTING is good for the performance because I am taking only the data I actually need.
READ TABLE t_emp1 INTO wa_emp INDEX 4 TRANSPORTING empno ename.
IF sy-subrc = 0.
  WRITE: / 'The fourth record of the internal table is:'.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ELSE.
  WRITE: / 'The fourth record was not found.'.
ENDIF.
ULINE.

*---------------------------------
*----------READ WITH KEY----------
*---------------------------------
*I can READ a record based on a particular field whose value I know. For example, I might want a record where the employee number equals 3.
*There are two of such, but I just want a single one. It is always recommended to sort the internal table based on the field I will be
*looking up the record by before using the READ statement to increase performance.
*Even if I did not specify by which field should the table be sorted, it would be sorted by 'empno' anyway, because the SORT will first check
*if the table has any key fields and, if found, sort the table by them. And my table has 'empno' as the key field.
SORT t_emp1 BY empno.
CLEAR wa_emp.
READ TABLE t_emp1 INTO wa_emp WITH KEY empno = 3.
*Only a single record will be displayed because READ reaches only for one. The first record that meets the requirements will be fetched.
IF sy-subrc = 0.
  WRITE: / 'The employee of number 3:'.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ELSE.
  WRITE: / 'The employee of number 3 is not there.'.
ENDIF.
ULINE.

*---------------------------------
*----------BINARY SEARCH----------
*---------------------------------
*I can use the addition BINARY SEARCH to improve the performance of the READ. A standard linear search goes through all the records of the
*table one by one. A binary search stars from the middle record, checks whether the value there is what it's looking for and, if not - checks
*if the value there is lower or higher than the one it's looking for. If higher - discards all the lower values. If lower, discards all the
*higher values. The process continues until the correct record is found and the number of records that needs to be checked is divided by two
*with every loop. The binary search requires the table to be sorted beforehand.
*E.g.
*READ TABLE t_emp1 INTO wa_emp WITH KEY empno = 3 BINARY SEARCH.

*------------------------------------------
*----------TRANSPORTING NO FIELDS----------
*------------------------------------------
*TRANSPORTING NO FIELDS is telling SAP to move no data from the table to the work area whatsoever. It is used just to check the existance of
*the particular record.
*In the below example, 'INTO wa_emp' actually makes no sense and is reduntant, because 'TRANSPORTING NO FIELDS' will never... transport any
*fields.
CLEAR wa_emp.
READ TABLE t_emp1 INTO wa_emp WITH KEY empno = 8 TRANSPORTING NO FIELDS.
IF sy-subrc = 0.
  WRITE: / 'The employee of number 8:'.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ELSE.
  WRITE: / 'The employee of number 8 is not there.'.
ENDIF.
ULINE.

*------------------------------------------
*----------SY-TABIX, SY-INDEX----------
*------------------------------------------
*sy-tabix contains the index' position within the internal table. It is used between LOOP and ENDLOOP statements.
*sy-index on the other hand is used in DO and WHILE loops.
*Below, 'sy-index' will increment but 'sy-tabix' will remain 0.
DO 10 TIMES.
  WRITE: / 'Hello!', sy-index, sy-tabix.
ENDDO.
ULINE.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*INTERNAL TABLES. SORTED TABLES.
*---------------------------------------------------------------------------------------------------------------------------------

TYPES: BEGIN OF ty_emp,
  empno        TYPE i,
  ename(20)    TYPE c,
  empdesig(25) TYPE c,
       END OF ty_emp.

*When I am declaring a standard table, I can decalre it with a key or without a key. If I define it with a key, it supports only
*non-unique ones. A sorted table type requires me to specify a key. It is mandatory. Both non-unique and unique keys are supported.
DATA: t_emp1 TYPE SORTED TABLE OF ty_emp WITH NON-UNIQUE KEY empno,
      wa_emp TYPE ty_emp.

*------------------------------
*----------APPEND--------------
*------------------------------
*While adding the entries to the sorted internal table, it will automatically sort them based on it's designated key field.
*When adding the work area to the internal table itself, standard internal tables allow APPEND and INSERT to be used. APPEND
*will always add the data at the end of the internal table and INSERT allows for the adding of the record both at the end of
*the itnernal table and at a particular position by specifying the index.
*Sorted tables also allow for APPEND, but if I attempt to add a record with the key field of a lower value than of a record before,
*it will throw an error instead of just placing it in the correct place of the sequence. That is because APPEND always tries to
*place the record at the end of the internal table.
*If I try to add a duplicate entry (the same key field) to the table with a UNIQUE KEY, the APPEND will cause an error (INSERT won't).
CLEAR wa_emp.
wa_emp-empno    = 3.
wa_emp-ename    = 'Thanquol'.
wa_emp-empdesig = 'Developer'.
APPEND wa_emp TO t_emp1.

CLEAR wa_emp.
wa_emp-empno    = 5.
wa_emp-ename    = 'Seleukos'.
wa_emp-empdesig = 'Junior Developer'.
APPEND wa_emp TO t_emp1.

LOOP AT t_emp1 INTO wa_emp.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ENDLOOP.
ULINE.

*To try to perform the below creates a conflict - this is a sorted table, but APPEND will always place the record at the very end of
*the table. Thus - a runtime error.
*CLEAR wa_emp.
*wa_emp-empno    = 2.
*wa_emp-ename    = 'Sati'.
*wa_emp-empdesig = 'Senior Developer'.
*APPEND wa_emp TO t_emp1.

*------------------------------
*----------INSERT--------------
*------------------------------
*In the below example, the record will be automatically placed in the correct place in the sequence, because INSERT isn't trying to
*put the new record at the end of the table obligatorily.
*INSERT statement is thus the recommended approach.
*If I try to add a duplicate entry (the same key field) to the table with a UNIQUE KEY, the INSERT will ignore it, without throwing
*an error (APPEND will).
CLEAR wa_emp.
wa_emp-empno    = 4.
wa_emp-ename    = 'Sati'.
wa_emp-empdesig = 'Senior Developer'.
INSERT wa_emp INTO TABLE t_emp1.

LOOP AT t_emp1 INTO wa_emp.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ENDLOOP.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*INTERNAL TABLES. HASHED TABLES.
*---------------------------------------------------------------------------------------------------------------------------------

*Hashed tables uses a hash algorithm. The algorithm allows for searching by the key field. Indexing is not possible. It is not
*possible to perform explicit or implicit index operations.
*Implicit index operations:
*- APPEND which is telling SAP indirectly to place the record at the end of the internal table. This is indirectly (implicitly)
*  pointing the specific placement (index).
*- READ with BINARY SEARCH is indirectly telling to search for the record from the specific location (middle). This is implicitly
*  pointing the specific location.
*Explicit index operations:
*- INSERT with INDEX. A regular INDEX  without specifying the index is not an explicit index operation!
*- READ with INDEX.

*Hashed tables irrespectively of the number of entries always take the constant amount of time to be searched. Tables with huge
*amount of data will benefit from being hashed tables.

TYPES: BEGIN OF ty_emp,
  empno        TYPE i,
  ename(20)    TYPE c,
  empdesig(25) TYPE c,
       END OF ty_emp.

*Hashed tables can only have unique keys.
DATA: t_emp1 TYPE HASHED TABLE OF ty_emp WITH UNIQUE KEY empno,
      wa_emp TYPE ty_emp.

CLEAR wa_emp.
wa_emp-empno    = 3.
wa_emp-ename    = 'Nessa'.
wa_emp-empdesig = 'Developer'.
INSERT wa_emp INTO TABLE t_emp1.

CLEAR wa_emp.
wa_emp-empno    = 5.
wa_emp-ename    = 'Fingolfin'.
wa_emp-empdesig = 'Junior Developer'.
INSERT wa_emp INTO TABLE t_emp1.

CLEAR wa_emp.
wa_emp-empno    = 2.
wa_emp-ename    = 'Nikanor'.
wa_emp-empdesig = 'Senior Developer'.
INSERT wa_emp INTO TABLE t_emp1.

LOOP AT t_emp1 INTO wa_emp.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ENDLOOP.
ULINE.

*--------------------------------
*----------Searches--------------
*--------------------------------
*A linear/sequential search is possible, because I am not providing any index and searching based on the key. An indexed or binary
*searches are not possible because they are explicitly and implicitly (respectively) providing an index.
CLEAR wa_emp.
READ TABLE t_emp1 INTO wa_emp WITH KEY empno = 3.
IF sy-subrc = 0.
  WRITE: / 'Employee number 3 found:'.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ELSE.
  WRITE / 'Employee number 3 not found.'.
ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*MODULARIZATION. INTERNAL SUBROUTINES, PASS BY VALUE, PASS BY REFERENCE.
*---------------------------------------------------------------------------------------------------------------------------------

*Modularization is a process of breaking a program into smaller individual blocks. A block is a set of statements which is defined
*only once and can be called any number of times.
*Modularization techniques are: subroutines, include programs, function modules, methods and macros.
*Modularization increases reusability, decreases the cost of maintenance, increases readibility and provides efficient control over
*programs' flow.

*Variables to be used by the second subroutine.
DATA: v_x TYPE i VALUE 20,
      v_y TYPE i VALUE 10.
*Variables to be used by the third subroutine.
DATA: v_r1 TYPE i,
      v_r2 TYPE i.

*Subroutine's call to action! I can reuse once defined subroutine as many times as I want. This is an internal subroutine which means
*it is defined and called within the same program. Subroutines can also be external when they are defined and called in different programs.
PERFORM sub1.
PERFORM sub1.
PERFORM sub1.

ULINE.

*Subroutines can also have parameters. USING is to be used whenever I am dealing with standard data types as parameters. At the time of
*the calling of the subroutine, I am USING the actual variables as parameters.
PERFORM sub2 USING v_x v_y.

ULINE.

*Subroutines can also return values and any number of them. CHANGING means these values (declared above) will be assigned new values by
*the subroutine.
PERFORM sub3 USING v_x v_y CHANGING v_r1 v_r2.
WRITE: 'The results from the sub3 are:'.
WRITE: 'The sum is: ', v_r1.
WRITE: 'The difference is: ', v_r2.

ULINE.

*-----------------------------------------------------------
*----------Pass by value and pass by reference--------------
*-----------------------------------------------------------
*Paramaters can be passed into subroutines in one of two ways - either pass by value or pass by reference. By default, they are passed
*by reference. In the below example 'v_x' and 'v_y' are received by the FORM as 'k1' and 'k2' and it means that the ADDRESSES of ACTUAL
*(former) parameters are copied to FORMAL (latter) parameters. Thus the formal parameters will point to the actual parameters. 'k1' and
*'k2' will point to 'v_x' and 'v_y' respectively knowing just their address and not containing their values.
v_x = 10.
v_y = 20.
WRITE: / 'Pass by reference:'.
WRITE: / 'v_x and v_y before the calling of the subroutine:', v_x, v_y.
PERFORM sub4 USING v_x v_y.
*The values of the variables have been changed. The changes made to the formal parameters are reflected in the actual parameters, because
*the formal parameters point to the actual parameters.
WRITE: / 'v_x and v_y after the calling of the subroutine:', v_x, v_y.

ULINE.

*When passing by value, the signature of the subroutine is the same. The changes come in the definition. The keyword 'VALUE' used there
*tells SAP to not take the address of the passed variable, but the value of the actual parameter. 'k1' and 'k2' will not be pointing to
*the actual variables. They are just receiving the same values as the actual parameters.
CLEAR: v_x, v_y.
v_x = 10.
v_y = 20.
WRITE: / 'Pass by value:'.
WRITE: / 'v_x and v_y before the calling of the subroutine:', v_x, v_y.
PERFORM sub5 USING v_x v_y.
*'v_x' and 'v_y' remain unchanged because the subroutine just copies their values and assigns them to its local variables of 'k1' and 'k2'.
*Any operation performed on formal parameters within the subroutine will not be reflected in the actual variables, because there's no
*connection between them.
WRITE: / 'v_x and v_y after the calling of the subroutine:', v_x, v_y.

*&---------------------------------------------------------------------*
*&      Form  sub1
*&---------------------------------------------------------------------*
*       This is the definition of the subroutine.
*----------------------------------------------------------------------*
FORM sub1.
  WRITE: / 'Hello! This is a very long text that I did not want to have to repeat multiple times, so I made it into a subroutine instead.'.
ENDFORM.                    "sub1

*&---------------------------------------------------------------------*
*&      Form  sub2
*&---------------------------------------------------------------------*
*       The names of the parameters can be the same as the actual parameters or they can be different. The moment the control comes out of
*       the subroutine, the local variables and formal parameters ('p_x', 'p_y') are destroyed.
*----------------------------------------------------------------------*
FORM sub2 USING p_x p_y.
  DATA: result TYPE i.
  result = p_x + p_y.
  WRITE: / 'The sum is: ', result.
ENDFORM.                    "sub2

*&---------------------------------------------------------------------*
*&      Form  sub3
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->K1         text
*      -->K2         text
*      <--M1         text
*      <--M2         text
*      k1 will become v_x, k2 will become v_y, m1 will become v_r1 and m2 will become v_r2. No 'return' is required. SAP understands
*      on its own that 'changing' values are the ones being returned.
*----------------------------------------------------------------------*
FORM sub3 USING k1 k2 CHANGING m1 m2.
  m1 = k1 + k2.
  m2 = k1 - k2.
ENDFORM.                    "sub3

*&---------------------------------------------------------------------*
*&      Form  sub4
*&---------------------------------------------------------------------*
*       Below, not values but addresses are being copied!
*----------------------------------------------------------------------*
*      -->K1         text
*      -->K2         text
*----------------------------------------------------------------------*
FORM sub4 USING k1 k2.
  DATA k3 TYPE i.
  k3 = k1.
  k1 = k2.
  k2 = k3.
ENDFORM.                    "sub4

*&---------------------------------------------------------------------*
*&      Form  sub5
*&---------------------------------------------------------------------*
*       In order to have the variables passed by value, I need to utilize the VALUE keyword.
*----------------------------------------------------------------------*
*      -->VALUE      text
*      -->(K1)       text
*      -->VALUE      text
*      -->(K2)       text
*----------------------------------------------------------------------*
FORM sub5 USING VALUE(k1) VALUE(k2).

ENDFORM.                    "sub5

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*MODULARIZATION. INTERNAL TABLES AS PARAMETERS. DELETE, MODIFY.
*---------------------------------------------------------------------------------------------------------------------------------

TYPES: BEGIN OF t_emp,
          empno        TYPE i,
          ename(20)    TYPE c,
          empdesig(25) TYPE c,
       END OF t_emp.

DATA: it_emp TYPE TABLE OF t_emp,
      wa_emp TYPE t_emp.

CLEAR wa_emp.
wa_emp-empno = 3.
wa_emp-ename = 'Dazikiri'.
wa_emp-empdesig = 'Developer'.
APPEND wa_emp TO it_emp.

CLEAR wa_emp.
wa_emp-empno = 1.
wa_emp-ename = 'Attalos'.
wa_emp-empdesig = 'Junior Developer'.
APPEND wa_emp TO it_emp.

CLEAR wa_emp.
wa_emp-empno = 5.
wa_emp-ename = 'Astrastvael'.
wa_emp-empdesig = 'Senior Developer'.
APPEND wa_emp TO it_emp.

*Displays the internal table's contents.
PERFORM sub2 TABLES it_emp.

ULINE.

*Deletes some of the internal table's contents.
PERFORM sub3 TABLES it_emp.
PERFORM sub2 TABLES it_emp.

ULINE.

PERFORM sub4 TABLES it_emp.

ULINE.

*A work area can be used anywhere in the program, including the FORMs. I am using it directly, because
*the work area itself is but a 'tool' for passing data and can be used for multiple internal tables.
FORM sub2 TABLES lt_emp.
  LOOP AT lt_emp INTO wa_emp.
    WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
  ENDLOOP.
ENDFORM.

*If I tried to do it as below with the USING keyword, SAP would throw an error saying 'lt_emp' is not
*recognized as an internal table.
*PERFORM sub1 USING it_temp.
*FORM sub1 USING lt_emp.
*  LOOP AT lt_emp INTO wa_emp.
*    doing important stuff!!!
*  ENDLOOP.
*ENDFORM.

*------------------------------
*----------DELETE--------------
*------------------------------
*Wherever I am altering the data in the internal table in a subroutine (MODIFY or DELETE), I need to
*specify the structure of the internal table by adding the keyword STRUCTURE and providing the work area
*used. "Row type" is work area.
*Without this addition (the example below) I will get an error:
*"The row type of the table must be identifiable statically in "...WHERE..."".
*FORM sub3 TABLES lt_emp.
*  DELETE lt_emp WHERE empdesig = 'Senior Developer'.
*ENDFORM.

*Changes done to the formal internal table will also affect the actual internal table which means it's
*passed by reference by default.
FORM sub3 TABLES lt_emp STRUCTURE wa_emp.
  DELETE lt_emp WHERE empdesig = 'Senior Developer'.
ENDFORM.

*------------------------------
*----------MODIFY--------------
*------------------------------
*I cannot modify an internal table directly, first I need to assign the desired value to the work area
*and then I can update the internal table via the work area.
*"TRANSPORTING empdesig" means that only this field is to be taken into account. I could say instead:
*"(...)TRANSPORTING ename WHERE empdesig = 'Developer'." if my work area contained the updated name
*which I wanted to assign to all developers.
FORM sub4 TABLES lt_emp STRUCTURE wa_emp.
  CLEAR wa_emp.
  wa_emp-empdesig = 'Senior Developer'.
  MODIFY lt_emp FROM wa_emp TRANSPORTING empdesig WHERE empdesig = 'Developer'. 
ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*MODULARIZATION. EXTERNAL SUBROUTINES.
*---------------------------------------------------------------------------------------------------------------------------------

*If I want the same functionality to be used across multiple programs, I should create an external subroutine. Below statement
*will throw an error desptie 'sub1' being defined... because it's defined in another program (ZBM_TEST3). By default, subroutines
*are considered internal.
*PERFORM sub1.

*I need to specify from what program I want to call the subroutine. Both of the below ways of calling an external subroutine are
*correct.
PERFORM sub1 IN PROGRAM ZBM_TEST3.
PERFORM sub1(ZBM_TEST3).

ULINE.

*Calling an external subroutine with parameters.
PERFORM sub2 IN PROGRAM ZBM_TEST3 USING 20 10.
PERFORM sub2 IN PROGRAM ZBM_TEST3 USING 60 3.

ULINE.

*---------------------------------------
*----------SUBROUTINE POOL--------------
*---------------------------------------
*In SE38, next to regular executable programs, I can create subroutine pools (ZBM_SUBROUTINE_POOL).
PERFORM sub1 IN PROGRAM ZBM_SUBROUTINE_POOL.
PERFORM sub1(ZBM_SUBROUTINE_POOL).

ULINE.

PERFORM sub2(ZBM_SUBROUTINE_POOL) USING 30 10.
PERFORM sub3(ZBM_SUBROUTINE_POOL) USING 30 10.

*********************************************
*THE CODE WITHIN ZBM_TEST3.
*********************************************
*REPORT  ZBM_TEST3.
*
*FORM sub1.
*  WRITE: / 'Inside the sub1 subroutine in ZBM_TEST3!'.
*ENDFORM.
*
*FORM sub2 USING x y.
*  WRITE: / 'Inside the sub2 subroutine in ZBM_TEST3!'.
*  DATA z TYPE i.
*  z = x + y.
*  WRITE: / 'The sum is: ', z.
*  WRITE: / 'The end of sub2!'.
*ENDFORM.

*********************************************
*THE CODE WITHIN ZBM_SUBROUTINE_POOL.
*********************************************
*This is a subroutine pool and thus is not executable. Trying to do so will throw an error.
*PROGRAM  ZBM_SUBROUTINE_POOL.
*
*DATA z TYPE i.
*
*FORM sub1.
*  WRITE: / 'Inside sub1 of subroutine pool!'.
*ENDFORM.
*
*FORM sub2 USING x y.
*  z = x + y.
*  WRITE: / 'The sum is: ', z.
*ENDFORM.
*
*FORM sub3 USING x y.
*  z = x - y.
*  WRITE: / 'The difference is: ', z.
*ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*INCLUDE PROGRAMS.
*---------------------------------------------------------------------------------------------------------------------------------

*Similar to Java's imports! An include is a reusable object which can contain global variables, subroutine definitions, module
*definitions.
*Variables are declared within the include. It is a good practice to include the INCLUDEs (hehe) at the beginning of the program.
INCLUDE ZBM_INCLUDE_ONE.
*INCLUDEs usually should be included at the very beginning of the program, but 'ZBM_INCLUDE_TWO' contains the definitions of
*subroutines and modules which means I have e.g. FORMs included... at the beginning of the program. And they always have to
*be at the very end of it. If I placed that INCLUDE below the 'PERFORM sub2', the program would compile.
*Thus, INCLUDEs should be at the very top of the program and if these INCLUDEs contain any subroutines' or modules' definitions,
*then I should add the event block START-OF-SELECTION after these INCLUDEs. This will tell SAP to not start the processing of
*the program from the INCLUDEs, but from where START-OF-SELECTION is placed and the INCLUDEs still will declared where they
*ought to be.
INCLUDE ZBM_INCLUDE_TWO.
START-OF-SELECTION.
x = 5.
y = 2.
z = x + y.
WRITE: / 'The sum is: ', z.

*The definition is within 'ZBM_INCLUDE_TWO'.
PERFORM sub2.

*********************************************
*THE CODE WITHIN ZBM_INCLUDE_ONE.
*********************************************
**An include program starts without any keyword. It is a nonexecutable program.
*DATA: x TYPE i,
*      y TYPE i,
*      z TYPE i.
*
*TYPES: BEGIN OF t_emp,
*         empno TYPE i,
*         ename(20) TYPE c,
*         empdesig(25) TYPE c,
*       END OF t_emp.
*
*DATA: it_emp TYPE TABLE OF t_emp,
*      wa_emp TYPE t_emp.

*********************************************
*THE CODE WITHIN ZBM_INCLUDE_TWO.
*********************************************
*DATA: a TYPE i VALUE 3,
*      b TYPE i VALUE 2,
*      c TYPE i.
*
*FORM sub1.
*  c = a - b.
*  WRITE: / 'The difference between two variables declared and defined withing the INCLUDE is: ', z.
*ENDFORM.
*
*FORM sub2.
*  c = a + b.
*  WRITE: / 'The sum between two variables declared and defined withing the INCLUDE is: ', z.
*ENDFORM.
*
*MODULE abc OUTPUT.
*  WRITE: / 'A module abc!'.
*ENDMODULE.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*FUNCTION MODULES.
*---------------------------------------------------------------------------------------------------------------------------------

*Similar to subroutines, it is a set of statements that is defined once and can be called any number of times. The difference is that
*subroutines are created as part of a particular program while function modules are created with a separate tool - a function builder
*tool (transaction SE37).
*There are many standard function modules - provided by SAP. They can be called explicitly. Function modules can be custom if defined
*by a developer.
*All function modules, be they standard or custom ones, are stored within a function group. Function modules are kept in
*a database table (TFDIR).
*Repository objects (executable programs, include programs, subroutine pools) are stored in a database table TADIR.
*Function modules need to reside within function groups which are to be created in SE80. Whenever a function group is created, SAP
*creates two include programs. One of them is the 'TOP' and is used for declaring global variables, subroutines and modules. The second
*one is the 'UXX' and it is reserved for SAP. It is internally used by SAP. A function group will contain the function modules and includes
*in different directories.
*On behalf of every function modules, one include statement is created in 'UXX' include. Each of these statements refers to one function
*module.
*Once created - every function module is global and can be used anywhere within the SAP system.

*Within the created function module, in Attributes tab, I can pick various radiobuttons in the Processing Type section:
*- A 'Regular Function Module' means my function module can be accessed throughout this particular SAP server.
*- A 'Remote-Enabled Module' means my function module can be called from another SAP server.

*Parameters for the second and third custom function modules.
PARAMETERS: p_x TYPE i,
            p_y TYPE i.
*To contain the values returned by the third function.
DATA: gv_r1 TYPE i,
      gv_r2 TYPE i.

*------------------------------------------------------------
*----------A FUNCTION MODULE WITHOUT PARAMETERS--------------
*------------------------------------------------------------
*Since function modules are developed in a separate tool, a developer is provisioned with the possibility to test a function module
*within a function module tool. The below test function module only prints a string using the WRITE statement which displays the
*output in the output screen - List Processing Screen. If I Test (F8) my function module, I will be taken to another screen where
*I can select 'Display output list of function module' button on the Application Toolbar. This will show me the list generated.
WRITE: / 'A function module without any parameters:'.
CALL FUNCTION 'ZBM_FUNCTION_MODULE_ONE'
          .
ULINE.

**********************************************
**THE CODE WITHIN ZBM_FUNCTION_MODULE_ONE.
**********************************************
*FUNCTION ZBM_FUNCTION_MODULE_ONE.
**"----------------------------------------------------------------------
**"*"Lokalny interfejs:
**"----------------------------------------------------------------------
*WRITE: / 'Hello from ZBM_FUNCTION_MODULE_ONE!'.
*ENDFUNCTION.

*---------------------------------------------------------
*----------A FUNCTION MODULE WITH PARAMETERS--------------
*---------------------------------------------------------
*A function module with parameters:
WRITE: / 'A function module with parameters:'.
CALL FUNCTION 'ZBM_FUNCTION_MODULE_TWO'
  EXPORTING
    i_x           = p_x
    i_y           = p_y
          .
ULINE.

**********************************************
**THE CODE WITHIN ZBM_FUNCTION_MODULE_TWO.
**********************************************
*FUNCTION ZBM_FUNCTION_MODULE_TWO.
**"----------------------------------------------------------------------
**"*"Lokalny interfejs:
**"  IMPORTING
**"     REFERENCE(I_X) TYPE  I
**"     REFERENCE(I_Y) TYPE  I
**"----------------------------------------------------------------------
*DATA: lv_z TYPE i.
*lv_z = i_x + i_y.
*WRITE: / 'The sum is: ', lv_z.
*ENDFUNCTION.

*In different programming languages, a function can return just a single value. In ABAP any number of values can be returned and
*it depends on the number of export parameters. In ABAP export parameters are always optional. Function modules do not use any
*"return" keyword, because export parameters are considered the values to be returned.
*When I am caling a function from my code, the EXPORTING parameters are the IMPORTING ones from the function's perspective. Likewise
*what, from the perspective of the rest of the code my function is IMPORTING is actually EXPORTING from within the function itself.
*The words used are dependant on the perspective.
*Below, esentially, 'p_x' and 'p_y' are being exported into the function module (from within the FM they are being imported), the function
*module performs its calculations and then the results are being imported from the FM (from within the FM they are being exported) and
*whatever values they are holding are being assigned to 'gv_r1' and 'gv_r2'.
WRITE: / 'A function module with multiple returned values:'.
CALL FUNCTION 'ZBM_FUNCTION_MODULE_THREE'
  EXPORTING
    i_x           = p_x
    i_y           = p_y
 IMPORTING
   E_R1          = gv_r1
   E_R2          = gv_r2
          .
WRITE: / 'The first returned value is:', gv_r1.
WRITE: / 'The second returned value is:', gv_r2.
ULINE.

**********************************************
**THE CODE WITHIN ZBM_FUNCTION_MODULE_THREE.
**********************************************
*FUNCTION ZBM_FUNCTION_MODULE_THREE.
*"----------------------------------------------------------------------
*"*"Lokalny interfejs:
*"  IMPORTING
*"     REFERENCE(I_X) TYPE  I
*"     REFERENCE(I_Y) TYPE  I
*"  EXPORTING
*"     REFERENCE(E_R1) TYPE  I
*"     REFERENCE(E_R2) TYPE  I
*"----------------------------------------------------------------------
*e_r1 = i_x + i_y.
*e_r2 = i_x - i_y.
*ENDFUNCTION.

*------------------------------------------------------------------
*----------A FUNCTION MODULE WITH CHANGING PARAMETERS--------------
*------------------------------------------------------------------
*CHANGING parameters act as both import and export parameters - the same parameter can be used for passing the value as well as
*returning the value.
*'p_y' acts as both the import and export value. It is one of the paramters exported into the function module and the only one
*that's being exported. The calculation is being performed on both parameters and one of them is also returned as a result.
WRITE: / 'A function module with a changing parameter:'.
CALL FUNCTION 'ZBM_FUNCTION_MODULE_FOUR'
  EXPORTING
    i_x           = p_x
  CHANGING
    c_y           = p_y
          .
WRITE: / 'The result is: ', p_y.

**********************************************
**THE CODE WITHIN ZBM_FUNCTION_MODULE_FOUR.
**********************************************
*FUNCTION ZBM_FUNCTION_MODULE_FOUR.
**"----------------------------------------------------------------------
**"*"Lokalny interfejs:
**"  IMPORTING
**"     REFERENCE(I_X) TYPE  I
**"  CHANGING
**"     REFERENCE(C_Y) TYPE  I
**"----------------------------------------------------------------------
*c_y = i_x + c_y.
*ENDFUNCTION.

*------------------------------------------------------------------
*----------A FUNCTION MODULE WITH EXCEPTIONS-----------------------
*------------------------------------------------------------------
*EXCEPTION handling is performed in order to avoid runtime errors. Due to 'myexception' being defined within the function
*module and raised if the divider is 0, a runtime error will be avoided and the result will be 0.
*Upon calling the FM, the exception section is added due to the fact that I created a custom exception for the FM. If the
*condition will be true (the divider -'i_y' being 0) and this 'myexception' is raised - sy-subrc is set to 1. sy-subrc contains
*the execution status of the previous ABAP statement. If any different exception is raised, sy-subrc is set to 2. I can assign
*whatever values I want. If no exception is raised, sy-subrc remains 0.
WRITE: / 'A function module with a custom exception:'.
CALL FUNCTION 'ZBM_FUNCTION_MODULE_FIVE'
  EXPORTING
    i_x               = p_x
    i_y               = p_y
  IMPORTING
    E_Z               = gv_r1
 EXCEPTIONS
   MYEXCEPTION       = 1
   OTHERS            = 2.
IF sy-subrc = 0.
  WRITE: / 'The division is: ', gv_r1.
ELSEIF sy-subrc = 1.
  WRITE: 'Cannot divide by 0!'.
ELSEIF sy-subrc = 2.
  WRITE: / 'An unknown error occured!'.
ENDIF.

**********************************************
**THE CODE WITHIN ZBM_FUNCTION_MODULE_FIVE.
**********************************************
*FUNCTION ZBM_FUNCTION_MODULE_FIVE.
**"----------------------------------------------------------------------
**"*"Lokalny interfejs:
**"  IMPORTING
**"     REFERENCE(I_X) TYPE  I
**"     REFERENCE(I_Y) TYPE  I
**"  EXPORTING
**"     REFERENCE(E_Z) TYPE  I
**"  EXCEPTIONS
**"      MYEXCEPTION
**"----------------------------------------------------------------------
*IF i_y = 0.
*  RAISE myexception.
*ELSE.
*  e_z = i_x / i_y.
*ENDIF.
*ENDFUNCTION.
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*STANDARD FUNCTION MODULES PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------

*Standard FMs are defined by SAP itself and are ready to be used by a developer.
*AS LISTBOX VISIBLE LENGTH addition provides a drop down list of values for the parameter field. If I used AS LISTBOX without
*VISIBLE LENGTH, I would get an error. I additionally need to specify a set of values which I would associate with my listbox.
*Without it, I would have an empty drop-down list.
*As I execute the program, before the selection screen is displayed, two events are triggered - INITIALIZATION and
*AT-SELECTION-SCREEN OUTPUT. If I want a fixed set of values to be available within my drop-down list, I need to specify it
*during the INITIALIZATION event.
*Every value in the drop-down list needs to be associated with a key which is used to identify the selected value. That key,
*upon the selection of the value, will be assigned to the parameter ('p_course').
PARAMETERS p_course(20) TYPE c AS LISTBOX VISIBLE LENGTH 15.
SELECTION-SCREEN SKIP 2.
*I want my pushbutton to start from 35th position and be of 15 characters' length. Every pushbutton needs to be associated
*with a function call (USER-COMMAND). The pushbutton's name is defined in INITIALIZATION. Whenever a pushbutton is pressed,
*AT-SELECTION-SCREEN event is triggered. The USER-COMMAND's name ('fc1' here) is held within 'sy-ucomm'.
SELECTION-SCREEN PUSHBUTTON 35(15) b1 USER-COMMAND fc1.

*An internal table required by the standard function module I will use to manage the drop-down list. The line of the table
*consists of a key and a text.
*In earlier SAP versions, I would also have to define 'TYPE-POOLS vrm' - to be able to use 'vrm_value' (double click on
*'vrm_value' and Types' Group VRM can be seen).
DATA: lt_values TYPE TABLE OF vrm_value,
      wa_value  TYPE vrm_value.

*The logic assigning values from the drop-down list to their keys should be specified in the INITIALIZATION. In ABAP whenever
*I need to create a drop-down list, there is a standard function module for that.
INITIALIZATION.
  b1 = 'Identify'.
  PERFORM prepared_drop_down. "Prepares the input for the FM.
    IF lt_values IS NOT INITIAL.
      PERFORM display_dropdown.
    ENDIF.

AT SELECTION-SCREEN.
  CASE sy-ucomm.
    WHEN 'FC1'.
      IF p_course = 'K1'.
        MESSAGE 'CORE ABAP is selected.' TYPE 'I'.
      ELSEIF p_course = 'K2'.
        MESSAGE 'OOPS ABAP is selected.' TYPE 'I'.
      ELSEIf p_course = 'K3'.
        MESSAGE 'CROSS APPS is selected.' TYPE 'I'.
      ELSE.
        MESSAGE 'No value has been selected.' TYPE 'I'.
      ENDIF.
    WHEN OTHERS.
  ENDCASE.

*&---------------------------------------------------------------------*
*&      Form  PREPARED_DROP_DOWN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM prepared_drop_down .
  CLEAR wa_value.
  wa_value-key = 'K1'.
  wa_value-text = 'CORE ABAP'.
  APPEND wa_value TO lt_values.

  CLEAR wa_value.
  wa_value-key = 'K2'.
  wa_value-text = 'OOPS ABAP'.
  APPEND wa_value TO lt_values.

  CLEAR wa_value.
  wa_value-key = 'K3'.
  wa_value-text = 'CROSS APPS'.
  APPEND wa_value TO lt_values.
ENDFORM.                    " PREPARED_DROP_DOWN

*&---------------------------------------------------------------------*
*&      Form  DISPLAY_DROPDOWN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM DISPLAY_DROPDOWN .
*ID is the name of the drop-down list. That name is the name of the parameter that's supposed to have
*a drop-down list.
  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id                    = 'P_COURSE'
      values                = lt_values
   EXCEPTIONS
     ID_ILLEGAL_NAME       = 1
     OTHERS                = 2.
  IF sy-subrc = 1.
    MESSAGE 'Illegal drop-down list box name.' TYPE 'I'.
  ELSEIF sy-subrc = 2.
    MESSAGE 'An unknown error occured.' TYPE 'I'.
  ENDIF.

ENDFORM.                    " DISPLAY_DROPDOWN

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*SELECTION SCREENS - CONTROLLING SCREEN ELEMENTS WITH EVENTS.
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
*ON-CHANGE-OF. CUSTOMERS' COUNTRIES REPORT.
*---------------------------------------------------------------------------------------------------------------------------------

*I want to display customers from various countries, but the country itself I want displayed only once for all the citizens hailing
*from that land.
TYPES: BEGIN OF t_customer,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kna1-land1,
  name1 TYPE kna1-name1,
  ort01 TYPE kna1-ort01,
END OF t_customer.

DATA: it_customer TYPE TABLE OF t_customer,
      wa_customer TYPE t_customer.

SELECT kunnr land1 name1 ort01
  FROM kna1
  INTO TABLE it_customer
  UP TO 500 ROWS.
IF sy-subrc = 0.
*If I didn't sort the results first, I would have multiple separate sections for the same country, because the loop just goes one by
*one through the internal table and triggers ON CHANGE OF with every change. If the first record is DE, the second is PL and the third
*is DE again, I'll have two DE sections. SORTing the table solves that problem on arrival.
  SORT it_customer BY land1.
  LOOP AT it_customer INTO wa_customer.
    ON CHANGE OF wa_customer-land1.
      FORMAT COLOR 4.
      WRITE: / 'Customer country: ', wa_customer-land1.
      FORMAT COLOR OFF.
    ENDON.
    FORMAT COLOR 2.
    WRITE: / wa_customer-kunnr,
             wa_customer-name1,
             wa_customer-ort01.
    FORMAT COLOR OFF.
  ENDLOOP.
ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*ON-CHANGE-OF. SELECT-ENDSELECT.
*---------------------------------------------------------------------------------------------------------------------------------

*I want to retrieve data about customers from three countries using SELECT-ENDSELECT and displaying the country's name only once.

TYPES: BEGIN OF t_customer,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kna1-land1,
  name1 TYPE kna1-name1,
  ort01 TYPE kna1-ort01,
END OF t_customer.

DATA: wa_customer TYPE t_customer.

**SELECT-ENDSELECT is a looping statment. SELECT-ENDSELECT acts like a work area. It will retrieve one record after another and
**print them before moving back to taking another record. Every loop is another request to the database server. Every following
**record is overwriting the previous one because I am using a work area and not an internal table.
**The records selected from the database table are grouped by the country's key which means they are sorted. Then every record
**is being displayed and the loop goes back to the beginning to process another record. Every time my loop encounteres a new
**country's key ('land1') - that key is being displayed and the loop goes back to its standard processing of the records.
*SELECT kunnr land1 name1 ort01
*  FROM kna1
*  INTO wa_customer
*  WHERE land1 IN ('AR', 'AU', 'BE')
*  ORDER BY land1. "This is the equivalent of SORT which I cannot use here because I have no table to SORT.
*    ON CHANGE OF wa_customer-land1.
*      FORMAT COLOR 2.
*      WRITE: / 'Country key: ', wa_customer-land1.
*      FORMAT COLOR OFF.
*    ENDON.
*  FORMAT COLOR 5.
*  WRITE: / wa_customer-kunnr,
*           wa_customer-name1,
*           wa_customer-ort01.
*  FORMAT COLOR OFF.
*ENDSELECT.

**SELECT-ENDSELECT will act as a loop and every SELECT will request a single record which means that a lot of requests to the database
*will be sent which is a performance issue. The usage of SELECT-ENDSELECT is discouraged.
*Instead, an internal table should be used. ORDER BY also increases the load on the database because it attempts to perform the sorting
*on the database itself so it should be avoided (it attempts to perform the sorting during the data retrieval itself). Instead, I should
*fetch the data into the internal table and SORT it.

*To create the internal table that wasn't here before.
DATA: it_customer TYPE TABLE OF t_customer.

*The select is executed only once and all the data comes to my internal table in one fell swoop. No ENDSELECT is required because I am
*inserting the retrieved data into an internal table, not a work area, so SAP does not need to send multiple requests to the database
*server as the structure where it keeps the retrieved data no longer can conatin but a single record as was the case with a work area.
SELECT kunnr land1 name1 ort01
  FROM kna1
  INTO TABLE it_customer
  WHERE land1 IN ('AR', 'AU', 'BE').
    IF sy-subrc = 0.
      SORT it_customer BY land1.
      LOOP AT it_customer INTO wa_customer.
        ON CHANGE OF wa_customer-land1.
          FORMAT COLOR 2.
          WRITE: / 'Country key: ', wa_customer-land1.
          FORMAT COLOR OFF.
        ENDON.
          FORMAT COLOR 5.
          WRITE: / wa_customer-kunnr,
                   wa_customer-name1,
                   wa_customer-ort01.
          FORMAT COLOR OFF.
      ENDLOOP.
    ELSE.
      WRITE: / 'No data available.'.
    ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*THE GLOBAL CLASS.
*---------------------------------------------------------------------------------------------------------------------------------

*SE24 can be used to create global classes. Such classes are reusable within the entirety of the system without being limited to the
*local program. The class has a single attribute of 'count' which is a private field. It has the 'Associated Type' of 'INT_5' as this
*is one of the predefined data types available. It translates to 'number field, 5 positions'.
*The class has three methods: set, increment, get (all public). Upon having selected one of the methods, Parameter button can be
*pushed to define the method's parameters. Set method has the parameter of 'set_value' as an importing one of the 'Associated Type'
*of 'INT_5'. Get method has the 'get_value' of the same 'Associated Type' but as an exporting one instead.
*All three methods has a line of code written for them (upon dobule-clicking the name an ABAP editor fires up).

*'number' refers to the data type used within my class. 'cnt' is the object of my global class.
DATA: number TYPE int_5 VALUE 3,
      cnt    TYPE REF TO ZCL_BM_TEST_COUNTER.

START-OF-SELECTION.
CREATE OBJECT cnt.

CALL METHOD cnt->set EXPORTING set_value = number.

DO 3 TIMES.
  CALL METHOD cnt->increment.
ENDDO.

CALL METHOD cnt->get IMPORTING get_value = number.

WRITE number.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*CREATING AN XML -> TRANSFORMATION.
*---------------------------------------------------------------------------------------------------------------------------------

*'CALL TRANSFORMATION' allows me to create an XML out of the provided input and saves it on my machine.

DATA: dev_name    TYPE c LENGTH 22,
      dev_surname TYPE c LENGTH 22,
      dev_age     TYPE i,
      dev_job     TYPE c LENGTH 44.

DATA: developer_xml_xstr TYPE xstring.

START-OF-SELECTION.
dev_name    = 'Dazikiri'.
dev_surname = 'Anikar'.
dev_age     = 33.
dev_job     = 'SAP/ABAP Developer'.

CALL TRANSFORMATION ID
     SOURCE name    = dev_name
            surname = dev_surname
            age     = dev_age
            job     = dev_job
     RESULT XML developer_xml_xstr.

cl_abap_browser=>show_xml( xml_xstring = developer_xml_xstr ).

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*UPLOADING DATA FROM A TEXT FILE INTO A SAP DATABASE.
*---------------------------------------------------------------------------------------------------------------------------------

*BDC -> Batch Data Communication. It is used for migrating the data from non-SAP systems (legacy systems) to a SAP system. The file
*can be either on a local system or an application server. in both scenarios, data need to be migrated to an internal table from which
*it will be moved to a database table.
*There are many BDC techniques.

*DIRECT INPUT METHOD.
*With this method I am reading the data from the legacy system into my internal table and then straightforward into SAP sysem without
*any validation on the way. I need to understand what data I am going to migrate and what are the corresponding tables I will use.
*If I am going to migrate customer master data, KNA1 it is. KNA1 has 215 fields, but the data to be migrated has only 3 per record. I
*need to realize what fields I will populate.
*In order to read data from a local text file, SAP has provided a function module 'GUI_UPLOAD' - it is used to read data from a local
*text file to an internal table.

*I want a user to provide me the filename in runtime.
PARAMETERS p_fname TYPE string.

*SAP has provided a function module - 'F4_FILENAME', that can be used to display the open dialogue box from which the user can pick
*the correct file.
*'v_path' is a varialbe of the same data type as the path to the file selected by the user in the open dialogue box.
DATA: v_path TYPE IBIPPARMS-PATH.

*The data will require reading from the selected file and placed within an internal table. A function module of 'GUI_UPLOAD' will be
*used for that. Below are data structures for it.
*I am migrating records with three fields each - customer number, country and name. They make a single string.
TYPES: BEGIN OF t_temp,
  str TYPE string,
END OF t_temp.

DATA: it_temp TYPE TABLE OF t_temp,
      wa_temp TYPE t_temp.

*The intermediate structure for the transfer of the data from the internal table into which the data was initially uploaded into
*the SAP database.
TYPES: BEGIN OF t_final,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kan1-land1,
  name1 TYPE kna1-name1,
END OF t_final.

DATA: it_final TYPE TABLE OF t_final,
      wa_final TYPE t_final.

*Upon pressing F4 I want a dialogue box open. AT SELECTION-SCREEN ON VALUE-REQUEST FOR... is an event triggered upon pressing F4.
*F4 is responsible for opening the "available options' list" (a button with two white sheets next to a parameter field).
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_fname.
CALL FUNCTION 'F4_FILENAME'
 IMPORTING
   FILE_NAME = v_path.

*If the reading was successful and my variable is not empty - then the parameter variable assumes the value of it and thus is the
*parameter provided with a value (that's basically just an alternative to providing the input manually).
IF v_path IS NOT INITIAL.
  p_fname = v_path.
ENDIF.

*START-OF-SELECTION is triggered when I click the execute button. The AT SELECTION-SCREEN ON VALUE REQUEST FOR... was used for the
*choosing of the file (fires up when F4 is pressed). When I have my file prepared (input provided), then I am executing the program
*to actually read the data and so it is defined within the START-OF-SELECTION.
*Previously, I had data structures defined for 'GUI_UPLOAD' just above the comments here and SAP was, rightly so, saying it sees no
*'it_temp' declared... because above there there's AT SELECTION-SCREEN ON VALUE-REQUEST FOR... event present and it fires up only
*when F4 is pressed on the selection screen. So 'it_temp' would appear only after doing so.
*If the records within the text file were not separated by a comma (as is the case with the sample file being used here), but by
*a tab, I could forego the temporary internal table of 'it_temp' that takes in the records as strings in order to split them within
*my program's logic, and just use one of the components of the EXPORTING section of 'GUI_UPLOAD' - that is the
*'HAS_FIELD_SEPARATOR = 'X''. With it, the file is expected to have the records divided into 'fields' by a tab already.
START-OF-SELECTION.
IF p_fname IS NOT INITIAL.
  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename                      = p_fname
    TABLES
      data_tab                      = it_temp.
*ELSE will be triggered if there's no file chosen (if p_fname IS initial).
ELSE.
  MESSAGE 'Please, choose a file.' TYPE 'I'.
ENDIF.

*The data from the file should now be present within 'it_temp' and need to be moved into SAP's database. In order to modify the
*database table with the data provided by the internal table, I can use the MODIFY keyword. The INSERT could also be used, but if
*there are any duplicates within my internal table, I will get a runtime error.
*A simple 'MODIFY kna1 FROM TABLE it_temp.' will not be enough, because these tables are not compatible. KNA1 has 215 fields, but
*my internal table has only a single field.
*'it_temp' is a table without a header line, so I loop the data into the Working Area and then split every string (for now,
*all records are in the form of a single string) into the proper fields of the internal table that's compatible with the KNA1
*database table. Then, I am appending the final work area's content (a row at a time) to the final internal table.
IF it_temp IS NOT INITIAL.
  LOOP AT it_temp INTO wa_temp.
    CLEAR wa_final.
    SPLIT wa_temp-str AT ',' INTO
                               wa_final-kunnr
                               wa_final-land1
                               wa_final-name1.
    APPEND wa_final TO it_final.
    
*Still, I cannot do a simple 'MODFIY kna1 FROM TABLE it_final' due to the discrepancy in the number of fields. Thus, if the final
*internal table is filled with values, I am declaring yet another internal table, this time of the same type as the database table
*I want the data inserted into.
    IF it_final IS NOT INITIAL.
      DATA: gt_final TYPE TABLE OF kna1,
            gs_final TYPE kna1.
*To move the data from the final internal table to the one of the same structure as KNA1.
      LOOP AT it_final INTO wa_final.
        CLEAR gs_final.
        gs_final-kunnr = wa_final-kunnr.
        gs_final-land1 = wa_final-land1.
        gs_final-name1 = wa_final-name1.
        APPEND gs_final TO gt_final.
    ENDIF.

*If the table of the KNA1's structure has values, then I am moving the data into KNA1. 'sy-dbcnt' contains the number of records
*that were affected by my meddling.
    IF gt_final IS NOT INITIAL.
      MODIFY kna1 FROM TABLE gt_final.
      WRITE: 'The number of records inserted is: ', sy-dbcnt.
    ENDIF.
ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*DATABASE DATA RETRIEVAL - SELECT SINGLE. NO INTERNAL TABLE. LOCAL FIELDS NOT REFERING TO DATABASE TABLE'S FIELDS.
*---------------------------------------------------------------------------------------------------------------------------------

*My variables reflect the fields within the database table in terms of the data type and the length.
DATA: f1(10) TYPE c,
      f2(3)  TYPE c,
      f3(35) TYPE c,
      f4(35) TYPE c.

PARAMETERS: p_cstno(10) TYPE c.

*SELECT SINGLE is an OpenSQL statement used for retrieving a single record from the database table. Whenever used,
*it is recommended to use WHERE clause in the query comparing a primary key field to ensure the appropriate record
*is loaded.
SELECT SINGLE kunnr land1 name1 name2
  FROM kna1
  INTO (f1, f2, f3, f4)
  WHERE kunnr = p_cstno.

*'sy-subrc' contains the information about the execution status of ABAP statements. 0 means success, 4 means failure.
IF sy-subrc = 0.
  MESSAGE 'Customer found!' TYPE 'I'.
  WRITE: / 'Customer number:', f1,
         / 'Customer country:', f2,
         / 'Customer name:', f3,
         / 'Customer city:', f2.
ELSE.
  MESSAGE 'Customer not found!' TYPE 'I'.
ENDIF.
  
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*DATABASE DATA RETRIEVAL - SELECT SINGLE. NO INTERNAL TABLE. WORK AREA.
*---------------------------------------------------------------------------------------------------------------------------------

PARAMETERS p_kunnr TYPE kna1-kunnr.

TYPES: BEGIN OF t_customer,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kna1-land1,
  name1 TYPE kna1-name1,
  ort01 TYPE kna1-ort01,
END OF t_customer.

*Work area is a collection of fields. It is a single row of whatever structure it is based on.
DATA: wa_customer TYPE t_customer.

SELECT SINGLE kunnr land1 name1 ort01
  FROM kna1
  INTO wa_customer
  WHERE kunnr = p_kunnr.
IF sy-subrc = 0.
  WRITE: / 'Customer ', p_kunnr, ' is found:'.
  WRITE: / 'Customer number: ', wa_customer-kunnr,
         / 'Customer country: ', wa_customer-land1,
         / 'Customer name: ', wa_customer-name1,
         / 'Customer city: ', wa_customer-ort01.
ELSE.
  WRITE: 'Cutomer number ', p_kunnr, ' not found.'.
ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*DATABASE DATA RETRIEVAL - NATIVE SQL.
*---------------------------------------------------------------------------------------------------------------------------------

PARAMETERS p_kunnr TYPE kna1-kunnr.

DATA: v_kunnr TYPE kna1-kunnr,
      v_land1 TYPE kna1-land1,
      v_name1 TYPE kna1-name1,
      v_ort01 TYPE kna1-ort01.

*Native SQL statements are embbeded within EXEC SQL and ENDEXEC statements. Every database has its own native SQL statements.
*The below ones are HANA's. The fields need to be separated with a comma.
*INTO clause does not require the brackets, if I am mentioning all fields separately, but a colon (called "a binding operator)
*is required as a prefix for every field. The field I am comparing the data from the database table to also needs to be prefixed
*with a colon and there is no full stop at the end.
*Using native SQL is not recommended - if a database is changed, all SQL statements would need to be changed too. It's better
*to use OpenSQL instead.
EXEC SQL.
  SELECT kunnr, land1, name1, ort01
    FROM kna1
    INTO :v_kunnr, :v_land1, :v_name1, :v_ort01
    WHERE kunnr = :p_kunnr
ENDEXEC.

IF sy-subrc = 0.
  WRITE: / 'Customer number: ', p_kunnr, ' found.'.
  WRITE: / 'Customer number: ', v_kunnr,
         / 'Customer country: ', v_land1,
         / 'Customer name: ', v_name1,
         / 'Customer city: ', v_ort01.

ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*DATABASE DATA RETRIEVAL - MULTIPLE RECORDS. INTERNAL TABLE.
*---------------------------------------------------------------------------------------------------------------------------------

*If I am not selecting a single record by design, I might load multiple record. Thus, my target variable needs to be an internal
*table. All country keys defined within SAP are stored within 'T005' database table.
PARAMETERS p_land1 TYPE kna1-land1.

*It is recommended that the fields of the internal table are declared in the same sequence as they are within the database table
*as this will slightly improve the performance.
TYPES: BEGIN OF t_customer,
  kunnr TYPE kna1-kunnr,
  name1 TYPE kna1-name1,
  ort01 TYPE kna1-ort01,
END OF t_customer.

DATA: lt_customer TYPE STANDARD TABLE OF t_customer,
      wa_customer TYPE t_customer.

START-OF-SELECTION.
  PERFORM get_customers.

*&---------------------------------------------------------------------*
*&      Form  GET_CUSTOMERS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
*The sequence of fields should reflect the sequence of fields within the database table for the performance's improvement.
*I want to know the number of records retrieved. I can count the number of records within the internal table with the
*DESCRIBE statement which will count the number of records and store it in the system field 'sy-tfill'. I can also use
*another system variable - 'sy-dbcnt'. It will hold the number of records retrieved by my SELECT statement. I should use
*it immediately after the SELECT statement. So the difference is that 'sy-dbcnt' has to be used after the SELECT because
*the next one will change its value and the combination of DESCRIBE TABLE and sy-tfill allow me to refer to any table
*anywhere.
*By using the INTO TABLE I am making the retrieved data sit directly in the body of the table. This process omit the
*work area - the debugger shows that the work area remains empty while the internal table is filled.
*I am additionally SORTing the results before they are displayed with the SORT keyword. I could also sort them during
*the SELECT statement by using ORDER BY, but this approach is discouraged as it performs the sorting on the database
*level increasing the load on the database. It is better to get the desired data into the internal table and SORT it
*based on one of the internal table's fields.
*The WHERE clause could contain different conditions, e.g. using the keyword OR:
* - WHERE land1 = 'PL' OR land1 = 'DE' OR land1 = 'EN'...
*Or a range of values:
* - WHERE land1 IN ('PL', 'DE', 'EN')...
*The 'equal to' operator ('=') should be used when I am comparing to exactly one value. If I have a set, I should use
*the IN operator.
FORM get_customers.
  SELECT kunnr name1 ort01
    FROM kna1
    INTO TABLE lt_customer
    WHERE land1 = p_land1.
  IF sy-subrc = 0. "At least one record is retrieved.
*The first way of counting the number of records within a table:
    WRITE: / 'The number of records found using sy-dbcnt is: ', sy-dbcnt.
*The second way of counting the number of records within a table:
    DESCRIBE TABLE lt_customer.
    WRITE: / 'The number of records found using DESCRIBE TABLE and sy-tfill is: ', sy-tfill.
    SORT lt_customer BY name1.
    LOOP AT lt_customer INTO wa_customer.
      WRITE: / wa_customer-kunnr,
               wa_customer-name1,
               wa_customer-ort01.
    ENDLOOP.
  ELSE.
    MESSAGE 'No data was found for the provided country key.' TYPE 'I'.
  ENDIF.
ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*DATABASE DATA RETRIEVAL - CUSTOM F4 HELP. MODIF ID.
*---------------------------------------------------------------------------------------------------------------------------------

*I want a program to take the material number as input, complete with having F4 help associated and then, if the material was found,
*make the second block visible and fill all its input fields with data associated to the selected and found material number.
  SELECTION-SCREEN BEGIN OF BLOCK bk1 WITH FRAME TITLE t1.
*I want a single line. Without this "line block", the comment and the parameter would be in different lines. If the COMMENT is in the
*same line as a parameter - it assumes the place of the name 'p_matnr'. If they're in two different lines, I would still see 'p_matnr'
*next to the input box, but when the COMMENT is in the same line, 'p_matnr' is gone.
*By creating a parameter of the database table's field's type I am ensuring there will be F4 help by default. If the data element is associated
*with the search help at a database level - the same search help will be associated with my program's selection screen's variable. I can see
*within the database table itself if a field has help associated with it. To do this I should navigate to the details of a particular data
*element and check the Further Characteristics tab - 'matnr' for example has the value of 'S_MAT1' associated with it and mentioned in the
*help box.
*I can overwrite the automated F4 help mechanism by defining custom behaviour withint the AT SELECTION-SCREEN ON VALUE REQUEST FOR block.
*If I so much as define the event without anything afterwards - the default behaviour will already not function.
  SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT 6(15) lb1.
  PARAMETERS p_matnr TYPE mara-matnr MODIF ID id2.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN END OF BLOCK bk1.

  SELECTION-SCREEN SKIP 1.

*I want the entire block two invisible. It consists of 7 elements - the block itself, the three labels and the three input boxes.
*Thus, all these elements are supposed to have a common property. I can group these elements - with a MODIF ID. This is an addition
*that is used to group screen elements together. MODIF ID saves the name of the group (however I name it) within 'group1' field
*of the 'screen' internal table.
*This block is to become visible when the first parameter ('p_matnr') has been found and the pusbutton has been pressed. All the
*input fields of this block are to be filled with the data associated to the selected material number ('p_matnr').
  SELECTION-SCREEN BEGIN OF BLOCK bk2 WITH FRAME TITLE t2.

  SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT 6(15) lb2 MODIF ID id1.
  PARAMETERS p_mtart TYPE mara-mtart MODIF ID id1.
  SELECTION-SCREEN END OF LINE.

  SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT 6(15) lb3 MODIF ID id1.
  PARAMETERS p_mbrsh TYPE mara-mbrsh MODIF ID id1.
  SELECTION-SCREEN END OF LINE.

  SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT 6(15) lb4 MODIF ID id1.
  PARAMETERS p_matkl TYPE mara-matkl MODIF ID id1.
  SELECTION-SCREEN END OF LINE.

  SELECTION-SCREEN END OF BLOCK bk2.

  SELECTION-SCREEN SKIP 1.

  SELECTION-SCREEN PUSHBUTTON 1(20) b1 USER-COMMAND fc1.

*Data for the 'F4IF_INT_TABLE_VALUE_REQUEST' FM to create my custom list of values for the F4 help.
TYPES: BEGIN OF t_f4values,
  matnr TYPE mara-matnr,
  mtart TYPE mara-mtart,
END OF t_f4values.

DATA: lt_f4values TYPE STANDARD TABLE OF t_f4values,
      wa_f4values TYPE t_f4values.

INITIALIZATION.
  lb1 = 'Material number'.
  t1 = 'Input block'.
  lb2 = 'Material type'.
  lb3 = 'Industry sector'.
  lb4 = 'Material group'.
  t2 = 'Material data'.
  b1 = 'Get Material Data'.

*By default, I want the second block invisible.
  PERFORM make_bk2_inv.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_matnr.
*In order to have 'lt_f4values' filled with data.
  PERFORM get_f4_values.

*In order to establish a custom F4 help - with my custom values, I need to use a standard FM. 'F4IF_INT_TABLE_VALUE_REQUEST'
*is always used for that purpose.
*'retfield' - is the field I want "returned" which is the field for which the F4 help is supposed to be. It refers to the field
*within the created table of values. 'retfield' and 'lt_f4values' are the only obligatory elements of the FM, but just providing
*'retfield' will not suffice - the program will claim there are no results within the table (although they are there!).
*I also need to provide a few "optional" fields for the FM to function properly:
*- 'dynpprog' is the name of the program where the help is supposed to be used.
*- 'dynpnr' refers to the screen number. The selection screen's number is always 1000 though.
*- 'dynprofield' points to the screen's field which is to be populated with the found value. I want my input field to be filled,
*  so 'p_matnr' it is.
*Without the above, the value selected from the F4 Help list will not be moved to the input field when I double-click my chosen one.
*- 'value_org' refers to the way the data is transferred. 'S' means 'structure'. Without it, the program will believe there are
*no values found.
  IF lt_f4values IS NOT INITIAL.
    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
      EXPORTING
        retfield               = 'MATNR'
        dynpprog               = sy-repid
        dynpnr                 = sy-dynnr
        dynprofield            = 'P_MATNR'
        value_org              = 'S'
      TABLES
        value_tab              = lt_f4values
     EXCEPTIONS
       PARAMETER_ERROR        = 1
       NO_VALUES_FOUND        = 2
       OTHERS                 = 3.
    IF sy-subrc <> 0.
*   Implement suitable error handling here
    ENDIF.
  ENDIF.

*AT SELECTION-SCREEN event is triggered e.g. when a pushbutton in the selection screen is pushed. I have a USER-COMMAND 'fc1'
*associated with the button, so 'sy-ucomm' will catch that name.
*If the material number has been found - the input fields of the second block are to filled with data associated with the
*material number. If the material is not found, the input fields of the second block are being cleared just in case a material
*number has been found previously and these fields still hold values. Thanks to the CLEAR - there will be no misconception here.
AT SELECTION-SCREEN.
  CASE sy-ucomm.
    WHEN 'FC1'.
      IF p_matnr IS NOT INITIAL.
        SELECT SINGLE mtart mbrsh matkl
          INTO (p_mtart, p_mbrsh, p_matkl)
          FROM mara
          WHERE matnr = p_matnr.
          IF sy-subrc = 0.
            MESSAGE 'Material found!' TYPE 'I'.
          ELSE.
            MESSAGE 'Material not found!' TYPE 'I'.
            CLEAR: p_mtart,
                   p_mbrsh,
                   p_matkl.
          ENDIF.
      ENDIF.
  ENDCASE.

START-OF-SELECTION.
  WRITE: / 'You entered ', p_matnr.

*&---------------------------------------------------------------------*
*&      Form  MAKE_BK2_INV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM make_bk2_inv.
*During the execution of every program, SAP internally creates an internal table - 'screen'. I can iterate through it and update it
*in order to control the appearance of the screen. The value of 'group1' field is saved in capital letters - it has to be 'ID1'
*because 'id1' will not work.
*'screen-invisible = 1' will make labels and comments invisible, but input fields will still be there. 'screen-invisible = 1' is sufficient
*for checkboxes, blocks and radiobuttons too, but not for input fields, so until they are made invisible too - a block will still be visible.
*It would be invisible, but a few of its elements are still visible, so it can't be invisible itself.
*To make input fields invisible to, I need to set 'screen-input' to '0'.
*Without it - input fields will not be invisible and will just come in the encrypted format (input will be stars).
*When AT SELECTION-SCREEN event is triggerd all the elements become visible automatically again. The idea is to initially make blocks invisible
*in the INITIALIZATION and then any modifications perform in the AT SELECTION-SCREEN OUTPUT making sure every time that screen elements that are
*to remain invisible receive the confirmation they are to remain invisible, e.g. IF...screen-invisible = '1'. ELSEIF...screen-invisible = '0'.
  LOOP AT SCREEN.
    IF screen-group1 = 'ID1'.
      screen-invisible = '1'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  GET_F4_VALUES
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
*I want just two fields to be available in my custom F4 help. I also only want limited data (WHERE clause). The selection of the help
*is to be limited, because it's a functionality that's supposed to provide the user with values they can choose from. And the set
*of values I want them to be able to choose from is limited.
*I want the F4 help to show me two columns - 'matnr' and 'mtart'.
FORM get_f4_values .
  SELECT matnr mtart
    FROM mara
    INTO TABLE lt_f4values
    WHERE mtart IN ('WGOT', 'SPOM').
ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*MOVING DATA BETWEEN TWO INTERNAL TABLES. FOR LOOP, VALUE.
*---------------------------------------------------------------------------------------------------------------------------------

TYPES: BEGIN OF t_tab1,
  number          TYPE i,
  name(25)        TYPE c,
  occupation(25)  TYPE c,
  sex             TYPE c,
  fav_pokemon(20) TYPE c,
  fav_food(25)    TYPE c,
END OF t_tab1.

TYPES: BEGIN OF t_tab2,
  number          TYPE i,
  name(25)        TYPE c,
  sex             TYPE c,
  fav_pokemon(20) TYPE c,
END OF t_tab2.

DATA: lt_tab1 TYPE STANDARD TABLE OF t_tab1,
      wa_tab1 TYPE t_tab1,
      lt_tab2 TYPE STANDARD TABLE OF t_tab2,
      wa_tab2 TYPE t_tab2,
      flag    TYPE c VALUE 1.

PERFORM populate_lt_tab1.

*A one line version.
lt_tab2 = VALUE #( FOR lmao IN lt_tab1 ( CORRESPONDING #( lmao ) ) ).

*A longer version.
*lt_tab2 = VALUE #( FOR lmao IN lt_tab1 ( number      = lmao-number
*                                         name        = lmao-name
*                                         sex         = lmao-sex
*                                         fav_pokemon = lmao-fav_pokemon ) ).

PERFORM print_results TABLES lt_tab1 USING flag.
flag = 0.
PERFORM print_results TABLES lt_tab2 USING flag.

*&---------------------------------------------------------------------*
*&      Form  POPULATE_LT_TAB1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM populate_lt_tab1 .
  wa_tab1-number         = 123.
  wa_tab1-name           = 'Nezuko'.
  wa_tab1-occupation     = 'Developer'.
  wa_tab1-sex            = 'F'.
  wa_tab1-fav_pokemon    = 'Dedenne'.
  wa_tab1-fav_food       = 'Blueberry'.
  APPEND wa_tab1 TO lt_tab1.

  wa_tab1-number         = 537.
  wa_tab1-name           = 'Abydon'.
  wa_tab1-occupation     = 'Developer'.
  wa_tab1-sex            = 'M'.
  wa_tab1-fav_pokemon    = 'Cyndaquil'.
  wa_tab1-fav_food       = 'Broccoli'.
  APPEND wa_tab1 TO lt_tab1.

  wa_tab1-number         = 333.
  wa_tab1-name           = 'Halibel'.
  wa_tab1-occupation     = 'Developer'.
  wa_tab1-sex            = 'F'.
  wa_tab1-fav_pokemon    = 'Cubone'.
  wa_tab1-fav_food       = 'Tomato'.
  APPEND wa_tab1 TO lt_tab1.

  wa_tab1-number         = 193.
  wa_tab1-name           = 'Bubik'.
  wa_tab1-occupation     = 'Developer'.
  wa_tab1-sex            = 'M'.
  wa_tab1-fav_pokemon    = 'Glaceon'.
  wa_tab1-fav_food       = 'Soy beans'.
  APPEND wa_tab1 TO lt_tab1.

  wa_tab1-number         = 666.
  wa_tab1-name           = 'Attalos'.
  wa_tab1-occupation     = 'Developer'.
  wa_tab1-sex            = 'M'.
  wa_tab1-fav_pokemon    = 'Poochyena'.
  wa_tab1-fav_food       = 'Peanut butter'.
  APPEND wa_tab1 TO lt_tab1.

  wa_tab1-number         = 578.
  wa_tab1-name           = 'Rokaro'.
  wa_tab1-occupation     = 'Developer'.
  wa_tab1-sex            = 'M'.
  wa_tab1-fav_pokemon    = 'Totodile'.
  wa_tab1-fav_food       = 'Cucumber'.
  APPEND wa_tab1 TO lt_tab1.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  PRINT_RESULTS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM print_results TABLES p_tab USING p_flag.
  DATA: p_wa_tab  TYPE t_tab1,
        p_wa_tab2 TYPE t_tab2.
IF flag = '1'.
  WRITE: 'The initial records of the first table:'.
  ULINE.
  LOOP AT p_tab INTO p_wa_tab.
    WRITE: / p_wa_tab-number,
             p_wa_tab-name,
             p_wa_tab-occupation,
             p_wa_tab-sex,
             p_wa_tab-fav_pokemon,
             p_wa_tab-fav_food.
  ENDLOOP.
  ULINE.
ELSE.
  WRITE: 'The records moved to the second table:'.
  ULINE.
  LOOP AT p_tab INTO p_wa_tab2.
    WRITE: / p_wa_tab2-number,
             p_wa_tab2-name,
             p_wa_tab2-sex,
             p_wa_tab2-fav_pokemon.
  ENDLOOP.
  ULINE.
ENDIF.
ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*DATABASE DATA RETRIEVAL - SELECT SINGLE. NO INTERNAL TABLE. FIELDS REFERING TO DATABASE TABLE'S FIELDS.
*---------------------------------------------------------------------------------------------------------------------------------

*My variables reflect the fields within the database table in terms of the data type and the length... BUT this is a "dangerous"
*way of declaring the variables. The data types within the database table might change and my variables here will not refelect that.
*DATA: f1(10) TYPE c,
*      f2(3)  TYPE c,
*      f3(35) TYPE c,
*      f4(35) TYPE c.

*Instead, I should create my variables to be of the same data element as the fields within the database table I am interested in.
*Thus, if, say, KUNNR is changed by SAP one day, my variables will reflect the change as well.
*DATA: f1 TYPE kunnr,
*      f2 TYPE land1_gp,
*      f3 TYPE name1_gp,
*      f4 TYPE ort01.

*I can also prefix every data element name with the name of the table from which the field will be taken. I am refering to the
*names of the fields of the table in this case, not the names of data elements themselves.
*Both ways of refering to the database table's fields are recommended. It is also recommended to name my program's fields the
*same as the database table's fields the type of which they are.
DATA: kunnr TYPE kna1-kunnr,
      land1 TYPE kna1-land1,
      name1 TYPE kna1-name1,
      ort01 TYPE kna1-ort01.

*The limitation to declaring a parameter like that is that I will not have an F4 help by default.
*PARAMETERS: p_cstno(10) TYPE c.

*Creating a parameter in a more specific way I am ensuring there will be F4 help by default. If the data element is associated
*with the search help at a database level - the same search help will be associated with my program's selection screen's variable.
PARAMETERS: p_kunnr TYPE kna1-kunnr.

*SELECT SINGLE ensures I will only get a single record. This is ensured by refering to the primary key field in the WHERE clause.
*A primary key field is a guarantee I will not have duplicate entries.
SELECT SINGLE kunnr land1 name1 name2
  FROM kna1
  INTO (kunnr, land1, name1, ort01)
  WHERE kunnr = p_kunnr.

*'sy-subrc' contains the information about the execution status of ABAP statements. 0 means success, 4 means failure.
IF sy-subrc = 0.
  MESSAGE 'Customer found!' TYPE 'I'.
  WRITE: / 'Customer number:', kunnr,
         / 'Customer country:', land1,
         / 'Customer name:', name1,
         / 'Customer city:', ort01.
ELSE.
  MESSAGE 'Customer not found!' TYPE 'I'.
ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*CDS VIEWS. EMPLOYEES REPORT.
*---------------------------------------------------------------------------------------------------------------------------------

*As the CDS view I have created does not have a key, WITH EMPTY KEY is required.
DATA: lt_so_emp_cdsv TYPE STANDARD TABLE OF z_cdsview_demo01 WITH EMPTY KEY.

*Instead of the below, I could also declare the data within the syntax of the select:
*"(...) into table @Data(lt_so_emp_cdsv)."
*Using OpenSQL like that allows me to get the data stored within the CDS view.
SELECT * FROM z_cdsview_demo01 INTO TABLE lt_so_emp_cdsv.

*This is a standard SAP class used for the displaying of the output.
cl_demo_output=>display(
    EXPORTING
        data = lt_so_emp_cdsv
        name = 'so and employees list' ).
		
*********************************************
*THE CDS VIEW.
*********************************************
@AbapCatalog.sqlViewName: 'Z_CDSView_DEMO01' //The name needs to be shorter than 16 characters' long.
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'demo view 1'
define view Z_DEMO_JOIN_01 as select from snwd_so
inner join snwd_employees
on snwd_so.created_by = snwd_employees.node_key {
    
	//With the inner join displayed will be what's common for both the tables.
    //Only the fields that match the criteria ("on" section) will be displayed.
    //There needs to be a match between both tables for them to be displayed.
    //If there is no match both tables' data for that particular row is omitted.
    snwd_so.so_id,
    snwd_so.gross_amount,
    snwd_employees.first_name,
    snwd_employees.last_name,
    snwd_employees.email_address
    
}

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*CDS VIEWS. EMPLOYEES AND BUSINESS PARTNERS REPORT.
*---------------------------------------------------------------------------------------------------------------------------------

DATA: lt_so_emp_cdsv TYPE STANDARD TABLE OF z_cdsview_demo02 WITH EMPTY KEY.

SELECT * FROM z_cdsview_demo02 INTO TABLE lt_so_emp_cdsv.

cl_demo_output=>display(
    EXPORTING
        data = lt_so_emp_cdsv
        name = 'so, employees and business partners list' ).
		
*********************************************
*THE CDS VIEW.
*********************************************
@AbapCatalog.sqlViewName: 'Z_CDSView_DEMO02'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Demo SO Emp and Business Partner'
define view Z_DEMO_JOIN_02 as select from snwd_so 
 //On the stage of the left outer join the data will already have been
 //filtered by the inner join. The result of the inner join will undergo
 //the left outer join.
    inner join snwd_employees
        on snwd_so.created_by = snwd_employees.node_key
 //Left outer join - all the fields in the first table, if found in the
 //second table - the join will happen (based on the joining condition).
 //If there's no match in the second table, the first table's data will
 //be added to the output matched with nulls on the other side.
 //The left outer join is done when the left table's data is required even
 //when there's no match in the right table.   
    left outer join snwd_bpa
        on snwd_so.buyer_guid = snwd_bpa.node_key {
    
    snwd_so.so_id,
    snwd_so.gross_amount,
    snwd_so.currency_code,
    snwd_employees.first_name,
    snwd_employees.last_name,
    snwd_bpa.bp_id as bus_par_id, //The id of the business partner with an alias.
    snwd_bpa.email_address as bus_par_email //The email of the business partner with an alias.
    
}

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*CDS VIEWS. PURCHASE ORDERS.
*---------------------------------------------------------------------------------------------------------------------------------

*********************************************
*PURCHASE ORDER HEADER CDS VIEW.
*********************************************
//Specifies the view in the database.
@AbapCatalog.sqlViewName: 'ZIPurHdr1'
//The filter conditions of the path expression are compared. If they are the same, the associated join expression 
//is evaluated only once. If the compareFilter is false, then the associate part is evaluated over and over again.
@AbapCatalog.compiler.compareFilter: true
//CDS View specifies the definition of the key fields to be the same as that of the associated database table's.
@AbapCatalog.preserveKey: true
//The authorization check for the view is required. It is a default behaviour and, if that annotation is not specified,
//the CDS View acts as if it is and its value is #CHECK.
@AccessControl.authorizationCheck: #CHECK
//Specifies the label for the CDS View.
@EndUserText.label: 'Purchase Order Header'
//VDM is intended to be interpreted by view browsers and other functionality which is based on the virtual data model.
//A Basic view is directly above the database and only Basic views are allowed to select from the database.
@VDM.viewType: #BASIC
//To expose the view as an oData service. This annotation will create the service for the view in the system.
@OData.publish: true
//The client handling's type is inherited, so it's inherited from the underlying data sources.
//#AUTOMATED means I don't want to specify from which client I want to inherit, but it should
//be done automatically - so the client will be the same in which the view is executed.
//ClientHandling annotations usually are specified only when I need to set a specific behaviour, different
//from a default one.
@ClientHandling.type: #INHERITED
@ClientHandling.algorithm: #AUTOMATED
define view ZI_PurOrderHdr as select from ekko 
 //The purchase order header can have 0 or more purchase items, so the cardinality is from 0 to many.
 //The associated CDS View can have a minimum of 0 and a maximum of unlimitied entries. In my case, there might be 
 //no purchase order items for my header CDS View or there can be an unlimited number of purchase order items.
 //"to" is the equivalent of "from". "on $projection." is a join condition - the "projected" field maps to the
 //associated table's field of(...).  The naming convention is that the alias for the association should always start with the underscore.
    association [0..*] to ZI_PurOrderItem as _POItem on $projection.PurchaseOrder = _POItem.PurchaseOrder
{

//The key field for the CDS View (the same as the key field of the purchase table itself).
//The aliases used will become the names of the columns.
    key ebeln as PurchaseOrder,
//PurchaseOrderTypes' name's are just short codes. I can replace these codes with custom names to improve
//the understanding of their meanings. A case statement can be used for it.
//First, I specify the operand which I want evaluated ('bsart' in the bracket). After "when" comes the
//condition and after "then" comes the result. The result of the case comes as the field specified after
//the "as" keyword.
//The below section with "case" replaced a simple "bsart as PurchaseOrderType,".
            case(bsart)
                when 'RQ' then 'External Quotation'
                when 'UB' then 'Stock transport order'
                else 'Other order'
            end as PurchaseOrderType,
        ekorg as PurOrganization,
        ekgrp as PurGroup,
        lifnr as Supplier,
        waers as DocCurrency,
        aedat as CreationDate,
        rlwrt as TotalValue,
//I can use a function to convert currencies. There are mandatory parameters to be provided.
//'target_currency' requires a 'waers' not a CHAR, so 'USD' has to be cast. 'cuky' is the
//data element type of the 'waers'.
        currency_conversion( amount => rlwrt, 
                             source_currency => waers,
                             target_currency => cast ('USD' as abap.cuky ),
                             exchange_rate_date => aedat ) as TotalUSDValue,
//The annotation here is "exposing the association". Purchase Order Item CDS View is the child view here.
//Since the association is exposed, the OData service (courtesy of @OData(...)) will receive the association's
//metadata. It also allows the user of the CDS View to access other fields of the exposed associated table than
//just those mentioned in this CDS View's select.
        @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
        _POItem
    
}

*********************************************
*PURCHASE ORDER ITEMS CDS VIEW.
*********************************************
@AbapCatalog.sqlViewName: 'ZIPurItm1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Order Item'
define view ZI_PurOrderItem as select from ekpo
 //One purchase order item can belong to just a single purchase order header hence the
 //cardinality is 1 to 1.
    association [1..1] to ZI_PurOrderHdr as _POHdr on $projection.PurchaseOrder = _POHdr.PurchaseOrder
//An additional association to a material providing CDS View. For each purchase order item there is only
//one material, hence the cardinality.
    association [1..1] to Z007_DEMO_ASSOCIATION as _Material on $projection.Material = _Material.Material
{
    
    key ebeln as PurchaseOrder,
    key ebelp as PurchaseOrderItem,
        matnr as Material,
//From the second association.
        _Material.MaterialType as MaterialType,
        txz01 as POItemText,
        matkl as MaterialGroup,
        werks as Plant,
        lgort as StorageLocation,
//A quantity field requires us to specify which field should be referred to for its unit. E.g. in
//'ekpo' 'menge' references 'meins' (from 'ekpo') as its unit. In CDS Views it's done with annotations.
//The quantity refers its units field by its name.
        @Semantics.quantity.unitOfMeasure: 'OrderUnit'
        menge as OrderQuantity,
//To inform the system that 'meins' contains the unit.
        @Semantics.unitOfMeasure: true
        meins as OrderUnit,
        netpr as NetPrice,
//Cast operations can be used for determining the type of the calculated field or for converting
//the type of the existing fields on the database level.
//The syntax starts from the specifying which field I want to cast and into what data type (what comes
//after the first "as"). In this case the data will be cast into abap floating type of the length of 16
//and multipled in order to have the tax amount included. The result is stored in the new field
//(TaxAmount) which does not exist in the database. Hence it's called a calculated field. I am
//adding a new field, not changing any existing one.
        cast( netpr as abap.fltp(16) ) * 0.35 as TaxAmount,
        netwr as NetOrderValue,
 //I can use arithmetic operations here as well, e.g. say I have a 25% discount  on the net value. 
 //"0.75" is a floating point type, so I need to cast the 'netwr' to a 'fltp' too. There's a lot
 //of trailing decimal places though.
        cast( netwr as abap.fltp(16) ) * 0.75 as DiscountedNetOrder,
//Numeric functions are also available. I can, e.g. round the DiscountedNetOrder in order to get rid
//of all the trailing decimal places. All the calculations in the CDS View are performed in the
//database layer, thus the application logic is pushed to the database layer.
        ceil(cast( netwr as abap.fltp(16) ) * 0.75) as DiscountedRoundedNetOrd,
//String functions can also be utilized.
        concat_with_space( werks, lgort, 1) as StorageDetails,
//Purchase order item is the child, so the header is the parent. The header is also the
//root view.
        @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
        _POHdr,
        _Material
       
}

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*CDS VIEWS. DCL - ACCESS CONTROL.
*---------------------------------------------------------------------------------------------------------------------------------

@EndUserText.label: 'DCL for Purchase Order'
//The below annotation means that this role is assigned implicitly for all the users. Currently,
//that's the only value that is supported.
@MappingRole: true
//Given how CDS Views' goal is to perform a pushdown of some of the weight of the calculations
//to the database level, if any authorization is required, it needs to be performed at the
//CDS View's level. Hence, a SAP has provided a new kind of a repository object - the undersigned,
//DCL Access Control (or, a role).
//It is a naming convention that a DCL object (Access Control) is named just like its CDS View.
//When data is selected from ZI_PURORDERHDR CDS View, this DCL will be executed automatically
//and will restrict data based on the Purchase Organization to which the user has access.
define role ZI_PURORDERHDR {
//This DCL provides a grant on a select from a ZI_PURORDERHDR CDS View.
    grant 
        select
            on
                ZI_PURORDERHDR
                    where
//There are two kinds of conditions that can be added to a DCL. The first one is the aspect condition.
//It allows me to use a standard authorization concept - 'M_BEST_EKO'. I am required to specify that 
//authorization object by using the statement 'aspect pfcg_auth'. There comes 'M_BEST_EKO' and it is 
//followed by a list of parameters for the authorization object itself.
//'PurOrganization' refers to one of the fields in the ZI_PURORDERHDR CDS View. The conditions means
//that only users having access to specific Purchase Organizations will see the desired data.
                        ( PurOrganization ) = aspect pfcg_auth( M_BEST_EKO, EKORG, actvt = '03' );
                        
}

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*CDS VIEWS. ASSOCIATIONS.
*---------------------------------------------------------------------------------------------------------------------------------

@AbapCatalog.sqlViewName: 'ZDEMOASSOCIATION'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'demo association'
define view Z007_DEMO_ASSOCIATION as select from mara {

    key matnr as Material,
        mtart as MaterialType,
        meins as BaseUnit
    
}

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*CDS VIEWS. UNIONS.
*---------------------------------------------------------------------------------------------------------------------------------

@AbapCatalog.sqlViewName: 'zuniondemo'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'demo union cds'
//A list of materials for which there is a purchase requisition or a purchase order for a specific plant.
//'eban' is a purchase requisition database table.
define view Z007_DEMO_UNION as select from eban {
    
    matnr as material
    
}
//A specific plant.
where werks = '0002'

//Union has selects from two different tables.
union

//To combine the materials from the purchase requisition table and the purchase order table (ekpo).
select from ekpo {

    matnr as material

}
where werks = '0002'

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*CDS VIEWS. JOINS.
*---------------------------------------------------------------------------------------------------------------------------------

@AbapCatalog.sqlViewName: 'zdemojoin'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'demo join cds'
//To get a list of purchase order items created from purchase requisitions. The purchase order item table (ekpo) has a purchase requisition
//reference in 'banfn' and 'bnfpo' (both are key fields for 'eban').
define view Z007_DEMO_JOIN as select from ekpo as po
//I want only the records from the purchase order table which are created from the purchase requisitions so an inner join it is.
inner join eban as pr
on po.banfn = pr.banfn
and po.bnfpo = pr.bnfpo {
    
    po.ebeln as PONum,
    po.matnr as Material,
    pr.banfn as PRNum,
    pr.bnfpo as PRItemNum
    
}

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*BALLOG. LOGGING THE INFORMATION ABOUT A FAILED DATABASE TABLE INSERTION ATTEMPT.
*---------------------------------------------------------------------------------------------------------------------------------

*A program adding a new record to a database table and making a ballog out of the process. Below is the section just for adding
*the record.
PARAMETERS: p_emp   TYPE zenumv2,
            p_name  TYPE zforenamev2,
            p_lname TYPE zsurnamev2.

DATA: wa_employees TYPE zpokemon.

START-OF-SELECTION.
  wa_employees-employee = p_emp.
  wa_employees-surname  = p_lname.
  wa_employees-forename = p_name.

INSERT zpokemon FROM wa_employees.
IF sy-subrc = 0.
  MESSAGE 'The record was successfully added.' TYPE 'I'.
*Below is the section required for the ballog. I am making a log in case a record has not been added to a database.
ELSEIF sy-subrc = 4.
  DATA: ls_header  TYPE bal_s_log,
        lt_handler TYPE bal_t_logh,
        lv_handle  TYPE balloghndl,
        lv_text    TYPE c LENGTH 50.

  ls_header-object    = 'ZBM_TEST5'.
  ls_header-subobject = 'ZBM_TEST5_SUB'.
  ls_header-extnumber = 'An employee inserting report log'.

*The creation of the ballog object itself.
  CALL FUNCTION 'BAL_LOG_CREATE'
    EXPORTING
      i_s_log                       = ls_header
    IMPORTING
      e_log_handle                  = lv_handle.

*An error message.
  lv_text = 'An employee of that number already exists in the database table.'.

  CALL FUNCTION 'BAL_LOG_MSG_ADD_FREE_TEXT'
    EXPORTING
      i_log_handle              = lv_handle
      i_msgty                   = 'E'
      i_text                    = lv_text.

  APPEND lv_handle TO lt_handler.

  CALL FUNCTION 'BAL_DB_SAVE'
    EXPORTING
      i_t_log_handle             = lt_handler.

  MESSAGE: lv_text TYPE 'E'.
ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*RANGES AND CONTROL BREAK EVENTS.
*---------------------------------------------------------------------------------------------------------------------------------

*RANGES is similar to SELECT-OPTIONS, but SELECT-OPTIONS generates the selection screen where the user can provide the range
*of values, but RANGES does not generate the selection screen. They have the same structure (sign, option, low and high). RANGES
*too is an internal table. RANGES are used when I am sure about the range and don't want the user to provide it - when I want to
*fetch data based on a fixed range.
RANGES r_vbeln FOR vbap-vbeln.

*To hold the results.
TYPES: BEGIN OF ty_sales_items,
  vbeln TYPE vbap-vbeln,
  posnr TYPE vbap-posnr,
  matnr TYPE vbap-matnr,
  netwr TYPE vbap-netwr,
END OF ty_sales_items.
DATA: it_sales_items TYPE TABLE OF ty_sales_items,
      wa_sales_items TYPE ty_sales_items.

START-OF-SELECTION.
*By providing a low and a high value and APPENDING it to the internal table (the range) multiple times, I can providing multiple
*ranges to my range - just like SELECT-OPTIONS allows for in the selection screen.
*SELECT-OPTIONS uses a default value for SIGN field ('I'), but RANGES do not have a default value here and it needs to be provided.
*The same goes for the OPTION field. SELECT-OPTIONS have a default value of 'BT' (between). RANGES expect me to provide the value
*manually.
r_vbeln-sign = 'I'.
r_vbeln-option = 'BT'.
r_vbeln-low = '0000004970'.
r_vbeln-high = '0000004975'.
APPEND r_vbeln.
r_vbeln-sign = 'I'.
r_vbeln-option = 'BT'.
r_vbeln-low = '0000004980'.
r_vbeln-high = '0000004985'.
APPEND r_vbeln.

PERFORM get_sales_items.
IF sy-subrc = 0.
  PERFORM display_sales_items.
ELSE.
  MESSAGE 'No sales items have been found in the provided range.' TYPE 'I'.
ENDIF.
*&---------------------------------------------------------------------*
*&      Form  GET_SALES_ITEMS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_sales_items.
*When I am using RANGES in the WHERE clause, much like with SELECT-OPTIONS, I need to use IN operator.
  SELECT vbeln posnr matnr netwr
    FROM vbap
    INTO TABLE it_sales_items
    WHERE vbeln IN r_vbeln.
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
  LOOP AT it_sales_items INTO wa_sales_items.
*AT FIRST is a control break event. It means that whenever the first record is being processed, this event is
*triggered.
*Control break events can only be used between LOOP and ENDLOOP.
    AT FIRST.
      FORMAT COLOR 1.
      WRITE: /15 'Sales documents item data with prices'.
      FORMAT COLOR OFF.
    ENDAT.
*AT NEW <data_element> is a control break event. Whenever a new 'vbeln' is encountered, the event will be triggered.
*It is similar to the ON CHANGE OF event. ON CHANGE OF is similarily triggered when there is a change with the given
*field's value. The difference is AT NEW event can only be used within LOOP-ENDLOOP. ON CHANGE OF event can be used
*within any of the looping statements (SELECT-ENDSELECT, WHILE-ENDWHILE, LOOP-ENDLOOP, etc).
    AT NEW vbeln.
      FORMAT COLOR 3.
      WRITE: / 'Sales document number: ', wa_sales_items-vbeln.
      FORMAT COLOR OFF.
    ENDAT.
    FORMAT COLOR 7.
    WRITE: /5 wa_sales_items-posnr,
             wa_sales_items-matnr,
             wa_sales_items-netwr.
    FORMAT COLOR OFF.
*AT END OF is a control break event. Whenever the control stops processing a 'vbeln' (many records could have had
*the same 'vbeln') I want the sum of the net value of all the items of the currently processed document displayed.
*SUM keyword will calculate the sum of all the numeric fields of the corresponding rows and store the summed value
*within the same field. So, combined with AT END OF vbeln event - it will sum up all the net values of all records
*with the same 'vbeln' and store them within the 'netwr' field for the duration of the event. When control leaves
*the event, the summed value will disappear from the 'netwr' field. 'vbeln' field is not being summed up because
*it's a character, not a numeric field.
*UNDER keyword will align the placement of the wa_sales_items-netwr with the placement of... wa_sales_items_netwr.
    AT END OF vbeln.
      SUM.
      FORMAT COLOR 6.
      WRITE: / 'Net value of ', wa_sales_items-vbeln, ' is', wa_sales_items-netwr UNDER wa_sales_items-netwr.
      FORMAT COLOR OFF.
    ENDAT.
*AT LAST is a control break event. It is triggered when the last row is iterated.
    AT LAST.
      SUM.
      FORMAT COLOR 2.
      WRITE: / 'The grand total is ', wa_sales_items-netwr UNDER wa_sales_items-netwr.
      FORMAT COLOR OFF.
    ENDAT.
  ENDLOOP.
ENDFORM.

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



*---------------------------------------------------------------------------------------------------------------------------------
*SELECT STATEMENTS. INNER JOIN, LEFT OUTER JOIN.
*---------------------------------------------------------------------------------------------------------------------------------

*Joins are used for retrieving the data from two or more tables using a single select query. In order to use joins to connect multiple
*tables, there should be at least one field shared by the tables being joined and that field should be compared between these tables
*during the select query.
*1. INNER JOIN.
*Whenever an inner join is used in the select query - each row of the left hand side table is compared with all the rows of the right
*hand side table.
*E.g.
*          TABLE A                       TABLE B
*         A  B  C  D                    E  F  G  H
*         a1 b1 c1 d1                   e1 f1 g1 h1
*         a2 b2 c2 d2                   e2 f2 g2 h2
*         a3 b3 c3 d3                   d2 f3 g3 h3
*         a4 b4 c4 d4                   d3 f4 g4 h4
*
*          TABLE A INNER JOIN TABLE B ON A~D = B~E
*
*                       RESULT TABLE
*                  A  B  C  D  E  F  G  H
*                  a2 b2 c2 d2 d2 f3 g3 h3
*                  a3 b3 c3 d3 d3 f4 g4 h4
*
*Only two rows are joined in the above query because A~D = B~E only in two cases (d2 and d3). Inner join discards the rows of both
*tables if they do not have a match between them.

*I want to get the customer data (KNA1) and the sales orders header data (VBAK) based on the provided customer range for every
*customer with a single select query.
DATA: v_kunnr TYPE kna1-kunnr.
SELECT-OPTIONS: sl_kunnr FOR v_kunnr DEFAULT '1000' TO '1010'.

TYPES: BEGIN OF ty_customer_sales,
  kunnr TYPE kna1-kunnr,
  ort01 TYPE kna1-ort01,
  vbeln TYPE vbak-vbeln,
  erdat TYPE vbak-erdat,
  erzet TYPE vbak-erzet,
END OF ty_customer_sales.
DATA: gt_customer_sales TYPE STANDARD TABLE OF ty_customer_sales,
      gwa_customer_sales TYPE ty_customer_sales.

START-OF-SELECTION.
*Every field that is present in both tables needs to be prefixed with the name of the table from which it's supposed to be
*retrieved from. 'ort01' and 'erzet' do not require specifying their table of origin because each of them is present only
*in one of the tables that are part of the select query. All other fields are present within both tables and must thus be
*prefixed with the appropriate table's name.
  SELECT k~kunnr ort01 vbeln v~erdat erzet
    FROM kna1 AS k INNER JOIN vbak AS v
      ON k~kunnr = v~kunnr
        INTO TABLE gt_customer_sales
          WHERE k~kunnr IN sl_kunnr.
  IF gt_customer_sales IS NOT INITIAL.
    FORMAT COLOR 3.
    DESCRIBE TABLE gt_customer_sales. "Saves the number of records in 'sy-tfill'.
    WRITE: / 'Total records: ', sy-tfill.
    FORMAT COLOR OFF.
    SORT gt_customer_sales BY kunnr.
*AT NEW should print the values mentioned within only once, whenever they are changed, but it works only for the value mentioned
*directly after AT NEW (so - kunnr). That means this will not work for 'ort01' - it will be replaced by a line of stars.
*In order to achieve this, I need to declare a variable for every variable other than specified with the AT NEW that I want
*treated in the same way. This variable should assume the value of the field I want displayed within AT NEW and be used instead
*of it. This is the case because, when inside AT NEW, all other fields in the work area but the one specified are replaced with stars.
*The field specified with the AT NEW event should be the first field of the internal table, otherwise the event will be triggered
*for every field of the table.
*In this particular case, it wouldn't happen because the select query above joins the tables based on 'kunnr'. Somehow this would
*prevent the neccessity of having to have 'kunnr' as the first field of the internal table in order to have AT NEW event work correctly
*with it.
    DATA: lv_ort01 TYPE kna1-ort01. "For the AT NEW event.
*The other way to achieve the same result is to use ON CHANGE OF event. It's triggered whenever a new value appears in the specified
*field ('kunnr' here). The advantage of ON CHANGE OF is thus it does not suppress the values in other fields than the one specified
*alongside the event like AT NEW does. ON CHANGE OF event can also be used in any of the looping statements (LOOP-ENDLOOP, WHILE-ENDWHILE,
*DO-ENDDO, SELECT-ENDSELECT) and AT NEW event can be used only inside LOOP-ENDLOOP.
    LOOP AT gt_customer_sales INTO gwa_customer_sales.
*      CLEAR lv_ort01.
*      lv_ort01 = gwa_customer_sales-ort01.
*      AT NEW kunnr.
*        FORMAT COLOR 1.
*        WRITE: / 'Customer number: ', gwa_customer_sales-kunnr,
*                 'Customer city: ', lv_ort01.
*        FORMAT COLOR OFF.
*      ENDAT.
      ON CHANGE OF gwa_customer_sales-kunnr.
        FORMAT COLOR 1.
        WRITE: / gwa_customer_sales-kunnr,
                 gwa_customer_sales-ort01.
        FORMAT COLOR OFF.
      ENDON.
      FORMAT COLOR 2.
        WRITE: / gwa_customer_sales-vbeln,
                 gwa_customer_sales-erdat,
                 gwa_customer_sales-erzet.
      FORMAT COLOR OFF.
    ENDLOOP.
  ELSE.
    MESSAGE 'No data has been retrieved.' TYPE 'I'.
  ENDIF.

*2. LEFT OUTER JOIN.
*While inner join discards the rows from both tables if no match for them has been found, left outer join retains all the rows from
*the left hand table even if they don't have a matching row in the right hand table and all the right hand side table's columns are
*filled with default values (e.g. numeric data types to 0 and character data types to blanks).
*E.g.
*          TABLE A                       TABLE B
*         A  B  C  D                    E  F  G  H
*         a1 b1 c1 d1                   e1 f1 g1 h1
*         a2 b2 c2 d2                   e2 f2 g2 h2
*         a3 b3 c3 d3                   d2 f3 g3 h3
*         a4 b4 c4 d4                   d3 f4 g4 h4
*
*        TABLE A LEFT OUTER JOIN TABLE B ON A~D = B~E
*
*                       RESULT TABLE
*                  A  B  C  D  E  F  G  H
*                  a1 b1 c1 d1
*                  a2 b2 c2 d2 d2 f3 g3 h3
*                  a3 b3 c3 d3 d3 f4 g4 h4
*                  a4 b4 c4 d4

*For an example, change the INNER JOIN to LEFT OUTER JOIN in the select query there.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*INNER JOIN, THREE TABLES. RAW FORMAT - CUSTOMER REPEATED FOR EVERY SALES ORDER.
*---------------------------------------------------------------------------------------------------------------------------------

DATA: v_kunnr TYPE kna1-kunnr.
SELECT-OPTIONS: sl_kunnr FOR v_kunnr DEFAULT '1000' TO '1010'.

TYPES: BEGIN OF ty_customer_sales,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kna1-land1,
  name1 TYPE kna1-name1,
  vbeln TYPE vbak-vbeln,
  erdat TYPE vbak-erdat,
  erzet TYPE vbak-erzet,
  ernam TYPE vbak-ernam,
  posnr TYPE vbap-posnr,
  matnr TYPE vbap-matnr,
  netwr TYPE vbap-netwr,
END OF ty_customer_sales.

DATA: gt_customer_sales TYPE STANDARD TABLE OF ty_customer_sales,
      gwa_customer_sales TYPE ty_customer_sales.

START-OF-SELECTION.
*Fields that are not unique to a single table included in the query require specifying from which table they are supposed to be
*taken from.
*Records here might be displayed in two lines each. I can amend that by adding the addition LINE-SIZE <number> to the name of the
*report to establish the number of characters I want every line to have.
*In the program's current form, the customer number/data is repeated multiple times. This is because every customer has multiple
*sales orders. If a particular customer has three sales orders, that customer will be repeated thrice - once for every displayed
*sales order of theirs.
  SELECT kna1~kunnr land1 name1
         vbak~vbeln vbak~erdat vbak~erzet vbak~ernam
         posnr matnr vbap~netwr
    FROM kna1 INNER JOIN vbak ON kna1~kunnr = vbak~kunnr
              INNER JOIN vbap ON vbak~vbeln = vbap~vbeln
      INTO TABLE gt_customer_sales
        WHERE kna1~kunnr IN sl_kunnr.
  IF gt_customer_sales IS NOT INITIAL.
    LOOP AT gt_customer_sales INTO gwa_customer_sales.
      WRITE: / gwa_customer_sales-kunnr,
               gwa_customer_sales-land1,
               gwa_customer_sales-name1,
               gwa_customer_sales-vbeln,
               gwa_customer_sales-erdat,
               gwa_customer_sales-erzet,
               gwa_customer_sales-ernam,
               gwa_customer_sales-posnr,
               gwa_customer_sales-matnr,
               gwa_customer_sales-netwr.
    ENDLOOP.
  ELSE.
    MESSAGE 'No data has been found.' TYPE 'I'.
  ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*PROUDLY ABAPER. CREATING CUSTOM DATABASE TABLES. DICTIONARY OBJECTS.
*---------------------------------------------------------------------------------------------------------------------------------

*There are many standard database tables provided by SAP itself. To maintain data within them, one uses standard transactions also
*provided by SAP.
*E.g.
*Customer data -> transaction XD01 (Creating customer). Data is persisted in KNA1, KNBK...
*Material data -> transaction MM01 (Creating material). Data is persisted in MARA, MAKT, MARC, MARD...
*Sales order data -> transaction VA01 (Creating sales order). Data is persisted in VBAK, VBAP...
*Purchase order data -> transaction ME21 (Creating purchase order). Data is persisted in EKKO, EKPO...
*
*Sometimes standard tables are not enough to represent all the data required by a specific customer. In such a scenario I need to
*create "customer specific tables" which hold data specific to a customer.
*
*Database tables are accessed within the dictionary - SE11. There are a few steps that need to be followed in order to create a
*database table:
* - Delivery and Maintenance:
*                Delivery Class needs to be specified. It is used for controlling the transportation of the table's data. The transportation
*                               refers to sending the table between the systems (development, quality and production). I can choose whether
*                               to transport only the structure or the structure along with the date. That transportaion is controlled by
*                               the Delivery Class.
*                                      "A - Application Table (master and transaction data)" - whenever I want to store master or transaction
*                                           data, A is the choice. Master data means data which has more read than write operations,
*                                           e.g. a bank account's number, the holder's name, etc. They do not keep on changing, so
*                                           they are master data. Transaction data is when I have more write operations. It's day to
*                                           day business data.
*                                      "C - Customizing table, maintenance only by cust., not SAP import" - my custom customer specific tables.
*
*                              The master and transaction data is maintained through the aforementioned standard transactions. In the case of
*                              "C" tables, it should be taken care of by the customer themselves. The majority of the tables provided by SAP
*                              are "A". Whenever I create my own tables, they are "C".
*
*                Data Browser/Table View Editing provides three possible options:
*                                      "Display/Maintenance Allowed with Restrictions" - I can only view the data but cannot insert, update nor
*                                           delete records. Almost all of the standard tables provided by SAP have this options.
*                                      "Display/Maintenance Allowed" - I can perform all the operations.
*                                      "Display/Maintenance Not Allowed" - I cannot perform any of the operations.
* - Fields:
*               Also called columns. Just like with internal tables. Names, data types, sizes. I can create my fields either basing them on
*               direct data types or data elements/domains. There are limitations to using direct data types here - the fields' values are always
*               captured in the upper case, I cannot impose any validation on the data, it doesn't support reusability and I cannot maintain field's
*               labels. E.g. I might want to have my column Designation provide only four possible values. I cannot impose any validation on what's
*               being provided if the data type is a simple string. Thus it is better to use Data Elements - see line 9668.
* - Technical settings:
*               Data class needs to be specified because the SAP database is partitioned into multiple schemas. There is a master schema which
*                              stores master tables that have more read operations than others. There is a transaction schema with transaction
*                              tables, etc. Thus Data Class specifies in which schema the database table is to be stored.
*                                      APPL0 - Master Data, Transparent Tables. This means the table is used for storing master data.
*                                      APPL1 - Transaction Data, Transparent Tables. This means the table is used for storing day to day data,
*                                              sales orders data.
*               Size category means the number of records expected to be stored in the database table. E.g. setting the size to 3 will make SAP
*                             initially allocate enough memory to store a maximum of 7400 records. It doesn't mean no more will fit - it's just
*                             the initial amount of memory. If the threshold is exceeded though, the allocated memory is extended by the initial
*                             amount, e.g. if I add 7401th record to the database table of the size 3, the table will receive memory for additional
*                             7400 records and will thus have memory for 14800 records in total.
*                             The extending of the database table requires some work from SAP, so choosing too small a size is discouraged. Having
*                             to enlarge the database table will degrade the performance.
*                             Likewise, it's not a good idea to assume too big the size of a table as it will waste memory.
* - Enhancement category:
*               If a customer wants 260 fields in a master data table, but SAP's standard KNA1 only has 251 and not all the fields match anyway,
*               I can use the enhance option to augment the SAP standard. The enhancement category controls the extensibility of SAP database
*               tables.
*               I can check the category of the database table by opening the table in SE11, going to Extras and checking Ehancement Category.
*               E.g. KNA1 has the "Can be enhanced (character-like or numeric)" option. This means additional fields can be added here and they
*               need to either be character or numeric fields. The "Can be enhanced (Deep)" option - "deep" means a structure within a structure
*               (any kind of data type can be added).

*---MANDT's purpose---
*If a table contains MANDT as the first field - it's a client dependent table. It stores the client's number. A client independent table does not
*have a MANDT field and the rows (records - the actual values stored) are not specific to any client. If I want records accessible across all the
*clients, I can create a client independent table (without the MANDT).

*---Primary Key and Initial Values---
*Every table should have at least one primary key (16 is maximum). Making a field a primary key field prevents it from having duplicate values.
*A combination of more than one primary key is called a composite key.
*The Initial Values option forces a not null policy. If no value is provided then a default value (specific to a data type the field is of) is
*inserted. It is automatically checked for primary key fields.

*---Manipulating the data---
*A new record can be added from the level of the database table's creation - SE11 -> enter a table -> Utilities -> Table Contents -> Create Entries.
*I can also manipulate the existing records by going to Utilities -> Table Contents -> Display (or pressing the Contents button in the Application
*Bar). When displaying the contents I can select the option of Table Entry and manipulate any record in a capacity allowed by the
*"Data Browser/Table View Maint." option selected when creating the table.

*---Table Maintenance---
*After the table has been created, I need to generate Table Maintenance which will create an interface through which the end user can maintain
*the table. To generate Table Maintenance, I need a Function Group.
*Whenever I generate Table Maintenance, some dependent objects are generated. They are stored within the Function Group. A Function Group can
*be created in SE80. When it's there, I need to activate it (right click its name).
*To generate Table Maintenance, I need to open the table in SE11, go to Utilities and select Table Maintenance Generator.
*- Authorization Group specifies what users can maintain the table in case I didn't want just any end-user to be able to do this. E.g. the
*                      option of "&NC&" means "without authorization group so anyone can maintain the table.
*- Maintenance Type needs to be specified as either One Step or Two Step.
*                   a) One Step - one screen is generated - the Overview Screen. In this screen all the CRUD operations can be performed
*                                 (adding, removing, updating and deleting records). I need to provide the screen number - any number up to
*                                 9999. I can have this number generated automatically by SAP. In the Application Toolbar there is a button
*                                 "Find Scr. Number(s)". I have three options there, one of which is "Propose screen number(s)". If this is
*                                 the first Table Maintenance created within the Function Group, the proposed number will be 1.
*                   B) Two Step - the Overview Screen is generated and the Single Screen is generated. In the Overview Screen I can only read
*                                 the data and the other three operations can be performed in the Single Screen.
*                   When that's done, I can click the white sheet button ("Create") and save the Table Maintenance. Then I F3 out of the Table
*                   Maintenance genertaion environment back to the database table in SE11, save and activate it.

*The user can maintain the table in SM30. Though here the user needs to remember the name of the table and specifically select the Maintain
*button out of all the available ones. I should provide them with a better tailored interface - I need to provide them with a tool that
*requires minimum navigating from them.
*For this purpose - I should create my own custom Transaction Code.

*To skip the initial screen of SM30 and create a Transaction Code that initially fires up the Maintain option, I need to collect the function call
*of the Maintain button - by moving the focus onto that button with Tab keyboard button and pressing F1.
*The creation of new Transaction Codes is carried out in SE93 transaction. I need to provide the name and the short description. I should choose
*the last of the options in the Start Object section ("Transaction with parameters (parameter transaction)") - it is the correct choice for the
*Transaction Code for the table maintenance.
*In the next screen in the "Default values for" section, I need to add SM30 to the "Transaction" box and mark the "Skip initial screen" checkbox.
*Furthermore, in the "GUI support" section, I need to mark the "SAPGUI for Windows" checkbox. Since I am skipping the initial screen, I need
*to provide my transaction with the information that I was providing in SM30 - the name of my database table and the pressing of the Maintain
*button. In the "Default Values" I need to provide the names of the screen fields I require - the input box and the button.
*The input box most likely is "VIEWNAME" and the Value is the name of my table.
*The second row should have "UPDATE" as Name of screen field and "X" as Value. "UPDATE" is the name of the Maintain's function call and "X" informs
*it's the button that's being pressed. Technically F1-ing the Maintain button in SM30 will give me "UPD", but I need to provide "UPDATE" here
*anyway.
*Whenever there are changes made to the database table - I need to generate the table maintenance again. In order to do so, I need to open my table
*in SE11 in the Change mode. The reason for change does not matter much, I can mark all the checkboxes. Then I need to tell SAP which screen
*I want generated again - in case I chose the Two Steps maintenance type - I should mark both checkboxes (Overview screen and Single screen).

*----------------------------------------------------------------------*
*       DATA ELEMENTS
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*It is recommended to declare the table's fields using Data Elements and Domains instead of direct data types.

*A Data Element is a reusable dictionary object which provides a description for the field. Which means I can maintain the descriptions when I
*               create Data Elements. These descriptions, specified in the Field Label sheet of the Data Element screen (when I double-click one)
*               appear automatically in the screens wherever the Data Element is referred to. Any Data Element can be associated with a direct
*               Data Type, a Domain or a Reference Type. I can see this in the Data Type sheet of the Data Element screen.
*               - a Domain - a reusable dictionary object which stores technical properties of the field like the data type or size. E.g. MANDT
*                            is associated with the domain also named MANDT - the name can be the same but doesn't have to.
*                            A domain allows me to make my variables retain the exact way they were stored instead of converting all letters to
*                            the uppercase. In the Definition sheet if I select Lower Case checkbox, it will do just that - retain the way the
*                            data was provided. Thus, when I create my own Data Elements, I can use a Domain for CHAR fields (to have them retain
*                            how they were stored) and use a Predefined Type for numeric fields since they don't have either uppercase or lowercase.
*                            A Domain allows me to create a set of possible values that can be selected for the Data Element associated.
*               - a Predefined Type.
*               - Object Oriented Interfaces of classes (Reference Type).

*----------------------------------------------------------------------*
*       REUSABLE FIELDS (AS STRUCTURES)
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*If I want to add new fields to the table, I can do it directly within the table unless I want to have them reusable - possible to use by other
*structures or other dictionary objects as well.
*A dictionary structure is essentially a work area, but on a database level. I can declare it, have it as many fields as I want and include that
*structure in different dictionary objects, e.g. database tables.
*After having created my structure, I should specify the enhancement category for it, just like with tables.
*When I want my custom structure included in a particular database table, I need to type '.include' as a new field of the table and provide the
*name of the structure as a Data Element field. Upon hitting Enter, the Data Type field will be filled with 'STRU' - indicating that it's indeed
*a structure being included in the database table.
*I need to keep in mind, I will need to generate the table maintenance for my table again! Whenever I add additional fields, modify existing ones
*or modify the labels - these changes will not be reflected in the existing table maintenance - it needs to be remade.
*I also need to remember that in the custom transaction code standing for the table maintenance for my custom table, the Two Step mainetance's
*Overview Screen will show only a handful of fields. If I select New Entries option, all the fields should be visible. If I want to display all the
*data for the particular records - I need to select it and choose Details option from the Application Toolbar.

*----------------------------------------------------------------------*
*       EVENTS AS PART OF TABLE MAINTENANCE
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*I can define events as part of Table Maintenance in order to e.g. have my Table Maintenance set the date and time fields to the current date and
*time in case the user has not provided actual values for these fields.
*I should open the database table in SE11, go to Utilities, Table Maintenance Generator, then go to Environment, Modification and select Events.
*There I should select New Entries and choose the value of 'T' (a table/time event). This is to specify when the subroutine I am going to specify
*should be triggered. For example, the number '05' stands for 'Creating a new entry' - I can use it to write a subroutine assigning values to
*specific fields at the time of the creation of a new record. I should also provide the name of my subroutine. Upon hitting Enter, the Editor button
*to the right should change and allow me to select it - doing so will take me to the editor.
*Whenever I implement events as part of table level, I need to reactivate the function group, so that all the objects are adjusted. When all that
*is done, adding a new record in my Table Maintenance with omitting the date and time fields and saving the record will make the current date and
*time be inserted into their respective fields automatically.

*----------------------------------------------------------------------*
*       INDEXES IN DATABASE TABLES
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*An index is a process of arranging data in a specifc order. If data is sorted, the searching is faster. The purpose of indexes is to increase
*the searching speed. If I want to search for a specifc record among a huge amount of data, I should sort the data and then search - like using
*the READ statement with internal tables - first I should sort the internal table based on the search field.
*There are two types of indexes:
*- primary - I don't have any control over it. It is automatically created by SAP. Internally it is going to arrange the table data in an order
*            based on the primary key fields. Whenever I search for a record based on a primary key field, SAP will make use of a primary index
*            to look for the record.
*- secondary - should be created by me and created on non-primary key fields. It increases the performance. There are two types of a secondary
*              index.
*            a) unique - if I create it on a field, it will not accept duplicate values for that field.
*            b) non-unique.

*I can improve the performance of SELECT queries that utilize non-primary key fields in their WHERE clause by creating a secondary index
*on a non-primary key field. If I am making a SELECT comparing non-primary key fields that had a secondary index created, SAP will make
*use of that secondary index and thus make the query faster.

*If I want to create a secondary index, I need to open my database table in SE11 and select 'Indexes...' option from the application toolbar.
*Then I should select 'Create' and 'Create index'. I should provide my custom index' name, e.g. 'ID1'. Then I ought to provide a short description
*for the secondary index I am creating.
*Then I can choose what kind of an index I want to create - a uniqe or non-unique. I can choose 'Table fields' button to choose the field on
*which I want the index created. If my database table is not client-independent (has MANDT), MANDT needs to be included in the index and has to be
*selected alongside my chosen field.
*If I am trying to create a unique secondary index on a field with duplicate values - SAP will refuse to do so. Blanks are also counted as
*duplicates! If at least two records have a blank space in the field on which I want my unique secondary index - it will not come to pass.
*When a unique secondary index is created on a field, I won't be able to insert a new record with the same value as held in that field by one
*of the other records.

*----------------------------------------------------------------------*
*       TYPE GROUP IN SE11
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*A reusable dictionary object which is a collection of global types and global constants. Much like I can have types and constant variables locally
*in my programs, I can create a Type Group if many dictionary objects will share the same types or constants and have them global and reusable.
*If I want to use variables of an include program, I need to type 'INCLUDE program'. In the same manner, but only until SAP GUI 6.0 -  if I wanted
*to use components of a type group, I needed to declare that type group. It was done by typing 'TYPE-POOL my_type_group'.
*In the newer versions, I no longer need to explicitly declare the type group. SAP will recognize I am using the components of a particular type
*group.
*Whatever the components I declare in my type group, these components have to have the name of the type group as a prefix, e.g. a type group going
*by the name of 'NezukoBestGirl' needs to have all of its components have a prefix of 'nezukobestgirl_'.

*----------------------------------------------------------------------*
*       LOCK OBJECTS
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*A reusable dictionary object which is used for row level locking. It's purpose is to prevent two users from updating the same record. If two users
*are trying to update the same record, it can lead to a deadlock. In operating systems a deadlock can occur when multiple users are trying to use
*the same resource. A lock object is used to lock a particular record and perform the operation and lift the lock afterwards.
*Row locking is performed based on the primary key column. The key fields are the lock object's parameters. Only one row can be locked at a time.

*Similarily, object level locking is performed by SAP itself - if one user edits a particular program, the other user cannot open that program in an
*edit mode. So only one user can edit an object at any given time. If a user opens an object, a lock is placed on top of that object automatically.

*When creating lock objects, their names should start with 'e' (compulsorily, SAP will demand it) and 'z' afterwards (that SAP won't demand). Then,
*I should provide a short description. In the 'Tables' tab I need to provide the name of the table whose row I want to have a lock for. Next, the
*'Lock Mode' means the type of lock. The three most important ones are:
*- Write Lock - also known as Exclusive/Acumulative Lock. In this lock only one user can read or edit the locked record. If other users request access
*               to the locked row, the request will be rejected but stored in the queue. Once the first user releases the lock, the exclusive access
*               is given to the user in the queue.
*- Read Lock - also known as Shared Lock. Multiple users can read the locked record and if a user modifies the locked record, the modified data is not
*              accessible to other users.
*- Exclusive, not cumulative - similar to the Write Lock, but other users' request for access are not stored in the queue. They have to send a fresh
*                              request themselves.
*Moving forward, in the 'Lock parameter' tab, I can see the key fields of the chosen table. Save and activate.
*When a lock object is created, SAP creates two function modules:
*- 'ENQUEUE_<LOCK_OBJECT_NAME>' - used for locking the row.
*- 'DEQUEUE_<LOCK_OBJECT_NAME>' - used for releasing the row.
*I can see these function modules if I open my lock object, select Goto and pcik Lock Modules. Both of the created FMs will be displayed.

*---In order to use a lock object---:
*In the case below, two separate users could access the same KUNNR. It might lead to a deadlock situation. If one user tries to modify
*the record and the other tries to access it, the second one might get invalid data. The record needs to be locked once a user has already
*accessed that record.
******************************************************************
*PARAMETERS: p_kunnr TYPE kna1-kunnr.
*DATA: v_name1 TYPE kna1-name1,
*      v_ort01 TYPE kna1-ort01.
*SELECT SINGLE name1 ort01
*  FROM kna1
*    INTO (v_name1, v_ort01)
*      WHERE kunnr = p_kunnr.
*IF sy-subrc = 0.
*  WRITE: / 'Customer found.'.
*  WRITE: / 'Customer name:', v_name1.
*  WRITE: / 'Customer city:', v_ort01.
*ELSE.
*  WRITE: / 'Customer not found.'.
*ENDIF.
******************************************************************
*In order to have a lock object put onto a record, I need to add 'SET PF-STATUS'. It is used to define my own GUI STATUS. As part of the
*GUI STATUS, I can add my own buttons to the application toolbar or enable or disable standard ones.
*To do this, I need to provide a preferred name ('ABC' in this case) and double-click the name to create the object. Then I need to provide
*a short description which can be just the status' name. The status type can remain as 'Normal Screen' which is a default. Now the Menu Painter
*(SE41) is open. Since I want to add custom buttons to the Application Toolbar, I need to select the button to the right of the Application
*Toolbar box. There I should provide the function call of my button (e.g. 'FC1') in one of the boxes available (I think they refer to the position
*of the button on the Application Toolbar), press Enter and continue (the default Static Text is good). Here I need to provide the text my button
*will display (e.g. Leave, Unlock, etc). Then I need to assign my function the function key. It is a shortcut - much like F3 means "go back". Only
*the available buttons are displayed as options. This is why I cannot choose F3 because it's reserved by SAP. If I create one button and assign it
*e.g. F2 and then create a second one, F2 will no longer be available, because the first button reserved it. I will still need to define the functions
*for my custom made buttons.
*Whenever I define my own GUI STATUS, SAP will lose the functionality of the standard back button. I thus need to create my own.
*My custom buttons are components of the Application Toolbar of the List Processing Screen. If I click any of the buttons on the selection screen's
*Application Toolbar, AT-SELECTION-SCREEN event is triggered, but my custom made buttons are placed in the Application Toolbar of the LPS and they
*trigger another event - AT USER-COMMAND.
*In order to finally lock the record, when I created my Lock Object, two function modules were created. ENQUEUE to lock the record and DEQUEUE to
*unlock.
******************************************************************
*PARAMETERS: p_kunnr TYPE kna1-kunnr.
*DATA: v_name1 TYPE kna1-name1,
*      v_ort01 TYPE kna1-ort01.
**My custom GUI STATUS.
*SET PF-STATUS 'ABC'.
**To lock the record, I need to call the automatically created ENQUEUE FM. 'MODE_KNA1 = 'E'' refers to the 'exclusive lock' or 'write lock'. If
**'sy-subrc' equals one, that means the record is locked.
**Upon executing the program (F8) the record will be locked first and then retrieved. While this session is active, if another user tries to
**access the same record - they will receive an error message informing them that the record is locked. It's important that the message is of
**type 'E'. If it's 'I', it will still proceed to display the record after the pop-up window!
**It is recommended to lock a record before performing an operation. Thus, the ENQUEUE function module is called before any operation is performed.
**The operation locks only the particular record, all other records will be free to be accessed by another user.
**I should lock the record even if I am just reading because there is a possibility that other users might seek to modify the record and I would
**be seeing outdated data.
*CALL FUNCTION 'ENQUEUE_EZBMIERZWILOCK'
* EXPORTING
*   MODE_KNA1            = 'E'
*   MANDT                = SY-MANDT
*   KUNNR                = p_kunnr
* EXCEPTIONS
*   FOREIGN_LOCK         = 1
*   SYSTEM_FAILURE       = 2
*   OTHERS               = 3.
*IF sy-subrc = 1.
*  MESSAGE 'The record is currently locked.' TYPE 'E'.
*ENDIF.
*
*SELECT SINGLE name1 ort01
*  FROM kna1
*    INTO (v_name1, v_ort01)
*      WHERE kunnr = p_kunnr.
*IF sy-subrc = 0.
*  WRITE: / 'Customer found.'.
*  WRITE: / 'Customer name:', v_name1.
*  WRITE: / 'Customer city:', v_ort01.
*ELSE.
*  WRITE: / 'Customer not found.'.
*ENDIF.
**I created a 'FC1' button and called it 'Leave' in my custom GUI STATUS. 'FC2' is assigned to my custom button named 'Unlock'. Pressing this
**button should unlock the record. These are defined within the boundaries of AT USER-COMMAND event as these buttons are part of the Application
**Toolbar of the List Processing Screen and AT USER-COMMAND is the go-to event here. If the user pressed a button back in the Application
**Toolbar of the selection screen, then AT SELECTION-SCREEN would be triggered instead.
**Leaving the program will also unlock the record.
*AT USER-COMMAND.
*  CASE sy-ucomm.
*    WHEN 'FC1'.
*      LEAVE PROGRAM.
*    WHEN 'FC2'.
*      CALL FUNCTION 'DEQUEUE_EZBMIERZWILOCK'
*       EXPORTING
*         MODE_KNA1       = 'E'
*         MANDT           = SY-MANDT
*         KUNNR           = p_kunnr.
*  ENDCASE.
******************************************************************

*----------------------------------------------------------------------*
*       FOREIGN KEY RELATIONSHIP BETWEEN TWO TABLES
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*The foreign key relationship is created between two tables in order to maintain the data consistency as this relationship is to be created when
*the data within one table is dependant on the data from the second table. The prerequisite is that the tables have at least one field of the
*same domain (data element can be different!) and in one of these tables that field has to be a primary key field. The table that has this field
*as a primary key field is called a Check Table. It contains unique data. The second table houses the foreign key and is called a Foreign Key Table.

*---In order to create the foreign key relationship---
*Say I have a table that houses the department data and the field with the department number is the primary key field and a second table with the
*employee data that also has a department number field but not as a primary key field.
*These fields need to have a common domain. The department table is a check table because it stores all the unique department numbers. Thus it stores
*all the master records, unique values (in terms of the logically related field - the department number).

*The foreign key is to be created in the other table. I need to select the proper field (in the example it's the department number in the employee
*data table) and select the 'Foreign Keys' button above the tables' fields' list. I should provide the 'Short text' explaining what tables are
*being joined. In the 'Check table' I need to provide the name of the parent table - the one that houses the field I am making into a foreign key
*and has it as the primary key field. When I press 'Generate proposal' button, SAP will show me all the fields of the parent table that share the
*domain with the field I selected in the foreign key table where I am performing the operation. I need to select 'Copy' (essentially 'Continue') to
*proceed. I should activate the table now.
*When I create the foreing key, the records that were already present will not be checked but from now on the newly added records will be. Whenever
*I create the foreign key relationship between two tables, SAP will maintain the referential integrity between them. According to the referential
*integrity, I will not be allowed to insert a child row in the foreign key table if there is no corresponding parent record in the check table, e.g.
*I will not be able to add a new employee to the employee table unless the department number I want them to have already exists in the department
*table. When adding a new record to the employee table, the department number field will have the F4 help available and it will display the values
*I can choose from. They are loaded from my department table.

*----------------------------------------------------------------------*
*       TABLE TYPE
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*Whenever I am working with multiple records, I am using internal tables in order to avoid doing the processing on the database. Instead, I am
*retrieving the data into a temporary table - an internal table. Within it I process the data the way I want and then I update the database. An
*internal table is local to my program - its lifetime and scope are limited by bounds of my program. Once the program's execution is finished,
*the internal table is destroyed.
*A Table Type is an internal table structure created at the database level.
*Like any other dictionary object a table type is reusable. I create it whenever I want a reusable internal table.
*In order to create a Table Type, I need to go to SE11, choose the Data Type radiobutton, provide a name of my Table Type and select Create. I
*should provide a short description here. A Type Table can be created in three various ways:
*- by referring to a Line Type,
*- by referring to a Predefined Type - a direct data type.
*- by referring to a Reference Type - a class or an interface.

*If I want to use the same internal table across many repository objects (programs), I can create a Table Type instead of a regular internal
*table every time separately.

*---Predefined Type---
*Below are two blocks of code, the first creates an internal table locally and uses it, the second uses a Table Type (so a "global" internal
*table) created as described above. It is a Table Type with a Predefined Type of CHAR of the length of 20.
******************************************************************
*This is a "regular" way of declaring and using an internal table. It is created locally.
*A local types declaration.
TYPES: BEGIN OF t_abc,
  f1(20) TYPE c,
END OF t_abc.

*A local internal table and a work area based on a local types declaration.
DATA: lt_abc  TYPE TABLE OF t_abc,
      lwa_abc TYPE t_abc.

CLEAR lwa_abc.
lwa_abc-f1 = 'Hasani'.
APPEND lwa_abc TO lt_abc.
CLEAR lwa_abc.
lwa_abc-f1 = 'Narsani'.
APPEND lwa_abc TO lt_abc.
CLEAR lwa_abc.
lwa_abc-f1 = 'Balisani'.
APPEND lwa_abc TO lt_abc.

FORMAT COLOR 5.
WRITE: / 'Data of the local internal table:'.
FORMAT COLOR OFF.
ULINE.
LOOP AT lt_abc INTO lwa_abc.
  WRITE: / lwa_abc-f1.
ENDLOOP.
ULINE.

*This block of code utilizes a "global" internal table, a table type.
*When creating a local internal table, I am using TYPE TABLE OF keywords. Below a simple TYPE is enough because 'zbmierzwi_test_tt' already
*is an internal table, just global. When creating a Table Type's version of a work area, I can use LIKE LINE OF keywords, because each line
*of 'lt_abc2' is a work area.
*Trying to use 'TYPE lt_abc2' wouldn't work as SAP requires a TYPES declaration to be the target of the TYPE for the work area. Here it would
*suggest that 't_abc' is available. Since using TYPE 'zbmierzwi_test_tt' would yield an internal table, instead of a work area, LIKE LINE OF
*is used instead.
DATA: lt_abc2  TYPE zbmierzwi_test_tt,
      lwa_abc2 LIKE LINE OF lt_abc2.

*I do not need to specify which field of the work area I am assigning a value to because 'zbmierzwi_test_tt' is of the Predefined Type and
*only has one field (CHAR of the length of 20).
CLEAR lwa_abc2.
lwa_abc2 = 'Dalisani'.
APPEND lwa_abc2 TO lt_abc2.
CLEAR lwa_abc2.
lwa_abc2 = 'Numisani'.
APPEND lwa_abc2 TO lt_abc2.
CLEAR lwa_abc2.
lwa_abc2 = 'Erisani'.
APPEND lwa_abc2 TO lt_abc2.

FORMAT COLOR 5.
WRITE: / 'Data of the Table Type internal table:'.
FORMAT COLOR OFF.
ULINE.
LOOP AT lt_abc2 INTO lwa_abc2.
  WRITE: / lwa_abc2.
ENDLOOP.
ULINE.

*---Line Type---
*If I want to create a Table Type (a "global" internal table) with multiple fields, I need to select the Line Type option. The Line Type is a
*Structure. I can provide the name of the Structure here and double click it in order to create it - I will be redirected to the panel of a Structure's
*creation. I should create it as usual. After adding all the necessary fields, I should (as usual) provide the Enhancement Category. I should go to
*Extras -> Enhancement Category... -> "Can be enhanced (character-type or numeric)" is a good option!
*When declaring a work area I can either make it LIKE LINE OF the local implementation of my global internal table or TYPE of the Structure I
*created to be the Line Type of my Table Type (the global internal table).
DATA: lt_abc3 TYPE zbmierzwi_test_tt2,
*      lwa_abc3 LIKE LINE OF lt_abc3
      lwa_abc3 TYPE zsbmierzwinski.

CLEAR lwa_abc3.
lwa_abc3-empno = 1.
lwa_abc3-ename = 'Sylasani'.
lwa_abc3-empdesig = 'Junior Developer'.
APPEND lwa_abc3 TO lt_abc3.

CLEAR lwa_abc3.
lwa_abc3-empno = 2.
lwa_abc3-ename = 'Elusani'.
lwa_abc3-empdesig = 'Developer'.
APPEND lwa_abc3 TO lt_abc3.

CLEAR lwa_abc3.
lwa_abc3-empno = 3.
lwa_abc3-ename = 'Measani'.
lwa_abc3-empdesig = 'Senior Developer'.
APPEND lwa_abc3 TO lt_abc3.

FORMAT COLOR 5.
WRITE: / 'Data of the Table Type internal table of the Line Type:'.
FORMAT COLOR OFF.
ULINE.
LOOP AT lt_abc3 INTO lwa_abc3.
  WRITE: / lwa_abc3-empno,
           lwa_abc3-ename,
           lwa_abc3-empdesig.
ENDLOOP.
ULINE.
******************************************************************

*----------------------------------------------------------------------*
*       VIEWS
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*A View is a reusable dictionary object which doesn't exist physically - it is a virtual (an "imaginary") table. The View is populated with the
*data during the runtime, it does not hold any data be default. A regular table on the other hand exists physically and strores the data physically.
*Views are used for hiding the original tables' names, fields' names, restricting access to a table's data or to read data from multiple tables.
*A View allows me to get the dprvifiv fields from different tables and put them in a single object, but it can also refer to just a single table.
*Once a View is created, it is a reusable dictionary object and I can use it my repository objects (programs). E.g. in order to fetch the data from
*multiple tables, I need to use a Select Statement with a Join. Using Joins is complex and using too many of them will degrade the performance of
*the program. Creating a View on top of multiple tables allows me to avoid using Joins - I select the data from the View which functions as as
*table that stores all the fields from different tables I would need to use a Join to get without a View.
*SE11 Views are being replaced by CDS Views. For the advantages of the latter over the former refer to:
*https://answers.sap.com/questions/13027498/what-is-the-difference-between-cds-view-database-v.html
*There are four kinds of Views in ABAP dictionary:
*1) Database View - can be created either on a single or on multiple tables. It supports both the projection and the selection. The projection is
*                   a process of selecting only the required fields - if I have a table with 200 fields and I only want 4 of them exposed, I can
*                   create a View for that - that's projection. The selection is a process of imposing conditions on accessing the table's
*                   data. If that View is created on a single table, then the maintenance status can either be "Read only" (the only database
*                   operation I can perform is read) or "Read and Change" (all database operations are allowed). The changes made to the data at the
*                   level of the View will be automatically reflected in the corresponding database table. If the View is created on multiple
*                   tables, it is always "Read only". A Table Maintenance cannot be generated for a Database View. Whenever I create a View based
*                   on multiple tables, I need to provide the Join conditions - I need to compare logically related fields, just like with a regular
*                   Join. Failing to do so will result in a "Cartesian product'.
*
*                   ---Implementation example - a View on one Table---
*                   In order to create a Database View, I need to go to SE11 and check the 'View' radiobutton, provide the name of my View and 'Create'.
*                   Here I need to select the 'Database view' option and proceed. A short description should be given now. In the 'Table/Join Conditions'
*                   tab I need to supply the name of the table within the 'Tables' section to the left. If I am making a View on just a single
*                   database table, say, KNA1, I do not need to give any Join conditions in the section to the right.
*                   Now I should proceed to the 'View Flds' tab and name the required fields. This process of called Projection - I am providing the
*                   full list of fields I want my View to have. I don't need to write all the desired fields manually, I can push the 'Table fields'
*                   button and SAP will give me a complete list of all the fields of the table/s I named previously to choose from. It is recommended
*                   (not compulsory) I select all the key fields. After choosing the desired fields, I am welcome to change their names - these changes
*                   are limited to the View and do not translate to the table it has come from. Moving on I should go to the 'Selection Conditions' tab
*                   in order to decide what kind of records I want loaded into my View (e.g. only the records with the country code of Japan). I should
*                   provide the name of the table on whose field the condition will be placed, the field itself, the oparator deciding what kind of a
*                   comparison will be used, the value of the comparison and I can also specify the AND/OR values in case I want more than a single
*                   condition. It essentially works like a WHERE clause of a SELECT statement.
*                   In the 'Maint.Status' tab I can see the radiobuttons 'read only' and 'read and change'. Changes made to the data within my View
*                   will be reflected in the base table. 
*                   
*                   ---Implementation example - a View on multiple Tables---
*                   If the data I am interested in is stored in many tables, I can have my View combine the required fields from all these tables into
*                   a single object. The way of creating such a View is almost the same as described above, for a database View on one table, but in the
*                   'Table/Join Conditions' tab I need to supply the names of all the tables I will be taking the data from complete with Join conditions
*                   for these tables. Failing to provide the Join conditions would result in a 'Cartesian product' which is a collection of all possible
*                   pairs, e.g. if I have a table A with values {1, 2 } and a table B with values {3, 4, 5}, then the 'Cartesian product' of A and B is
*                   {(1, 3), (1, 4), (1, 5), (2, 3), (2, 4), (2, 5)}.
*                   A database View created on multiple tables utilizes an inner join. Each entry of the left hand side table will be compared with the
*                   row of the right hand side table. If the matching is found - only then that entry will be included.
*                   Since the View here is being created on multiple tables, the only possible 'Maint.Status' is 'Read only'. I cannot change the content
*                   of the tables my View is created on if it's not just a single table.
*                   When I am providing conditions in the "WHERE clause" ('Selection Conditions' tab), I need to make sure I am providing the 'Comparison
*                   Value' correctly - e.g. if I want a VBELN here, I need to make sure the value has enough leading 0s added to it so that there is exactly
*                   10 digits. That means '0000000666' instead of '666'. This wouldn't be a problem in a SELECTION-SCREEN, as '666' would be accepted and
*                   understood, but here I need to be specific.

******************************************************************
*The below piece of code with a select with an inner join works exactly the same as the piece of code below it, with the structure that includes the
*View that has been created. The View is on tables VBAK and VBAP joined by MANDT and VBELN. The list of fields included is the same as the list of
*fields included in 't_sales'.
*A piece of code with a join.
TYPES: BEGIN OF t_sales,
  vbeln TYPE vbak-vbeln,
  erdat TYPE vbak-erdat,
  erzet TYPE vbak-erzet,
  ernam TYPE vbak-ernam,
  posnr TYPE vbap-posnr,
  matnr TYPE vbap-matnr,
END OF t_sales.

DATA: lt_sales TYPE STANDARD TABLE OF t_sales,
      lwa_sales TYPE t_sales.

SELECT vbak~vbeln vbak~erdat vbak~erzet vbak~ernam posnr matnr
  FROM vbak INNER JOIN vbap
    ON vbak~vbeln = vbap~vbeln
      INTO TABLE lt_sales
        WHERE vbak~vbeln IN ( '2770200001', '2770200002' ). "The values are exemplary and may vary depending on the system.

IF sy-subrc = 0.
  WRITE: / 'Number of records: ',sy-dbcnt.
  LOOP AT lt_sales INTO lwa_sales.
    WRITE: / lwa_sales-vbeln,
             lwa_sales-erdat,
             lwa_sales-erzet,
             lwa_sales-ernam,
             lwa_sales-posnr,
             lwa_sales-matnr.
  ENDLOOP.
ENDIF.
ULINE.

*A piece of code without a join, utilizing a View. The TYPES declaration is a little bit different when I want to INCLUDE a structure within. There
*should be a point, not a comma, preceding the INCLUDE keyword and there needs to be a point afterwards. If the end of the TYPES occurs after the
*INCLUDE, then I need to add TYPES again.
*In the SELECT itself I do not need to add the conditions (the WHERE clause) as it is already defined in the View itself in the 'Selection Conditions'
*tab. They are the same as used in the piece of code above.
TYPES: BEGIN OF t_sales2.
  INCLUDE TYPE zbmviewtest2.
TYPES END OF t_sales2.

DATA: lt_sales2 TYPE STANDARD TABLE OF t_sales2,
      lwa_sales2 TYPE t_sales2.

SELECT * FROM zbmviewtest2 INTO TABLE lt_sales2.

IF sy-subrc = 0.
  WRITE: / 'Number of records: ',sy-dbcnt.
  LOOP AT lt_sales2 INTO lwa_sales2.
    WRITE: / lwa_sales2-vbeln,
             lwa_sales2-erdat,
             lwa_sales2-erzet,
             lwa_sales2-ernam,
             lwa_sales2-posnr,
             lwa_sales2-matnr.
  ENDLOOP.
ENDIF.
ULINE.
******************************************************************

*2) Projection View - the main idea behind Projection Views is to hide the original table's fields. A Projection View can be created only on one table.
*                     It does not support Selection which means I cannot limit the number of the base table's records that will be included in the View.
*                     All of the table's data will be available. Essentially, the Projection Views do not allow their version of the WHERE clause. A 
*                     Projection View can be used if I want to expose all of the table's data but with the limited number of fields displayed.
*                     If I want to create a Projection View and have already provided the ever present short description, I need to supply the name of
*                     the 'Basis Table' in the 'View Fields' tab and select the desired fields via 'Table fields' button.
*                     Since the Projection Views are created on a single table, they can be either 'Read only' or 'Read and change' in the 
*                     'Maintenance Status' tab. The changes to the data through the Projection View will be reflected in the base table.
*                     I cannot generate Table Maintenance for a Projection View.
*
*3) Maintenance View - can be created on one or multiple tables. The main purpose of the Maintenance View is to grant access to multiple tables' data
*                      through a single object (the Maintenance View being that object). The difference between the Maintenance View and the
*                      Database View is that the Maintenance View allows for the generation of the Table Maintenance while the Database View does not.
*                      Moreover, the Database View requires me to provide the Join condition if I am creating it on multiple tables. In case of the
*                      Maintenance View I can select multiple tables which have a foreign key relationship and this the Join condition will be
*                      provided by SAP itself. For example, if I created a Maintenance View on VBAK and wanted to add more tables to the list, I cannot
*                      do so manually. After having provided the first table's name in the 'Tables' section in the 'Table/Join Conditions' tab, I can
*                      only press the 'Relationships' pushbutton below the section. SAP will provide me with a complete list of all tables with
*                      which VBAK has a foreign key relationship. When I select a table, Join conditions will be provided for me, e.g. if I selected
*                      KNA1, SAP would join the two tables by MANDT and KNA1's KUNNR being compared with VBAK's KNKLI.
*                      Both the Projection and the Selection are supported.
*                      In case of the Maintenance View, even if I am creating the View on multiple tables, both reading and modifying the data is
*                      possible which means the changes made to the data through the View will be reflected in the base tables. In the 'Maint.Status'
*                      tab I have four 'Access' options to choose from. 'Read only' allows for reading alone, 'Read, change, delete and insert' allows
*                      for all four of the database operations, 'Read and change' lets me read and modify the data. The fourth is not relevant at the
*                      moment.
*                      For the Maintenance View it is mandatory to generate the Table Maintenance. Maintenance View cannot be used in SELECT queries.
*                      It is to be used from the Table Maintenance level. Maintenance View is used to link all the dependent tables and maintain them
*                      as a single object. This is called a 'View Cluster'.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*F4 SEARCH HELP AS A REUSABLE DICTIONARY OBJECT.
*---------------------------------------------------------------------------------------------------------------------------------

*Search help is used for providing the custom F4 help. Once the Search Help as a reusable dictionary object is created, it can
*be utilized at various levels in SAP.
*There are two types of Search Help.
*1. Elementary Search Help.
*2. Collective Search Help.

*In case of below parameters, I will automatically receive F4 Help for KUNNR and LAND1, but not for NAME1. If I double-click,
*say, KUNNR and then double-click its Data Element (also KUNNR) I will be transported to the Data Element panel. Then I can click
*'Further Characteristics' tab and I will see 'Search Help' box. KUNNR Data Element has Search Help attached to it. So does LAND1.
*NAME1 on the other hand does not. Thus NAME1's Data Element does not have Search Help associated with it.
*PARAMETERS: p_kunnr TYPE kna1-kunnr,
*            p_land1 TYPE kna1-land1,
*            p_name1 TYPE kna1-name1.
*If I wanted NAME1 to have F4 Help attached to it, I could define it locally by using the event AT SELECTION-SCREEN ON VALUE REQUEST
*FOR p_name1. Within that event I'd have to call a Function Module F4IF_INT_TABLE_VALUE_REQUEST. If I defined it for KUNNR on LAND1
*as well, SAP will use my definitions instead of its standard ones because local definitions have priority over global ones.
*I can also define my own custom Search Help that can be used outside of my local program if I define it in SE11. Just like I have
*standard Database Tables, Structures, Type Groups, I also have standard Search Helps provided by SAP.
*I have a custom Database Table ('zbmierzwitest7' in this case) with three fields:
*- MANDT    - Data Element MANDT, Data Type CLNT, Length 3,
*- EMP_ID   - Data Element ZEMP_ID, Data Type INT2, Length 5,
*- EMP_NAME - Data Element ZEMP_NAME, Data Type CHAR, Length 20.
*If I wanted the Search Help to be available only in this particular program, I could handle this in the event AT SELECTION-SCREEN
*ON VALUE REQUEST FOR by calling the Function Module 'F4IF_INT_TABLE_VALUE_REQUEST'. Before that I would create an Internal Table
*containing all the F4 values and that table would be passed into the Function Module.
*But I want my custom F4 values attached to the 'emp_name' to be available wherever I refer to 'emp_name' including different programs.
*The requirement is global so I need to create the Search Help and attach it to the field on the Data Element level.
*When I create the Search Help, I should decide whether I want to provide one input path or multiple input path. When clicking on the
*F4 Help next to the input box, a window will appear. If it has multiple tabs - that's the multiple input path. E.g. if I the KNA1's KUNNR's
*Data Element - KUNNR, in the 'Further Characteristics' tab it has a Search Help attached - C_KUNNR. If I double click it, it says, to the
*left of its name, that it's of the type 'Collective srch hlp' (Collective Search Help). That provides the Data Element with the multiple
*input path type of the Search Help.
*If I want my Data Element to have the Search Help with just a one input path, I should attach the Elementary Search Help to the Data Type.

*---The creation of the global Search Help---
*1) Elementary Search Help.
*In order to create a global Search Help, I need to go to SE11, and provide the name within the input box next to the Search Help radiobutton.
*When the Create button is clicked, I should choose which type of the Search Help I would prefer. In this scenario I am selecting the
*Elementary Search Help as I want just one input path. After providing the usual Short Description, I need to move to the 'Selection Method'
*within the 'Definition' tab. A Selection Method is the source I want the values of my F4 Help to come from can be a Database Table,
*a Database View or a Help View. If I want the values to come from a single table, I can provide a Database Table here. If I want the values
*of my Search Help to come from multiple tables, I need to select a Database View or a Help View. A Database View will use the inner join and
*a Help View will use a left outer join. In my Search Help (named zbm_test_srch_hlp) I am using my custom Database Table (zbmierzwitest7)
*described above. Then I should move down to the 'Parameter' box and provide the 'Search help parameter'. I can use F4 Help here to browse the
*possibilities - it will show me the fields available in the source I provided in the 'Selection Method'. I am choosing the values of which
*column of the source should be suggested to the user. I need to check the 'IMP' box and 'EXP' box. 'IMP' means that when F4 is pressed, a list
*of values is to be displayed and 'EXP' means that when I select a value it is to be provided to the field in the Selection Screen. 'LPos' and
*'SPos' should both have the value of 1. They will be explained in the section about the multiple input path type of the Search Help.
*Now I need to attach the Search Help I created to the Data Element I want to have it. In the example, I want the Data Element of the 'emp_name'
*field to have it. That Data Element is 'zemp_name'. I should open the table and navigate to the Data Element itself and go to the 'Further
*Characteristics' tab. Here, in the 'Search Help' box I should provide the name of my Search Help and provide the parameters. It should suffice
*to F4 the field and select the option. In this case it's 'emp_name'.
*The white sheet button will not be visible next to my field in the Selection Screen, but if I press F4 while the cursor is in the input box of
*the field, I will get the list of possible values.
PARAMETERS: p_ename TYPE zbmierzwitest7-emp_name.

*If the global Search Help I created wasn't attached to the Data Element of 'emp_name' I could still use it freely, but I would need to add
*the addition of MATCHCODE OBJECT <search_help_name> to the parameter.
*Even if 'emp_name' didn't have the Search Help attached to its Data Element, the below code would still work exactly like the above one.
PARAMETERS: p_ename2 TYPE zbmierzwitest7-emp_name MATCHCODE OBJECT zbm_test_srch_hlp.

*2) Collective Search Help.
*I should select the Collective Search Help whenever I want my custom Search Help to have multiple input paths/sets of values.
*A Collective Search Help is made out of multiple Elementary Search Helps. I have two custom Database Tables and two Elementary Search Helps
*created for the sake of the example:
*- Database Table 'zbmierzwitest7' with 'zbm_test_srch_hlp' Search Help,
*- Database Table 'zbmierzwitest8' with 'zbm_test_srch_hlp3' Search Help
*Both the Database Tables and the Search Helps are the same but the Database Tables contain different values.
*I need to start creating the Search Help much like in the case of the Elementary one, but choose the 'Collective search help' radiobutton
*after having pressed 'Create'. In the 'Parameter' section below I need to provide the parameters for my Search Help object. The 'Search help
*parameter' is the name of the parameter and I can call it whatever I desire. I should have 'IMP' and 'EXP' checkboxes checked to make sure that
*pressing F4 will make the list of values be displayed and that clicking a chosen value will provide it to the parameter's input box. I need to
*suppy the Data Element as well. In the case of my Collective Search Help (zbm_test_srch_hlp2) it is 'zemp_name' (from my custom Database Table -
*'zbmierzwitest7/8'). Then I need to go to the 'Included search helps' tab and provide the names of the Elementary Search Helps I want included
*in my Collective Search Help. In my case I am adding 'zbm_test_srch_hlp' and 'zbm_test_srch_hlp3' here. At this stage, if I activated my
*Collective Search Help, SAP will give me the warning of 'No parameter assignment maintained for included search help <name>'. I need to link
*the parameter I provided in the 'Definition' tab with a field from the included Search Helps. In order to do this, I need to move to the
*'Included search helps' tab, select the row with a Search Help and press the 'Param.assignment' button. There I need to browse (the white sheet
*button) the possibilities for the 'Reference parameter' and choose which field should be linked with the Collective Search Help's paramater. I
*think the options are provided based on the Data Element.
*There are three way to use a Collective Search Help:
*- I can attach it on the Data Element's level (provide it within the 'Search Help' box of the Data Element),
*- I can attach it on the Selection Screen's input level (MATCHCODE OBJECT added to the parameter),
*- I can attach it on the Module Pool's level.
PARAMETERS: p_ename3 TYPE zbmierzwitest7-emp_name MATCHCODE OBJECT zbm_test_srch_hlp2.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*MPP. DESIGNING A NEW TRANSACTION WITH THE SCREEN PAINTER.
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
*MPP. FIELDS - DISABLING AND ENABLING, MAKING VISIBLE AND INVISIBLE.
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
*MPP. A MODULE POOL PROGRAM CONTAINING THE TABLE CONTROL COMPONENT.
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



*---------------------------------------------------------------------------------------------------------------------------------
*MPP. VALIDATIONS.
*---------------------------------------------------------------------------------------------------------------------------------

*There are three ways a Module Pool transaction (program?) can be validated:
*1. Automatic field validation.
*2. Flow logic validation.
*3. Module pool validation.
*Every transaction I design has to be validated before any data is processed.

*AUTOMATIC FIELD VALIDATION
***************************
*I am now creating an MP program named 'Z_BM_TEST_MPP4'. I create a new screen for it (100) and move to the layout access the Screen Painter
*tool. I choose GoTo -> Secondary Window -> Dictionary/Program field and provide the 'KNA1' table from which I take KUNNR, LAND1 and ERDAT.
*After having placed the chosen fields in the layout of my screen I choose the Box option from the tool panel on the left hand side and
*draw the box around my previously placed fields. I double click the box, set the Name to 'BX1' and the text to 'Automatic_field_validations'.
*The underscores are added automatically when I press Space. Then I choose the Pushbutton option from the panel on the left and draw a
*button for exiting my application. I double click it, set the Name to 'B1', text 'Exit' and the Function Code to 'FC1'.
*Now I write the logic for my Exit button. Whenever a Module Pool button is clicked, the PAI event is triggered - so it's here that the
*mentioned logic needs to be placed. I go to my screen 100, the Flow Logic tab, uncomment the 'MODULE_USER_COMMAND_0100' in PAI and
*double click it. I place it within the TOP INCLUDE.
*The module looks like that so far:
********************************************************************
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
  	WHEN 'FC1'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
********************************************************************

*Now I create the transaction for my program. The transaction's name is 'ZBMI6', the 'Start object', as always is the case with MP programs,
*is 'Program and dynpro (dialog transaction)' and the 'GUI support' is 'SAP GUI for Windows' which is also a standard. I would also like to
*make the 'Customer' screen field an obligatory one so I go to the Screen Painter tool, double-click the field and in the 'Attributes' section,
*in the 'Program' tab, nex to 'Input' I select the 'required' option.
*If I now push my 'Exit' button after having executed my program, I will get an error message - a validation message. It is a standard message
*provided by SAP. It is thus validation stemming from a property being set at a screen's level. It is the Automatic Field Validation.
*If I provided my 'Country' screen field with a country key that does not exist and tried to exit my program, I would get a message telling me
*that this country code does not exist in T005. This is also the Automatic Field Validation. SAP is looking for the value within a database
*table - this is maintained at the database level. 
*If I provided a wrong date, e.g. 19/26/2018, I would get the 'Invalid date' validation message. This is, yet again, the Automatic Field Validation.
*The Automatic Field Validations are triggered thus either due to certain properties being set at the screen level or properties of the field
*maintained at the database level. If these validations do not pass, I cannot exit the transaction.

*If I want to be able to exit the transaction if the the Automatic Field Validations do not pass - there is a way to do it. I go to the layout
*of my screen (the Screen Painter tool) and draw a second button. Its 'Name' is 'B2' and its 'Text' is 'Cancel'. The 'FctCode' is 'FC2' and I
*additionally set the 'FctType' to 'E Exit command'. This is a property that I need to set if I want my button to be able to take me out of
*the transaction even if the Automatic Field Validations did not pass.
*Apart from doing that I also need to define a dedicated 'AT EXIT COMMAND' module if I want my button to work correctly. Whenever a button is
*clicked, the PAI event is triggered and so its there that said module needs to be placed.
*My screen 100 so far looks like this:
********************************************************************
PROCESS BEFORE OUTPUT.
* MODULE STATUS_0100.
*
PROCESS AFTER INPUT.
 MODULE USER_COMMAND_0100.
 MODULE super_cancel AT EXIT-COMMAND.
********************************************************************
   
*And the newly created in the TOP INCLUDE module looks like that:
********************************************************************
MODULE super_cancel INPUT.
  CASE sy-ucomm.
    WHEN 'FC2'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
********************************************************************

*FLOW LOGIC VALIDATION
**********************
*In case of the Flow Logic Validation, the validation is defined on the flow logic level.
*I go to the Screen Painter tool, create another box with database table's fields. The database table is MARA and the fields chosen are
*MATNR, MTART and MATKL. I draw a 'Box' around the fields box and name it 'BX2'. The text says 'Flow logic validations'.
*I want to make sure that the MTART (material type) field only accept the values of COUP (Coupons), FERT (Finished Product) and FRIP
*(Perishables). Right now, there's a very long list of possible values available due to the data element of the MTART having an F4 Help
*attached by default.
*I can ensure such a restriction by implementing a Flow Logic Validation. I need to add the restriction to the PAI event within my MP
*program. 
*The PAI section within my flow logic now looks as below (it works despite the VALUES keyword beign marked as wrong).
********************************************************************
PROCESS AFTER INPUT.
 FIELD mara-mtart VALUES ('COUP', 'FERT', 'FRIP').
 MODULE USER_COMMAND_0100.
 MODULE super_cancel AT EXIT-COMMAND.
********************************************************************
   
*Right now in my MP program, the Exit button will not allow me to leave the application unless all the required fields are filled
*correctly. Without my new restriction for the material type, the Exit button would work only if there was any value provided to the
*customer input field. With my new restriction the material type input field also needs to be filled - with one of three possible values.
*Otherwise I will get an error message 'Enter a valid value'. In such a scenario, the field has failed the Flow Logic Validation. All the
*other input fields get disabled as a result - no values can be provided at this point. Thus if a field fails the Flow Logic Validation,
*all other input fields are disabled.

*If I want to avoid the disabling of all the input fields in case of the material type field failing the Flow Logic Validation, I need
*to group the fields I want to remain enabled within a CHAIN. All the fields enclosed within it will always remain enabled even if a field
*fails the Flow Logic Validation. This needs to be done within the PAI event. In my case, I want the customer number, the material number
*and the material type to always remain enabled.
*Hence, my PAI event looks as below:
********************************************************************
PROCESS AFTER INPUT.
 CHAIN.
  FIELD kna1-kunnr.
  FIELD mara-matnr.
  FIELD mara-mtart VALUES ('COUP', 'FERT', 'FRIP').
 ENDCHAIN.
 MODULE USER_COMMAND_0100.
 MODULE super_cancel AT EXIT-COMMAND.
********************************************************************

*MODULE POOL VALIDATIONS
************************
*If I want user defined validation messages I should define a Module Pool Validation implementation. The messages of the Automatic Field
*Validations and the Flow Logic Validations are always provided by SAP itself.
*I move back to the Screen Painter tool and draw a fields box of the VBAK database table taking VBELN, ERDAT, ERZET and ERNAM fields. I draw
*a 'Box' around it, name it 'BX3' and set its text to 'Module_pool_validations'.
*I would like all the input fields of that section to be filled automatically with data upon providing the VBELN and pressing Enter. Pressing
*the Enter key in the input field triggers the PAI event and it is here where I need to define my desired logic. To have such an action be
*carried out upon pressing Enter in a particular field, I need to utilize the syntax of 'FIELD <field_name> MODULE <module_name>' and thus
*define a separate module for the action.
*The PAI event's section within the flow logic of my MP program now looks like this:
********************************************************************
PROCESS AFTER INPUT.
 CHAIN.
  FIELD kna1-kunnr.
  FIELD mara-matnr.
  FIELD mara-mtart VALUES ('COUP', 'FERT', 'FRIP').
 ENDCHAIN.
 MODULE USER_COMMAND_0100.
 MODULE super_cancel AT EXIT-COMMAND.
 FIELD vbak-vbeln MODULE get_data.
********************************************************************
 
*The 'get_data' module is created within the TOP INCLUDE and looks like this:
********************************************************************
MODULE get_data INPUT.
  IF vbak-vbeln IS NOT INITIAL.
*I am using a key field in the WHERE clause so SELECT SINGLE it is.
    SELECT SINGLE erdat erzet ernam
      FROM vbak
        INTO (vbak-erdat, vbak-erzet, vbak-ernam)
          WHERE vbeln = vbak-vbeln.
    IF sy-subrc = 0.
      MESSAGE 'The sales document has been found' TYPE 'S'.
    ELSE.
      MESSAGE 'The sales document has not been found' TYPE 'S'.
    ENDIF.
  ELSE.
    MESSAGE 'Please enter a sales document' TYPE 'S'.
  ENDIF.
ENDMODULE.
********************************************************************

*The above will so far not work because if I want to use screen fields in my program, I need to declare them explicitly. I am using four
*fields of the VBAK table and I could use the TABLES keyword complete with the VBAK addition but that would decrease the performance given
*the large number of fields in VBAK itself (TABLES creates a work area and thus a work area with around 200 fields would be made). I could 
*create a structure containing only the four fields of my choosing instead and use it side by side with the TABLES keyword.
*I can also simply declare the fields separately with the DATA keyword but I need to change the names of the fields within the Screen Painter
*tool so that they no longer contain a hyphen. I thus change 'vbak-vbeln' into 'v_vbeln' and all other fields similarly. All mentions of
*the fields need to be amended. I am choosing this method this time.

*The PAI event's section in the flow logic now looks like this:
********************************************************************
PROCESS AFTER INPUT.
 CHAIN.
  FIELD kna1-kunnr.
  FIELD mara-matnr.
  FIELD mara-mtart VALUES ('COUP', 'FERT', 'FRIP').
 ENDCHAIN.
 MODULE USER_COMMAND_0100.
 MODULE super_cancel AT EXIT-COMMAND.
 FIELD v_vbeln MODULE get_data.
********************************************************************
 
*The top part of my TOP INCLUDE looks like this:
********************************************************************
PROGRAM Z_BM_TEST_MPP4.

DATA: v_vbeln TYPE vbak-vbeln,
      v_erdat TYPE vbak-erdat,
      v_erzet TYPE vbak-erzet,
      v_ernam TYPE vbak-ernam.
********************************************************************

*The 'get_data' module looks like this:
********************************************************************
MODULE get_data INPUT.
  IF v_beln IS NOT INITIAL.
    SELECT SINGLE erdat erzet ernam
      FROM vbak
        INTO (v_erdat, v_erzet, v_ernam)
          WHERE vbeln = v_vbeln.
    IF sy-subrc = 0.
      MESSAGE 'The sales document has been found' TYPE 'S'.
    ELSE.
      MESSAGE 'The sales document has not been found' TYPE 'S'.
    ENDIF.
  ELSE.
    MESSAGE 'Please enter a sales document' TYPE 'S'.
  ENDIF.
ENDMODULE.
********************************************************************

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*MPP. TABSTRIP CONTROL.
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



*---------------------------------------------------------------------------------------------------------------------------------
*MPP. MODAL DIALOG BOX.
*---------------------------------------------------------------------------------------------------------------------------------

*A Modal Dialog Box is a pop-up window that allows me to display certain screen elements. Until a Modal Dialog Box is closed, I
*cannot interact with other elements of the screen.
*I want a program that takes a sales document's number as a parameter and, upon hitting Enter, displays a Modal Dialog Box that
*contains the corresponding header data associated with that particular sales document. An Exit button should also be present
*within the bounds of the Modal Dialog Box that takes me back to the main screen of the program.

*I go to SE80 and create a new MP program named 'Z_BM_TEST_MPP6' which includes a TOP INCLUDE. I create a new screen, with the
*number of 100 and move to the Layout. I want to process sales documents so my tables are VBAK and VBAP. I go to Goto ->
*Secondary Window -> Dictionary/Program fields and provide 'VBAK'. I press 'Get from Dictionary' and select VBELN alone. I place
*it somewhere on my screen on proceed to draw a 'Pushbutton' I will use to exit the program. I double click it, give it the name
*of 'B1', text 'Exit' and function code 'FC1'. Now I move on to write the logic for the Exit button. The clicking of a pushbutton
*in the screen triggers the PAI event so I uncomment the SAP provided 'USER_COMMAND_0100' module and double click to create it
*within my TOP INCLUDE.
*The module looks like this:
*********************************************************************
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'FC1'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*********************************************************************

*Now I need to create the transaction code (by right-clicking on the program's name, selecting Create and then Transaction).
*It's name is 'ZBMI8' and its start object 'Program and dynpro (dialog transaction)' Moving forward I need to provide the
*program's name and the screen number which is 0100. I need to check the 'SAP GUI for Windows' radiobutton within the
*'GUI support' section.

*In case of a selection screen, pressing the Enter key in the input field triggers three events one after another. These are
*AT SELECTION-SCREEN ON FIELD, AT SELECTION-SCREEN and AT SELECTION-SCREEN OUTPUT. In case of Module Pool (a dialog screen)
*pressing the Enter key within the input field will trigger the PAI and PBO events.
*So if I want a function to be executed upon hitting the Enter key while in an input box, I need to create a module in the
*PAI event.
*The PAI event within the flow logic section of screen 100 looks like this:
*********************************************************************
PROCESS AFTER INPUT.
 MODULE USER_COMMAND_0100.
 FIELD vbak-vbeln MODULE get_sales_data.
*********************************************************************

*'vbak-vbeln' refers to the screen field of the sales document within my program's main screen. The FIELD keyword is followed
*by the exact screen field's name which is specified within the Screen Painter tool. In order to be able to refer to the
*screen fields I need to declare them explicitly within my program, so I would need to declare:
*********************************************************************
DATA: vbak-vbeln TYPE vbak-vbeln.
*********************************************************************

*... which would not work, because it contains a hyphen. Even if SAP didn't consider it an error (might be a SAP version thing)
*data would simply not be fetched because it technically satisfies the necessity to declare the screen field explicitly... but
*doesn't make it work as if the field was declared.
*I could instead declare my screen field 'vbak-vbeln' like that:
*********************************************************************
TABLES: vbak.
*********************************************************************

*... which technically would work because it would create a work area of VBAK. The problem is it would hinder performance
*of my program because with that declaration I have created a work area with a few hundred fields while I am only going to
*use one.
*A better thing to do is simply to change the name of the field within the Layout of my screen (the Screen Painter tool) as
*it will allow me to declare a single field and will work just fine. I access the Screen Painter tool and change the name
*of the sales document's field to 'v_vbeln' and proceed to change all its mentions in the code as well.
*The PAI event looks like this:
*********************************************************************
PROCESS AFTER INPUT.
 MODULE USER_COMMAND_0100.
 FIELD v_vbeln MODULE get_sales_data.
*********************************************************************
 
*The top part of the TOP INCLUDE looks like this:
*********************************************************************
PROGRAM Z_BM_TEST_MPP6.

DATA: v_vbeln TYPE vbak-vbeln.
*********************************************************************

*The 'get_sales_data' module looks like this:
*********************************************************************
MODULE get_sales_data INPUT.
  IF v_vbeln IS NOT INITIAL.
  ELSE.
    MESSAGE 'Please provide the sales document.' TYPE 'E'.
  ENDIF.
ENDMODULE.
*********************************************************************

*Now to design the Modal Dialog Box itself - I need to prepare a new screen which will be my Modal Dialog Box. I right click
*the name of my program and click Create and then Screen. I give it the number of 200, the description of 'Screen 200' and I
*need to check the 'Modal Dialog Box' radiobutton in the 'Screen Type' section. The point of Modal Dialog Boxes is that until
*they are closed, the user cannot interact with other parts of the window.
*Now I design the layout (move to the Screen Painter tool). I choose Goto -> Secondary Window -> Dictionary/Program fields and
*provide the table VBAK. I select 'Get from Dictionary', choose VBELN, ERDAT, ERZET and ERNAM and place them on my screen. In
*order to solve the problem with the screen fields containing a hyphen I immediately move to change the names of the newly
*created fields. 'vbak-vbeln' becomes 'v_vbeln', 'vbak-erdat' becomes 'v_erdat' and so on. It's not a problem that I will now
*have two different fields called the same ('v_vbeln'). In fact, they will share their one explicit declaration too.
*I also add the button for leaving the Modal Dialog Box - I draw a pushbutton whose name is 'B1', text 'Leave' and function
*code 'FC1'.
*Now I go back to the flow logic section of screen 100. The data that is to be displayed in the Modal Dialog Box is to be fetched
*the moment the Enter key is pressed while in the sales document's input box in the screen. Thus it is within therein created
*'get_sales_data' module that the logic fetching the data is to be written. The moment the described action occurs, 'get_sales_data'
*is triggered and, if the VBELN's screen field is not empty, the code tries to fetch the corresponding data. If it's a success,
*then the Modal Dialog Box (which is a screen of the number of 200!) is called at a specified location.
*- STARTING AT is followed by the coordinates of the top left corner.
*- ENDING AT is followed by the coordinates of the bottom right corner.
*If the fetching does not bring back any results from the database table, a pop-up window with a relevant update is displayed.
*If the Enter key is pressed without a sales document having been provided, a pop-up window asking for one is displayed.
*The 'get_sales_data' module now looks like this:
*********************************************************************
MODULE get_sales_data INPUT.
  IF v_vbeln IS NOT INITIAL.
    SELECT SINGLE vbeln erdat erzet ernam
      FROM vbak
        INTO (v_vbeln, v_erdat, v_erzet, v_ernam)
          WHERE vbeln = v_vbeln.
    IF sy-subrc = 0.
      CALL SCREEN 200 STARTING AT 5 10 ENDING AT 50 20.
    ELSE.
      MESSAGE 'No sales data available for the provided sales document.' TYPE 'I'.
    ENDIF.
  ELSE.
    MESSAGE 'Please provide the sales document.' TYPE 'E'.
  ENDIF.
ENDMODULE.
*********************************************************************

*All the screen fields I am referring to in my MP programs need to be declared explicitly, thus the top part of my TOP INCLUDE
*looks like this:
*********************************************************************
PROGRAM Z_BM_TEST_MPP6.

DATA: v_vbeln TYPE vbak-vbeln,
      v_erdat TYPE vbak-erdat,
      v_erzet TYPE vbak-erzet,
      v_ernam TYPE vbak-ernam.
*********************************************************************

*Now to make the 'Leave' button in the Modal Dialog Box let me go back to the main screen of the program. The main screen of
*the program is called a "parent screen".
*I go to screen 200 and uncomment the 'USER_COMMAND_0200' module in the PAI event. The logic needs to happen in the PAI event
*because that's the event that is triggered upon hitting a button in the screen. I choose my TOP INCLUDE as the destination
*of the new module. The 'LEAVE TO SCREEN 0' part tells SAP to return to the parent screen.
*The module 'USER_COMMAND_0200' now looks like this:
*********************************************************************
MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
  	WHEN 'FC1'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
*********************************************************************

*Now I would like to create my own custom F4 Help for the initial sales document screen field that would include both available
*sales documents (like the SAP-provided default F4 Help does) and the associated net value. Furthermore I want the Help to
*suggest only the documents of the net worth higher than 5.
*The requirement is local to my MP program and not to be shared by multiple objects. Thus I am not to define the Search Help
*on the database level but on the object level.
*In case of selection screen programs, pressing F4 button in an input field, the AT SELECTION-SCREEN ON VALUE REQUEST. Therein
*I ought to call a standard function module ('F4IF_INT_TABLE_VALUE_REQUEST'). In case of MP programs, pressing F4 in an input
*field will make SAP react by triggering the PROCESS ON VALUE-REQUEST event. I need to define the desired behaviour therein,
*in the flow logic section of screen 100.
*It is then here that I once again utilize the syntax to have a specific module be executed for a specific field.
*The bottom part of screen 100's flow logic section looks like this:
*********************************************************************
PROCESS ON VALUE-REQUEST.
 FIELD v_vbeln MODULE get_f4_values.
*********************************************************************
 
*I double-click the new module to be created and make it happen within the TOP INCLUDE. That function will require an internal
*table to store the values for my custom F4 Help to use, so I create it. No work area will be needed.
*The top part of my TOP INCLUDE now looks like this:
*********************************************************************
PROGRAM Z_BM_TEST_MPP6.

DATA: v_vbeln TYPE vbak-vbeln,
      v_erdat TYPE vbak-erdat,
      v_erzet TYPE vbak-erzet,
      v_ernam TYPE vbak-ernam.

TYPES: BEGIN OF t_f4_values,
  vbeln TYPE vbak-vbeln,
  netwr TYPE vbak-netwr,
END OF t_f4_values.
DATA: lt_f4_values TYPE TABLE OF t_f4_values.
*********************************************************************

*Now I define the 'get_f4_values' module. First I need to select the desired fields (VBELN and NETWR) from the database table
*into the internal table I have created previously. I also include the condition of the net value being above 5. If the loading
*of the data was successful, I call the standard function module responsible for handling the F4 Help and provide it with relevant
*data:
*- 'retfield' -    refers to the field for which the F4 Help is being created, so VBELN in my case. It's the name of the field within
*                  the internal table.
*- 'dynpprog' -    refers to the program's name which is stored in the system variable sy-repid.
*- 'dynpnr'   -    is the current screen's number which is stored in the system variable sy-dynnr.
*- 'dynprofield' - is the name of the screen field for which I am to return the values. It is 'V_VBELN' in my case.
*- 'value_org'   - refers to the way the data is transferred. 'S' means 'structure'. Without it, the program will believe there are
*                  no values found.
*- 'value_tab'   - is the internal table I have created to hold the values for the F4 Search Help.
*The 'get_f4_values' module looks like this:
*********************************************************************
MODULE get_f4_values INPUT.
  SELECT vbeln netwr
    FROM vbak
      INTO TABLE lt_f4_values
        WHERE netwr > 5.
  IF sy-subrc = 0.
    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
      EXPORTING
        retfield               = 'VBELN'
        dynpprog               = sy-repid
        dynpnr                 = sy-dynnr
        dynprofield            = 'V_VBELN'
        value_org              = 'S'
      TABLES
        value_tab              = lt_f4_values.
  ELSE.
    MESSAGE 'There is no relevant data for F4 Help to suggest.' TYPE 'I'.
  ENDIF.
ENDMODULE.
*********************************************************************

*Now I want to create my custom F1 Help for my sales document's screen field. In case of a selection screen program, whenever F1 is
*pressed while in an input field, the AT SELECTION-SCREEN ON HELP-REQUEST event is triggered. In case of an MP program, that event is
*PROCESS ON HELP-REQUEST. Much like the PROCESS ON VALUE-REQUEST event, it too must be defined in the main screen's flow logic section
*under the PAI event.
*I create the 'get_f1_help' module and place it within the TOP INCLUDE. Within it I summon a standard function module - 'popup_to_inform'
*that allows me to define a field's custom F1 help. Within the bounds of my help window I can provide whatever information I deem
*necessary for a user to receive.
*The 'get_f1_help' module looks like this:
*********************************************************************
MODULE get_f1_help INPUT.
  CALL FUNCTION 'POPUP_TO_INFORM'
    EXPORTING
      titel         = 'Sales document number'
      txt1          = 'Table name: VBAK'
      txt2          = 'Field name: V_VBELN'
      txt3          = 'Very help, much wow'.
ENDMODULE.
*********************************************************************

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*MPP. DROP-DOWN LISTBOXES.
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



*---------------------------------------------------------------------------------------------------------------------------------
*MPP. SELECT-OPTIONS.
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



*---------------------------------------------------------------------------------------------------------------------------------
*BDC - BATCH DATA COMMUNICATION. MIGRATING DATA FROM A LOCAL TEXT FILE USING DIRECT INPUT METHOD.
*---------------------------------------------------------------------------------------------------------------------------------

*BDC - Batch Data Communication, is used for migrating the data from legacy systems (non-SAP systems) to a SAP system. If a company,
*say - Fluffy Ponies, decided to migrate to SAP, people (me) responsible for making it happen, would need to create a BDC program
*that would read the data from Fluffy Ponies' legacy system and migrate it to SAP's database tables.
*The data to be migrated could be located on a local machine or a server. Irrespective of the location, I need to load the data into
*an internal table and to SAP database tables from there.
*There are many BDC techniques.
*
*TheDirect Input Method is just reading the data from the legacy system into an internal table and directly into SAP. There are no
*validations on the way. First, I need to understand what data is there in the legacy system, I need to know what database tables I
*will be migrating the data to (customer data, material data, vendor data, cost centre data, sales order data, invoice data, purchase
*order data, etc), how many fields there are per record, what is the separateor, what is the delimiter.
*E.g. I have a .txt file on a local machine. It contains the customer data, is named 'POKE' and looks like this:
********************
*666xyz,KA,Dedenne
*729abc,KT,Cubone
*695tal,JH,Cyndaquil
********************
*In this case, the first field is the customer number, the second is the customer's country key and the third is the customer's first
*name. This file contains customer data, has a maximum of three fields per record and fields are separated by a comma. I now need to
*analyse what is my target table within SAP. The database table for storing the customer master data is KNA1. It has 215 fields but
*the legacy system has data only for three fields. I need to understand what are those three fields within SAP.
*The DIM technique does not include checking if the data is valid, I am migrating everything as it is.

*In order to read the data from a local text file, SAP has provided a function module 'GUI_UPLOAD'. It's one mandatory import
*parameter is the filename, all other are optional. Although I also need to provide a table parameter because the function module
*reads the data into an internal table.
*I would like the end-user to be able to provide the file in the runtime of the program. To that end I am taking a path to the
*file as a parameter. To make the life of the end-user easier, I should provide a F4 Help functionality to the input box accepting
*the path. When F4 is pressed, an Open Dialog Box should be opened. When F4 is pressed, the AT SELECTION-SCREEN ON VALUE REQUEST
*event is triggered (it's defined at the bottom of the source code). I could, e.g. display a message here - it will be displayed
*upon hitting F4 within my input box. In order to present the user with an Open Dialog Box where user can choose the path to the
*file I am to use a standard SAP's function module - 'F4_FILENAME'. It will allow the user to conveniently choose the path to the
*file that the program will load. 'F4_FILENAME' has one export parameter (the value returned by the function module) of the type
*IBIPPARMS-PATH. This is the path to the file selected by the user.

*A parameter input box for the end-user to provide the path to the file that contains the data we want to be migrated to a SAP's
*database table.
PARAMETERS: p_fname TYPE string.

*I declare the variable 'lv_path' of the IBIPPARMS-PATH type in order to store the path to the file in a local variable.
DATA: lv_path TYPE ibipparms-path.

*I declare the internal table that will be the FIRST "middle man" between the legacy system's file and SAP's database table. The
*file's records consist of three fields each - customer number, country and name, but the entire record... is a string. So one
*variable within my internal table is enough. To begin with, I am essentially copying the local file's structure within my code.
TYPES: BEGIN OF t_temp,
  str TYPE string,
END OF t_temp.
DATA: lt_temp1  TYPE TABLE OF t_temp,
      lwa_temp1 TYPE t_temp.

*I declare the internal table that will be the SECOND "middle man" between the legacy system's file and SAP's database table. First,
*the data from the local file has been uploaded into 't_temp1' in a "raw" form - it was a text file and I just loaded the data into
*an internal table with a single field of the string type. Now I need to adjust the structure of the data so SAP knows what fields
*and in what way should receive the data within KNA1. The second "middle man" has the data properly split bewtween the correct
*fields but is still not the final "middle man". I can only MODIFY the database table FROM an internal table of an identical
*structure. The second "middle man" has only three fields and KNA1 has 215 of them.
TYPES: BEGIN OF t_temp2,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kna1-land1,
  name1 TYPE kna1-name1,
END OF t_temp2.
DATA: lt_temp2  TYPE TABLE OF t_temp2,
      lwa_temp2 TYPE t_temp2.

*I declare the third and final "middle man". The first one served as the receiver of the data in its raw form from the initial text
*file - its job was to simply load the data as it is into SAP. The second "middle man's" job was to organise the fields correctly -
*split the data into correct fields that correspond to those that will serve as the data's final destination within the database
*table. The third "middle man's" task is to receive the loaded and prepared data into the structure identical to that of the final
*database table's and transfer it into that table.
DATA: lt_temp3  TYPE TABLE OF kna1,
      lwa_temp3 TYPE kna1.

*When the Execute button is pressed, the START-OF-SELECTION event is triggered. So if at the moment of the program's execution
*the input box is not empty and thus a path to the file has indeed been provided - I should read the data from my local text
*file to the temporary internal table. I will use the 'GUI_UPLOAD' function module for this. If no path has been provided, a
*pop-up window with a message is displayed.
START-OF-SELECTION.
  IF p_fname IS NOT INITIAL.
    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING
        filename                      = p_fname
      TABLES
        data_tab                      = lt_temp1.
  ELSE.
    MESSAGE 'Please select a file.' TYPE 'I'.
  ENDIF.

*If the 'lt_temp1' indeed contains the data, I need to properly split it among the fields that I recognised as good destination
*fields within KNA1. So I need the first "middle man" who holds the data in its "raw" form to hand the data to the second "middle man"
*who splits the data into the fields that are the same as the fields of the database table in which that data will be put.
*I iterate through the first "middle man" and for every single one of its records, I am performing the operation of splitting that
*record at every occurence of a comma (since the initial text file had its data organised in this way) and placing the part of the
*string that was split first in the second "middle man's" work area's 'kunnr' field, then in the 'land1' field and then in the 'name1'
*field. The order of the fields is deliberate because that's how the data in the initial text file was organised. If it had the data
*starting with, say, the customer's name, then the 'name1' field should be the first to appear after the INTO keyword. At the end, I am
*appending the data stored within the work area to the second "middle man" and starting the loop anew for the next record of the
*first "middle man".
  IF lt_temp1 IS NOT INITIAL.
    LOOP AT lt_temp1 INTO lwa_temp1.
      CLEAR lwa_temp2.
      SPLIT lwa_temp1-str AT ',' INTO lwa_temp2-kunnr
                                     lwa_temp2-land1
                                     lwa_temp2-name1.
      APPEND lwa_temp2 TO lt_temp2.
    ENDLOOP.
  ENDIF.

*If the data indeed resides within the second "middle man" then it's time to transfer said data into the third "middle man" whose
*structure is identical to that of the target database table.
  IF lt_temp2 Is NOT INITIAL.
    LOOP AT lt_temp2 INTO lwa_temp2.
      CLEAR lwa_temp3.
      lwa_temp3-kunnr = lwa_temp2-kunnr.
      lwa_temp3-land1 = lwa_temp2-land1.
      lwa_temp3-name1 = lwa_temp2-name1.
      APPEND lwa_temp3 TO lt_temp3.
    ENDLOOP.
  ENDIF.

*Finally, I need to transfer the data to the target database table itself. I can do it now, because the third "middle man" has the
*structure identical to that of KNA1 where the data I am processing is going. Yet again, I am starting by making sure there actually
*is any data present with my internal table in order not to perform operations if there's nothing to perform them on.
IF lt_temp3 IS NOT INITIAL.
  MODIFY kna1 FROM TABLE lt_temp3.
  WRITE: / 'The number of records affected: ', sy-dbcnt.
ENDIF.

*In the case of my program, the data contains country keys that are not available in SAP (the list of the country keys that SAP
*recognises is within the T005 dataase table). Thus the keys are invalid, but the data will be blindly inserted into the system
*regardless as I am not performing any validations with the Direct Input Method of the Batch Data Communication. The lack of any 
*validations of the data improves performance but constitues a risk of storing invalid data.

*It is worth noting that the initial file's data isn't bound by any legal contract to have a comma as a separator. It could also
*use a tab as one. In that case my content of the legacy system's text file would look like that:
********************
*666xyz  KA  Dedenne
*729abc  KT  Cubone
*695tal  JH  Cyndaquil
********************
*If that was the case, my program would look slightly different. The 'GUI_UPLOAD' function module has an optional import parameter 
*of 'has_field_separator'. It is a parameter specifically designed to inform the function module if the file's data is separated
*by tabs. Thanks to that property, I can load the data directly into the second "middle man".
*The calling of the 'GUI_UPLOAD' function module would look like this:
*CALL FUNCTION 'GUI_UPLOAD'
*      EXPORTING
*        filename                      = p_fname
*         has_field_separator           = 'X'
*      TABLES
*        data_tab                      = lt_temp2.
*The function module would place the data within the second "middle man's" field according to the order of these fields within that
*internal table, so by creating the second "middle man" in a way that its columns are in the same order as the data within the
*legacy system's text file, I ensure the correct placement of said data.
*This method of handling this task is available only if the separator is a tab. If it's a comma, a semicolon or anything else, I
*need to stick to the original logic of first loading the legacy system's file data into an internal table in its "raw" form.

*To define what happens during the AT SELECTION-SCREEN ON VALUE REQUEST event. Hitting F4 in the parameter input box will display
*the Open Dialog Box allowing the end-user to select the file. The path to the chosen file is returned by the 'F4_FILENAME' function
*module and stored within my 'lv_path' variable. If the path was indeed chosen and a value is present within 'lv_path' - that value
*is assigned to the parameter input box.
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_fname.
*  MESSAGE 'Hello' TYPE 'I'. "This is testing. Upon hitting F4, that message should pop up.
  CALL FUNCTION 'F4_FILENAME'
    IMPORTING
      FILE_NAME           = lv_path.

  IF lv_path IS NOT INITIAL.
    p_fname = lv_path.
  ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*BDC - BATCH DATA COMMUNICATION. MIGRATING DATA FROM A LOCAL TEXT FILE USING THE CALL TRANSACTION TECHNIQUE.
*---------------------------------------------------------------------------------------------------------------------------------

*While the Direct Input Method consists of three levels - the legacy system, an internal table and SAP, the Call Transaction technique
*consist of five - the legacy system -> an internal table -> a BDCDATA internal table -> MP transaction -> SAP.
*First I need to get the data from the legacy system to an internal table, then into a BDCDATA internal table from which I need to
*map the data into a Module Pool dialog transaction from which I need to migrate the data to SAP itself.
*First I need to analyse the file containing the data - in my case it will be a text file stored locally with the customer data with
*three fields - customer number, country code and customer name. The target database table is thus KNA1.
*The file looks like that:
********************
*666xyz  KA  Dedenne
*729abc  KT  Cubone
*695tal  JH  Cyndaquil
********************
*To perform the Call Transaction technique, I need a module pool transaction. Hence I need to develop a module pool program. I go
*to SE80 and create a new program ('Z_BM_TEST_MPP9' in this case) with the TOP INCLUDE, it's 'Type' being 'Module Pool'. Then I
*create a screen (100), its 'Screen Type' being 'Normal'. Then I move to the 'Layout' so design the screen's layout. In this screen
*I need three fields - 'kunnr', 'land1' and 'name1' of the table KNA1 so I choose GoTo -> Secondary Window -> Dictionary/Program Fields
*provide the name of KNA1, take the three fields I require and place them in my screen.
*Now I move to create three buttons and draw them beneath the screen fields. The first one's name is 'B1', text 'Insert' and function
*code 'FC1', the second one is 'B2', 'Exit' and 'FC2' and the third 'B3', 'Cancel' and 'FC3'. The third is to act as a cancel button and
*so I also need to set the 'FctType' (function type) property to 'E Exit command' - this will allow me to perform a forecfull exit which
*means that even a failure to provide the obligatory input fields with values will not prevent the end-user from leaving the program.

*The idea of the Call Transaction technique is that, when the program is executed its Module Pool part's screen will be repeatedly called
*for every record  (thanks to the 'CALL TRANSACTION' part) separately during runtime, that record's data being inserted into the prepared 
*screen fields and the end-user will decide what to do - either 'Insert' the data or 'Cancel' it. The Call Transaction technique allows 
*for all the validations to take place, unlike the Direct Input Method of migrating the data. Every record needs to pass through the 
*transaction so SAP will perform the Automatic Field Validation, Flow Logic Validation and Module Pool Validation.

*When a screen button is pushed in a Module Pool program, the PAI event is triggered. Thus I move to the flow logic section of screen 100, 
*uncomment the 'user_command_0100' module, double-click it, place it within the TOP INCLUDE and proceed to write the logic for the buttons.
*The area for the 'FC1' function code is left void so far, it will be done later. The 'FC2' function code is responsible for the
*"gracious" exit - one that will not be possible if any validation in the screen is failed.
*The "forceful" exit - one that will be possible even if there are failed validations in the screen requires me to define a separate
*module in the flow logic section of the screen. This module will be executed when a button with the function type of 'E' is pressed.
*Thus I create the 'exit_forcefully' module in the PAI event and define it within the TOP INCLUDE. The logic is the same as in the case
*of the "gracious" exit but the "forceful" requires a module with the AT EXIT-COMMAND part.
*The flow logic section of screen 100 looks like this so far:
**********************************************************************
PROCESS BEFORE OUTPUT.
* MODULE STATUS_0100.
*
PROCESS AFTER INPUT.
 MODULE USER_COMMAND_0100.
 MODULE exit_forcefully AT EXIT-COMMAND.
**********************************************************************

*The 'user_command_0100' looks like that:
**********************************************************************
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'FC1'.

    WHEN 'FC2'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
**********************************************************************

*And the 'exit_forcefully' module looks like that:
**********************************************************************
MODULE exit_forcefully INPUT.
  CASE sy-ucomm.
    WHEN 'FC3'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
**********************************************************************

*Now I create the transaction for the program. Its name is 'ZBMI10' and its 'Start object' is 'Program and dynpro (dialog transaction'
*as is always the case for Module Pool programs. Next I need to provide the name of my program ('Z_BM_TEST_MPP9') and the screen
*number (0100). I also need to check the 'SAP GUI for Windows' checkbox in the 'GUI support' section.

*Here I am inserting one record at a time. In order to store the data provided in the screen, I need to declare a work area with
*the type compatibility with KNA1. I will be collecting the data from the screen fields and their names are 'kna1-kunnr',
*'kna1-land1' and 'kna1-name1'. Thus I can simply declare 'TABLES kna1' and that statement will both create the correct work area,
*compatibile with the KNA1 database table AND serve as the explicit declaration of my program's screen fields.
*So now, when the 'Insert' button is pressed (so if the function code is 'FC1') I can simply state 'MODIFY kna1'. That's it. I don't
*need to specify 'FROM kna1' because the work area's name is exactly the same as database table's name. 'FROM kna1' is thus inferred.
*As per the aforementioned idea of the Call Transaction technique - that the Module Pool screen is to be called separately for every
*record that needs to be processed - whatever operation takes place at this stage, I need to 'LEAVE PROGRAM' so the control leaves the 
*Module Pool screen, goes back here (to the executable part of the program) and into the loop (that will be created earlier) which will
*start processing the next record and call the Module Pool screen again but for that next record.
*The top part of my TOP INCLUDE now looks like this:
**********************************************************************
PROGRAM Z_BM_TEST_MPP9.

TABLES: kna1.
**********************************************************************

*And the 'user_command_0100' looks like that:
**********************************************************************
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'FC1'.
      MODIFY kna1.
      IF sy-subrc = 0.
        MESSAGE 'A record has been affected.' TYPE 'I'.
      ELSE.
        MESSAGE 'A record has not been affected.' TYPE 'I'.
      ENDIF.
      LEAVE PROGRAM.
    WHEN 'FC2'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
**********************************************************************

*The recommended way of doing the above is a BAPI instead of MODIFY, INSERT statements.

*Now, that the Module Pool program is complete, I need to perform the actual Call Transaction technique to migrate the data from the
*legacy system. First, I need to read the data from the legacy system into an internal table. The data is stored within the 'POKE2'
*text file. A tab is the separator. *To proceed, I now need to create an executable program (SE38).

*Below begins the structure of the aforementioned executable program.
*To begin with I am to read data from the local text file and into an internal table which I am declaring.
TYPES: BEGIN OF t_kna1,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kna1-land1,
  name1 TYPE kna1-name1,
END OF t_kna1.
DATA: lt_kna1     TYPE TABLE OF t_kna1,
      lwa_kna1    TYPE t_kna1,
*Below is an internal table of the type of a standard SAP structure that is used in this technique of migrating the data. When
*the data is loaded from the legacy system's local text file and into the 'lt_kna1' internal table, I will be mapping that data
*from 'lt_kna1' to the below table.
      lt_bdcdata  TYPE TABLE OF bdcdata,
      lwa_bdcdata TYPE bdcdata.

*Now I need to read the data from the local text file. I am to use the 'GUI_UPLOAD' function module for it. The path to the file
*is hardcoded. I need to inform the function module that the field separator (tab) is indeed present.
CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename                      = 'C:\Users\bartosz.mierzwinski\Desktop\POKE2.txt'
    has_field_separator           = 'X'
  TABLES
    data_tab                      = lt_kna1.

*When the data is present within 'lt_kna1', I am to map the data to the BDCDATA internal table. BDCDATA is a standard SAP structure
*(like SCREEN). If the data is indeed present within 'lt_kna1', I need to map it to 'lt_bdcdata'. I am using PERFORMs here for the
*sake of modularization. My first PERFORM is taking two parameters - the module pool program's name and the screen's number. This
*PERFORM will set the 'lt_bdcdata's' fields that are shared by all the records.
*The second PERFORM - 'map_field_data' populates the 'fnam' and 'fval' fields of the BDCDATA structure. It is called to action for
*every field.
*After all PERFORMs have finished their task for the particular record - the data of that record is successfully mapped to the
*BDCDATA internal table and now I need to call the transaction I created before ('ZBMI10') and provide it with the BDCDATA internal
*table.
IF lt_kna1 IS NOT INITIAL.
  LOOP AT lt_kna1 INTO lwa_kna1.
    PERFORM map_program_data USING 'Z_BM_TEST_MPP9' '100'.
    PERFORM map_field_data USING 'KNA1-KUNNR' lwa_kna1-kunnr.
    PERFORM map_field_data USING 'KNA1-LAND1' lwa_kna1-land1.
    PERFORM map_field_data USING 'KNA1-NAME1' lwa_kna1-name1.
    CALL TRANSACTION 'ZBMI10' USING lt_bdcdata.
  ENDLOOP.
ENDIF.

*&---------------------------------------------------------------------*
*&      Form  MAP_PROGRAM_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*The two passed parameters 'Z_BM_TEST_MPP9' and '100' are received in formal parameters 'p_prgname' and 'p_scrnr' respectively.
*The BDCDATA structure expect me to provide it with five fields per record - 'program', 'dynpro', 'dynbegin', 'fnam' and 'fval'.
*Both 'program' and 'dynpro' are present within the PERFORM due to the parameters passed. 'dynbegin' is an indicator of the
*occurence of a new screen.
FORM map_program_data USING p_prgname p_scrnr.
  REFRESH lt_bdcdata.
  CLEAR lwa_bdcdata.
  lwa_bdcdata-program = p_prgname.
  lwa_bdcdata-dynpro = p_scrnr.
  lwa_bdcdata-dynbegin = 'X'.
  APPEND lwa_bdcdata TO lt_bdcdata.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  MAP_FIELD_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM map_field_data USING p_field_name p_field_value.
  CLEAR lwa_bdcdata.
  lwa_bdcdata-fnam = p_field_name.
  lwa_bdcdata-fval = p_field_value.
ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*BDC - BATCH DATA COMMUNICATION. MIGRATING DATA FROM A TEXT FILE STORED IN APPLICATION SERVER USING THE SESSION METHOD.
*---------------------------------------------------------------------------------------------------------------------------------

*Application server is where SAP is installed. If I want to know the IP Address of my application server I need to go to SAP Logon
*and right-click the name of the server  (e.g. BOD, QMR, MMX) and go to its 'Properties'. I have the Application Server's IP address
*here, e.g. 666.666.666.666. I can access the Application Server's drive from my local system by running the Run command
*(Windows key + R) and providing e.g. "\\666.666.666.666\c" .
*I am most likely going to be asked for the admin's ID and password. The data will be uploaded from a text file stored in the
*Application server - it contains the customer data and looks like this:
********************
*666xyz,KA,Dedenne
*729abc,KT,Cubone
*695tal,JH,Cyndaquil
********************
*The Session technique is similar to the Call Transaction technique but has one additional level. First the data is uploaded from
*the legacy system to an internal table. Then it is mapped from that table to a BDCDATA internal table, but before the data is
*further mapped to the Module Pool transaction, it is mapped from the BDCDATA structure to a Session Object from which the data
*is mapped to the Module Pool transaction.

*To perform the Session technique, I need a module pool transaction. Hence I need to develop a module pool program. I go to SE80
*and create a new program ('Z_BM_TEST_MPP10' in this case) with the TOP INCLUDE, it's 'Type' being 'Module Pool'. Then I create a
*screen (100), its 'Screen Type' being 'Normal'. Then I move to the 'Layout' so design the screen's layout. In this screen I need
*three fields - 'kunnr', 'land1' and 'name1' of the table KNA1 so I choose GoTo -> Secondary Window -> Dictionary/Program Fields
*provide the name of KNA1, take the three fields I require and place them in my screen.
*Now I move to create three buttons and draw them beneath the screen fields. The first one's name is 'B1', text 'Insert' and function
*code 'FC1', the second one is 'B2', 'Exit' and 'FC2' and the third 'B3', 'Cancel' and 'FC3'. The third is to act as a cancel button and
*so I also need to set the 'FctType' (function type) property to 'E Exit command' - this will allow me to perform a forecfull exit which
*means that even a failure to provide the obligatory input fields with values will not prevent the end-user from leaving the program.

*Now I create the logic for the created buttons. Within the flow logic section of screen 100 I uncomment the 'user_command_0100' module
*and define the behaviour for particular function codes. When it's 'FC1' (so when the 'Insert' button has been pressed), the target
*database table is to be modified based on the values present within the screen fields. The syntax 'MODIFY kna1' is enough because I
*declared the 'TABLES kna1' which creates a work area so the 'FROM kna1' part of the MODIFY statement is inferred and the 'TABLES kna1'
*also serves as an explicit declaration of my screen fields because their names are 'KNA1-KUNNR', 'KNA1-LAND1' AND 'KNA1-NAME1'. A
*pop-up window with a message is displayed based on whether the modification was successful or not. If the function code is 'FC2', then
*the 'Exit' button has been pushed and the program should be closed. However this exit will be prevented if any validations have been
*failed in the screen. The 'Cancel' button's ('FC3') logic is defined in a separate module as it has the function type property set to
*'E' ('Exit Command') and thus I need to create a separate module with the 'AT EXIT-COMMAND' addition which handles the function codes
*that had the function type set to 'E'. This button will allow the end-user to leave the program even if the validations have failed.
*The flow lofic section of screen 100 looks like this:
**********************************************************************
PROCESS BEFORE OUTPUT.

PROCESS AFTER INPUT.
 MODULE USER_COMMAND_0100.
 MODULE exit_forcefully AT EXIT-COMMAND.
**********************************************************************

*The TOP INCLUDE looks like this:
**********************************************************************
PROGRAM Z_BM_TEST_MPP10.

TABLES: kna1.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'FC1'.
      MODIFY kna1.
      IF sy-subrc = 0.
        MESSAGE 'A record has been affected.' TYPE 'I'.
      ELSE.
        MESSAGE 'A record has not been affected.' TYPE 'I'.
      ENDIF.
    WHEN 'FC2'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  EXIT_FORCEFULLY  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit_forcefully INPUT.
  CASE sy-ucomm.
    WHEN 'FC3'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
**********************************************************************

*Now I create the transaction for the program. Its name is 'ZBMI11' and its 'Start object' is 'Program and dynpro (dialog transaction'
*as is always the case for Module Pool programs. Next I need to provide the name of my program ('Z_BM_TEST_MPP10') and the screen
*number (0100). I also need to check the 'SAP GUI for Windows' checkbox in the 'GUI support' section.

*Now, that the Module Pool program is complete, I need to perform the actual Session technique to migrate the data from the legacy
*system. First, I need to read the data from the legacy system into an internal table. The data is stored within within a text file in
*an application server. A comma is the separator. To proceed, I now need to create an executable program (SE38).

*Below begins the structure of the aforementioned executable program.
*If the file was stored locally, I could use the 'GUI_UPLOAD' function module to load the data. However it is placed in an application
*server so I declare a variable to store the path to the file which includes the IP address of the application server. 'hedgehog.txt'
*is my file. The 'lv_msg' variable is here to store the possible return message if the reading of the file has not been successful.
*The internal table 'lt_legacy' is the one I will be loading the data into from the legacy system's file.
DATA: lv_path TYPE string VALUE '\\666.666.666.666\c\hedgehog.txt',
      lv_msg  TYPE string.
TYPES: BEGIN OF t_legacy,
  str TYPE string,
END OF t_legacy.
DATA: lt_legacy  TYPE TABLE OF t_legacy,
      lwa_legacy TYPE t_legacy.
*The final internal table is where the above internal table 'lt_legacy' will be chucking the data over. While 'lt_legacy' has one
*field of the string type because it just takes in the "raw" lines of text from the legacy system's file in their entirety, the
*'lt_final' table needs to have a structure that differentiates between the desired fields ('kunnr', 'land1', 'name1' in my case).
TYPES: BEGIN OF t_final,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kna1-land1,
  name1 TYPE kna1-name1,
END OF t_final.
DATA: lt_final  TYPE TABLE OF t_final,
      lwa_final TYPE t_final.
*I also need an internal table of the BDCDATA type. In this case my session object will be giving it the data.
DATA: lt_bdcdata  TYPE TABLE OF bdcdata,
      lwa_bdcdata TYPE bdcdata.

*If the file containing the data is stored locally (so in the "presentation server"), I can use the 'GUI_UPLOAD' function module to
*upload the data, but reaching the file in the application system requires a different mechanism. The OPEN DATASET statement allows
*me to reach the application server, the FOR INPUT part means it's for reading, the IN TEXT MODE means the reading will be done
*line by line. The MESSAGE part of the statement needs to be followed by a variable of the string type. If the file I am trying to
*reach is not reached, the operating system's message will be stored within that variable.
OPEN DATASET lv_path FOR INPUT IN TEXT MODE ENCODING DEFAULT MESSAGE lv_msg.

*If the program has failed to open the file, the appropriate message is contained within the 'lv_msg' variable, so if the 'sy-subrc'
*is not 0, I simply display the message as it tells the end-user what went wrong. If the file has been reached properly, I need to
*start reading it from the first line to the last line. I don't know how long is the file so, to make sure, all the records are read,
*I am writing the logic for reading the file's content within a loop (DO..ENDO LOOP) that is going to be finished only when the reading
*of a line has failed, so when 'sy-subrc' is not 0. If it has been successful and the line has been placed within my work area, I am
*appending the current content of the work area to my internal table. The 'READ DATASET lv_path' changes the lines of the file it reads
*thanks to the concept of the "file pointer". If the file has been successfully read, the file pointer is placed at the beginning of the
*first line. The loop is entered. The 'READ DATASET' statement reads the entire line of the file because it has been opened in the
*'TEXT MODE'. If the reading operation was successful, 'sy-subrc' is set to 0, the content of the work area is appended to the internal
*table and the file pointer automatically goes to the next row of the file because it is within a loop. It will keep repeating over and
*over again until there are no more records to read which is indicated by the failure ('sy-subrc' not being 0) of the READ DATASET. When
*that happenes, the EXIT keyword will make the control leave the current loop.
*When all the lines of the file have been read and the loop is finished, I should use the statement of 'CLOSE DATASET' to close the
*file that I was reading. It should be done before leaving the loop altogether.
IF sy-subrc = 0.
  DO.
    CLEAR lwa_legacy.
    READ DATASET lv_path INTO lwa_legacy-str.
    IF sy-subrc = 0.
      APPEND lwa_legacy TO lt_legacy.
    ELSE.
      CLOSE DATASET lv_path.
      EXIT.
    ENDIF.
  ENDDO.
ELSE.
  WRITE: / lv_msg.
ENDIF.

*Now, if my temporary internal table indeed has records within it, I need to transfer the data from it to the final internal table.
*I iterate through 'lt_legacy' and for every single one of its records, I am performing the operation of splitting that record at
*every occurence of a comma (since the initial text file had its data organised in this way) and placing the part of the string that
*was split first in 'lt_final's' work area's 'kunnr' field, then in the 'land1' field and then in the 'name1' field. The order of
*the fields is deliberate because that's how the data in the initial text file was organised. If it had the data starting with, say,
*the customer's name, then the 'name1' field should be the first to appear after the INTO keyword. At the end, I am appending the
*data stored within the work area to 'lt_final' and starting the loop anew for the next record of 'lt_legacy'.
IF lt_legacy IS NOT INITIAL.
  LOOP AT lt_legacy INTO lwa_legacy.
    CLEAR lwa_final.
    SPLIT lwa_legacy-str AT ',' INTO lwa_final-kunnr
                                     lwa_final-land1
                                     lwa_final-name1.
    APPEND lwa_final TO lt_final.
  ENDLOOP.
ENDIF.

*Now, before I map the data to the BDCDATA intenal table, I need to create the session object given the 'lt_final' internal table
*indeed has values stored within it. To do it, I need to utilize the 'BDC_OPEN_GROUP' function module. The 'group' property is the
*name of the session object and can be named whatever. The 'holddate' property indicates until when the object is not processable.
*The 'keep' property with the 'X' means the session object will be available even after processing.
IF lt_final IS NOT INITIAL.
  CALL FUNCTION 'BDC_OPEN_GROUP'
    EXPORTING
      CLIENT                    = SY-MANDT
      GROUP                     = 'S1'
      HOLDDATE                  = '20230530'
      KEEP                      = 'X'
      USER                      = SY-UNAME.

*Now to map the data from 'lt_final' to 'lt_bdcdata'. To populate the BDCDATA structure, I need to map the program's information
*first and then map the individual fields. To map the program's information, I create the 'map_program_info' perform which is
*USING my module pool program's name and its screen's number.
*Afterwards I need to map all the fields' data as well. My perform takes in the name of the field and the value of the field as
*parameters.
  LOOP AT lt_final INTO lwa_final.
    PERFORM map_program_info USING 'Z_BM_TEST_MPP10' '100'.
    PERFORM map_field_info USING 'KNA1-KUNNR' lwa_final-kunnr.
    PERFORM map_field_info USING 'KNA1-LAND1' lwa_final-land1.
    PERFORM map_field_info USING 'KNA1-NAME1' lwa_final-name1.
*In case of the Call Transaction technique, when the BDCDATA structure is populated, I call the transaction directly
*(CALL TRANSACTION <program_same> USING <my_bdcdata_internal_table). In case of the Session technique, I need to map the data to
*the session object first. In order to do it, I use the 'BDC_INSERT' function module. I need to provide it with the transaction
*code of the module pool part of my program ('ZBMI11') and the name of the BDCDATA internal table I populated with the data
*previously.
    CALL FUNCTION 'BDC_INSERT'
      EXPORTING
        TCODE                  = 'ZBMI11'
      TABLES
        DYNPROTAB              = lt_bdcdata.   
  ENDLOOP.
  
*When all the data has been processed (the loop ended), I should close the session object. The 'BDC_CLOSE_GROUP' function module
*does not require any parameters and is smart enough to know what session object I want closed.
  CALL FUNCTION 'BDC_CLOSE_GROUP'.
ENDIF.

*When the program here is executed the transaction will NOT be displayed like it was in case of the Call Transaction technique.
*Instead of calling the transaction after having populated the BDCDATA structure, I am mapping the data to the session object and
*executing the program creates that session object. In order to process the session object, I need to go to the SM35 transaction.
*I should see 'Batch Input: Session Overview' at the top of the screen and my session object in the table control below. In case
*of my program here, I should see the 'Lock Date' field with the value of 30.05.2023 because when creating the session object with
*the help of the 'BDC_OPEN_GROUP' function module I set the 'HOLDDATE' property to that date. If I want to process the session
*object, I need to press the 'Process' button (F8). If I tried to do that before 30.05.2023, I wouldn't be able to due to the
*lock date being set. I can unlock the object by pressing the 'Unlock' button in the application toolbar in SM35 (or simply by
*not adding any 'HOLDDATE' in the frist place).
*When I hit the 'Process' button and there's no active lock, SAP will ask me whether I want to process the session object in the
*'foreground' or 'background' mode. If I check the 'Process/foreground' radiobutton and push the 'Process' button, my module pool
*transaction will be triggered and I will be at the same stage I would be in if I used the CALL TRANSACTION statement after
*having populated the BDCDATA structure.
*When all the data has been processed, I should see a pop-up window with a text message of 'Processing of batch input session
*completed'. If I choose the 'Session overview' button I will be taken back to SM35. My session object should have a white box
*with a green checkmark icon in the 'Status' columns which means the session object is processed. I am still able to see the session
*object here even after the processing because while I was creating the session object I set the 'KEEP' property to 'X'. Without
*it, the session object would not be visible here after the processing. I think it's a good idea to have the 'KEEP' property have
*the 'X' value because that will allow me to see the log.

*An advatnge of the session technique is that a log is generated automatically here. If my session object is still here after the
*processing (if it's been KEPT, hehe), I can choose the 'Log' option from the application toolbar. Then I can go deeper by choosing
*the 'Analyze session' button. Here I have a tab called 'Log created on <date>'. If I enter that tab I can see the entire history
*of processing the session object. E.g. if there were any errors on the way, e.g. one of the records had a country code unknown to
*SAP, I will see a proper message here within the log, informing me what went wrong. The changes made in the screen are neatly
*tracked here, e.g. I have the information at what exact time the 'KNA1-KUNNR' screen field changed the value from one to another.

*The Session technique is not an immediate process, while the Call Transaction technique acts immediately. In case of the Session
*technique the data is held within the session object and I can process it at a later point in time by accessing SM35.
*The Call Transaction technique is an asynchronous process while the Session technique is a synchronous process. In case of a
*synchronous process internally an acknowledgement is noted after every record has been processed and the next record is processed
*only after said acknowledgement has been noted. In case of an asynchronous process, no such acknowledgement is had SAP immediately
*starts processing the next record after being done with the previous one. The Call Transaction technique is thus faster than the 
*Session technique.
*On the other hand, in case of the Session technique an automatic log is generated which I can analyse later. If I want a log with
*the Call Transaction I would need to generate it manually.

*&---------------------------------------------------------------------*
*&      Form  MAP_PROGRAM_INFO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*The internal table itself is refreshed because, after all the program's data and all the fields' data have been placed within,
*the module pool part of the program is called using that table, the data housed within is placed into proper screen fields based
*on the fields' names that the BDCDATA structure is provided with and when the record is processed, the cycle repeats itself so
*the BDCDATA structure is always to contain just one record at a time.
FORM map_program_info USING p_program_name p_screen_number.
  REFRESH lt_bdcdata.
  CLEAR lwa_bdcdata.
  lwa_bdcdata-program = p_program_name.
  lwa_bdcdata-dynpro = p_screen_number.
  lwa_bdcdata-dynbegin = 'X'.
  APPEND lwa_bdcdata TO lt_bdcdata.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  MAP_FIELD_INFO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM map_field_info USING p_field_name p_field_value.
  CLEAR lwa_bdcdata.
  lwa_bdcdata-fnam = p_field_name.
  lwa_bdcdata-fval = p_field_valie.
  APPEND lwa_bdcdata TO lt_bdcdata.
ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*BDC - BATCH DATA COMMUNICATION. MIGRATING DATA FROM A LOCAL EXCEL FILE USING THE CALL TRANSACTION METHOD WITH A MANUAL LOGGING.
*---------------------------------------------------------------------------------------------------------------------------------

*First of all I need to read the data from a local Excel file into an internal table. In case of a text file, I would use the
*'GUI_UPLOAD' function module. In case of an Excel file I should use the 'TEXT_CONVERT_XLS_TO_SAP' function module. It has two
*mandatory parameters. One is of the 'TRUXS_T_TEXT_DATA' type. It is an internal table and the second is of the 'RLGRAP-FILENAME'
*type so it is a field of the 'RLGRAP' structure. That field is of the 'CHAR' type and of the length of 128.
*'TEXT_CONVERT_XLS_TO_SAP' returns a table.

*My Excel file is called 'POKE3' and looks like this:
***************************
*     A   |  B |   C
*-------------------------
*1 666xyz | KA | Dedenne
*-------------------------
*2 729abc | KT | Cubone
*-------------------------
*3 695tal | JH | Cyndaquil
**************************

*First I declare an internal table to receive the data from the local Excel file via the aforementioned function module. I need
*to understand what kind of data I am migrating and which SAP's database table and what fields of it should that data go to. I
*recognised here I am dealing with customer data. I have a customer number, country code and customer name. Thus, KNA1 it is as
*it is the customer master data database table of SAP.
TYPES: BEGIN OF t_kna1,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kna1-land1,
  name1 TYPE kna1-name1,
END OF t_kna1.
DATA: lt_kna1  TYPE TABLE OF t_kna1,
      lwa_kna1 TYPE t_kna1,
*The function module I will be using to load the data from the Excel file to my internal table requests a parameter of the
*'TRUXS_T_TEXT_DATA' type.
      lt_truxs TYPE truxs_t_text_data,
*It also required a parameter of the 'RLGRAP-FILENAME' type for the path to the Excel file.
      lv_filename TYPE rlgrap-filename VALUE 'c:\POKE3.xls'.

*The data from the Excel file found due to the provided path ('lv_filename') is loaded into the internal table that has been
*prepared to receive the data into specific fields. If my internal table was constructed in a way that the customer name would
*be the first column, then what is actually a customer number (the first information in the Excel file) would end up in that
*customer name field. The 'lt_truxs' internal table is kind of here for the ride. It is a part of the 'TRUXS' type group so,
*if I am working in an older version of SAP, I might be told that this structure is unknown. If it is so, I need to declare 
*the 'TYPE-POOLS: truxs.' at the top of the program. Once upon a time working with elements belonging to a type group required
*the declaring of that type group. It was the case until version 6.0.
CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
  EXPORTING
    i_tab_raw_data             = lt_truxs
    i_filename                 = lv_filename
  TABLES
    i_tab_converted_data       = lt_kna1.
	
*If the data is indeed present in 'lt_kna1', I need to map that data now to a BDCDATA structure which will then be going to
*the module pool screen which, suprisingly, needs to be created.
*Hence I need to develop a module pool program. I go to SE80 and create a new program ('Z_BM_TEST_MPP10' in this case) with the 
*TOP INCLUDE, it's 'Type' being 'Module Pool'. Then I create a screen (100), its 'Screen Type' being 'Normal'. Then I move to the 
*'Layout' so design the screen's layout. In this screen I need three fields - 'kunnr', 'land1' and 'name1' of the table KNA1 so 
*I choose GoTo -> Secondary Window -> Dictionary/Program Fields and provide the name of KNA1, take the three fields I require and 
*place them in my screen. Now I move to create three buttons and draw them beneath the screen fields. The first one's name is 'B1', 
*text 'Insert' and function code 'FC1', the second one is 'B2', 'Exit' and 'FC2' and the third 'B3', 'Cancel' and 'FC3'. The third 
*is to act as a cancel button and so I also need to set the 'FctType' (function type) property to 'E Exit command' - this will 
*allow me to perform a forecfull exit which means that even a failure to provide the obligatory input fields with values will not 
*prevent the end-user from leaving the program.

*Now I create the logic for the created buttons. Within the flow logic section of screen 100 I uncomment the 'user_command_0100' module
*and define the behaviour for particular function codes. When it's 'FC1' (so when the 'Insert' button has been pressed), the target
*database table is to be modified based on the values present within the screen fields. The syntax 'MODIFY kna1' is enough because I
*declared the 'TABLES kna1' which creates a work area so the 'FROM kna1' part of the MODIFY statement is inferred and the 'TABLES kna1'
*also serves as an explicit declaration of my screen fields because their names are 'KNA1-KUNNR', 'KNA1-LAND1' AND 'KNA1-NAME1'. A
*pop-up window with a message is displayed based on whether the modification was successful or not. If the function code is 'FC2', then
*the 'Exit' button has been pushed and the program should be closed. However this exit will be prevented if any validations have been
*failed in the screen. The 'Cancel' button's ('FC3') logic is defined in a separate module as it has the function type property set to
*'E' ('Exit Command') and thus I need to create a separate module with the 'AT EXIT-COMMAND' addition which handles the function codes
*that had the function type set to 'E'. This button will allow the end-user to leave the program even if the validations have failed.
*The flow lofic section of screen 100 looks like this:
**********************************************************************
PROCESS BEFORE OUTPUT.

PROCESS AFTER INPUT.
 MODULE USER_COMMAND_0100.
 MODULE exit_forcefully AT EXIT-COMMAND.
**********************************************************************

*The TOP INCLUDE looks like this:
**********************************************************************
PROGRAM Z_BM_TEST_MPP10.

TABLES: kna1.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'FC1'.
      MODIFY kna1.
      IF sy-subrc = 0.
        MESSAGE 'A record has been affected.' TYPE 'I'.
      ELSE.
        MESSAGE 'A record has not been affected.' TYPE 'I'.
      ENDIF.
    WHEN 'FC2'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  EXIT_FORCEFULLY  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit_forcefully INPUT.
  CASE sy-ucomm.
    WHEN 'FC3'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
**********************************************************************

*Now I create the transaction for the program. Its name is 'ZBMI11' and its 'Start object' is 'Program and dynpro (dialog transaction'
*as is always the case for Module Pool programs. Next I need to provide the name of my program ('Z_BM_TEST_MPP10') and the screen
*number (0100). I also need to check the 'SAP GUI for Windows' checkbox in the 'GUI support' section.

*Now, that the Module Pool program is complete, I need to populate the BDCDATA structure. In order to do it I need to map the program's
*information first and then map the individual fields. To map the program's information, I create the 'map_program_info' perform which
*is USING my module pool program's name and its screen's number. Afterwards I need to map all the fields' data as well. My perform takes
*in the name of the field and the value of the field as parameters.
*Afterwards I am calling the module pool screen created beforehand with the addition of "USING lt_bdcdata" to ensure that with every
*iteration of the loop, I will have the module pool screen displayed and its fields filled with the data previously mapped into the
*BDCDATA structure. Additionally, the "MESSAGES INTO lt_bdcmsgcoll" addition (hehe) ensures that the internal table will contain all
*the messages' IDs and using these IDs I can collect the messages.
IF lt_kna1 IS NOT INITIAL.
  LOOP AT lt_kna1 INTO lwa_kna1.
    PERFORM map_program_info USING 'Z_BM_TEST_MPP10' '100'.
    PERFORM map_field_info USING 'KNA1-KUNNR' lwa_kna1-kunnr.
    PERFORM map_field_info USING 'KNA1-LAND1' lwa_kna1-land1.
    PERFORM map_field_info USING 'KNA1-NAME1' lwa_kna1-name1.
    CALL TRANSACTION 'ZBMI11' USING lt_bdcdata MESSAGES INTO lt_bdcmsgcoll. 
  ENDLOOP.
ENDIF.

*Now the program works in terms of migrating the data from the Excel file to one of SAP's database tables, but I also want the logging
*to take place. In order to generate a log in the Call Transaction technique I need to employ the Error Handling jutsu. In this case
*at least "Error handling" means "generating a log". Just like I have the BDCDATA structure, SAP has also provided me with the BDCMSGCOLL
*structure and I can use it to collect messages in the SAP system. The structure has first been declared and then populated due to the
*"MESSAGES INTO lt_bdcmsgcoll" code above, in the "CALL TRANSACTION" statement. That operation though provides the BDCMSGCOLL structure
*only with the IDs of the messages and now I need to collect the messages themselves.
*In order to do it I am to iterate through the BDCMSGCOLL structure and for every ID stored within call a standard SAP's function module
*'FORMAT_MESSAGE'. This function module returns a message based on the parameters stored previously within 'lt_bdcmsgcoll'. In order to
*know what fields of the internal table I need to assign to the particular fields of the function module I am comparing their descriptions
*or names, e.g. 'no' wants a number and the BDCMSGCOLL structure has a field called "message number" so this one goes there.
*Previously I have created an internal table - 'lt_log' on which a file with log on the application server will be based. This internal
*table has two fields - one of the string type to store the message and one of the alphanumeric type to store the number of the record. 
*While the function module returns the message, I can simply use 'sy-tabix' to number my records as the system variable auto-increments
*with every iteration of the loop. 
IF lt_bdcmsgcoll IS NOT INITIAL.
  LOOP AT lt_bdcmsgcoll INTO lwa_bdcmsgcoll.
    CLEAR lwa_log.
    CALL FUNCTION 'FORMAT_MESSAGE'
      EXPORTING
        id              = lwa_bdcmsgcoll-msgid
        lang            = sy-lang
        no              = lwa_bdcmsgcoll-msgnr
        v1              = lwa_bdcmsgcoll-msgv1
        v2              = lwa_bdcmsgcoll-msgv2
        v3              = lwa_bdcmsgcoll-msgv3
        v4              = lwa_bdcmsgcoll-msgv4
      IMPORTING
        msg             = lwa_log-msg.
    lwa_log-recno = sy-tabix.  
  ENDLOOP.
ENDIF.

*When my custom internal table ('lt_log') is filled with the collected messages, I need to write the log into local a text file. Much like
*the 'GUI_UPLOAD' function module is used for reading, the 'GUI_DOWNLOAD' function module is used for writing. The 'filename' field is the
*path to where the file is to be created and its name. The 'write_field_separator' field is used to indicate if the separator should be a 
*tab. The 'data_tab' field is the table that contains the information that is to be written. The function module will create a text file
*containing all the previously collected messages.
IF lt_log IS NOT INITIAL.
  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
      filename                        = 'C:\Users\bartosz.mierzwinski\Desktop\test_log'
      write_field_separator           = 'X'
    TABLES
      data_tab                        = lt_log.
ENDIF.

*Now I need to move the file to the application server as per the initial requirement. The 'lv_path' variable is the path to the location
*in the application server where I want the file stored and the name of the file. The 'lv_msg' variable is used by the "MESSAGE(...) part
*of the OPEN DATASET statement. If there is a problem with the creating of the file the operating system's message will be stored within
*'lv_msg'. When I was reaching to an application server in order to read a file, the "FOR INPUT" addition was used. Now I want to write a
*file into the application server so "FOR OUTPUT" it is. 'sy-subrc' will assume the value of 0 if the file is successfully created for
*writing purposes by the "OPEN DATASET(...)" part. I need to actually transfer the data from my internal table to the created file. This
*is done by looping through my internal table that contains the number of every message and the message itself. Within the loop I am
*concatenating both the number and the message to my string variable ('lv_msg') and then, courtesy of the TRANSFER statement, transferring
*every record of the internal table into the file created by the OPEN DATASET statement. When it's done, I need to CLOSE DATASET to close
*the connection.
  DATA: lv_path TYPE string VALUE '666.666.666.666\c\test_log',
        lv_msg  TYPE string.
  OPEN DATASET lv_path FOR OUTPUT IN TEXT MODE ENCODING DEFAULT MESSAGE lv_msg.
*If the creation of the file in the application server is successful...
  IF sy-subrc = 0.
    LOOP AT lt_log INTO lwa_log.
      CLEAR lv_msg.
      CONCATENATE lwa_log-recno lwa_log-msg INTO lv_msg SEPARATED BY space.
      TRANSFER lv_msg TO lv_path.
    ENDLOOP.
    CLOSE DATASET lv_path.
  ELSE.
*If the creation of the file in the application server is not successful - print out the operating system's message to tell me what is wrong.
    WRITE lv_msg.
  ENDIF.
ENDIF.

*The Call Transaction Technique is asynchronous while the Session Technique is synchronous. That means the Call Transaction Technique
*will not wait to see the status of the migrated record before migrating the next one. The Session Technique will check the status of
*the record before migrating another. The Session Technique also automatically generates logs while in the case of the Call Transaction
*Technique I need to create it manually.

*&---------------------------------------------------------------------*
*&      Form  MAP_PROGRAM_INFO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM map_program_info USING p_program_name p_screen_number.
  REFRESH lt_bdcdata.
  CLEAR lwa_bdcdata.
  lwa_bdcdata-program = p_program_name.
  lwa_bdcdata-dynpro = p_screen_number.
  lwa_bdcdata-dynbegin = 'X'.
  APPEND lwa_bdcdata TO lt_bdcdata.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  MAP_FIELD_INFO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM map_field_info USING p_field_name p_field_number.
  CLEAR lwa_bdcdata.
  lwa_bdcdata-fnam = p_field_name.
  lwa_bdcdata-fval = p_field_number.
  APPEND lwa_bdcdata TO lt_bdcdata.
ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*BDC - RECORDING A PROGRAM WITH A LOCAL TEXT FILE.
*---------------------------------------------------------------------------------------------------------------------------------

*Generally whenever I want to do the data migration, I am not writing the program but recording it. First I need to understand the
*data that is going to be migrated - the format of the file, how many fields per record there are, what's the separator. When the
*program is generated after the recording, I will need to modify it manually.
*To record a transaction, I need to understand the entire process of the migration and perform it for a single record using sample
*data. That is because that's how recording takes place - I do the process manually once and SAP remembers how it's done.
*My exemplary file contains the fields MATNR, MBRSH, MTART and MEINS that belong to the table MARA and MAKTX from MAKT. Thus I see
*I need to create a material. I have the MM01 transaction that is used for creating the materials. If I have analysed the legacy
*data and realized there's no relevant SAP transaction, I need to create that transaction.

*In order to start recording I need to go to the SHDB transaction. Here I should hit the 'New recording' button. This is the first
*screen. Here I need to provide the name to the recording and the transaction code I want recorded. In my case it's MM01 because I
*want to create a new material. Then I need to press the 'Start recording' button. This will take me to the initial screen of the
*transaction I am recording.
*Here I need to provide all the necessary parameters, a sample record. I am providing the 'Material' (a name, e.g. ZBMTESTMAT, the
*'Industry sector' (e.g. Chemical Industry) and the 'Material Type' (e.g. FERT-Finished Product). Then I should press Enter.

*Upon hitting Enter I am transported to a second screen - a pop-up window appears. Within here I choose the 'Basic data 1' option.
*Now the third screen appears in which I am providing a description and filling the 'Base Unit of Measure' field with the value of
*'KG'. Now I save the progress. I should get the message that the recording is complete and SAP should display the recorded details
*mapped to the fields of a BDCDATA structure. The columns I see here are the BDCDATA columns.
*In the second row I should see a record - it indicates the first screen I visited. The program's name should be 'SAPLMGMM' and the
*screen number should be '0060'. Since it is a new screen the DYNBEGIN field of BDCDATA (the column's header is called 'Start ID'
*here) assumes the value of 'X'. Whenever a new screen starts the DYNBEGIN field ('Start ID here) is set to have the value of 'X'.
*Within this recorded details' screen I need to make note of the field names for which I entered the sample data. In the 'Field name'
*column I can see e.g. the RMMG1-MATNR field with ZBMTESTMAT in the column next right next to it. This is the name of the field where
*I put my material's name. Underneath there's the RMMG1-MBRSH field and RMMG1-MTART field corresponding to the provided 'Industry
*sector' and 'Material Type' respectively.
*I need to remember the names of these fields because I will need them if I want to be able to implement any changes.
*Then I can see (preferably in the 8th row) that a new screen has begun ('0070'). In the second screen I didn't provide any data.
*I only selected one of the available options - the first one, which is indicated by the '(01)' part of the MSICHTAUSW-KZSEL (01)
*value of the 'Field name' column.
*In the third screen ('4004') I provided the description and the base unit of measure. That's MAKT-MAKTX and MARA-MEINS respectively.

*I should move back now (F3) and my recording should be available. The column 'Transact.' indicates how many transactions have
*been recorded and the 'Screens' one how many screens. I need to select my recording and press the 'Program' button in the Application
*Toolbar. I will be prompted to provide the name for my new program. In my case it's 'ZBM_RECORDED_BDC_MM01_TEST'. The 'Field contents'
*should be left as the defauly 'Read from file'. When I proceed, I will be asked to provide a short description of the program. Its
*type is 'Executable program'. To commence forth, I should select the 'Source code' button.
*Doing the above will generate the program for me based on the previously created recording. I need to modify it to properly read the
*data from the legacy system.

*I need to read the file with the data before the START-OF-SELECTION event. The file in my case is stored locally and the separator
*is a comma. Because it is a comma, I will require two internal tables to process the data correctly. If it was a tab, one internal
*table would suffice. 
*The first table will contain just one field - every record will become one string within the table and I will
*split the data later on while moving it into the second table.
*The second table's fields are the same fields five that SAP recorded for me.
TYPES: BEGIN OF t_legacy,
  string TYPE string,
END OF t_legacy.
DATA: lt_legacy  TYPE TABLE OF t_legacy,
      lwa_legacy TYPE t_legacy.

TYPES: BEGIN OF t_final,
  matnr TYPE rmmg1-matnr,
  mbrsh TYPE rmmg1-mbrsh,
  mtart TYPE rmmg1-mtart,
  maktx TYPE makt-maktx,
  meins TYPE mara-meins,
END OF t_final.
DATA: lt_final  TYPE TABLE OF t_final,
      lwa_final TYPE t_final.
	  
*I need to decide which of the code generated by SAP is necessary and which isn't. Right after the START-OF-SELECTION begins, SAP now
*calls the subroutine 'open_dataset' which is a standard SAP subroutine which I can only display. As the name possibly might suggest
*the OPEN DATASET statement is used there. The FOR INPUT variant. This statement should be used when the file I will be migrating the
*data from is stored in an application server. In my case it is stored locally so I can safely lob that subroutine out the window or
*comment it out.
*In order to read the data from a local file, the 'GUI_UPLOAD' function module is to be used. I use it to move the data from the legacy
*file into the initial internal table.
*The 'filename' field is the path to the file. The 'data_tab' field is the internal table into which the data will be read.
*If there indeed is data within the 'lt_legacy' internal table, I need to transfer it to the 'lt_final' internal table that will hold
*the data properly divided into fields. To achieve this, I need to SPLIT what's in 'lt_legacy' as every record there is a line. The order
*of the fields mentioned at the end of the SPLIT statement matters. At every occurence of a comma what came before it is put into the
*next mentioned field.
CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename                      = 'd:\MATERIAL.txt'
  TABLES
    data_tab                      = lt_legacy.
IF lt_legacy IS NOT INITIAL.
  LOOP AT lt_legacy INTO lwa_legacy.
    CLEAR lwa_final.
    SPLIT lwa_legacy-string AT ',' INTO lwa_final-matnr
                                        lwa_final-mbrsh
                                        lwa_final-mtart
                                        lwa_final-maktx
                                        lwa_final-meins.
    APPEND lwa_final TO lt_final.
  ENDLOOP.
ENDIF.

*Now what needs to happen is the mapping of the data from 'lt_final' to the BDCDATA structure. SAP has already generated this part, but
*I need to make sure it's done correctly. The 'open_group' subroutine creates a session object in case of the Session Technique being
*deployed. I am not commenting it out as it is relevant for what I am doing.
*The generated program is using the DO loop, but I am trading it for LOOP loop. The generated program has also created the 'READ DATASET
*dataset INTO record.' statement which I will not require as it is used to read the data from an application server and mine is stored
*locally.
*Within the loop I need to map the program's information as well as the individual fields' information to the BDCDATA structure. SAP
*has generated a few subroutines for that. The 'bdc_dynpro' one maps the program data and does it just right so I am leaving that one
*where it is. The generated 'bdc_data' subroutine maps the fields' information to the BDCDATA structure. Right now the fields passed
*into the subroutines are a part of the 'record' structure  so I am changing their origin into my work area that the data is being looped
*into. The first and second callings of the 'bdc_field' subroutine are automatically generated and I shouldn't concern myself with them.
*The occurences of the 'bdc_field' subroutine that map my fields mention the fields' names as provided by SAP after I recorded the
*process - hence the combination of weird 'RMMG1' first and simple 'MAKT' and 'MARA' later on. They are a bit scattered around so I
*need to locate them amongst all other occurences of the calling of the subroutine performed by SAP itself. The 'bdc_transaction'
*subroutine was generated by SAP and decides what kind of the migration technique will be used - be it the Session or the Call Transaction
*one. If it's Session, the 'BDC_INSERT' function module is called. If it's Call Transaction - the statement "CALL TRANSACTION TCODE USING
*BDCDATA" takes place. The occurence of 'bdc_field' subroutine with the parameters "'MSICHTAUSW-KZSEL(01)' 'x'" has also been changed.
*The second parameter used to be "record-KZSEL_01_004". The 'X' it has been traded for is an indication for SAP that, when leaving
*the first screen of the transaction and arriving at the next, the first option (indicated by the string - the first parameter) should
*be checked. It's the 'Basic Data 1' option from the second screen.
*The mapping of the data looks as below:
LOOP AT lt_final INTO lwa_final.
  PERFORM bdc_data        USING 'SAPLMGMM' '0060'.
  PERFORM bdc_field       USING 'BDC_CURSOR' 'RMMG1-MTART'.
  PERFORM bdc_field       USING 'BDC_OK_CODE' '=ENTR'.
  PERFORM bdc_field       USING 'RMMG1-MATNR' lwa_final-matnr. "<---changed here
  PERFORM bdc_field       USING 'RMMG1-MBRSH' lwa_final-mbrsh. "<---changed here
  PERFORM bdc_field       USING 'RMMG1-MTART' lwa_final-mtart. "<---changed here
  PERFORM bdc_dynpro      USING 'SAPLMGMM' '0070'.
  PERFORM bdc_field       USING 'BDC_CURSOR' 'MSICHTAUSW-DYTXT(01)'.
  PERFORM bdc_field       USING 'BDC_OKCODE' '=ENTR'.
  PERFORM bdc_field       USING 'MSICHTAUSW-KZSEL(01)' 'x'.    "<---changed here.
  PERFORM bdc_dynpro      USING 'SAPLMGMM' '4004'.
  PERFORM bdc_field       USING 'BDC_OKCODE' '=BU'.
  PERFORM bdc_field       USING 'MAKT-MAKTX'  lwa_final-maktx. "<---changed here
  PERFORM bdc_field       USING 'BDC_CURSOR' 'MARA-MEINS'.
  PERFORM bdc_field       USING 'MARA-MEINS'  lwa_final-meins. "<---changed here
  PERFORM bdc_field       USING 'MARA-MTPOS_MARA' record-MTPOD_MARA_007.
  PERFORM bdc_transaction USING 'MM01'.
ENDLOOP.

*After the mapping is done, SAP calls the 'close_group' subroutine. If the Session Technique has been deployed, it closes the Session
*Object. Afterwards the 'close_dataset' subroutine comes which I can comment out, because I was opening no dataset previously.

*To sum things up I added the logic for reading the data from a local file (to replace the generated OPEN DATASET), I replaced the
*generated parameters (structure 'record') passed into those occurences of the 'bdc_field' that correspond to the fields I am interested 
*in with the fields of my own work area ('lwa_final') and I commented out a few unnecessary lines like "OPEN DATASET" or "CLOSE_DATASET".

*When I execute the program ('F8' while still in SE38) I will see the auto-generated screen. Here I can choose whether I want to utilize
*the Session Technique or the Call Transaction Technique.
*Say I choose the Session Technique. I should select the 'Generate session' radiobutton and provide the 'Session name' ('S60' in my case).
*If I check the 'Keep session' checkbox - even after the processing of the Session Object it will still be available for further analisys.
*Thus it is recommended to always have it checked. I can also elect to give the Session Object a lock by providing the 'Lock date'. When
*I execute the transaction now, the Session Object should be created. In order to process a Session Object, I need to go to the SM35
*transaction. Here I should see my Session Object - 'S60'. The column 'Transaction' shows how many records are available in the Session
*Object. Upon choosing my Session Object and hitting the 'Process' button, I will be asked whether I want to process the Session Object
*in foreground or background.
*If I chose the foreground processing - I will be taken on a ride through the process. I will need to select the green tick in the
*pop-up window or press Enter whenever promted to.
*If I choose the background processing - it will just all happen in the background.

*If I want to analyse the process that the Session Object carried out I can select it and click the 'Log' button in the Application
*Toolbar. I should choose the log in the 'Log Overview' tab and click the 'Analyse session' button in the Application Toolbar.
*Here, in the left hand side of the screen I should be able to see the status for every record processed - it's here that I can see
*if something went wrong - it will be indicated by the 'Incorrect' status. If I select the 'Log created on(...)' button, I can see
*all the operations with timestamps. Every operation is described, e.g. if something went wrong with a record it might be informing me
*here that "The material type does not exist". This is the problem that was encountered by SAP with this particular record during
*the process of the migration.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*BDC - RECORDING A PROGRAM WITH TABLE CONTROL.
*---------------------------------------------------------------------------------------------------------------------------------

*I want to record the XK01 transaction which is used to create new vendors. During the process I will be asked to provide the bank
*details - the screen will display a table control.
*I go to SHDB and select the 'New recording' button in the Application Toolbar. I provide the name of the recording - in my case
*it's 'R2' and the transaction code of 'XK01'. Then I press the 'Start recording' button. Now I need to walk through the process
*of creating a vendor so that SAP might record my actions. I ought to provide the 'Vendor' (e.g. '666') and the 'Account group'
*(e.g. '0001') and press Enter. I am transported to the next screen where I provide the 'Name' (e.g. 'Lilith'), the 'Search term'
*(e.g. 'Lil') and the 'Country' which actually is a country key, not just country (e.g. 'UA'). After pressing Enter here, I am
*taken to the next screen which contains a Table Control component. Here I provide the 'Ctry' (e.g. 'UA'), the 'Bank Key'
*(e.g. 'DOG') and the 'Bank Account' (e.g. '666666666'). Upon saving the progress the recording is complete and the transaction
*"is transferred" (according to the SAP's message). I am transported to the screen with the details of the recording mapped to
*the BDCDATA structure's components.
*I should remember the fields for which I provided the input during the recording. In the screen '0100' (indicated in the second
*row in the column 'Screen'), I provided the values '666' in the 'Vendor' field. That is the 'RF02K-LIFNR' field in the details.
*I also provided the '0001' value to the 'Account group' field which here translates to 'RF02K-KTOKK'.
*In the '0110' screen I provided 'Lilith' ('Name'), 'Lil' ('Search term') and 'UA' ('Country'). These three translate to 'LFA1-NAME1',
*'LFA1-SORTL' and 'LFA1-LAND1' respectively.
*In the screen '0120' I did not provide any input.
*In the screen '0130' I can see the three fields I provided data for. These are 'LFBK-BANKS(01)', 'LFBK-BANKL(01)' and 'LFBK-BANKN(01)'
*with the values of 'UA', 'DOG' and '666666666' respectively. The '(01)' part all the fields' names are suffixed with means the row
*number. These fields are all the fields of the Table Control and the suffixed number indicates the row. If I added more rows with
*data, I would have three more fields here with the same names but suffixed with '(02)' instead.
*Now I should save the progress and go back ('F3'). Here I select my recording ('R2') and click the 'Program' button in the
*Application Toolbar. The program itself will be generated and I can start modifying it.

*Before the START-OF-SELECTION event, I should declare the structures I require. I need two "final" internal tables, because the
*legacy data is going to be distributed between LFA1 and LFBK database tables. Each one of them needs its own structures here, because
*I will be loading the data from these structures to the database tables. LFA1 will be receiving NAME1, SORTL and LAND1 while LFBK
*will be receiving BANKS, BANKL, BANKN (multiple of those if the Table Control received multiple records!). Apart from these, I also
*provided input for the 'Vendor' and the 'Account group' fields both of which can go into LFA1 while LFBK can be connected just by
*'Vendor' (since I am providing a bank account's details of a particular Vendor to the LFBK).
*The 'lv_rowid' variable will be pointing at a record of the table control since there can be many of them. It is of the length of
*two and of an alphanumeric type because I want them in the same format as SAP which is e.g. 'LFBK-BANKS(01)' for the first record
*in the Table Control. The default value of the 'lv_rowid' variable is '00'. If I incremented it by 1, it becomes '01'. This
*variable cannot be a simple integer because I cannot specify the length of an integer - I could not achieve the '00' or '01' values.
*A default value of 'lv_rowid(2) TYPE i' would be just '0'.
*The record of my file with the legacy data start with a three-digit identifier. They inform me whether the row is the master data
*or bank data. The variable 'lv_id' will store that identifier.
TYPES: BEGIN OF t_legacy,
  string TYPE string,
END OF t_legacy.
DATA: lt_legacy  TYPE TABLE OF t_legacy,
      lwa_legacy TYPE t_legacy.

TYPES: BEGIN OF t_lfa1,
  lifnr TYPE rf02k-lifnr,
  ktokk TYPE rf02k-ktokk,
  name1 TYPE lfa1-name1,
  sortl TYPE lfa1-sortl,
  land1 TYPE lfa1-land1,
END OF t_lfa1.
DATA: lt_lfa1  TYPE TABLE OF t_lfa1,
      lwa_lfa1 TYPE t_lfa1.

TYPES: BEGIN OF t_lfbk,
  lifnr TYPE rf02k-lifnr,
  banks TYPE lfbk-banks,
  bankl TYPE lfbk-bankl,
  bankn TYPE lfbk-bankn,
END OF t_lfbk.
DATA: lt_lfbk  TYPE TABLE OF t_lfbk,
      lwa_lfbk TYPE t_lfbk.

DATA: lv_rowid(2) TYPE n,
      lv_id(3)    TYPE c.
	  
*Just after the START-OF-SELECTION event, SAP has automatically generated the 'open_dataset' subroutine. It is used to load the
*files from an application server, so I am not going to need it as my file is stored locally. I comment out that subroutine and
*instead use the 'GUI_UPLOAD' function module. I provide the path to my file and the internal table into which the data should
*be loaded.
CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename                      = 'd:\vendor.txt'
  TABLES
    data_tab                      = lt_legacy.
	
*If there indeed is data within 'lt_legacy', I need to transfer the data from it to the other two internal tables - the final
*ones. I need to differentiate which records should go to the vendor table and which to the bank table. This will be done by
*checking the identifier every line within the file starts with. Every record within 'lt_legacy' is just a single string, but
*I know that the identifier is always at the starts of the lines. So I can essentially take a substring out of the string and
*see what the identifier is. Based on that, I can decide into which final internal table the line that is being processed
*should go. It works by reading the string from the position specified by '+0' where 0 can be replaced with any number that
*indicates the index I want to start reading and '(3)' where 3 can be replaced by the length of the string I want read.
*Since all the records moved from the legacy file into the 'lt_legacy' internal table are stored as a single string, I need
*to split those strings into specific fields within the final internal table after deciding which one of the two final internal
*tables the particular record should go to. The splitting is done at commas as such is the structure of the records within
*the legacy file - every record has its components separated by commas.
IF lt_legacy IS NOT INITIAL.
  LOOP AT lt_legacy INTO lwa_legacy.
    CLEAR lv_id.
    lv_id = lwa_legacy-string+0(3).
    IF lv_id = 'VEN'.
      SPLIT lwa_legacy-string AT ',' INTO lwa_lfa1-lifnr
                                          lwa_lfa1-ktokk
                                          lwa_lfa1-name1
                                          lwa_lfa1-sortl
                                          lwa_lfa1-land1.
      APPEND lwa_lfa1 TO lt_lfa1.
    ELSEIF lv_id = 'BNK'.
      SPLIT lwa_legacy-string AT ',' INTO lwa_lfbk-lifnr
                                          lwa_lfbk-banks
                                          lwa_lfbk-bankl
                                          lwa_lfbk-bankn.
      APPEND lwa_lfbk TO lt_lfbk.
    ENDIF.
  ENDLOOP.
ENDIF.

*Below the above I should see the 'open_group' subroutine which is responsible for the creation of a Session Object. I am
*leaving this subroutine within my code. Below that there's a DO loop, a READ DATASET statement and a status check - all three
*I am commenting out as they are not necessary. READ DATASET would be used if I used OPEN DATASET which I am not doing because
*my file with the legacy data is stored locally.
*Below is the code I am either changing, leaving as it is or adding to.
*Out of the two the 'lt_lfa1' internal table is the main one. This is due to the relation between LFA1 and LFBK. Each vendor
*(LFA1) can contain multiple bank records in LFBK. Thus, all the operations, including the mapping of the fields of 'lt_lfbk'
*needs to happen for every record of 'lt_lfa1'.
LOOP AT lt_lfa1 INTO lwa_lfa1.
  PERFORM bdc_dynpro USING 'SAPMF02K' '0100'.
  PERFORM bdc_field  USING 'BDC_CURSOR' 'RF02K-KTOKK'.
  PERFORM bdc_field  USING 'BDC_OKCODE' '/00'.
  PERFORM bdc_field  USING 'RF02K-LIFNR' lwa_lfa1-lifnr. "<---changed here
  PERFORM bdc_field  USING 'RF02K-KTOKK' lwa_lfa1-ktokk. "<---changed here
  PERFORM bdc_dynpro USING 'SAPMF02K' '0110'.
  PERFORM bdc_field  USING 'BDC_CURSOR' 'LFA1-LAND1'.
  PERFORM bdc_field  USING 'BDC_OKCODE' '/00'.
  PERFORM bdc_field  USING 'LFA1-NAME1' lwa_lfa1-name1. "<---changed here
  PERFORM bdc_field  USING 'LFA1-SORTL' lwa_lfa1-sortl. "<---changed here
  PERFORM bdc_field  USING 'LFA1-LAND1' lwa_lfa1-land1. "<---changed here
  PERFORM bdc_dynpro USING 'SAPMF02K' '0120'.
  PERFORM bdc_field  USING 'BDC_CURSOR' 'LFA1-KUNNR'.
  PERFORM bdc_field  USING 'BDC_OKCODE' '/00'.
  PERFORM bdc_dynpro USING 'SAPMF02K' '0130'.
  PERFORM bdc_field  USING 'BDC_CURSOR' 'LFBK-BANKN(01)'.
  PERFORM bdc_field  USING 'BDC_OKCODE' '=UPDA'.
*Now, for each vendor I need to map all of their bank records in 'lt_lfbk'. Up until now I wasn't changing the names of the
*fields, but in the case of 'lt_lfbk' this will be necessary, because - as every record within 'lf_lfa1' can have multiple
*records related to it within 'lt_lfbk' - the name of the field changes - the value within the brackets is incremented with
*every next record. E.g. the first one is 'LFBK-BANKS(01)' and the second will be 'LFBK-BANKS(02)'. Thus, I need to change
*the name of the field dynamically as many times as there are records within 'lt_lfbk' related to the particular vendor
*within 'lt_lfa1'. To make it happen I will deploy the indomitable might of the 'lv_rowid' variable. It is of the value of
*'00' to begin with. Hence I increment it at the beginning of the loop below and thus its value will match that of the first
*record's name's part enclosed within the brackets. With every iteration of the loop, the value of 'lv_rowid' will be
*incremented and match the incremnted bracketed value of the currently processed record's name. Of course, I will need to
*construct the field's name myself.
  LOOP AT lt_lfbk INTO lwa_lfbk WHERE lifnr = lwa_lfa1-lifnr.
    lv_rowid = lv_rowid + 1.
    CLEAR lv_fname.
    CONCATENATE 'LFBK-BANKS(' lv_rowid ')' INTO lv_fname.
    PERFORM bdc_field USING lv_fname lwa_lfbk-banks.
    CLEAR lv_fname.
    CONCATENATE 'LFBK-BANKL(' lv_rowid ')' INTO lv_fname.
    PERFORM bdc_field USING lv_fname lwa_lfbk-bankl.
    CLEAR lv_fname.
    CONCATENATE 'LFBK-BANKN(' lv_rowid ')' INTO lv_fname.
    PERFORM bdc_field USING lv_fname lwa_lfbk-bankn.    
  ENDLOOP.
  PERFORM bdc_transaction USING 'XK01'.
*Below should be the ENDDO statement which I am commenting out and replacing with the ENDLOOP.
ENDLOOP.

*WARNING - there is a chance that the above code will throw an exception saying "Invalid access to a string (offset too
*large)". In this case SAP has a problem with the attempt to cut a substring out of a string while trying to check the
*three-digit identifier within the 'lt_legacy' internal table. This problem can be solved by modifying the structure of
*my legacy table - change the 'string' variable from the type string to a type C and set the length of the field to, e.g.
*100. So "string(100) TYPE c" instead of "string TYPE string".

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*LSMW - LEGACY SYSTEM MIGRATION WORKBENCH.
*---------------------------------------------------------------------------------------------------------------------------------

*LSMW is a tool provided by SAP used for migrating the data from a legacy system to a SAP system. The tool can be used in four
*different ways:
*1. By using the Batch Input Recording.
*2. By using the Direct Input Method.
*3. By using IDOC.
*4. By using BAPI.
*To present LSMW, I will perform the migration of the material data from a locally stored text file to the SAP system. I need to
*go to the LSMW transaction. I should see a pop-up welcome message here. I need to provide the name of the 'Project' here - in
*my case it's "ZBM_TEST_LSMW_PRJ". In the Application Toolbar there is the 'Create Entry' button which needs pressing right now. I will
*be prompted to provide a description. When that's done I will need to provide the name of the 'Subproject' and it's description.
*In my case it's "ZBM_TEST_LSMW_SUB". And when that's done I will also need to provide the name of the 'Object' and its description.
*For me it's "ZBM_TEST_LSMW_OBJ". When all that's done, I need to click the execute button (F8).
*Now I should see a screen displaying a list of various steps I need to take. 
*----------THE FIRST STEP----------
*The first one is 'Maintain Object Attributes'. Here I need to choose the technique - Batch Input Recording, Direct Input Technique, 
*IDOC, BAPI. The step should already be highlighted. In order to proceed - I need to Execute (F8).
*In this case I am using the Batch Input Recording technique. Using this technique requires me to provide the name of the recording
*and record the steps I want taken by walking through them with a sample record. The file with the legacy data contains the material
*data in my example. The transaction thus is MM01. I press the 'Execute' button and change the mode from 'Display' to 'Change' if
*necessary. In the section 'Object Type and Import Method' I should see all the techniques I can choose from. I choose the Batch
*Input Recording one. In the input box available I should provide the name of the recording, e.g. 'R100'. Next I should click the
*'Recordings: Overview' button to the right of the input box. And to the right of the button with an arrow on it. In the next screen
*I should click the 'Create Recording' button, the white sheet on the left hand side of the Application Toolbar. Here I provide
*the recording's name ('R100') and a short description. Here I am prompted to provide the name of the transaction I want to record
*which is MM01.
*Here I need to provide three pieces of information about the sample material I am using for the recording. For example 'Codigo Material'
*can be '7AMAT666', 'Industry sector' might be 'Pharmaceuticals' and 'Material Type' can be 'FERT - Finished Product'. When I press Enter
*now, I will be asked to select a view. It refers to the kind of data about the material I will be additionally providing. In my case,
*apart from the three fields I filled previously, I also want to add a description and a basic unit of measure. These are part of
*'Basic Data 1'. In order to determine the kind of every piece of data I might need the help of a functional consultant. Thus I select
*the 'Basic Data 1' option and proceed.
*In the following screen I provide the description of 'Material 7AMAT666' within the input box to the right of the 'CoMaterial' input
*box and the 'Base Unit of Measure' with 'CM'. Thus I have provided SAP with all the data about the sample record from the legacy file.
*I do not fill any other field as the legacy records do not have any more information about them. When I save my progress, I should
*be transported to another screen where I should be able to see the recorded details mapped to the BDCDATA structure. On the left hand
*side I see the fields' names, a little bit to the right there are their values and on the far right side there are orange fields that
*are all blank. I need to press the 'Default All' button in the Application Toolbar in order to fill these blank orange fields with
*the data element of every field that particular orange box is in line with.
*Now I need to save the progress and go back (F3). I should see the screen with the information about my recording which I need to
*leave by pressing F3. Here I can save again and go back (F3) again.
*Now I should be back in the screen displaying all the steps I need to take. In the first step I have chosen the technique type
*(Batch Input Recording), given the recording a name and recorded the MM01 transaction by manually providing sample data to all
*the necessary fields.
*----------THE SECOND STEP----------
*The second step is Maintain Source Structures. Here I will need to create my own structure. If the second step (row) is selected,
*I need to Execute the program (F8) and change the mode to Change if it's in the Display one. When that's done, I should click the
*'Create a Structure' button in the Application Toolbar. I need to give it a name, e.g. 'Z7AMMATSTR' and a description, e.g.
*'Material structure' and proceed. Now I need to save my progress and go back. In this step I created a blank structure.
*----------THE THIRD STEP----------
*Now I should be back in the screen where all the steps are displayed. The third step is Maintain Source Fields. This step is about
*creating the fields for the currently blank structure created in the previous step. I will need to create five fields as this is
*the number of fields present in the file with the legacy data I am working with. With the third row (step) selected, I am to click
*the Execute button (F8). In this screen I should see the structure I previously created. If it's the Display mode, I need to change
*it into the Change one (hehehehehe). I need to choose my structure and then click the 'Table maintenance' button in the Application
*Toolbar. Here I need to provide the data elements of every field that my structure is to have. These can be collected from the first
*step as I can simply go back (F3) and access the first step just like I did it before and then return here once again. In my case
*the fields are as follows ('Field Name', 'Type', 'Length', 'Field description'):
*MATNR, C, 18.
*MBRSH, C, 1.
*MTART, C, 4.
*MAKTX, C, 40.
*MEINS, C, 3.
*Yes, the 'Field description' is left blank for every field. That is because when I press Enter, the descriptions will appear automatically.
*And that is because I am using data elements known to SAP, so she knows what to make of them.
*----------THE FOURTH STEP----------
*With that done - the fourth step is 'Maintain Structure Relations'. In this step I need to assign my recording to the previously
*created structure. Since I have only a single recording in this case and just one structure, the assignment shall be done automatically.
*If I select the fourth step and Execute it (F8), I should see the name of my recording ('R100' in this case) and the name of my structure
*('Z7AMMATSTR' in this case) to the right. If I wanted to I could delete this relationship. I'd have to select the structure (click the
*four arrows pointing at the recording's name) and press the 'Relationship' button with the garbage can in the Application Toolbar. I can
*create relationships manually by clicking the 'Relationship' button with the white sheet in the Application Toolbar.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------




*---------------------------------------------------------------------------------------------------------------------------------
*SENDING EMAIL WITH BCS.
*---------------------------------------------------------------------------------------------------------------------------------

DATA: lv_subject    TYPE so_obj_des VALUE 'Email subject',
      lv_sender     TYPE ad_smtpadr VALUE 'bartosz.mierzwinski@cedc.com',
      it_email_body TYPE bcsy_text,
      it_receivers  TYPE bcsy_smtpa.

*I need to send the information to proper class and methods. For that, I need declarations:
DATA: obj_docu           TYPE REF TO cl_document_bcs,
      obj_sender         TYPE REF TO if_sender_bcs,
      obj_sender_request TYPE REF TO cl_bcs,
      obj_receivers      TYPE REF TO if_recipient_bcs.

it_email_body = VALUE #( ( line = 'Configuration Fails Notification' )
                         ( line = 'Please, call someone' ) ).

it_receivers = VALUE #( ( 'bartosz.mierzwinski@cedc.com' ) ).

*To send the email...
*Creating the document to be sent.
TRY.
  obj_docu = cl_document_bcs=>create_document(
    EXPORTING
      i_type         = 'HTM'
      i_text         = it_email_body
      i_subject      = lv_subject ).

*Sender.
  obj_sender = cl_cam_address_bcs=>create_internet_address(
    EXPORTING
      i_address_string = lv_sender ).

*Preparing the request.
*The sender for the request.
  obj_sender_request = cL_bcs=>create_persistent( ).
  CALL METHOD obj_sender_request->set_sender
    EXPORTING
      i_sender = obj_sender.

*The document for the request - which document needs to be sent?
  CALL METHOD obj_sender_request->set_document
    EXPORTING
      i_document = obj_docu.

*Receiver for the request. It's within a loop because I specified the e-mail address within an internal table.
  LOOP AT it_receivers INTO DATA(wa_receivers).
    obj_receivers = cl_cam_address_bcs=>create_internet_address(
      EXPORTING
        i_address_string = wa_receivers ).

    CALL METHOD obj_sender_request->add_recipient
      EXPORTING
        i_recipient  = obj_receivers
        i_express    = 'X'. "Send immediately!
  ENDLOOP.

  CALL METHOD obj_sender_request->send
    EXPORTING
      i_with_error_screen = 'X'
    RECEIVING
      result              = DATA(lv_sent).
  COMMIT WORK.
  CATCH cx_bcs INTO DATA(obj_exception).
ENDTRY.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------