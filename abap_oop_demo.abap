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



*---------------------------------------------------------------------------------------------------------------------------------
*THIRD ABAP OOP PROGRAM. METHODS.
*---------------------------------------------------------------------------------------------------------------------------------
CLASS smith DEFINITION.

  PUBLIC SECTION.
    DATA: name TYPE c LENGTH 40,
          age TYPE i,
          gender TYPE c LENGTH 1.
    CLASS-DATA: count TYPE i.

    METHODS: setname
              IMPORTING namein TYPE c, "This means this method takes in a 'namein' as a parameter. It's 'importing' input.

             getname
              EXPORTING nameout TYPE c,

             setgender
              CHANGING newgender TYPE c.
ENDCLASS.                    "smith DEFINITION

*----------------------------------------------------------------------*
*       CLASS smith IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS smith IMPLEMENTATION.

  METHOD setname. "In the implementation it's Method, not Methods.
    name = namein. "This method imports input and sets the data defined in the class definition accordingly. It's basically a simple setter.
  ENDMETHOD.                    "setname

  METHOD getname.
    nameout = name. "As in the definition it is EXPORTING data, it means it's 'returning' the parameter nameout... and that parameter that is being returned is data defined in the class definition. So it's basically a simple getter.
  ENDMETHOD.                    "getname

  METHOD setgender.
    IF newgender CO 'MF'. "If the parameter being passed into the method contains (CO) 'M' or 'F', then we are setting the data defined in the class deifinition to the parameter being passed into the method.
      gender  = newgender.
      newgender = '1'.    "Set the returning value to 1, which means the gender was set correctly.
    ELSE.
      newgender = '2'.    "Means the gender was not set.
    ENDIF.
  ENDMETHOD.                    "setgender

ENDCLASS.                    "smith IMPLEMENTATION

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------