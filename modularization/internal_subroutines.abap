*---------------------------------------------------------------------------------------------------------------------------------
*MODULARIZATION. INTERNAL SUBROUTINES, PASS BY VALUE, PASS BY REFERENCE.
*---------------------------------------------------------------------------------------------------------------------------------

*Modularization is a process of breaking a program into smaller individual blocks. A block is a set of statements which is defined
*only once and can be called any number of times.
*Modularization techniques are: subroutines, include programs, function modules, methods and macros.
*Modularization increases reusability, decreases the cost of maintenance, increases readibility and provides efficient control over
*programs' flow.

*Variables to be used by the second subroutine.
DATA: v_x TYPE i VALUE 20,
      v_y TYPE i VALUE 10.
*Variables to be used by the third subroutine.
DATA: v_r1 TYPE i,
      v_r2 TYPE i.

*Subroutine's call to action! I can reuse once defined subroutine as many times as I want. This is an internal subroutine which means
*it is defined and called within the same program. Subroutines can also be external when they are defined and called in different programs.
PERFORM sub1.
PERFORM sub1.
PERFORM sub1.

ULINE.

*Subroutines can also have parameters. USING is to be used whenever I am dealing with standard data types as parameters. At the time of
*the calling of the subroutine, I am USING the actual variables as parameters.
PERFORM sub2 USING v_x v_y.

ULINE.

*Subroutines can also return values and any number of them. CHANGING means these values (declared above) will be assigned new values by
*the subroutine.
PERFORM sub3 USING v_x v_y CHANGING v_r1 v_r2.
WRITE: 'The results from the sub3 are:'.
WRITE: 'The sum is: ', v_r1.
WRITE: 'The difference is: ', v_r2.

ULINE.

*-----------------------------------------------------------
*----------Pass by value and pass by reference--------------
*-----------------------------------------------------------
*Paramaters can be passed into subroutines in one of two ways - either pass by value or pass by reference. By default, they are passed
*by reference. In the below example 'v_x' and 'v_y' are received by the FORM as 'k1' and 'k2' and it means that the ADDRESSES of ACTUAL
*(former) parameters are copied to FORMAL (latter) parameters. Thus the formal parameters will point to the actual parameters. 'k1' and
*'k2' will point to 'v_x' and 'v_y' respectively knowing just their address and not containing their values.
v_x = 10.
v_y = 20.
WRITE: / 'Pass by reference:'.
WRITE: / 'v_x and v_y before the calling of the subroutine:', v_x, v_y.
PERFORM sub4 USING v_x v_y.
*The values of the variables have been changed. The changes made to the formal parameters are reflected in the actual parameters, because
*the formal parameters point to the actual parameters.
WRITE: / 'v_x and v_y after the calling of the subroutine:', v_x, v_y.

ULINE.

*When passing by value, the signature of the subroutine is the same. The changes come in the definition. The keyword 'VALUE' used there
*tells SAP to not take the address of the passed variable, but the value of the actual parameter. 'k1' and 'k2' will not be pointing to
*the actual variables. They are just receiving the same values as the actual parameters.
CLEAR: v_x, v_y.
v_x = 10.
v_y = 20.
WRITE: / 'Pass by value:'.
WRITE: / 'v_x and v_y before the calling of the subroutine:', v_x, v_y.
PERFORM sub5 USING v_x v_y.
*'v_x' and 'v_y' remain unchanged because the subroutine just copies their values and assigns them to its local variables of 'k1' and 'k2'.
*Any operation performed on formal parameters within the subroutine will not be reflected in the actual variables, because there's no
*connection between them.
WRITE: / 'v_x and v_y after the calling of the subroutine:', v_x, v_y.

*&---------------------------------------------------------------------*
*&      Form  sub1
*&---------------------------------------------------------------------*
*       This is the definition of the subroutine.
*----------------------------------------------------------------------*
FORM sub1.
  WRITE: / 'Hello! This is a very long text that I did not want to have to repeat multiple times, so I made it into a subroutine instead.'.
ENDFORM.                    "sub1

*&---------------------------------------------------------------------*
*&      Form  sub2
*&---------------------------------------------------------------------*
*       The names of the parameters can be the same as the actual parameters or they can be different. The moment the control comes out of
*       the subroutine, the local variables and formal parameters ('p_x', 'p_y') are destroyed.
*----------------------------------------------------------------------*
FORM sub2 USING p_x p_y.
  DATA: result TYPE i.
  result = p_x + p_y.
  WRITE: / 'The sum is: ', result.
ENDFORM.                    "sub2

*&---------------------------------------------------------------------*
*&      Form  sub3
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->K1         text
*      -->K2         text
*      <--M1         text
*      <--M2         text
*      k1 will become v_x, k2 will become v_y, m1 will become v_r1 and m2 will become v_r2. No 'return' is required. SAP understands
*      on its own that 'changing' values are the ones being returned.
*----------------------------------------------------------------------*
FORM sub3 USING k1 k2 CHANGING m1 m2.
  m1 = k1 + k2.
  m2 = k1 - k2.
ENDFORM.                    "sub3

*&---------------------------------------------------------------------*
*&      Form  sub4
*&---------------------------------------------------------------------*
*       Below, not values but addresses are being copied!
*----------------------------------------------------------------------*
*      -->K1         text
*      -->K2         text
*----------------------------------------------------------------------*
FORM sub4 USING k1 k2.
  DATA k3 TYPE i.
  k3 = k1.
  k1 = k2.
  k2 = k3.
ENDFORM.                    "sub4

*&---------------------------------------------------------------------*
*&      Form  sub5
*&---------------------------------------------------------------------*
*       In order to have the variables passed by value, I need to utilize the VALUE keyword.
*----------------------------------------------------------------------*
*      -->VALUE      text
*      -->(K1)       text
*      -->VALUE      text
*      -->(K2)       text
*----------------------------------------------------------------------*
FORM sub5 USING VALUE(k1) VALUE(k2).

ENDFORM.                    "sub5

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------