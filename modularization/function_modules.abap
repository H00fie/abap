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

*Parameters for the second custom function module.
PARAMETERS: p_x TYPE i,
            p_y TYPE i.

*Since function modules are developed in a separate tool, a developer is provisioned with the possibility to test a function module
*within a function module tool. The below test function module only prints a string using the WRITE statement which displays the
*output in the output screen - List Processing Screen. If I Test (F8) my function module, I will be taken to another screen where
*I can select 'Display output list of function module' button on the Application Toolbar. This will show me the list generated.
WRITE: / 'A function module without any parameters:'.
CALL FUNCTION 'ZBM_FUNCTION_MODULE_ONE'
          .

**********************************************
**THE CODE WITHIN ZBM_FUNCTION_MODULE_ONE.
**********************************************
*FUNCTION ZBM_FUNCTION_MODULE_ONE.
*WRITE: / 'Hello from ZBM_FUNCTION_MODULE_ONE!'.
*ENDFUNCTION.

*A function module with parameters:
WRITE: / 'A function module with parameters:'.
CALL FUNCTION 'ZBM_FUNCTION_MODULE_TWO'
  EXPORTING
    i_x           = p_x
    i_y           = p_y
          .

**********************************************
**THE CODE WITHIN ZBM_FUNCTION_MODULE_TWO.
**********************************************
*FUNCTION ZBM_FUNCTION_MODULE_TWO.
*DATA: lv_z TYPE i.
*lv_z = i_x + i_y.
*WRITE: / 'The sum is: ', lv_z.
*ENDFUNCTION.
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------