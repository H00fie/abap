*---------------------------------------------------------------------------------------------------------------------------------
*ABAP OOP PROGRAM. ACCESS SECTIONS.
*---------------------------------------------------------------------------------------------------------------------------------

CLASS army DEFINITION.
  PUBLIC SECTION.
  *In the ABAP code, I need to specify a pre-defined data type (I cannot create mu custom ones, like Data Element in 
  *Standard ABAP Dictionary Tables).
    DATA: official_numbers TYPE i VALUE 1000. 
    DATA: info TYPE char25 VALUE 'yay'.
    METHODS: charge.

  PROTECTED SECTION.
    DATA: protected_numbers TYPE i VALUE 700.

  PRIVATE SECTION.
    DATA: actual_numbers TYPE i VALUE 400.
ENDCLASS.                    "army DEFINITION

*----------------------------------------------------------------------*
*       CLASS army IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS army IMPLEMENTATION.
  METHOD charge.
    WRITE: / 'Charge method called: ',
       official_numbers,
       protected_numbers,
       actual_numbers.
  ENDMETHOD.                    "charge
ENDCLASS.         "charge

START-OF-SELECTION.
  DATA: army TYPE REF TO army.
  CREATE OBJECT army.
  CALL METHOD: army->charge.     "Here I am calling the method from the object - army.
  WRITE: / army->official_numbers.
  WRITE: / army->info.           "This will work, because 'info' is defined in the PUBLIC SECTION, thus, it is accessible from any place.
  WRITE: / army->actual_numbers. "This is not going to work, because actual_numbers is defined in the PRIVATE SECTION. Thus, I cannot 
                                 "just grab it from the level of the object, I need to access it via a method. In this case, my method
								 "'charge', basically, assumes the role of... a getter. I access the private field of the class via a 
                                 "method of that class called on an object of the class. Just like Java, only a little bit different.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------