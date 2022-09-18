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

*------------------------------------------------------------------
*----------A FUNCTION MODULE WITH EXCEPTIONS-----------------------
*------------------------------------------------------------------
*EXCEPTION handling is performed in order to avoid runtime errors. Due to 'myexception' being defined within the function
*module and raised if the divider is 0, a runtime error will be avoided and the result will be 0.
*Upon calling the FM, the exception section is added due to the fact that I created a custom exception for the FM. If the
*condition will be true (the divider -'i_y' being 0) and this 'myexception' is raised - sy-subrc is set to 1. sy-subrc contains
*the execution status of the previous ABAP statement. If any different exception is raised, sy-subrc is set to 2. I can assign
*whatever values I want. If no exception is raised, sy-subrc remains 0.
WRITE: / 'A function module with a custom exception:'.
CALL FUNCTION 'ZBM_FUNCTION_MODULE_FIVE'
  EXPORTING
    i_x               = p_x
    i_y               = p_y
  IMPORTING
    E_Z               = gv_r1
 EXCEPTIONS
   MYEXCEPTION       = 1
   OTHERS            = 2.
IF sy-subrc = 0.
  WRITE: / 'The division is: ', gv_r1.
ELSEIF sy-subrc = 1.
  WRITE: 'Cannot divide by 0!'.
ELSEIF sy-subrc = 2.
  WRITE: / 'An unknown error occured!'.
ENDIF.

**********************************************
**THE CODE WITHIN ZBM_FUNCTION_MODULE_FIVE.
**********************************************
*FUNCTION ZBM_FUNCTION_MODULE_FIVE.
**"----------------------------------------------------------------------
**"*"Lokalny interfejs:
**"  IMPORTING
**"     REFERENCE(I_X) TYPE  I
**"     REFERENCE(I_Y) TYPE  I
**"  EXPORTING
**"     REFERENCE(E_Z) TYPE  I
**"  EXCEPTIONS
**"      MYEXCEPTION
**"----------------------------------------------------------------------
*IF i_y = 0.
*  RAISE myexception.
*ELSE.
*  e_z = i_x / i_y.
*ENDIF.
*ENDFUNCTION.
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*STANDARD FUNCTION MODULES PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------

*Standard FMs are defined by SAP itself and are ready to be used by a developer.
*AS LISTBOX VISIBLE LENGTH addition provides a drop down list of values for the parameter field. If I used AS LISTBOX without
*VISIBLE LENGTH, I would get an error. I additionally need to specify a set of values which I would associate with my listbox.
*Without it, I would have an empty drop-down list.
*As I execute the program, before the selection screen is displayed, two events are triggered - INITIALIZATION and
*AT-SELECTION-SCREEN OUTPUT. If I want a fixed set of values to be available within my drop-down list, I need to specify it
*during the INITIALIZATION event.
*Every value in the drop-down list needs to be associated with a key which is used to identify the selected value. That key,
*upon the selection of the value, will be assigned to the parameter ('p_course').
PARAMETERS p_course(20) TYPE c AS LISTBOX VISIBLE LENGTH 15.

*An internal table required by the standard function module I will use to manage the drop-down list. The line of the table
*consists of a key and a text.
*In earlier SAP versions, I would also have to define 'TYPE-POOLS vrm' - to be able to use 'vrm_value'.
DATA: lt_values TYPE TABLE OF vrm_value,
      wa_value  TYPE vrm_value.

*The logic assigning values from the drop-down list to their keys should be specified in the INITIALIZATION. In ABAP whenever
*I need to create a drop-down list, there is a standard function module for that.
INITIALIZATION.
  PERFORM prepared_drop_down. "Prepares the input for the FM.
    IF lt_values IS NOT INITIAL.
      PERFORM display_dropdown.
    ENDIF.

*&---------------------------------------------------------------------*
*&      Form  PREPARED_DROP_DOWN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM prepared_drop_down .
  CLEAR wa_value.
  wa_value-key = 'K1'.
  wa_value-text = 'CORE ABAP'.
  APPEND wa_value TO lt_values.

  CLEAR wa_value.
  wa_value-key = 'K2'.
  wa_value-text = 'OOPS ABAP'.
  APPEND wa_value TO lt_values.

  CLEAR wa_value.
  wa_value-key = 'K3'.
  wa_value-text = 'CROSS APPS'.
  APPEND wa_value TO lt_values.
ENDFORM.                    " PREPARED_DROP_DOWN

*&---------------------------------------------------------------------*
*&      Form  DISPLAY_DROPDOWN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM DISPLAY_DROPDOWN .
*ID is the name of the drop-down list. That name is the name of the parameter that's supposed to have
*a drop-down list.
  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id                    = 'P_COURSE'
      values                = lt_values
   EXCEPTIONS
     ID_ILLEGAL_NAME       = 1
     OTHERS                = 2.
  IF sy-subrc = 1.
    MESSAGE 'Illegal drop-down list box name.' TYPE 'I'.
  ELSEIF sy-subrc = 2.
    MESSAGE 'An unknown error occured.' TYPE 'I'.
  ENDIF.

ENDFORM.                    " DISPLAY_DROPDOWN

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------