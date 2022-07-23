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