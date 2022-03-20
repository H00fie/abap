*---------------------------------------------------------------------------------------------------------------------------------
*SUBROUTINES.
*---------------------------------------------------------------------------------------------------------------------------------

*WARNING! -> a PERFORM will not work correctly if declared beneath another PERFORM's FORM.

*EVENT BLOCKS are a modularization technique as well.

*INCLUDE----------------------------------------
*They are made available globally within a SAP system. Their sole purpose is to modularize code. They accept no parameters. An include
*file/program is a separate file in SAP system and can be included in any other program.
*A syntax check within my main program, it is also carried out automatically in my includes. They work in tandem.
*INCLUDE some_include.


*PROCEDURES----------------------------------------
*Processing blocks that are called from the main ABAP program. Procedures come in the form of SUBROUTINES or SUBPROGRAMS and
*FUNCTION MODULES.
*They are used mainly for local modularization of the code - to contain a small modular unit of code that is self-contained to be
*called from program in which they are defined (so basically methods).
*Such subroutines can be used to write functions that are used many times in the program. Any ABAP program can include subroutines.
*Function modules allow me to create modular blocks of code that are held separately from my ABAP program and can be called by any
*other program.
*So SUBROUTINES are local to the program in which they are defined abd FUNCTION MODULES are global.
*FUNCTION MODULES are used the most often.
*Procedures are different from INCLUDES as they have an interface for trasnferring data from the calling program to the procedure
*itself. Thus, I can pass parameters into procedures.
PERFORM test_subroutine.

*Variables can be used in the interface of my form. When I do that, I am telling the system I am going to transfer the data
*throughout the subroutine data interface - by using USING.
DATA: z_field1 LIKE zpokemon-surname,
      z_field2 LIKE zpokemon-forename.
z_field1 = 'Ayen'. "Making sure the passed fields have an actual value.
z_field2 = 'Tranok'.
PERFORM test_subroutine_two USING z_field1 z_field2.
WRITE / z_field1. "This will NOT be 'Ayen' - see the subroutine's interface.

DATA modu_tab TYPE STANDARD TABLE OF zpokemon.
PERFORM test_subroutine_three TABLES modu_tab.

