*---------------------------------------------------------------------------------------------------------------------------------
*Character strings
*---------------------------------------------------------------------------------------------------------------------------------

*There are two elementary data types used for character strings. C and N. THESE ARE GENERIC CHARACTER STRING DATA TYPES.

TABLES: zbm_cust_02.

*C holds 'alpha numeric' characters. Minimum 1 char, max 65.535 chars.
DATA mychar(10) TYPE c.

*Default value of the size of the field is one character. If I want the length to be of one character, I don't need to decalre
*the size in the brackets.
DATA mychar2. 

*Because the character field is the default type used by the system to declare the field, I can not decalre any type.
*mychar2 is the short version for 'DATA mychar2(1) TYPE c.

DATA zcusts LIKE zbm_cust_02-cust_name.
*Character field like the provided variable from the provided table.
*Instead of the above, I could use: 'DATA zcusts(100) TYPE c.' - and it would be the same as the column in the
*table. It's a character field, it's not like Java, I don't need specifically defined types.

DATA znumber LIKE zbm_cust_02-ord_num.
*Similar as above but refers to the data type NUMC. It's treated like a character type but there's an in-built mechanism that will only
*allow numeric characters to be included.  When data is moved in, it is right aligned just like a regular numeric type field.
*Also, it is perfect to be used when I only want number within the field and have no intention of carrying out any calculations.
*It would be the same if I typed: 'DATA znumber TYPE n.'

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------