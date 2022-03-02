*---------------------------------------------------------------------------------------------------------------------------------
*QUANTITY AND CURRENCY.
*---------------------------------------------------------------------------------------------------------------------------------

*Treated just like pack number fields (p). They need thus be declared as such...
*But it may be better to associate my fields with those already existing in ABAP dictionary. So LIKE will be used.

TABLES: zpokemon. "I need this declaration here because I will be selecting data from it via a SELECT.

DATA: my_salary      LIKE zpokemon-salary, "ABAP will keep my field's and my table's data type of salary in sync.
                                           "There are two aspects to it: a number of decimal places and the associated currency or quantity fields.

      tax_amount     LIKE zpokemon-salary, "This is also a currency with two decimal places so it can reference the same ABAP dictionary field.
      net_pay        LIKE zpokemon-salary,
      tax_percentage TYPE p DECIMALS 2.

tax_percentage = '0.20'. "20% tax rate.

SELECT * FROM zpokemon.
  WRITE: / 'Surname: ', zpokemon-surname, 'Salary: ', zpokemon-salary, zpokemon-ecurrency.
  tax_amount = tax_percentage * zpokemon-salary.
  net_pay = zpokemon-salary - tax_amount.
  WRITE: / 'Tax amount is: ', tax_amount, zpokemon-ecurrency,
           'Net pay is: ', net_pay, zpokemon-ecurrency.
  ULINE.
ENDSELECT.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------