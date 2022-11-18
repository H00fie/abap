*---------------------------------------------------------------------------------------------------------------------------------
*DATABASE DATA RETRIEVAL - SELECT SINGLE. NO INTERNAL TABLE. LOCAL FIELDS NOT REFERING TO DATABASE TABLE'S FIELDS.
*---------------------------------------------------------------------------------------------------------------------------------

*My variables reflect the fields within the database table in terms of the data type and the length.
DATA: f1(10) TYPE c,
      f2(3)  TYPE c,
      f3(35) TYPE c,
      f4(35) TYPE c.

PARAMETERS: p_cstno(10) TYPE c.

*SELECT SINGLE is an OpenSQL statement used for retrieving a single record from the database table. Whenever used,
*it is recommended to use WHERE clause in the query comparing a primary key field to ensure the appropriate record
*is loaded.
SELECT SINGLE kunnr land1 name1 name2
  FROM kna1
  INTO (f1, f2, f3, f4)
  WHERE kunnr = p_cstno.

*'sy-subrc' contains the information about the execution status of ABAP statements. 0 means success, 4 means failure.
IF sy-subrc = 0.
  MESSAGE 'Customer found!' TYPE 'I'.
  WRITE: / 'Customer number:', f1,
         / 'Customer country:', f2,
         / 'Customer name:', f3,
         / 'Customer city:', f2.
ELSE.
  MESSAGE 'Customer not found!' TYPE 'I'.
ENDIF.
  
*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*DATABASE DATA RETRIEVAL - SELECT SINGLE. NO INTERNAL TABLE. FIELDS REFERING TO DATABASE TABLE'S FIELDS.
*---------------------------------------------------------------------------------------------------------------------------------

*My variables reflect the fields within the database table in terms of the data type and the length... BUT this is a "dangerous"
*way of declaring the variables. The data types within the database table might change and my variables here will not refelect that.
*DATA: f1(10) TYPE c,
*      f2(3)  TYPE c,
*      f3(35) TYPE c,
*      f4(35) TYPE c.

*Instead, I should create my variables to be of the same data element as the fields within the database table I am interested in.
*Thus, if, say, KUNNR is changed by SAP one day, my variables will reflect the change as well.
*DATA: f1 TYPE kunnr,
*      f2 TYPE land1_gp,
*      f3 TYPE name1_gp,
*      f4 TYPE ort01.

*I can also prefix every data element name with the name of the table from which the field will be taken. I am refering to the
*names of the fields of the table in this case, not the names of data elements themselves.
*Both ways of refering to the database table's fields are recommended. It is also recommended to name my program's fields the
*same as the database table's fields the type of which they are.
DATA: kunnr TYPE kna1-kunnr,
      land1 TYPE kna1-land1,
      name1 TYPE kna1-name1,
      ort01 TYPE kna1-ort01.

*The limitation to declaring a parameter like that is that I will not have an F4 help by default.
*PARAMETERS: p_cstno(10) TYPE c.

*Creating a parameter in a more specific way I am ensuring there will be F4 help by default. If the data element is associated
*with the search help at a database level - the same search help will be associated with my program's selection screen's variable.
PARAMETERS: p_kunnr TYPE kna1-kunnr.

*SELECT SINGLE ensures I will only get a single record. This is ensured by refering to the primary key field in the WHERE clause.
*A primary key field is a guarantee I will not have duplicate entries.
SELECT SINGLE kunnr land1 name1 name2
  FROM kna1
  INTO (kunnr, land1, name1, ort01)
  WHERE kunnr = p_kunnr.

*'sy-subrc' contains the information about the execution status of ABAP statements. 0 means success, 4 means failure.
IF sy-subrc = 0.
  MESSAGE 'Customer found!' TYPE 'I'.
  WRITE: / 'Customer number:', kunnr,
         / 'Customer country:', land1,
         / 'Customer name:', name1,
         / 'Customer city:', ort01.
ELSE.
  MESSAGE 'Customer not found!' TYPE 'I'.
ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*DATABASE DATA RETRIEVAL - SELECT SINGLE. NO INTERNAL TABLE. WORK AREA.
*---------------------------------------------------------------------------------------------------------------------------------

