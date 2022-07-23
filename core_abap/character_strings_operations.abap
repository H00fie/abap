*---------------------------------------------------------------------------------------------------------------------------------
*OPERATIONS ON CHARACTER STRINGS.
*---------------------------------------------------------------------------------------------------------------------------------

*CONCATENATE----------------------------------------
DATA: title(15)         TYPE c VALUE 'High King',
      forename(40)      TYPE c VALUE 'Rasta',
      surname(40)       TYPE c VALUE 'Khan',
      sep, "This is the separator field. No length or type are declared, so default ones are used! These are (1) and C!
      destination1(200) TYPE c.

CONCATENATE title forename surname INTO destination1 SEPARATED BY sep.

*First, I decide what I want concatenated and then into what. I can separate the incoming values by whatever I deem fit.
*If the sum of lengths of concatenated fields is larger than the number of destination1's available characters -> it will be truncated.
*I should be using string data type for it. It can hold over 65.000 characters.

WRITE destination1.
*Program some! <3 -> programmed some! <3
ULINE.



*CONDENSE----------------------------------------
*Removes leading and closing blanks characters. All directly consecutive blanks are all replaced by exactly one space character.
*If NO-GAPS additions is used -> removes all blank spaces.

DATA: spaced_name(50) TYPE c VALUE ' Hand    of     Argus     Halasibel '. "Without specifying the length, it won't print it!
WRITE: / spaced_name. "No changes.
ULINE.
CONDENSE spaced_name.
WRITE: / spaced_name. "Simple CONDENSE.
ULINE.
CONDENSE spaced_name NO-GAPS.
WRITE: spaced_name. "No blanks.
ULINE.



*FINDING THE LENGTH OF A STRING----------------------------------------
DATA: len TYPE i.        "To hold the length of a string.
len = strlen( surname ). "strln is a function, not a statement. So basically string.length()
WRITE: 'The length of the surname is ', len.
ULINE.



*REPLACE----------------------------------------
DATA full_name(40). "No type defined, so this is the default type - c!
full_name = 'Corsair, King Castamir'.
WRITE full_name.
ULINE.
REPLACE ',' WITH '' INTO full_name. "This replaces only the first comma!
WRITE full_name.
ULINE.

*I can replace all occurences of a thing:
DATA: name1(20). "At first, I didn't add here the length and so the data element had the value of 'A'.
name1 = 'Ash, Ketchum,'.
WRITE name1.
ULINE.
REPLACE ',' WITH '' INTO name1. "The second comma remains.
REPLACE ALL OCCURRENCES OF ',' IN name1 WITH ''.
WRITE name1. "Both commas are removed.
ULINE.



*SEARCH----------------------------------------
*... for specific characters.
*I am not specifying a variable here to hold any result. Instead, two system variables are used:
*1) sy-subrc -> identifies whether the search was successful or not.
*2) sy_fdpos -> if the search was successful, this variable is set to the position of the character string I am searching for
*in another_name.

DATA another_name(30) TYPE c VALUE 'Herumor the Black Dread'.

WRITE: 'Searching: Herumor the Black Dread'.
SKIP.

*Blank spaces are ignored.
SEARCH another_name FOR 'Herumor       '.
WRITE: / 'Searching for "Herumor       " ...'.
WRITE: / 'sy-subrc: ', sy-subrc, / 'sy-fdpos: ', sy-fdpos.
ULINE.

*Blank spaces are taken into account.
SEARCH another_name FOR '.Herumor'. "NOTE <-- this makes no sense at all. This isn't any actual functionality that tells ABAP to take blanks into consideration. It treats points like regular characters.
                                    "Even '.Herumor' does not work, so this point literally does nothing.
WRITE: / 'Searching for ".Herumor      ." ...'.
WRITE: / 'sy-subrc: ', sy-subrc, / 'sy-fdpos: ', sy-fdpos.
ULINE.

