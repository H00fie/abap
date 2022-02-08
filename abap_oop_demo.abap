*---------------------------------------------------------------------------------------------------------------------------------
*FIRST ABAP OOP PROGRAM. CLASSES.
*---------------------------------------------------------------------------------------------------------------------------------

CLASS my_first_class DEFINITION.
*Instead of specifying the access modifier for every variable and method separately, I am defining sections.
*Everything in this section will be public. The public section will end e.g. when I define the private section.
  PUBLIC SECTION.
    DATA: text(45) VALUE 'My First Object'.

    METHODS: display.
ENDCLASS.                    "my_first_class DEFINITION

*----------------------------------------------------------------------*
*       CLASS my_first_class IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS my_first_class IMPLEMENTATION.

  METHOD display.

    WRITE: / 'This is the Display method! My first ABAP OOP method!'.
  ENDMETHOD.                    "display
ENDCLASS.                    "display

START-OF-SELECTION.
*The creation of ABAP object is basically the same as in Java, but looks a bit different.
*In Java, the first thing I do is a reference (Dog dogOne) and THEN I create the object itself (= new Dog();)
*Below is basically the equivalent of Java's: Dog dogOne = new Dog();
  DATA: my_first_class TYPE REF TO my_first_class. "First I create a reference to the class... This is the 'Dog dogOne' part.
  CREATE OBJECT: my_first_class.                   "Then I create the object itself... this is the '= new Dog();' part.
  WRITE: / my_first_class->text.                   "Here I am reaching for the variable of the object.
  CALL METHOD: my_first_class->display.            "Here I am reaching for the method of the object.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*SECOND ABAP OOP PROGRAM. CLASSES.
*---------------------------------------------------------------------------------------------------------------------------------

CLASS armoury DEFINITION.
  PUBLIC SECTION.
*my_var is just a name. This is basically a field of the class and it can only be defined in the DEFINITION.
    DATA: my_var(25) VALUE 'Forging a weapon...'. 
	
*If a method is defined here, it has to have an implementation. So, similar to interfaces. Implement all methods.
    METHODS: forge, call_for_supplies. 
ENDCLASS.                    "armoury DEFINITION

*----------------------------------------------------------------------*
*       CLASS armoury IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*IMPLEMENTATION can only define methods! Variables cannot be defined here... unless they are within a method -> a local variable.
*ABAP classes are created in two steps, I always have to create a definition and an implementation. In the implementation I just 
*decide what methods will do and I call upon them then, to answer the call of Gondor, wherever I please within the boundaries of the program.
CLASS armoury IMPLEMENTATION. 
  METHOD forge.
    WRITE: / 'The weapon has been forged!'.
  ENDMETHOD.                    "forge

  METHOD call_for_supplies.
    WRITE: / 'Sending the wee lad for more ingots.'.
  ENDMETHOD.                    "call_for_supplies
ENDCLASS.           "forge

START-OF-SELECTION.
  DATA: armoury TYPE REF TO armoury.
  CREATE OBJECT: armoury.
  WRITE: / armoury->lol.
  CALL METHOD: armoury->forge.

  CALL METHOD: armoury->call_for_supplies.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------