PARAMETERS p_kunnr TYPE kna1-kunnr.

TYPES: BEGIN OF t_customer,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kna1-land1,
  name1 TYPE kna1-name1,
  ort01 TYPE kna1-ort01,
END OF t_customer.

*Work area is a collection of fields. It is a single row of whatever structure it is based on.
DATA: wa_customer TYPE t_customer.

SELECT SINGLE kunnr land1 name1 ort01
  FROM kna1
  INTO wa_customer
  WHERE kunnr = p_kunnr.
IF sy-subrc = 0.
  WRITE: / 'Customer ', p_kunnr, ' is found:'.
  WRITE: / 'Customer number: ', wa_customer-kunnr,
         / 'Customer country: ', wa_customer-land1,
         / 'Customer name: ', wa_customer-name1,
         / 'Customer city: ', wa_customer-ort01.
ELSE.
  WRITE: 'Cutomer number ', p_kunnr, ' not found.'.
ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*DATABASE DATA RETRIEVAL - NATIVE SQL.
*---------------------------------------------------------------------------------------------------------------------------------

PARAMETERS p_kunnr TYPE kna1-kunnr.

DATA: v_kunnr TYPE kna1-kunnr,
      v_land1 TYPE kna1-land1,
      v_name1 TYPE kna1-name1,
      v_ort01 TYPE kna1-ort01.

