*---------------------------------------------------------------------------------------------------------------------------------
*RECORDING A PROGRAM WITH A LOCAL TEXT FILE.
*---------------------------------------------------------------------------------------------------------------------------------

*Generally whenever I want to do the data migration, I am not writing the program but recording it. First I need to understand the
*data that is going to be migrated - the format of the file, how many fields per record there are, what's the separator. When the
*program is generated after the recording, I will need to modify it manually.
*To record a transaction, I need to understand the entire process of the migration and perform it for a single record using sample
*data. That is because that's how recording takes place - I do the process manually once and SAP remembers how it's done.
*My exemplary file contains the fields MATNR, MBRSH, MTART and MEINS that belong to the table MARA and MAKTX from MAKT. Thus I see
*I need to create a material. I have the MM01 transaction that is used for creating the materials. If I have analysed the legacy
*data and realized there's no relevant SAP transaction, I need to create that transaction.

*In order to start recording I need to go to the SHDB transaction. Here I should hit the 'New recording' button. This is the first
*screen. Here I need to provide the name to the recording and the transaction code I want recorded. In my case it's MM01 because I
*want to create a new material. Then I need to press the 'Start recording' button. This will take me to the initial screen of the
*transaction I am recording.
*Here I need to provide all the necessary parameters, a sample record. I am providing the 'Material' (a name, e.g. ZBMTESTMAT, the
*'Industry sector' (e.g. Chemical Industry) and the 'Material Type' (e.g. FERT-Finished Product). Then I should press Enter.

*Upon hitting Enter I am transported to a second screen - a pop-up window appears. Within here I choose the 'Basic data 1' option.
*Now the third screen appears in which I am providing a description and filling the 'Base Unit of Measure' field with the value of
*'KG'. Now I save the progress. I should get the message that the recording is complete and SAP should display the recorded details
*mapped to the fields of a BDCDATA structure. The columns I see here are the BDCDATA columns.
*In the second row I should see a record - it indicates the first screen I visited. The program's name should be 'SAPLMGMM' and the
*screen number should be '0060'. Since it is a new screen the DYNBEGIN field of BDCDATA (the column's header is called 'Start ID'
*here) assumes the value of 'X'. Whenever a new screen starts the DYNBEGIN field ('Start ID here) is set to have the value of 'X'.
*Within this recorded details' screen I need to make note of the field names for which I entered the sample data. In the 'Field name'
*column I can see e.g. the RMMG1-MATNR field with ZBMTESTMAT in the column next right next to it. This is the name of the field where
*I put my material's name. Underneath there's the RMMG1-MBRSH field and RMMG1-MTART field corresponding to the provided 'Industry
*sector' and 'Material Type' respectively.
*I need to remember the names of these fields because I will need them if I want to be able to implement any changes.
*Then I can see (preferably in the 8th row) that a new screen has begun ('0070'). In the second screen I didn't provide any data.
*I only selected one of the available options - the first one, which is indicated by the '(01)' part of the MSICHTAUSW-KZSEL (01)
*value of the 'Field name' column.
*In the third screen ('4004') I provided the description and the base unit of measure. That's MAKT-MAKTX and MARA-MEINS respectively.

*I should move back now (F3) and my recording should be available. The column 'Transact.' indicates how many transactions have
*been recorded and the 'Screens' one how many screens. I need to select my recording and press the 'Program' button in the Application
*Toolbar. I will be prompted to provide the name for my new program. In my case it's 'ZBM_RECORDED_BDC_MM01_TEST'. The 'Field contents'
*should be left as the defauly 'Read from file'. When I proceed, I will be asked to provide a short description of the program. Its
*type is 'Executable program'. To commence forth, I should select the 'Source code' button.
*Doing the above will generate the program for me based on the previously created recording. I need to modify it to properly read the
*data from the legacy system.

*I need to read the file with the data before the START-OF-SELECTION event. The file in my case is stored locally and the separator
*is a comma. Because it is a comma, I will require two internal tables to process the data correctly. If it was a tab, one internal
*table would suffice. 
*The first table will contain just one field - every record will become one string within the table and I will
*split the data later on while moving it into the second table.
*The second table's fields are the same fields five that SAP recorded for me.
TYPES: BEGIN OF t_legacy,
  string TYPE string,
END OF t_legacy.
DATA: lt_legacy  TYPE TABLE OF t_legacy,
      lwa_legacy TYPE t_legacy.

TYPES: BEGIN OF t_final,
  matnr TYPE rmmg1-matnr,
  mbrsh TYPE rmmg1-mbrsh,
  mtart TYPE rmmg1-mtart,
  maktx TYPE makt-maktx,
  meins TYPE mara-meins,
END OF t_final.
DATA: lt_final  TYPE TABLE OF t_final,
      lwa_final TYPE t_final.
	  
*I need to decide which of the code generated by SAP is necessary and which isn't. Right after the START-OF-SELECTION begins, SAP now
*calls the subroutine 'open_dataset' which is a standard SAP subroutine which I can only display. As the name possibly might suggest
*the OPEN DATASET statement is used there. The FOR INPUT variant. This statement should be used when the file I will be migrating the
*data from is stored in an application server. In my case it is stored locally so I can safely lob that subroutine out the window or
*comment it out.
*In order to read the data from a local file, the 'GUI_UPLOAD' function module is to be used. I use it to move the data from the legacy
*file into the initial internal table.
*The 'filename' field is the path to the file. The 'data_tab' field is the internal table into which the data will be read.
*If there indeed is data within the 'lt_legacy' internal table, I need to transfer it to the 'lt_final' internal table that will hold
*the data properly divided into fields. To achieve this, I need to SPLIT what's in 'lt_legacy' as every record there is a line. The order
*of the fields mentioned at the end of the SPLIT statement matters. At every occurence of a comma what came before it is put into the
*next mentioned field.
CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename                      = 'd:\MATERIAL.txt'
  TABLES
    data_tab                      = lt_legacy.
IF lt_legacy IS NOT INITIAL.
  LOOP AT lt_legacy INTO lwa_legacy.
    CLEAR lwa_final.
    SPLIT lwa_legacy-string AT ',' INTO lwa_final-matnr
                                        lwa_final-mbrsh
                                        lwa_final-mtart
                                        lwa_final-maktx
                                        lwa_final-meins.
    APPEND lwa_final TO lt_final.
  ENDLOOP.
ENDIF.

*Now what needs to happen is the mapping of the data from 'lt_final' to the BDCDATA structure. SAP has already generated this part, but
*I need to make sure it's done correctly. The 'open_group' subroutine creates a session object in case of the Session Technique being
*deployed. I am not commenting it out as it is relevant for what I am doing.
*The generated program is using the DO loop, but I am trading it for LOOP loop. The generated program has also created the 'READ DATASET
*dataset INTO record.' statement which I will not require as it is used to read the data from an application server and mine is stored
*locally.
*Within the loop I need to map the program's information as well as the individual fields' information to the BDCDATA structure. SAP
*has generated a few subroutines for that. The 'bdc_dynpro' one maps the program data and does it just right so I am leaving that one
*where it is. The generated 'bdc_data' subroutine maps the fields' information to the BDCDATA structure. Right now the fields passed
*into the subroutines are a part of the 'record' structure  so I am changing their origin into my work area that the data is being looped
*into. The first and second callings of the 'bdc_field' subroutine are automatically generated and I shouldn't concern myself with them.
*The occurences of the 'bdc_field' subroutine that map my fields mention the fields' names as provided by SAP after I recorded the
*process - hence the combination of weird 'RMMG1' first and simple 'MAKT' and 'MARA' later on. They are a bit scattered around so I
*need to locate them amongst all other occurences of the calling of the subroutine performed by SAP itself. The 'bdc_transaction'
*subroutine was generated by SAP and decides what kind of the migration technique will be used - be it the Session or the Call Transaction
*one. If it's Session, the 'BDC_INSERT' function module is called. If it's Call Transaction - the statement "CALL TRANSACTION TCODE USING
*BDCDATA" takes place. The occurence of 'bdc_field' subroutine with the parameters "'MSICHTAUSW-KZSEL(01)' 'x'" has also been changed.
*The second parameter used to be "record-KZSEL_01_004". The 'X' it has been traded for is an indication for SAP that, when leaving
*the first screen of the transaction and arriving at the next, the first option (indicated by the string - the first parameter) should
*be checked. It's the 'Basic Data 1' option from the second screen.
*The mapping of the data looks as below:
LOOP AT lt_final INTO lwa_final.
  PERFORM bdc_data        USING 'SAPLMGMM' '0060'.
  PERFORM bdc_field       USING 'BDC_CURSOR' 'RMMG1-MTART'.
  PERFORM bdc_field       USING 'BDC_OK_CODE' '=ENTR'.
  PERFORM bdc_field       USING 'RMMG1-MATNR' lwa_final-matnr. "<---changed here
  PERFORM bdc_field       USING 'RMMG1-MBRSH' lwa_final-mbrsh. "<---changed here
  PERFORM bdc_field       USING 'RMMG1-MTART' lwa_final-mtart. "<---changed here
  PERFORM bdc_dynpro      USING 'SAPLMGMM' '0070'.
  PERFORM bdc_field       USING 'BDC_CURSOR' 'MSICHTAUSW-DYTXT(01)'.
  PERFORM bdc_field       USING 'BDC_OKCODE' '=ENTR'.
  PERFORM bdc_field       USING 'MSICHTAUSW-KZSEL(01)' 'x'.    "<---changed here.
  PERFORM bdc_dynpro      USING 'SAPLMGMM' '4004'.
  PERFORM bdc_field       USING 'BDC_OKCODE' '=BU'.
  PERFORM bdc_field       USING 'MAKT-MAKTX'  lwa_final-maktx. "<---changed here
  PERFORM bdc_field       USING 'BDC_CURSOR' 'MARA-MEINS'.
  PERFORM bdc_field       USING 'MARA-MEINS'  lwa_final-meins. "<---changed here
  PERFORM bdc_field       USING 'MARA-MTPOS_MARA' record-MTPOD_MARA_007.
  PERFORM bdc_transaction USING 'MM01'.
ENDLOOP.

*After the mapping is done, SAP calls the 'close_group' subroutine. If the Session Technique has been deployed, it closes the Session
*Object. Afterwards the 'close_dataset' subroutine comes which I can comment out, because I was opening no dataset previously.

*To sum things up I added the logic for reading the data from a local file (to replace the generated OPEN DATASET), I replaced the
*generated parameters (structure 'record') passed into those occurences of the 'bdc_field' that correspond to the fields I am interested 
*in with the fields of my own work area ('lwa_final') and I commented out a few unnecessary lines like "OPEN DATASET" or "CLOSE_DATASET".

*When I execute the program ('F8' while still in SE38) I will see the auto-generated screen. Here I can choose whether I want to utilize
*the Session Technique or the Call Transaction Technique.
*Say I choose the Session Technique. I should select the 'Generate session' radiobutton and provide the 'Session name' ('S60' in my case).
*If I check the 'Keep session' checkbox - even after the processing of the Session Object it will still be available for further analisys.
*Thus it is recommended to always have it checked. I can also elect to give the Session Object a lock by providing the 'Lock date'. When
*I execute the transaction now, the Session Object should be created. In order to process a Session Object, I need to go to the SM35
*transaction. Here I should see my Session Object - 'S60'. The column 'Transaction' shows how many records are available in the Session
*Object. Upon choosing my Session Object and hitting the 'Process' button, I will be asked whether I want to process the Session Object
*in foreground or background.
*If I chose the foreground processing - I will be taken on a ride through the process. I will need to select the green tick in the
*pop-up window or press Enter whenever promted to.
*If I choose the background processing - it will just all happen in the background.

*If I want to analyse the process that the Session Object carried out I can select it and click the 'Log' button in the Application
*Toolbar. I should choose the log in the 'Log Overview' tab and click the 'Analyse session' button in the Application Toolbar.
*Here, in the left hand side of the screen I should be able to see the status for every record processed - it's here that I can see
*if something went wrong - it will be indicated by the 'Incorrect' status. If I select the 'Log created on(...)' button, I can see
*all the operations with timestamps. Every operation is described, e.g. if something went wrong with a record it might be informing me
*here that "The material type does not exist". This is the problem that was encountered by SAP with this particular record during
*the process of the migration.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------