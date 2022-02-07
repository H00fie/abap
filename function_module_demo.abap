*---------------------------------------------------------------------------------------------------------------------------------
*FUNCTION MODULE.
*---------------------------------------------------------------------------------------------------------------------------------

DATA result LIKE spell.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(15) text-001. 
*'text-001' belongs to a pool of texts/data do be used in selection screens. There is a similar mechanism for windows with
*messages, but that is different. I should not look for a Java analogy, because there is none. This is strictly an ABAP thing.

PARAMETER num_1 TYPE i.

SELECTION-SCREEN END OF LINE.

*Below is a function that writes in words the numbers provided as integers.
CALL FUNCTION 'SPELL_AMOUNT'
  EXPORTING
    amount   = num_1   "A numerical parameter.
  IMPORTING
    in_words = result. "This is a data element for holding the result of the function.

IF sy-subrc <> 0.                                          "If sy-subrc is anything else than 0, something went wrong.
  WRITE: 'The value returned is: ', sy-subrc.              "So write for me the value of sy-subrc. E.g. 4 might mean an error.
ELSE.
  WRITE: 'The provided number in words is: ', result-word. "If sy-subrc is not different than 0 (so everything went fine), write the result for me.
ENDIF.                                                     "The addition of '-word' stems from the function itself. I could name the data element
                                                           "'donkey' instead of 'result', if I so desired and the syntax will be: 'donkey-word'.    
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------