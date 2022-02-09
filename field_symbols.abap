*---------------------------------------------------------------------------------------------------------------------------------
*FIELD-SYMBOLS.
*---------------------------------------------------------------------------------------------------------------------------------
*Field-symbol is a placeholder for a data object which points to the value present at the memory address of a data object. The field-symbol does not reserve any
*physical memory itself when declared. It only points to a data object at run time. There are two types: typed field-symbols and generic field-symbols.

*--------------------------------------------
*FIELD-SYMBOLS AS A REPLACEMENT FOR WORK AREA.
*--------------------------------------------
*I can declare a field-symbol of type any structure, which can be used while looping through the internal table.
DATA: it_mara TYPE STANDARD TABLE OF mara.
FIELD-SYMBOLS: <fs_mara> TYPE mara.

SELECT * FROM mara INTO TABLE it_mara UP TO 50 ROWS. "Fetching the data into the internal table.

LOOP AT it_mara ASSIGNING <fs_mara>. "Assiging what's in the internal table into the field-symbol. I think that with field-symbols, I always have to ASSIGN stuff to it.
  IF <fs_mara> IS ASSIGNED.          "This is generally redundant. Used just to be on the safe side.
    WRITE: / <fs_mara>-matnr,        "Fields from the MARA table.
             <fs_mara>-mtart,
             <fs_mara>-meins.
  ENDIF.
