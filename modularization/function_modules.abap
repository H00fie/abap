*---------------------------------------------------------------------------------------------------------------------------------
*FUNCTION MODULES.
*---------------------------------------------------------------------------------------------------------------------------------

*Similar to subroutines, it is a set of statements that is defined once and can be called any number of times. The difference is that
*subroutines are created as part of a particular program while function modules are created with a separate tool - a function builder
*tool (transaction SE37).
*There are many standard function modules - provided by SAP. They can be called explicitly. Function modules can be custom if defined
*by a developer.
*All function modules, be they standard or custom ones, are stored within a function group. Function modules are kept in
*a database table (TFDIR).
*Repository objects (executable programs, include programs, subroutine pools) are stored in a database table TADIR.
*Function modules need to reside within function groups which are to be created in SE80. Whenever a function group is created, SAP
*creates two include programs. One of them is the 'TOP' and is used for declaring global variables, subroutines and modules. The second
*one is the 'UXX' and it is reserved for SAP. It is internally used by SAP. A function group will contain the function modules and includes
*in different directories.
*On behalf of every function modules, one include statement is created in 'UXX' include. Each of these statements refers to one function
*module.
*Once created - every function module is global and can be used anywhere within the SAP system.

*Within the created function module, in Attributes tab, I can pick various radiobuttons in the Processing Type section:
*- A 'Regular Function Module' means my function module can be accessed throughout this particular SAP server.
*- A 'Remote-Enabled Module' means my function module can be called from another SAP server.

*Parameters for the second, third and fourth custom function modules.
PARAMETERS: p_x TYPE i,
            p_y TYPE i.
*To contain the values returned by the third function.
DATA: gv_r1 TYPE i,
      gv_r2 TYPE i.

*------------------------------------------------------------
*----------A FUNCTION MODULE WITHOUT PARAMETERS--------------
*------------------------------------------------------------
*Since function modules are developed in a separate tool, a developer is provisioned with the possibility to test a function module
*within a function module tool. The below test function module only prints a string using the WRITE statement which displays the
*output in the output screen - List Processing Screen. If I Test (F8) my function module, I will be taken to another screen where
*I can select 'Display output list of function module' button on the Application Toolbar. This will show me the list generated.
WRITE: / 'A function module without any parameters:'.
CALL FUNCTION 'ZBM_FUNCTION_MODULE_ONE'
          .
ULINE.

**********************************************
**THE CODE WITHIN ZBM_FUNCTION_MODULE_ONE.
**********************************************
*FUNCTION ZBM_FUNCTION_MODULE_ONE.
**"----------------------------------------------------------------------
**"*"Lokalny interfejs:
**"----------------------------------------------------------------------
*WRITE: / 'Hello from ZBM_FUNCTION_MODULE_ONE!'.
*ENDFUNCTION.

*---------------------------------------------------------
*----------A FUNCTION MODULE WITH PARAMETERS--------------
*---------------------------------------------------------
*A function module with parameters:
WRITE: / 'A function module with parameters:'.
CALL FUNCTION 'ZBM_FUNCTION_MODULE_TWO'
  EXPORTING
    i_x           = p_x
    i_y           = p_y
          .
ULINE.

**********************************************
**THE CODE WITHIN ZBM_FUNCTION_MODULE_TWO.
**********************************************
*FUNCTION ZBM_FUNCTION_MODULE_TWO.
**"----------------------------------------------------------------------
**"*"Lokalny interfejs:
**"  IMPORTING
**"     REFERENCE(I_X) TYPE  I
**"     REFERENCE(I_Y) TYPE  I
**"----------------------------------------------------------------------
*DATA: lv_z TYPE i.
*lv_z = i_x + i_y.
*WRITE: / 'The sum is: ', lv_z.
*ENDFUNCTION.

*In different programming languages, a function can return just a single value. In ABAP any number of values can be returned and
*it depends on the number of export parameters. In ABAP export parameters are always optional. Function modules do not use any
*"return" keyword, because export parameters are considered the values to be returned.
*When I am caling a function from my code, the EXPORTING parameters are the IMPORTING ones from the function's perspective. Likewise
*what, from the perspective of the rest of the code my function is IMPORTING is actually EXPORTING from within the function itself.
*The words used are dependant on the perspective.
*Below, esentially, 'p_x' and 'p_y' are being exported into the function module (from within the FM they are being imported), the function
*module performs its calculations and then the results are being imported from the FM (from within the FM they are being exported) and
*whatever values they are holding are being assigned to 'gv_r1' and 'gv_r2'.
WRITE: / 'A function module with multiple returned values:'.
CALL FUNCTION 'ZBM_FUNCTION_MODULE_THREE'
  EXPORTING
    i_x           = p_x
    i_y           = p_y
 IMPORTING
   E_R1          = gv_r1
   E_R2          = gv_r2
          .
WRITE: / 'The first returned value is:', gv_r1.
WRITE: / 'The second returned value is:', gv_r2.
ULINE.

**********************************************
**THE CODE WITHIN ZBM_FUNCTION_MODULE_THREE.
**********************************************
*FUNCTION ZBM_FUNCTION_MODULE_THREE.
*"----------------------------------------------------------------------
*"*"Lokalny interfejs:
*"  IMPORTING
*"     REFERENCE(I_X) TYPE  I
*"     REFERENCE(I_Y) TYPE  I
*"  EXPORTING
*"     REFERENCE(E_R1) TYPE  I
*"     REFERENCE(E_R2) TYPE  I
*"----------------------------------------------------------------------
*e_r1 = i_x + i_y.
*e_r2 = i_x - i_y.
*ENDFUNCTION.

*------------------------------------------------------------------
*----------A FUNCTION MODULE WITH CHANGING PARAMETERS--------------
*------------------------------------------------------------------
*CHANGING parameters act as both import and export parameters - the same parameter can be used for passing the value as well as
*returning the value.
*'p_y' acts as both the import and export value. It is one of the paramters exported into the function module and the only one
*that's being exported. The calculation is being performed on both parameters and one of them is also returned as a result.
WRITE: / 'A function module with a changing parameter:'.
CALL FUNCTION 'ZBM_FUNCTION_MODULE_FOUR'
  EXPORTING
    i_x           = p_x
  CHANGING
    c_y           = p_y
          .
WRITE: / 'The result is: ', p_y.

**********************************************
**THE CODE WITHIN ZBM_FUNCTION_MODULE_THREE.
**********************************************
*FUNCTION ZBM_FUNCTION_MODULE_FOUR.
**"----------------------------------------------------------------------
**"*"Lokalny interfejs:
**"  IMPORTING
**"     REFERENCE(I_X) TYPE  I
**"  CHANGING
**"     REFERENCE(C_Y) TYPE  I
**"----------------------------------------------------------------------
*c_y = i_x + c_y.
*ENDFUNCTION.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------