*Native SQL statements are embbeded within EXEC SQL and ENDEXEC statements. Every database has its own native SQL statements.
*The below ones are HANA's. The fields need to be separated with a comma.
*INTO clause does not require the brackets, if I am mentioning all fields separately, but a colon (called "a binding operator)
*is required as a prefix for every field. The field I am comparing the data from the database table to also needs to be prefixed
*with a colon and there is no full stop at the end.
*Using native SQL is not recommended - if a database is changed, all SQL statements would need to be changed too. It's better
*to use OpenSQL instead.
EXEC SQL.
  SELECT kunnr, land1, name1, ort01
    FROM kna1
    INTO :v_kunnr, :v_land1, :v_name1, :v_ort01
    WHERE kunnr = :p_kunnr
ENDEXEC.

IF sy-subrc = 0.
  WRITE: / 'Customer number: ', p_kunnr, ' found.'.
  WRITE: / 'Customer number: ', v_kunnr,
         / 'Customer country: ', v_land1,
         / 'Customer name: ', v_name1,
         / 'Customer city: ', v_ort01.

ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*DATABASE DATA RETRIEVAL - MULTIPLE RECORDS. INTERNAL TABLE.
*---------------------------------------------------------------------------------------------------------------------------------

*If I am not selecting a single record by design, I might load multiple record. Thus, my target variable needs to be an internal
*table. All country keys defined within SAP are stored within 'T005' database table.
PARAMETERS p_land1 TYPE kna1-land1.

*It is recommended that the fields of the internal table are declared in the same sequence as they are within the database table
*as this will slightly improve the performance.
TYPES: BEGIN OF t_customer,
  kunnr TYPE kna1-kunnr,
  name1 TYPE kna1-name1,
  ort01 TYPE kna1-ort01,
END OF t_customer.

DATA: lt_customer TYPE STANDARD TABLE OF t_customer,
      wa_customer TYPE t_customer.

START-OF-SELECTION.
  PERFORM get_customers.

*&---------------------------------------------------------------------*
*&      Form  GET_CUSTOMERS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
*The sequence of fields should reflect the sequence of fields within the database table for the performance's improvement.
*I want to know the number of records retrieved. I can count the number of records within the internal table with the
*DESCRIBE statement which will count the number of records and store it in the system field 'sy-tfill'. I can also use
*another system variable - 'sy-dbcnt'. It will hold the number of records retrieved by my SELECT statement. I should use
*it immediately after the SELECT statement. So the difference is that 'sy-dbcnt' has to be used after the SELECT because
*the next one will change its value and the combination of DESCRIBE TABLE and sy-tfill allow me to refer to any table
*anywhere.
*By using the INTO TABLE I am making the retrieved data sit directly in the body of the table. This process omit the
*work area - the debugger shows that the work area remains empty while the internal table is filled.
*I am additionally SORTing the results before they are displayed with the SORT keyword. I could also sort them during
*the SELECT statement by using ORDER BY, but this approach is discouraged as it performs the sorting on the database
*level increasing the load on the database. It is better to get the desired data into the internal table and SORT it
*based on one of the internal table's fields.
*The WHERE clause could contain different conditions, e.g. using the keyword OR:
* - WHERE land1 = 'PL' OR land1 = 'DE' OR land1 = 'EN'...
*Or a range of values:
* - WHERE land1 IN ('PL', 'DE', 'EN')...
*The 'equal to' operator ('=') should be used when I am comparing to exactly one value. If I have a set, I should use
*the IN operator.
FORM get_customers.
  SELECT kunnr name1 ort01
    FROM kna1
    INTO TABLE lt_customer
    WHERE land1 = p_land1.
  IF sy-subrc = 0. "At least one record is retrieved.
*The first way of counting the number of records within a table:
    WRITE: / 'The number of records found using sy-dbcnt is: ', sy-dbcnt.
*The second way of counting the number of records within a table:
    DESCRIBE TABLE lt_customer.
    WRITE: / 'The number of records found using DESCRIBE TABLE and sy-tfill is: ', sy-tfill.
    SORT lt_customer BY name1.
    LOOP AT lt_customer INTO wa_customer.
      WRITE: / wa_customer-kunnr,
               wa_customer-name1,
               wa_customer-ort01.
    ENDLOOP.
  ELSE.
    MESSAGE 'No data was found for the provided country key.' TYPE 'I'.
  ENDIF.
ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*DATABASE DATA RETRIEVAL - CUSTOM F4 HELP. MODIF ID.
*---------------------------------------------------------------------------------------------------------------------------------

*I want a program to take the material number as input, complete with having F4 help associated and then, if the material was found,
*make the second block visible and fill all its input fields with data associated to the selected and found material number.
  SELECTION-SCREEN BEGIN OF BLOCK bk1 WITH FRAME TITLE t1.
*I want a single line. Without this "line block", the comment and the parameter would be in different lines. If the COMMENT is in the
*same line as a parameter - it assumes the place of the name 'p_matnr'. If they're in two different lines, I would still see 'p_matnr'
*next to the input box, but when the COMMENT is in the same line, 'p_matnr' is gone.
*By creating a parameter of the database table's field's type I am ensuring there will be F4 help by default. If the data element is associated
*with the search help at a database level - the same search help will be associated with my program's selection screen's variable. I can see
*within the database table itself if a field has help associated with it. To do this I should navigate to the details of a particular data
*element and check the Further Characteristics tab - 'matnr' for example has the value of 'S_MAT1' associated with it and mentioned in the
*help box.
*I can overwrite the automated F4 help mechanism by defining custom behaviour withint the AT SELECTION-SCREEN ON VALUE REQUEST FOR block.
*If I so much as define the event without anything afterwards - the default behaviour will already not function.
  SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT 6(15) lb1.
  PARAMETERS p_matnr TYPE mara-matnr MODIF ID id2.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN END OF BLOCK bk1.

  SELECTION-SCREEN SKIP 1.

*I want the entire block two invisible. It consists of 7 elements - the block itself, the three labels and the three input boxes.
*Thus, all these elements are supposed to have a common property. I can group these elements - with a MODIF ID. This is an addition
*that is used to group screen elements together. MODIF ID saves the name of the group (however I name it) within 'group1' field
*of the 'screen' internal table.
*This block is to become visible when the first parameter ('p_matnr') has been found and the pusbutton has been pressed. All the
*input fields of this block are to be filled with the data associated to the selected material number ('p_matnr').
  SELECTION-SCREEN BEGIN OF BLOCK bk2 WITH FRAME TITLE t2.

  SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT 6(15) lb2 MODIF ID id1.
  PARAMETERS p_mtart TYPE mara-mtart MODIF ID id1.
  SELECTION-SCREEN END OF LINE.

  SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT 6(15) lb3 MODIF ID id1.
  PARAMETERS p_mbrsh TYPE mara-mbrsh MODIF ID id1.
  SELECTION-SCREEN END OF LINE.

  SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT 6(15) lb4 MODIF ID id1.
  PARAMETERS p_matkl TYPE mara-matkl MODIF ID id1.
  SELECTION-SCREEN END OF LINE.

  SELECTION-SCREEN END OF BLOCK bk2.

  SELECTION-SCREEN SKIP 1.

  SELECTION-SCREEN PUSHBUTTON 1(20) b1 USER-COMMAND fc1.

*Data for the 'F4IF_INT_TABLE_VALUE_REQUEST' FM to create my custom list of values for the F4 help.
TYPES: BEGIN OF t_f4values,
  matnr TYPE mara-matnr,
  mtart TYPE mara-mtart,
END OF t_f4values.

DATA: lt_f4values TYPE STANDARD TABLE OF t_f4values,
      wa_f4values TYPE t_f4values.

INITIALIZATION.
  lb1 = 'Material number'.
  t1 = 'Input block'.
  lb2 = 'Material type'.
  lb3 = 'Industry sector'.
  lb4 = 'Material group'.
  t2 = 'Material data'.
  b1 = 'Get Material Data'.

*By default, I want the second block invisible.
  PERFORM make_bk2_inv.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_matnr.
*In order to have 'lt_f4values' filled with data.
  PERFORM get_f4_values.

*In order to establish a custom F4 help - with my custom values, I need to use a standard FM. 'F4IF_INT_TABLE_VALUE_REQUEST'
*is always used for that purpose.
*'retfield' - is the field I want "returned" which is the field for which the F4 help is supposed to be. It refers to the field
*within the created table of values. 'retfield' and 'lt_f4values' are the only obligatory elements of the FM, but just providing
*'retfield' will not suffice - the program will claim there are no results within the table (although they are there!).
*I also need to provide a few "optional" fields for the FM to function properly:
*- 'dynpprog' is the name of the program where the help is supposed to be used.
*- 'dynpnr' refers to the screen number. The selection screen's number is always 1000 though.
*- 'dynprofield' points to the screen's field which is to be populated with the found value. I want my input field to be filled,
*  so 'p_matnr' it is.
*Without the above, the value selected from the F4 Help list will not be moved to the input field when I double-click my chosen one.
*- 'value_org' refers to the way the data is transferred. 'S' means 'structure'. Without it, the program will believe there are
*no values found.
  IF lt_f4values IS NOT INITIAL.
    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
      EXPORTING
        retfield               = 'MATNR'
        dynpprog               = sy-repid
        dynpnr                 = sy-dynnr
        dynprofield            = 'P_MATNR'
        value_org              = 'S'
      TABLES
        value_tab              = lt_f4values
     EXCEPTIONS
       PARAMETER_ERROR        = 1
       NO_VALUES_FOUND        = 2
       OTHERS                 = 3.
    IF sy-subrc <> 0.
*   Implement suitable error handling here
    ENDIF.
  ENDIF.

*AT SELECTION-SCREEN event is triggered e.g. when a pushbutton in the selection screen is pushed. I have a USER-COMMAND 'fc1'
*associated with the button, so 'sy-ucomm' will catch that name.
*If the material number has been found - the input fields of the second block are to filled with data associated with the
*material number. If the material is not found, the input fields of the second block are being cleared just in case a material
*number has been found previously and these fields still hold values. Thanks to the CLEAR - there will be no misconception here.
AT SELECTION-SCREEN.
  CASE sy-ucomm.
    WHEN 'FC1'.
      IF p_matnr IS NOT INITIAL.
        SELECT SINGLE mtart mbrsh matkl
          INTO (p_mtart, p_mbrsh, p_matkl)
          FROM mara
          WHERE matnr = p_matnr.
          IF sy-subrc = 0.
            MESSAGE 'Material found!' TYPE 'I'.
          ELSE.
            MESSAGE 'Material not found!' TYPE 'I'.
            CLEAR: p_mtart,
                   p_mbrsh,
                   p_matkl.
          ENDIF.
      ENDIF.
  ENDCASE.

START-OF-SELECTION.
  WRITE: / 'You entered ', p_matnr.

*&---------------------------------------------------------------------*
*&      Form  MAKE_BK2_INV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM make_bk2_inv.
*During the execution of every program, SAP internally creates an internal table - 'screen'. I can iterate through it and update it
*in order to control the appearance of the screen. The value of 'group1' field is saved in capital letters - it has to be 'ID1'
*because 'id1' will not work.
*'screen-invisible = 1' will make labels and comments invisible, but input fields will still be there. 'screen-invisible = 1' is sufficient
*for checkboxes, blocks and radiobuttons too, but not for input fields, so until they are made invisible too - a block will still be visible.
*It would be invisible, but a few of its elements are still visible, so it can't be invisible itself.
*To make input fields invisible to, I need to set 'screen-input' to '0'.
*Without it - input fields will not be invisible and will just come in the encrypted format (input will be stars).
*When AT SELECTION-SCREEN event is triggerd all the elements become visible automatically again. The idea is to initially make blocks invisible
*in the INITIALIZATION and then any modifications perform in the AT SELECTION-SCREEN OUTPUT making sure every time that screen elements that are
*to remain invisible receive the confirmation they are to remain invisible, e.g. IF...screen-invisible = '1'. ELSEIF...screen-invisible = '0'.
  LOOP AT SCREEN.
    IF screen-group1 = 'ID1'.
      screen-invisible = '1'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  GET_F4_VALUES
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
*I want just two fields to be available in my custom F4 help. I also only want limited data (WHERE clause). The selection of the help
*is to be limited, because it's a functionality that's supposed to provide the user with values they can choose from. And the set
*of values I want them to be able to choose from is limited.
*I want the F4 help to show me two columns - 'matnr' and 'mtart'.
FORM get_f4_values .
  SELECT matnr mtart
    FROM mara
    INTO TABLE lt_f4values
    WHERE mtart IN ('WGOT', 'SPOM').
ENDFORM.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*SELECT STATEMENTS. INNER JOIN, LEFT OUTER JOIN.
*---------------------------------------------------------------------------------------------------------------------------------

*Joins are used for retrieving the data from two or more tables using a single select query. In order to use joins to connect multiple
*tables, there should be at least one field shared by the tables being joined and that field should be compared between these tables
*during the select query.
*1. INNER JOIN.
*Whenever an inner join is used in the select query - each row of the left hand side table is compared with all the rows of the right
*hand side table.
*E.g.
*          TABLE A                       TABLE B
*         A  B  C  D                    E  F  G  H
*         a1 b1 c1 d1                   e1 f1 g1 h1
*         a2 b2 c2 d2                   e2 f2 g2 h2
*         a3 b3 c3 d3                   d2 f3 g3 h3
*         a4 b4 c4 d4                   d3 f4 g4 h4
*
*          TABLE A INNER JOIN TABLE B ON A~D = B~E
*
*                       RESULT TABLE
*                  A  B  C  D  E  F  G  H
*                  a2 b2 c2 d2 d2 f3 g3 h3
*                  a3 b3 c3 d3 d3 f4 g4 h4
*
*Only two rows are joined in the above query because A~D = B~E only in two cases (d2 and d3). Inner join discards the rows of both
*tables if they do not have a match between them.

*I want to get the customer data (KNA1) and the sales orders header data (VBAK) based on the provided customer range for every
*customer with a single select query.
DATA: v_kunnr TYPE kna1-kunnr.
SELECT-OPTIONS: sl_kunnr FOR v_kunnr DEFAULT '1000' TO '1010'.

TYPES: BEGIN OF ty_customer_sales,
  kunnr TYPE kna1-kunnr,
  ort01 TYPE kna1-ort01,
  vbeln TYPE vbak-vbeln,
  erdat TYPE vbak-erdat,
  erzet TYPE vbak-erzet,
END OF ty_customer_sales.
DATA: gt_customer_sales TYPE STANDARD TABLE OF ty_customer_sales,
      gwa_customer_sales TYPE ty_customer_sales.

START-OF-SELECTION.
*Every field that is present in both tables needs to be prefixed with the name of the table from which it's supposed to be
*retrieved from. 'ort01' and 'erzet' do not require specifying their table of origin because each of them is present only
*in one of the tables that are part of the select query. All other fields are present within both tables and must thus be
*prefixed with the appropriate table's name.
  SELECT k~kunnr ort01 vbeln v~erdat erzet
    FROM kna1 AS k INNER JOIN vbak AS v
      ON k~kunnr = v~kunnr
        INTO TABLE gt_customer_sales
          WHERE k~kunnr IN sl_kunnr.
  IF gt_customer_sales IS NOT INITIAL.
    FORMAT COLOR 3.
    DESCRIBE TABLE gt_customer_sales. "Saves the number of records in 'sy-tfill'.
    WRITE: / 'Total records: ', sy-tfill.
    FORMAT COLOR OFF.
    SORT gt_customer_sales BY kunnr.
*AT NEW should print the values mentioned within only once, whenever they are changed, but it works only for the value mentioned
*directly after AT NEW (so - kunnr). That means this will not work for 'ort01' - it will be replaced by a line of stars.
*In order to achieve this, I need to declare a variable for every variable other than specified with the AT NEW that I want
*treated in the same way. This variable should assume the value of the field I want displayed within AT NEW and be used instead
*of it. This is the case because, when inside AT NEW, all other fields in the work area but the one specified are replaced with stars.
*The field specified with the AT NEW event should be the first field of the internal table, otherwise the event will be triggered
*for every field of the table.
*In this particular case, it wouldn't happen because the select query above joins the tables based on 'kunnr'. Somehow this would
*prevent the neccessity of having to have 'kunnr' as the first field of the internal table in order to have AT NEW event work correctly
*with it.
    DATA: lv_ort01 TYPE kna1-ort01. "For the AT NEW event.
*The other way to achieve the same result is to use ON CHANGE OF event. It's triggered whenever a new value appears in the specified
*field ('kunnr' here). The advantage of ON CHANGE OF is thus it does not suppress the values in other fields than the one specified
*alongside the event like AT NEW does. ON CHANGE OF event can also be used in any of the looping statements (LOOP-ENDLOOP, WHILE-ENDWHILE,
*DO-ENDDO, SELECT-ENDSELECT) and AT NEW event can be used only inside LOOP-ENDLOOP.
    LOOP AT gt_customer_sales INTO gwa_customer_sales.
*      CLEAR lv_ort01.
*      lv_ort01 = gwa_customer_sales-ort01.
*      AT NEW kunnr.
*        FORMAT COLOR 1.
*        WRITE: / 'Customer number: ', gwa_customer_sales-kunnr,
*                 'Customer city: ', lv_ort01.
*        FORMAT COLOR OFF.
*      ENDAT.
      ON CHANGE OF gwa_customer_sales-kunnr.
        FORMAT COLOR 1.
        WRITE: / gwa_customer_sales-kunnr,
                 gwa_customer_sales-ort01.
        FORMAT COLOR OFF.
      ENDON.
      FORMAT COLOR 2.
        WRITE: / gwa_customer_sales-vbeln,
                 gwa_customer_sales-erdat,
                 gwa_customer_sales-erzet.
      FORMAT COLOR OFF.
    ENDLOOP.
  ELSE.
    MESSAGE 'No data has been retrieved.' TYPE 'I'.
  ENDIF.

*2. LEFT OUTER JOIN.
*While inner join discards the rows from both tables if no match for them has been found, left outer join retains all the rows from
*the left hand table even if they don't have a matching row in the right hand table and all the right hand side table's columns are
*filled with default values (e.g. numeric data types to 0 and character data types to blanks).
*E.g.
*          TABLE A                       TABLE B
*         A  B  C  D                    E  F  G  H
*         a1 b1 c1 d1                   e1 f1 g1 h1
*         a2 b2 c2 d2                   e2 f2 g2 h2
*         a3 b3 c3 d3                   d2 f3 g3 h3
*         a4 b4 c4 d4                   d3 f4 g4 h4
*
*        TABLE A LEFT OUTER JOIN TABLE B ON A~D = B~E
*
*                       RESULT TABLE
*                  A  B  C  D  E  F  G  H
*                  a1 b1 c1 d1
*                  a2 b2 c2 d2 d2 f3 g3 h3
*                  a3 b3 c3 d3 d3 f4 g4 h4
*                  a4 b4 c4 d4

*For an example, change the INNER JOIN to LEFT OUTER JOIN in the select query there.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------