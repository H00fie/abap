*---------------------------------------------------------------------------------------------------------------------------------
*LOOPS.
*---------------------------------------------------------------------------------------------------------------------------------

*SELECT----------------------------------------
  TABLES: zpokemon.

*SELECT * FROM zpokemon.
*  WRITE: / zpokemon.                                "This will print out all the records within the table... Or it should, according to Pete. It doesn't work here.
*  ENDSELECT.

*  SELECT * FROM zpokemon WHERE surname = 'ANIKAR'.
*    WRITE: / zpokemon.                              "It doesn't want to print 'zpokemon' without me specifying the fields!
*  ENDSELECT.



*DO LOOP----------------------------------------
*sy-index keeps the index of the loop's iteration.
DATA: a TYPE i.

a = 0.

DO 10 TIMES.
  a = a + 1.
  WRITE: / 'Dog.', a.
  WRITE sy-index. "This will print out the same number set as 'a'. Outside of the loop, it's back to 0.
ENDDO.
ULINE.



*NESTED DO LOOP----------------------------------------
*Each DO LOOP has its own sy-index.
DATA: b TYPE i,
      c TYPE i,
      d TYPE i.

DO 3 TIMES.
  b = b + 1.
  WRITE: / 'Outer loop is at: ', b.
  c = 0.
  DO 3 TIMES.
    c = c + 1.
    WRITE: / 'Inner loop is at: ', c.
  ENDDO.
  d = d + c.
ENDDO.
  d = d + b.
ULINE.
WRITE: 'The total number of iterations is: ', d.
ULINE.



*WHILE LOOP----------------------------------------
DATA: u TYPE i,
      y TYPE i.

u = 0.
y = 0.

WHILE u <> 10.
  WRITE: / 'Haha, lol!', u.
    WHILE y <> 5.
      WRITE: 'Nested rotfl!'.
      y = y + 1.
    ENDWHILE.
  u = u + 1.
ENDWHILE.
ULINE.



*CONTINUE----------------------------------------
*Termination statements allow me to terminate a loop prematurely. There are two kinds of such statements:
*- those that apply to the loop,
*- those that apply to the processing block in which the loop occurs.
*CONTINUE is the doom of the processing of a loop. I can cut down the loop unconditionally using this statement.
DATA: omg TYPE i VALUE 1.

DO 15 TIMES.
  omg = omg + 1.
  IF sy-index = 2.          "When it's on the index 2...
    CONTINUE.
  ENDIF.
  WRITE: / 'Omg is: ', omg. "... this will not be written down. Because CONTINUE aborts the processing of anything
ENDDO.                      "left to process within the loop AND RETURNS TO THE BEGINNING OF THE LOOP.
ULINE.



*CHECK----------------------------------------
*Allows for the termination of the loop passes, but also for the checking of the certain conditions first.
*It is kind of a combination of an IF statements and a CONTINUE statement.
DATA: wtf TYPE i VALUE 0.

DO 10 TIMES.
  wtf = wtf + 1.
  CHECK sy-index <> 2.      "Basically - 'If the system variable is at the second index, abandon the rest of the current
  WRITE: / 'Wtf is: ', wtf. "loop and go back to the beginning of the loop.
ENDDO.
ULINE.
*CHECK can also be used outside of the loops, e.g. in subroutines (function modules?). It's essentially a very nice
*big red 'Do not press!' button.



*EXIT----------------------------------------
*Allows me to assasinate the loop without any conditions provided. The loop. It stops the entirety of the loop,
*unlike CONTINUE which terminates just the ongoing roll of the loop.
*If I use it in a subroutine then it will just abandon it and return to the main program.
DATA: lmao TYPE i VALUE 0.

DO 10 TIMES.
  lmao = lmao + 1.
  IF sy-index = 3.
    EXIT.
  ENDIF.
  WRITE: / 'Lmao is: ', lmao. "Just two of those are written, because when it's index 3's time to shine
ENDDO.                        "it just exits the loop altogether.
WRITE: / 'Almost no lmaos written!'.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*MOVING DATA BETWEEN TWO INTERNAL TABLES. FOR LOOP, VALUE.
*---------------------------------------------------------------------------------------------------------------------------------

TYPES: BEGIN OF t_tab1,
  number          TYPE i,
  name(25)        TYPE c,
  occupation(25)  TYPE c,
  sex             TYPE c,
  fav_pokemon(20) TYPE c,
  fav_food(25)    TYPE c,