ENDLOOP.
*If I change any field of structure in field-symbol, the corresponding field in the internal table will get updated. MODIFY statement is not required (it would be if
*I was using work area instead of field-symbols. Work area stores a copy of the internal table row, whereas field-symbol references the internal table row directly.
*Processing the internal table with field-symbols is thus faster than using work area.



*--------------------------------------------
*APPENDING TO INTERNAL TABLE PROGRAM.
*--------------------------------------------
DATA it_mara TYPE  STANDARD TABLE OF mara.
FIELD-SYMBOLS: <fs_mara> TYPE mara.

APPEND INITIAL LINE TO it_mara ASSIGNING <fs_mara>.
IF <fs_mara> IS ASSIGNED.
  <fs_mara>-matnr = 'MAT1'.
  <fs_mara>-matkl = '001'.
  UNASSIGN <fs_mara>.
ENDIF.

APPEND INITIAL LINE TO it_mara ASSIGNING <fs_mara>.
IF <fs_mara> IS ASSIGNED.
  <fs_mara>-matnr = 'MAT2'.
  <fs_mara>-matkl = '001'.
  UNASSIGN <fs_mara>.
ENDIF.
*-----CALLING THE FUNCTION-----
CALL FUNCTION 'SRTT_TABLE_DISPLAY' "I am calling this function to be able to WRITE the content of the table to a screen!
  EXPORTING
    table               = 'MARA'"I think that's the table we're basing our internal table on.
*   IV_TITLE            =
  tables
    table_content       = it_mara. "This is what we want written. The content of what we want displayed.
* EXCEPTIONS
*   INVALID_INPUT       = 1
*   OTHERS              = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
*-----FINISHING THE FUNCTION-----


*I should always perform a check on a field-symbol seeing if it is indeed assigned (IF <fs_mara> IS ASSIGNED.) before doing
*any operation in order to avoid a 'short dump'. After doing the opertaion, I should also unassign the field-symbol.

*READ TABLE it_mara ASSIGNING <fs_mara> WITH KEY matnr = 'MAT1'. "This should technically read the table as well, but tough luck, IT DOSN'T!

*----------------------------
*TYPED FIELD SYMBOLS' PROGRAM
*----------------------------
DATA var TYPE i VALUE 2.
FIELD-SYMBOLS: <fs_num> TYPE i. "My field-symbol assumes a certain type of data.
ASSIGN var TO <fs_num>. "My field-symbol assumes the concrete value of the variable var.
WRITE: / <fs_num>. "My field-symbol has now the value of 2, because it was assigned the value of var which initially had 2 as its value.
<fs_num> = 4.
WRITE: / var. "var now has the value of 4 because my field-symbol is a placeholder for it, a representation of it. If my field-symbols chagnes so does the value it points at.

*Typed field-symbols can only point to the data object of a specified type. Changes done to the field-symbol will be also done to the variable which was ASSIGNed to my field-symbol.
*----------------------------
*GENERIC FIELD SYMBOLS' - TYPE ANY PROGRAM
*----------------------------
*Dynamic programming is usually implemented using generic field-symbols. The most commonly used generic types are
*TYPE ANY and TYPE ANY TABLE.

FIELD-SYMBOLS: <fs_str> TYPE any.
FIELD-SYMBOLS: <fs_data> TYPE any.

*I can assign any data object to the TYPE ANY and any internal table to TYPE TABLE ANY.

DATA lw_mara TYPE mara.
ASSIGN lw_mara TO <fs_str>. "Assigning internal table's data to <fs_str> which is of whatever type I want it to be.
IF <fs_str> IS ASSIGNED.
  ASSIGN COMPONENT 'MATNR' OF STRUCTURE <fs_str> TO <fs_data>.
*Above I am adding component named 'matnr' from the structure <fs_str> to <fs_data>. This is done in such a stiff manner, because
*I cannot directy access the field <fs_str>-matnr... It's declared at runtime!
*By doing it that way, I am creating an abstraction, a workaround - I am assigning a component named MATNR of <fs_str> (which is basically
*lw_mara which is like mara) to <fs_data> and then, below, I am giving the value of MAT001 to <fs_data>... so to a field named MATNR in
*<fs_str> because field-symbols are references! I am thus assigning a value to a field that I cannot access yet because it's done decalred
*yet (will be at runtime)!
  IF <fs_data> IS ASSIGNED.
    <fs_data> = 'MAT001'.
    UNASSIGN <fs_data>. "Also a supposedely regular thing to do. Clean code thing maybe?
  ENDIF.
  UNASSIGN <fs_str>.
ENDIF.

*After I've assigned lw_mara to <fs_str>, I cannot directly use '-' operator on the field-symbol to access mara's
*structure (e.g. <fs_str>-matnr), because that would cause a syntax error - and that is because field-symbol type is
*declared only at runtime, not at compile time! Which means that until then... <fs_str> does not have the content of what's
*been assigned to it?
*After all that, the above code will make lw_mara-matnr have the value of 'MAT001', which is kewl.

*----------------------------
*GENERIC FIELD SYMBOLS' - TYPE ANY TABLE PROGRAM
*----------------------------
*I can assign any internal table to such a symbol.

FIELD-SYMBOLS: <fs_tab> TYPE ANY TABLE. "Remember, field-symbols are references to data objects.
FIELD-SYMBOLS: <fs_str> TYPE any.
FIELD-SYMBOLS: <fs_data> TYPE any.

DATA: lt_mara TYPE STANDARD TABLE OF mara. "Creating an internal table based on database table mara.

SELECT * FROM mara INTO TABLE lt_mara UP TO 30 ROWS. "Populating the internal table with records from mara... which means that declaring lt_mara there makes the internal table look LIKE (structure) mara, not have the values.
ASSIGN lt_mara TO <fs_tab>. "Making <fs_tab> refer to lt_mara.

LOOP AT <fs_tab> ASSIGNING <fs_str>."Looping through lt_mara (referenced by <fs_tab>!) ASSIGNing it's records (one record per iteration of the loop) to <fs_str>. Which means that <fs_str> is a reference to a single record.
  IF <fs_str> IS ASSIGNED.
    ASSIGN COMPONENT 'MATKL' OF STRUCTURE <fs_str> TO <fs_data>. "ASSIGN COMPONENT "which looks like 'MATKL' from <fs_str> (which is a reference to a single record of lt_mara) to <fs_data>.
*So <fs_data> is now a refernce to a component (field) named 'MATKL' taken from <fs_str> which is a reference to a single record from <fs_tab> which is lt_mara.
    IF <fs_data> IS ASSIGNED.
      IF <fs_data> EQ '01'. "If that field equals '01' then do stuff...
************DO STUFF************
      ENDIF.
      UNASSIGN <fs_data>.
    ENDIF.
  ENDIF.
ENDLOOP.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------