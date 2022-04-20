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
*header line are called the same. APPENDING in such a scenario can only mean one thing.
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
FORMAT COLOR 3.
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

FORMAT COLOR 3.
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
FORMAT COLOR 7.
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
FORMAT COLOR 3.
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
FORMAT COLOR 7.
SORT t_emp2.
WRITE:/ 'Data in t_emp2 after a default SORT: '.
LOOP AT t_emp2 INTO wa_emp.
  WRITE: / wa_emp-empno, wa_emp-ename, wa_emp-empdesig.
ENDLOOP.
ULINE.
FORMAT COLOR OFF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------