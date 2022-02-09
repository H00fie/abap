*---------------------------------------------------------------------------------------------------------------------------------
*ABAP OOP PROGRAM. INHERITANCE.
*---------------------------------------------------------------------------------------------------------------------------------

CLASS warrior DEFINITION.
  PUBLIC SECTION.
    DATA: warrior_message(45) VALUE 'I am a warrior!'.
    METHODS: warrior_method.
ENDCLASS.                    "warrior DEFINITION

*----------------------------------------------------------------------*
*       CLASS axeman DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS axeman DEFINITION INHERITING FROM warrior.
  PUBLIC SECTION.
    METHODS: axeman_method.
ENDCLASS.                    "axeman DEFINITION

*----------------------------------------------------------------------*
*       CLASS warrior IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS warrior IMPLEMENTATION.
  METHOD warrior_method.
    WRITE: / warrior_message.
  ENDMETHOD.                    "warrior
ENDCLASS.                    "warrior IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS axeman IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS axeman IMPLEMENTATION.
*Axeman reaches for a variable it never defined itself but which is defined in Warrior (its parent class).
  METHOD: axeman_method.
    WRITE: / 'From the axeman class: ', warrior_message. 
  ENDMETHOD.                    "axeman
ENDCLASS.                    "axeman IMPLEMENTATION

START-OF-SELECTION.
  DATA: warrior TYPE REF TO warrior,
        axeman TYPE REF TO axeman.
  CREATE OBJECT: warrior, axeman.
  CALL METHOD: warrior->warrior_method,
               axeman->axeman_method. "Axeman's method reaches for the attribute defined in Warrior.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------