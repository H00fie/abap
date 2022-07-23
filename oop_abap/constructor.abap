*---------------------------------------------------------------------------------------------------------------------------------
*ABAP OOP PROGRAM. CONSTRUCTOR.
*---------------------------------------------------------------------------------------------------------------------------------

CLASS dog DEFINITION.
  PUBLIC SECTION.
    METHODS: bark, constructor.
ENDCLASS.                    "dog DEFINITION

*----------------------------------------------------------------------*
*       CLASS dog IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS dog IMPLEMENTATION.
  METHOD bark.
    WRITE: / 'The dog is barking from a regular method.'.
  ENDMETHOD.                    "bark

  METHOD constructor. "Constructor makes sure that the logic within the method will be carried out upon the creation of the object.
    WRITE: / 'The dog is barking from a constructor method!.'.
  ENDMETHOD.                    "constructor
ENDCLASS.                    "dog IMPLEMENTATION

START-OF-SELECTION.
  DATA dog TYPE REF TO dog.
  CREATE OBJECT dog. "Method 'bark' is never executed because it's never called. 'Constructor' is executed because it happens upon the very creation of an object.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------