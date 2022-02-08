*---------------------------------------------------------------------------------------------------------------------------------
*ABAP OOP PROGRAM. STATIC ATTRIBUTES.
*---------------------------------------------------------------------------------------------------------------------------------

CLASS rune DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA: rune_name TYPE char45,
                rune_number TYPE i.
    METHODS: forge_rune.
ENDCLASS.                    "rune DEFINITION

*----------------------------------------------------------------------*
*       CLASS rune IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS rune IMPLEMENTATION.
  METHOD forge_rune.
    DO 4 TIMES.
      rune_number = 1 + rune_number.
      WRITE: / rune_number, rune_name.
    ENDDO.
    SKIP. "Thanks to this, I will see in the output the distinction between rune1's and rune2's callings of the method.
  ENDMETHOD.                    "forge_rune
ENDCLASS.                    "rune IMPLEMENTATION

START-OF-SELECTION.
  rune=>rune_name = 'Fire Rune'. "This way of assigning values will work ONLY for CLASS-DATA (static attributes), it will not work for non-statics (simple DATA).
  rune=>rune_number = 0.

  DATA: rune1 TYPE REF TO rune,
        rune2 TYPE REF TO rune.

  CREATE OBJECT: rune1, rune2.
  CALL METHOD: rune1->forge_rune,
               rune2->forge_rune. "rune_number is a static attribute, so, despite the default value being set to 0, rune2 will write 5, 6, 7 and 8, because 
			                      "it's a shared attribute and already has been incremented by rune1.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------