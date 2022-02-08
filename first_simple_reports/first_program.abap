REPORT  report_name LINE-SIZE 255.
*Self-explanatory, but this can, apparently, cut the results of tables short. If the LINE-SIZE is set to a 
*value lower than the number of characters required to display all the output, the content of the line is cut.

*Comments are fine to explain stuff.

*---------------------------------------------------------------------------------------------------------------------------------
*My first program written with Udemy course.
*---------------------------------------------------------------------------------------------------------------------------------

DATA d_times TYPE i VALUE 4.
*I can add colon to WRITE and make it a 'statement chain' -> instead of writing WRITE every new line.
WRITE: '--------------------------'.
WRITE / '| Invoice number. | Date.|'.
WRITE / '--------------------------'.

DO 20 TIMES.
  WRITE / d_times.
  d_times = d_times + 1.
  WRITE 15 '3'. "15 means the value will be pushed 15 characters to the right.
ENDDO.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------