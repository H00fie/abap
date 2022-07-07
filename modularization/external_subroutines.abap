*---------------------------------------------------------------------------------------------------------------------------------
*MODULARIZATION. EXTERNAL SUBROUTINES.
*---------------------------------------------------------------------------------------------------------------------------------

*If I want the same functionality to be used across multiple programs, I should create an external subroutine. Below statement
*will throw an error desptie 'sub1' being defined... because it's defined in another program (ZBM_TEST3). By default, subroutines
*are considered internal.
*PERFORM sub1.

*I need to specify from what program I want to call the subroutine. Both of the below ways of calling an external subroutine are
*correct.
PERFORM sub1 IN PROGRAM ZBM_TEST3.
PERFORM sub1(ZBM_TEST3).

ULINE.

*Calling an external subroutine with parameters.
PERFORM sub2 IN PROGRAM ZBM_TEST3 USING 20 10.
PERFORM sub2 IN PROGRAM ZBM_TEST3 USING 60 3.

ULINE.

*---------------------------------------
*----------SUBROUTINE POOL--------------
*---------------------------------------
*In SE38, next to regular executable programs, I can create subroutine pools (ZBM_SUBROUTINE_POOL).
PERFORM sub1 IN PROGRAM ZBM_SUBROUTINE_POOL.
PERFORM sub1(ZBM_SUBROUTINE_POOL).

ULINE.

PERFORM sub2(ZBM_SUBROUTINE_POOL) USING 30 10.
PERFORM sub3(ZBM_SUBROUTINE_POOL) USING 30 10.

*********************************************
*THE CODE WITHIN ZBM_TEST3.
*********************************************
*REPORT  ZBM_TEST3.
*
*FORM sub1.
*  WRITE: / 'Inside the sub1 subroutine in ZBM_TEST3!'.
*ENDFORM.
*
*FORM sub2 USING x y.
*  WRITE: / 'Inside the sub2 subroutine in ZBM_TEST3!'.
*  DATA z TYPE i.
*  z = x + y.
*  WRITE: / 'The sum is: ', z.
*  WRITE: / 'The end of sub2!'.
*ENDFORM.

*********************************************
*THE CODE WITHIN ZBM_SUBROUTINE_POOL.
*********************************************
*This is a subroutine pool and thus is not executable. Trying to do so will throw an error.
*PROGRAM  ZBM_SUBROUTINE_POOL.
*
*DATA z TYPE i.
*
*FORM sub1.
*  WRITE: / 'Inside sub1 of subroutine pool!'.
*ENDFORM.
*
*FORM sub2 USING x y.
*  z = x + y.
*  WRITE: / 'The sum is: ', z.
*ENDFORM.
*
*FORM sub3 USING x y.
*  z = x - y.
*  WRITE: / 'The difference is: ', z.
*ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------