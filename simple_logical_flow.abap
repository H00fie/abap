*---------------------------------------------------------------------------------------------------------------------------------
*Logical flow.
*---------------------------------------------------------------------------------------------------------------------------------

*I can have the predefined structure of the if-statement inserted for me with Wzorzec -> mark the Inny Wzorzec at the bottom -> type in
*'if' and hit enter.

DATA name(15) TYPE c.

name = 'Dazikiri'.

IF name EQ 'Dazikiri'.
  WRITE / 'Lancer'.
ELSEIF name EQ 'Halasibel'.
  WRITE / 'Shaman'.
ELSE.
    WRITE / 'Dont know!'.
ENDIF.

name = 'Halasibel'.

IF name EQ 'Dazikiri'.
  WRITE / 'Lancer'.
ELSEIF name EQ 'Halasibel'.
  WRITE / 'Shaman'.
ELSE.
    WRITE / 'Dont know!'.
ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------