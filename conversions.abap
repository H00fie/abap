*---------------------------------------------------------------------------------------------------------------------------------
*CONVERSION RULES.
*---------------------------------------------------------------------------------------------------------------------------------

DATA: number_one TYPE p DECIMALS 2 VALUE '2',
      number_two TYPE p DECIMALS 2 VALUE '8',
      result TYPE i,
      result2 TYPE p DECIMALS 2.

result = number_one.
WRITE: / result.
*Result will be 3.

result = number_two.
WRITE: / result.
*Result will be 5.

*************************************************
*Regular division.
result2 = number_one / number_two.
WRITE: / result2.

*Integer division.
result2 = number_one DIV number_two. "DIV converts values to integers.
WRITE: / result2.

*Remainder division.
result2 = number_one MOD number_two. "Modulo in theory, but if the second value is higher than the previous one, it just gives the first value???
WRITE: / result2.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------