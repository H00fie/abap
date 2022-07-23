*---------------------------------------------------------------------------------------------------------------------------------
*Numeric data elements' declaration.
*---------------------------------------------------------------------------------------------------------------------------------

DATA integer01 TYPE i VALUE 22. "Value determines the initial value of the variable.
DATA decimal01 TYPE p DECIMALS 1 VALUE '-5.7'.

DATA result LIKE decimal01. "That means result is like the type of decimal01.

integer01 = 10. "Changing the value of the variable.

result = integer01 + decimal01.

WRITE: result.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------