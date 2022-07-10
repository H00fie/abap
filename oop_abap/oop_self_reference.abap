*---------------------------------------------------------------------------------------------------------------------------------
*ABAP OOP PROGRAM. ME operator.
*---------------------------------------------------------------------------------------------------------------------------------

CLASS example DEFINITION.
  PUBLIC SECTION.
    DATA text_initial TYPE char100 VALUE 'This is the initial value of the attribute!'.
    METHODS: method1.
ENDCLASS.                    "example DEFINITION

*----------------------------------------------------------------------*
*       CLASS example IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS example IMPLEMENTATION.
  METHOD method1.
    DATA text_initial TYPE char100 VALUE 'This is the same attribute, but changed by the method!'.
    WRITE: / me->text_initial, "Operator 'me' allows me to see what was the value of the attribute before it was changed.
           /     text_initial.
  ENDMETHOD.                    "method1
ENDCLASS.                    "example IMPLEMENTATION


START-OF-SELECTION.
  DATA object TYPE REF TO example.
  CREATE OBJECT object.
  CALL METHOD object->method1.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------