END OF t_tab1.

TYPES: BEGIN OF t_tab2,
  number          TYPE i,
  name(25)        TYPE c,
  sex             TYPE c,
  fav_pokemon(20) TYPE c,
END OF t_tab2.

DATA: lt_tab1 TYPE STANDARD TABLE OF t_tab1,
      wa_tab1 TYPE t_tab1,
      lt_tab2 TYPE STANDARD TABLE OF t_tab2,
      wa_tab2 TYPE t_tab2,
      flag    TYPE c VALUE 1.

PERFORM populate_lt_tab1.

*A one line version.
lt_tab2 = VALUE #( FOR lmao IN lt_tab1 ( CORRESPONDING #( lmao ) ) ).

*A longer version.
*lt_tab2 = VALUE #( FOR lmao IN lt_tab1 ( number      = lmao-number
*                                         name        = lmao-name
*                                         sex         = lmao-sex
*                                         fav_pokemon = lmao-fav_pokemon ) ).

PERFORM print_results TABLES lt_tab1 USING flag.
flag = 0.
PERFORM print_results TABLES lt_tab2 USING flag.

*&---------------------------------------------------------------------*
*&      Form  POPULATE_LT_TAB1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM populate_lt_tab1 .
  wa_tab1-number         = 123.
  wa_tab1-name           = 'Nezuko'.
  wa_tab1-occupation     = 'Developer'.
  wa_tab1-sex            = 'F'.
  wa_tab1-fav_pokemon    = 'Dedenne'.
  wa_tab1-fav_food       = 'Blueberry'.
  APPEND wa_tab1 TO lt_tab1.

  wa_tab1-number         = 537.
  wa_tab1-name           = 'Abydon'.
  wa_tab1-occupation     = 'Developer'.
  wa_tab1-sex            = 'M'.
  wa_tab1-fav_pokemon    = 'Cyndaquil'.
  wa_tab1-fav_food       = 'Broccoli'.
  APPEND wa_tab1 TO lt_tab1.

  wa_tab1-number         = 333.
  wa_tab1-name           = 'Halibel'.
  wa_tab1-occupation     = 'Developer'.
  wa_tab1-sex            = 'F'.
  wa_tab1-fav_pokemon    = 'Cubone'.
  wa_tab1-fav_food       = 'Tomato'.
  APPEND wa_tab1 TO lt_tab1.

  wa_tab1-number         = 193.
  wa_tab1-name           = 'Bubik'.
  wa_tab1-occupation     = 'Developer'.
  wa_tab1-sex            = 'M'.
  wa_tab1-fav_pokemon    = 'Glaceon'.
  wa_tab1-fav_food       = 'Soy beans'.
  APPEND wa_tab1 TO lt_tab1.

  wa_tab1-number         = 666.
  wa_tab1-name           = 'Attalos'.
  wa_tab1-occupation     = 'Developer'.
  wa_tab1-sex            = 'M'.
  wa_tab1-fav_pokemon    = 'Poochyena'.
  wa_tab1-fav_food       = 'Peanut butter'.
  APPEND wa_tab1 TO lt_tab1.

  wa_tab1-number         = 578.
  wa_tab1-name           = 'Rokaro'.
  wa_tab1-occupation     = 'Developer'.
  wa_tab1-sex            = 'M'.
  wa_tab1-fav_pokemon    = 'Totodile'.
  wa_tab1-fav_food       = 'Cucumber'.
  APPEND wa_tab1 TO lt_tab1.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  PRINT_RESULTS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM print_results TABLES p_tab USING p_flag.
  DATA: p_wa_tab  TYPE t_tab1,
        p_wa_tab2 TYPE t_tab2.
IF flag = '1'.
  WRITE: 'The initial records of the first table:'.
  ULINE.
  LOOP AT p_tab INTO p_wa_tab.
    WRITE: / p_wa_tab-number,
             p_wa_tab-name,
             p_wa_tab-occupation,
             p_wa_tab-sex,
             p_wa_tab-fav_pokemon,
             p_wa_tab-fav_food.
  ENDLOOP.
  ULINE.
ELSE.
  WRITE: 'The records moved to the second table:'.
  ULINE.
  LOOP AT p_tab INTO p_wa_tab2.
    WRITE: / p_wa_tab2-number,
             p_wa_tab2-name,
             p_wa_tab2-sex,
             p_wa_tab2-fav_pokemon.
  ENDLOOP.
  ULINE.
ENDIF.
ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------