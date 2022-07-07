*---------------------------------------------------------------------------------------------------------------------------------
*INCLUDE PROGRAMS.
*---------------------------------------------------------------------------------------------------------------------------------

*Similar to Java's imports! An include is a reusable object which can contain global variables, subroutine definitions, module
*definitions.
*Variables are declared within the include. It is a good practice to include the INCLUDEs (hehe) at the beginning of the program.
INCLUDE ZBM_INCLUDE_ONE.
*INCLUDEs usually should be included at the very beginning of the program, but 'ZBM_INCLUDE_TWO' contains the definitions of
*subroutines and modules which means I have e.g. FORMs included... at the beginning of the program. And they always have to
*be at the very end of it. If I placed that INCLUDE below the 'PERFORM sub2', the program would compile.
*Thus, INCLUDEs should be at the very top of the program and if these INCLUDEs contain any subroutines' or modules' definitions,
*then I should add the event block START-OF-SELECTION after these INCLUDEs. This will tell SAP to not start the processing of
*the program from the INCLUDEs, but from where START-OF-SELECTION is placed and the INCLUDEs still will declared where they
*ought to be.
INCLUDE ZBM_INCLUDE_TWO.
START-OF-SELECTION.
x = 5.
y = 2.
z = x + y.
WRITE: / 'The sum is: ', z.

*The definition is within 'ZBM_INCLUDE_TWO'.
PERFORM sub2.

*********************************************
*THE CODE WITHIN ZBM_INCLUDE_ONE.
*********************************************
**An include program starts without any keyword. It is a nonexecutable program.
*DATA: x TYPE i,
*      y TYPE i,
*      z TYPE i.
*
*TYPES: BEGIN OF t_emp,
*         empno TYPE i,
*         ename(20) TYPE c,
*         empdesig(25) TYPE c,
*       END OF t_emp.
*
*DATA: it_emp TYPE TABLE OF t_emp,
*      wa_emp TYPE t_emp.

*********************************************
*THE CODE WITHIN ZBM_INCLUDE_TWO.
*********************************************
*DATA: a TYPE i VALUE 3,
*      b TYPE i VALUE 2,
*      c TYPE i.
*
*FORM sub1.
*  c = a - b.
*  WRITE: / 'The difference between two variables declared and defined withing the INCLUDE is: ', z.
*ENDFORM.
*
*FORM sub2.
*  c = a + b.
*  WRITE: / 'The sum between two variables declared and defined withing the INCLUDE is: ', z.
*ENDFORM.
*
*MODULE abc OUTPUT.
*  WRITE: / 'A module abc!'.
*ENDMODULE.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------