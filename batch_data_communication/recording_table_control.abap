*---------------------------------------------------------------------------------------------------------------------------------
*BDC - RECORDING A PROGRAM WITH TABLE CONTROL.
*---------------------------------------------------------------------------------------------------------------------------------

*I want to record the XK01 transaction which is used to create new vendors. During the process I will be asked to provide the bank
*details - the screen will display a table control.
*I go to SHDB and select the 'New recording' button in the Application Toolbar. I provide the name of the recording - in my case
*it's 'R2' and the transaction code of 'XK01'. Then I press the 'Start recording' button. Now I need to walk through the process
*of creating a vendor so that SAP might record my actions. I ought to provide the 'Vendor' (e.g. '666') and the 'Account group'
*(e.g. '0001') and press Enter. I am transported to the next screen where I provide the 'Name' (e.g. 'Lilith'), the 'Search term'
*(e.g. 'Lil') and the 'Country' which actually is a country key, not just country (e.g. 'UA'). After pressing Enter here, I am
*taken to the next screen which contains a Table Control component. Here I provide the 'Ctry' (e.g. 'UA'), the 'Bank Key'
*(e.g. 'DOG') and the 'Bank Account' (e.g. '666666666'). Upon saving the progress the recording is complete and the transaction
*"is transferred" (according to the SAP's message). I am transported to the screen with the details of the recording mapped to
*the BDCDATA structure's components.
*I should remember the fields for which I provided the input during the recording. In the screen '0100' (indicated in the second
*row in the column 'Screen'), I provided the values '666' in the 'Vendor' field. That is the 'RF02K-LIFNR' field in the details.
*I also provided the '0001' value to the 'Account group' field which here translates to 'RF02K-KTOKK'.
*In the '0110' screen I provided 'Lilith' ('Name'), 'Lil' ('Search term') and 'UA' ('Country'). These three translate to 'LFA1-NAME1',
*'LFA1-SORTL' and 'LFA1-LAND1' respectively.
*In the screen '0120' I did not provide any input.
*In the screen '0130' I can see the three fields I provided data for. These are 'LFBK-BANKS(01)', 'LFBK-BANKL(01)' and 'LFBK-BANKN(01)'
*with the values of 'UA', 'DOG' and '666666666' respectively. The '(01)' part all the fields' names are suffixed with means the row
*number. These fields are all the fields of the Table Control and the suffixed number indicates the row. If I added more rows with
*data, I would have three more fields here with the same names but suffixed with '(02)' instead.
*Now I should save the progress and go back ('F3'). Here I select my recording ('R2') and click the 'Program' button in the
*Application Toolbar. The program itself will be generated and I can start modifying it.

*Before the START-OF-SELECTION event, I should declare the structures I require. I need two "final" internal tables, because the
*legacy data is going to be distributed between LFA1 and LFBK database tables. Each one of them needs its own structures here, because
*I will be loading the data from these structures to the database tables. LFA1 will be receiving NAME1, SORTL and LAND1 while LFBK
*will be receiving BANKS, BANKL, BANKN (multiple of those if the Table Control received multiple records!). Apart from these, I also
*provided input for the 'Vendor' and the 'Account group' fields both of which can go into LFA1 while LFBK can be connected just by
*'Vendor' (since I am providing a bank account's details of a particular Vendor to the LFBK).
*The 'lv_rowid' variable will be pointing at a record of the table control since there can be many of them. It is of the length of
*two and of an alphanumeric type because I want them in the same format as SAP which is e.g. 'LFBK-BANKS(01)' for the first record
*in the Table Control. The default value of the 'lv_rowid' variable is '00'. If I incremented it by 1, it becomes '01'. This
*variable cannot be a simple integer because I cannot specify the length of an integer - I could not achieve the '00' or '01' values.
*A default value of 'lv_rowid(2) TYPE i' would be just '0'.
*The record of my file with the legacy data start with a three-digit identifier. They inform me whether the row is the master data
*or bank data. The variable 'lv_id' will store that identifier.
TYPES: BEGIN OF t_legacy,
  string TYPE string,
END OF t_legacy.
DATA: lt_legacy  TYPE TABLE OF t_legacy,
      lwa_legacy TYPE t_legacy.

TYPES: BEGIN OF t_lfa1,
  lifnr TYPE rf02k-lifnr,
  ktokk TYPE rf02k-ktokk,
  name1 TYPE lfa1-name1,
  sortl TYPE lfa1-sortl,
  land1 TYPE lfa1-land1,
END OF t_lfa1.
DATA: lt_lfa1  TYPE TABLE OF t_lfa1,
      lwa_lfa1 TYPE t_lfa1.

TYPES: BEGIN OF t_lfbk,
  lifnr TYPE rf02k-lifnr,
  banks TYPE lfbk-banks,
  bankl TYPE lfbk-bankl,
  bankn TYPE lfbk-bankn,
END OF t_lfbk.
DATA: lt_lfbk  TYPE TABLE OF t_lfbk,
      lwa_lfbk TYPE t_lfbk.

DATA: lv_rowid(2) TYPE n,
      lv_id(3)    TYPE c.
	  
*Just after the START-OF-SELECTION event, SAP has automatically generated the 'open_dataset' subroutine. It is used to load the
*files from an application server, so I am not going to need it as my file is stored locally. I comment out that subroutine and
*instead use the 'GUI_UPLOAD' function module. I provide the path to my file and the internal table into which the data should
*be loaded.
CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename                      = 'd:\vendor.txt'
  TABLES
    data_tab                      = lt_legacy.
	
*If there indeed is data within 'lt_legacy', I need to transfer the data from it to the other two internal tables - the final
*ones. I need to differentiate which records should go to the vendor table and which to the bank table. This will be done by
*checking the identifier every line within the file starts with. Every record within 'lt_legacy' is just a single string, but
*I know that the identifier is always at the starts of the lines. So I can essentially take a substring out of the string and
*see what the identifier is. Based on that, I can decide into which final internal table the line that is being processed
*should go. It works by reading the string from the position specified by '+0' where 0 can be replaced with any number that
*indicates the index I want to start reading and '(3)' where 3 can be replaced by the length of the string I want read.
*Since all the records moved from the legacy file into the 'lt_legacy' internal table are stored as a single string, I need
*to split those strings into specific fields within the final internal table after deciding which one of the two final internal
*tables the particular record should go to. The splitting is done at commas as such is the structure of the records within
*the legacy file - every record has its components separated by commas.
IF lt_legacy IS NOT INITIAL.
  LOOP AT lt_legacy INTO lwa_legacy.
    CLEAR lv_id.
    lv_id = lwa_legacy-string+0(3).
    IF lv_id = 'VEN'.
      SPLIT lwa_legacy-string AT ',' INTO lwa_lfa1-lifnr
                                          lwa_lfa1-ktokk
                                          lwa_lfa1-name1
                                          lwa_lfa1-sortl
                                          lwa_lfa1-land1.
      APPEND lwa_lfa1 TO lt_lfa1.
    ELSEIF lv_id = 'BNK'.
      SPLIT lwa_legacy-string AT ',' INTO lwa_lfbk-lifnr
                                          lwa_lfbk-banks
                                          lwa_lfbk-bankl
                                          lwa_lfbk-bankn.
      APPEND lwa_lfbk TO lt_lfbk.
    ENDIF.
  ENDLOOP.
ENDIF.

*Below the above I should see the 'open_group' subroutine which is responsible for the creation of a Session Object. I am
*leaving this subroutine within my code. Below that there's a DO loop, a READ DATASET statement and a status check - all three
*I am commenting out as they are not necessary. READ DATASET would be used if I used OPEN DATASET which I am not doing because
*my file with the legacy data is stored locally.
*Below is the code I am either changing, leaving as it is or adding to.
*Out of the two the 'lt_lfa1' internal table is the main one. This is due to the relation between LFA1 and LFBK. Each vendor
*(LFA1) can contain multiple bank records in LFBK. Thus, all the operations, including the mapping of the fields of 'lt_lfbk'
*needs to happen for every record of 'lt_lfa1'.
LOOP AT lt_lfa1 INTO lwa_lfa1.
  PERFORM bdc_dynpro USING 'SAPMF02K' '0100'.
  PERFORM bdc_field  USING 'BDC_CURSOR' 'RF02K-KTOKK'.
  PERFORM bdc_field  USING 'BDC_OKCODE' '/00'.
  PERFORM bdc_field  USING 'RF02K-LIFNR' lwa_lfa1-lifnr. "<---changed here
  PERFORM bdc_field  USING 'RF02K-KTOKK' lwa_lfa1-ktokk. "<---changed here
  PERFORM bdc_dynpro USING 'SAPMF02K' '0110'.
  PERFORM bdc_field  USING 'BDC_CURSOR' 'LFA1-LAND1'.
  PERFORM bdc_field  USING 'BDC_OKCODE' '/00'.
  PERFORM bdc_field  USING 'LFA1-NAME1' lwa_lfa1-name1. "<---changed here
  PERFORM bdc_field  USING 'LFA1-SORTL' lwa_lfa1-sortl. "<---changed here
  PERFORM bdc_field  USING 'LFA1-LAND1' lwa_lfa1-land1. "<---changed here
  PERFORM bdc_dynpro USING 'SAPMF02K' '0120'.
  PERFORM bdc_field  USING 'BDC_CURSOR' 'LFA1-KUNNR'.
  PERFORM bdc_field  USING 'BDC_OKCODE' '/00'.
  PERFORM bdc_dynpro USING 'SAPMF02K' '0130'.
  PERFORM bdc_field  USING 'BDC_CURSOR' 'LFBK-BANKN(01)'.
  PERFORM bdc_field  USING 'BDC_OKCODE' '=UPDA'.
*Now, for each vendor I need to map all of their bank records in 'lt_lfbk'. Up until now I wasn't changing the names of the
*fields, but in the case of 'lt_lfbk' this will be necessary, because - as every record within 'lf_lfa1' can have multiple
*records related to it within 'lt_lfbk' - the name of the field changes - the value within the brackets is incremented with
*every next record. E.g. the first one is 'LFBK-BANKS(01)' and the second will be 'LFBK-BANKS(02)'. Thus, I need to change
*the name of the field dynamically as many times as there are records within 'lt_lfbk' related to the particular vendor
*within 'lt_lfa1'. To make it happen I will deploy the indomitable might of the 'lv_rowid' variable. It is of the value of
*'00' to begin with. Hence I increment it at the beginning of the loop below and thus its value will match that of the first
*record's name's part enclosed within the brackets. With every iteration of the loop, the value of 'lv_rowid' will be
*incremented and match the incremnted bracketed value of the currently processed record's name. Of course, I will need to
*construct the field's name myself.
  LOOP AT lt_lfbk INTO lwa_lfbk WHERE lifnr = lwa_lfa1-lifnr.
    lv_rowid = lv_rowid + 1.
    CLEAR lv_fname.
    CONCATENATE 'LFBK-BANKS(' lv_rowid ')' INTO lv_fname.
    PERFORM bdc_field USING lv_fname lwa_lfbk-banks.
    CLEAR lv_fname.
    CONCATENATE 'LFBK-BANKL(' lv_rowid ')' INTO lv_fname.
    PERFORM bdc_field USING lv_fname lwa_lfbk-bankl.
    CLEAR lv_fname.
    CONCATENATE 'LFBK-BANKN(' lv_rowid ')' INTO lv_fname.
    PERFORM bdc_field USING lv_fname lwa_lfbk-bankn.    
  ENDLOOP.
  PERFORM bdc_transaction USING 'XK01'.
*Below should be the ENDDO statement which I am commenting out and replacing with the ENDLOOP.
ENDLOOP.

*WARNING - there is a chance that the above code will throw an exception saying "Invalid access to a string (offset too
*large)". In this case SAP has a problem with the attempt to cut a substring out of a string while trying to check the
*three-digit identifier within the 'lt_legacy' internal table. This problem can be solved by modifying the structure of
*my legacy table - change the 'string' variable from the type string to a type C and set the length of the field to, e.g.
*100. So "string(100) TYPE c" instead of "string TYPE string".

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------