*Wild card search -> ending.
SEARCH another_name FOR '*ead'.
WRITE: / 'Searching for "*ead" ...'.
WRITE: / 'sy-subrc: ', sy-subrc, / 'sy-fdpos: ', sy-fdpos. "Gives the index of 18 because the index of the word '*ead' is a part of starts at 18th index.
ULINE.

*Wild card search -> beginning.
SEARCH another_name FOR 'He*'.
WRITE: / 'Searching for "Bla*" ...'.
WRITE: / 'sy-subrc: ', sy-subrc, / 'sy-fdpos: ', sy-fdpos. "SAME.
ULINE.
*Wild cards show the starting index of the word that contains the sought for value. Blank spaces have indexes too. So both 'He*' and '*or' will give sy-fdpos = 0, because they are both parts of
*the word 'Herumor' which starts after the index 0.



*SHIFT----------------------------------------
*Allows me to move the content of the character string left or right character by character.
DATA: emp_num(10) TYPE c VALUE '0000654321'. "When I didn't specify the length of C, it was set to default 1... and the result was 1?
SHIFT emp_num LEFT DELETING LEADING '0'.
WRITE: / emp_num.
ULINE.

SHIFT emp_num. "The output here will be '54321', because previously I deleted the 0s and the defult shift is by 1. So 6 gets yeeted.
WRITE: / emp_num.
ULINE.

SHIFT emp_num CIRCULAR. "Shifts the string by the default 1, but does not yeet 5 out (6 got yeeted out before), but yeets it to the other side of the string.
WRITE: / emp_num.       "So the result is '4321     5'. The blanks are there because it's still of the length 10.
ULINE.
*I can always use -> CONDENSE emp_num NO-GAPS. -> if I want to remove the blank spaces!
WRITE: / emp_num.
ULINE.



*SPLIT----------------------------------------
DATA: mystring(30) TYPE c,
      a1(10)       TYPE c,
      a2(10)       TYPE c,
      a3(10)       TYPE c,
      sep2(2)      TYPE c VALUE '**'.

mystring = ' 1234** ABCD **6789'.
WRITE: / mystring.
ULINE.
SKIP.

SPLIT mystring AT sep2 INTO a1 a2 a3. "This means -> SPLIT the provided string AT the position where you find whatever value 'sep2' holds INTO the following data elements.
WRITE: / a1.
WRITE:/  a2. "Retains the blank space before it, as only '**' are removed.
WRITE: / a3. "SAME.
ULINE.
SKIP.

DATA: mystring2(30) TYPE c.

mystring2 = 'looool**omg **wtf**rofl'.
WRITE mystring2.
ULINE.
SKIP.

SPLIT mystring2 AT sep2 INTO a1 a2 a3. "SPLIT will try to divide the string into four pieces, because there are three occurences of its separator within the string.
                                       "Since there are only three fields provided, the remainder (the one that would go into the fourth) will be assigned to the last
                                       "field provided, so a3.
WRITE: / a1.
WRITE:/  a2.
WRITE: / a3.
ULINE.
SKIP.
*If the separator is not found at all within the string, the entirety of the string will be moved to the first of the provided fields that were to receive the pieces of the string!



*SUB-FIELDS----------------------------------------
*Used to refer to specific characters within the field - "processing sub-fields". There is no SUB-FIELD keyword/function. The syntax of 'string+6(2)' is what makes SUB-FIELD operations.
DATA: int_telephone_num(17) TYPE c,
      country_code(3)       TYPE c,
      telephone_num(14)    TYPE c.

int_telephone_num = '+44-(0)207-123456'.
WRITE: / int_telephone_num.
SKIP.

country_code = int_telephone_num(3). "country_code assumes the value of the first three characters of int_telephone_num.

telephone_num = int_telephone_num+4(13). "telephone_num assumes the value of the 13 characters of int_telephone_num and their count begins after the 4th character.

WRITE: / 'country_code: ', country_code.
WRITE: / 'telephone_num: ', telephone_num.

country_code+1(2) = '01'.

WRITE: / 'country_code: ', country_code.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------