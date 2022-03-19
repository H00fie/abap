*---------------------------------------------------------------------------------------------------------------------------------
*MODULARIZING PROGRAMS.
*---------------------------------------------------------------------------------------------------------------------------------

*EVENT BLOCKS are a modularization technique as well.



*INCLUDE----------------------------------------
*They are made available globally within a SAP system. Their sole purpose is to modularize code. They accept no parameters. An include
*file/program is a separate file in SAP system and can be included in any other program.
*A syntax check within my main program, it is also carried out automatically in my includes. They work in tandem.



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
DATA modu_tab TYPE zpokemon.
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
FORM TEST_SUBROUTINE_THREE  TABLES   p_modu_tab STRUCTURE .
*Test structures for "bypassing" the header line.  
*  DATA wa_tmp TYPE some_table.
*  LOOP AT p_modu_tab INTO wa_tmp.
*    WRITE wa_tmp-some_value.
*  ENDLOOP.
endform.                    " TEST_SUBROUTINE_THREE

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------