*Below is my subroutine created automatically by the forward navigation. It is not considered a part of the actual report, the report
*itself is finishing upon the calling of the perform (because there's nothing else afterwards).
*&---------------------------------------------------------------------*
*&      Form  TEST_SUBROUTINE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM TEST_SUBROUTINE .

  DATA zpoke LIKE zpokemon-surname. "This is a local variable and can only be referenced from within the subroutine.

ENDFORM.                    " TEST_SUBROUTINE


*My form is declaring two fields that will be used in the interface of the form, but they have no data type. That is
*because they are copied from my main program.
*The global field (DATA in the main program) will be updated along with the local field that corresponds to it if it's
*updated itself within the subroutine. Any fields used by USING statement will be changed like that.
*&---------------------------------------------------------------------*
*&      Form  TEST_SUBROUTINE_TWO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_Z_FIELD1  text
*      -->P_Z_FIELD2  text
*----------------------------------------------------------------------*
FORM TEST_SUBROUTINE_TWO  USING    p_zsurname
                                   p_zforename.

WRITE / p_zsurname.
WRITE / p_zforename.

p_zsurname = 'Toka'. "This will change the value of the corresponding variable in the main program!

ENDFORM.                    " TEST_SUBROUTINE_TWO

*Internal tables as well as a combination of individual fields can also be passed into subroutines.
*The sequence of the passed fields and tables has to be the same as in the main program because it's
*the sequence of the fields when I create my perform statement that determines which field is passed to
*the interface variable of my form.
DATA modu_tab TYPE STANDARD TABLE OF zpokemon.
PERFORM test_subroutine_three TABLES modu_tab.

*USING is here replaced with TABLES. When the program is executed, the perform makes sure that contents
*of my internal table are transferred to the subroutine and stored within p_modu_tab.
*One the processing reaches the end of the form, the contents of the local internal table are then passed
*back to the global internal table. This is so for the tables without a header line. If I was using a table
*with a header line, my perform would only pass the header line into the subroutine.
*If I am using an internal table with a header line, I need to add square brackets to the table's name.

*When the internal table is passed into the subroutine, this local internal table is ALWAYS declared with a
*header line!
*I can declare a local Work Area and still loop at the local internal table into it in order to bypass the
*fact that the local internal table is with a header line.
*&---------------------------------------------------------------------*
*&      Form  TEST_SUBROUTINE_THREE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_MODU_TAB  text
*----------------------------------------------------------------------*
FORM TEST_SUBROUTINE_THREE  TABLES   p_modu_tab.
*Test structures for "bypassing" the header line.
*  DATA wa_tmp TYPE some_table.
*  LOOP AT p_modu_tab INTO wa_tmp.
*    WRITE wa_tmp-some_value.
*  ENDLOOP.
endform.                    " TEST_SUBROUTINE_THREE

*The combination of fields and tables can also be passed into subroutines at the same time.
PERFORM test_subroutine_four TABLES modu_tab USING z_field1 z_field2.

*&---------------------------------------------------------------------*
*&      Form  TEST_SUBROUTINE_FOUR
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_MODU_TAB  text
*      -->P_Z_FIELD1  text
*      -->P_Z_FIELD2  text
*----------------------------------------------------------------------*
FORM TEST_SUBROUTINE_FOUR  TABLES   p_modu_tab
                           using    p_z_field1
                                    p_z_field2.

ENDFORM.                    " TEST_SUBROUTINE_FOUR

*Subroutines were desgined for modularizing and structurizing programs, but they can be extended in such a way, that they can
*be called externally from other programs.
*If my goal is to make my function available throughout SAP system, I should rather use Function Modules though.
*There are two ways in which I can call a subroutine over an external program, but the first one is preferable, because it's
*required when using ABAP objects!

*FIRST WAY
PERFORM external_sub IN PROGRAM external_program USING z_field1 z_field2.

*SECOND WAY - UNAVAILABLE IN THE CONTEXT OF ABAP OBJECTS
*PERFORM external_sub (external_program) USING z_field1 z_field2. <--- the first bracker is red anyway.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*FUNCTION MODULES.
*---------------------------------------------------------------------------------------------------------------------------------

*A Function Module is a specific procedure that are defined within function groups and can be called from any other ABAP program.
*A function group acts like a container for all the function modules that logically belong together.

*Attributes tab.
*Here I can see the function group my function module belongs to and its descriptions. The processing type section defines the
*actual type of function module, e.g. Remote-enabled module mean it can get triggered from an external system.
*Import tab.
*Lists the individual fields I will use as my data interface for data I pass into the function module. This is the information
*that my function module will be importing in order to process it. Fields can be set as optional. The pass by value means (if checked)
*that I will be passing the actual value into the function module.
*Export tab.
*Once the function module does its work, the fields defined in the export tab constitues what is being sent back to the calling program.
*Changing tab.
*Lists fields that would be changed by the function module. Import is what is being received, export what is being returned and changing
*what is being received, changed and sent back.
*Tables tab.
*Internal tables, as they also can be passed, are set up here.
*Exceptions tab.
*All function modules have the ability to pass back exception information to indicate whether the function module was executed successfully
*or not. Specific error messages can also be determined here.
*Source code.
*This is where ABAP is!

*Because function modules are created separate to normal programs, there are various tools to test out them without having to write the
*code to call them.
*If I have the function module open (or am in SE37), I can just press F8. The initial screen will look a little bit different for every
*function module, because it is dependant on import, changing and tables parameters.

*Coding example.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(15) text-003. "Start at the first position and have 15 characters' length.
PARAMETER my_num TYPE i.
SELECTION-SCREEN END OF LINE.

*When I call a function module, all its optional fields are automatically commented out. The finishing dot is placed in its own line
*because all other lines might be commented out to begin with and that last dot is, obviously, required.
*I am coding the actions of the module upon its execution myself in the IF section. Firstly, what's it supposed to do if there's an
*error and what to do ELSE, if everything went fine.

*I need to create a variable to hold the result. I will add it to IMPORTING part (in Function Module editor it's actually in export tab!
*It's a matter of perspective. I am calling this FM, so I am importing a result from it, but the FM is exporting it to me).
*I learn how to declare my result variables by checking FM editor, the export tab - there I can find what the FM is supposed to return.
*SPELL is a structure, so my WRITE statement cannot convert it just like that to text. I can check what's the result of the FM made of by testing
*the FM in its editor and I can check which field of SPELL I need to focus on by checking the structure of SPELL.
DATA result LIKE spell.
CALL FUNCTION 'SPELL_AMOUNT'
 EXPORTING
   AMOUNT          = my_num
*   CURRENCY        = ' '
*   FILLER          = ' '
*   LANGUAGE        = SY-LANGU
 IMPORTING
   IN_WORDS        = result
* EXCEPTIONS
*   NOT_FOUND       = 1
*   TOO_LARGE       = 2
*   OTHERS          = 3
          .
IF sy-subrc <> 0.
  WRITE: 'The function module returned a value of ', sy-subrc.
ELSE.
  WRITE: 'The amount in words is ', result-word.
ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------