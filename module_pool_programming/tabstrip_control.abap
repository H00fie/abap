*---------------------------------------------------------------------------------------------------------------------------------
*VALIDATIONS.
*---------------------------------------------------------------------------------------------------------------------------------

*There are three ways a Module Pool transaction (program?) can be validated:
*1. Automatic field validation.
*2. Flow logic validation.
*3. Module pool validation.
*Every transaction I design has to be validated before any data is processed.

*AUTOMATIC FIELD VALIDATION
***************************
*I am now creating an MP program named 'Z_BM_TEST_MPP4'. I create a new screen for it (100) and move to the layout access the Screen Painter
*tool. I choose GoTo -> Secondary Window -> Dictionary/Program field and provide the 'KNA1' table from which I take KUNNR, LAND1 and ERDAT.
*After having placed the chosen fields in the layout of my screen I choose the Box option from the tool panel on the left hand side and
*draw the box around my previously placed fields. I double click the box, set the Name to 'BX1' and the text to 'Automatic_field_validations'.
*The underscores are added automatically when I press Space. Then I choose the Pushbutton option from the panel on the left and draw a
*button for exiting my application. I double click it, set the Name to 'B1', text 'Exit' and the Function Code to 'FC1'.
*Now I write the logic for my Exit button. Whenever a Module Pool button is clicked, the PAI event is triggered - so it's here that the
*mentioned logic needs to be placed. I go to my screen 100, the Flow Logic tab, uncomment the 'MODULE_USER_COMMAND_0100' in PAI and
*double click it. I place it within the TOP INCLUDE.
*The module looks like that so far:
********************************************************************
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
  	WHEN 'FC1'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
********************************************************************

*Now I create the transaction for my program. The transaction's name is 'ZBMI6', the 'Start object', as always is the case with MP programs,
*is 'Program and dynpro (dialog transaction)' and the 'GUI support' is 'SAP GUI for Windows' which is also a standard. I would also like to
*make the 'Customer' screen field an obligatory one so I go to the Screen Painter tool, double-click the field and in the 'Attributes' section,
*in the 'Program' tab, nex to 'Input' I select the 'required' option.
*If I now push my 'Exit' button after having executed my program, I will get an error message - a validation message. It is a standard message
*provided by SAP. It is thus validation stemming from a property being set at a screen's level. It is the Automatic Field Validation.
*If I provided my 'Country' screen field with a country key that does not exist and tried to exit my program, I would get a message telling me
*that this country code does not exist in T005. This is also the Automatic Field Validation. SAP is looking for the value within a database
*table - this is maintained at the database level. 
*If I provided a wrong date, e.g. 19/26/2018, I would get the 'Invalid date' validation message. This is, yet again, the Automatic Field Validation.
*The Automatic Field Validations are triggered thus either due to certain properties being set at the screen level or properties of the field
*maintained at the database level. If these validations do not pass, I cannot exit the transaction.

*If I want to be able to exit the transaction if the the Automatic Field Validations do not pass - there is a way to do it. I go to the layout
*of my screen (the Screen Painter tool) and draw a second button. Its 'Name' is 'B2' and its 'Text' is 'Cancel'. The 'FctCode' is 'FC2' and I
*additionally set the 'FctType' to 'E Exit command'. This is a property that I need to set if I want my button to be able to take me out of
*the transaction even if the Automatic Field Validations did not pass.
*Apart from doing that I also need to define a dedicated 'AT EXIT COMMAND' module if I want my button to work correctly. Whenever a button is
*clicked, the PAI event is triggered and so its there that said module needs to be placed.
*My screen 100 so far looks like this:
********************************************************************
PROCESS BEFORE OUTPUT.
* MODULE STATUS_0100.
*
PROCESS AFTER INPUT.
 MODULE USER_COMMAND_0100.
 MODULE super_cancel AT EXIT-COMMAND.
********************************************************************
   
*And the newly created in the TOP INCLUDE module looks like that:
********************************************************************
MODULE super_cancel INPUT.
  CASE sy-ucomm.
    WHEN 'FC2'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
********************************************************************

*FLOW LOGIC VALIDATION
**********************
*In case of the Flow Logic Validation, the validation is defined on the flow logic level.
*I go to the Screen Painter tool, create another box with database table's fields. The database table is MARA and the fields chosen are
*MATNR, MTART and MATKL. I draw a 'Box' around the fields box and name it 'BX2'. The text says 'Flow logic validations'.
*I want to make sure that the MTART (material type) field only accept the values of COUP (Coupons), FERT (Finished Product) and FRIP
*(Perishables). Right now, there's a very long list of possible values available due to the data element of the MTART having an F4 Help
*attached by default.
*I can ensure such a restriction by implementing a Flow Logic Validation. I need to add the restriction to the PAI event within my MP
*program. 
*The PAI section within my flow logic now looks as below (it works despite the VALUES keyword beign marked as wrong).
********************************************************************
PROCESS AFTER INPUT.
 FIELD mara-mtart VALUES ('COUP', 'FERT', 'FRIP').
 MODULE USER_COMMAND_0100.
 MODULE super_cancel AT EXIT-COMMAND.
********************************************************************
   
*Right now in my MP program, the Exit button will not allow me to leave the application unless all the required fields are filled
*correctly. Without my new restriction for the material type, the Exit button would work only if there was any value provided to the
*customer input field. With my new restriction the material type input field also needs to be filled - with one of three possible values.
*Otherwise I will get an error message 'Enter a valid value'. In such a scenario, the field has failed the Flow Logic Validation. All the
*other input fields get disabled as a result - no values can be provided at this point. Thus if a field fails the Flow Logic Validation,
*all other input fields are disabled.

*If I want to avoid the disabling of all the input fields in case of the material type field failing the Flow Logic Validation, I need
*to group the fields I want to remain enabled within a CHAIN. All the fields enclosed within it will always remain enabled even if a field
*fails the Flow Logic Validation. This needs to be done within the PAI event. In my case, I want the customer number, the material number
*and the material type to always remain enabled.
*Hence, my PAI event looks as below:
********************************************************************
PROCESS AFTER INPUT.
 CHAIN.
  FIELD kna1-kunnr.
  FIELD mara-matnr.
  FIELD mara-mtart VALUES ('COUP', 'FERT', 'FRIP').
 ENDCHAIN.
 MODULE USER_COMMAND_0100.
 MODULE super_cancel AT EXIT-COMMAND.
********************************************************************

*MODULE POOL VALIDATIONS
************************
*If I want user defined validation messages I should define a Module Pool Validation implementation. The messages of the Automatic Field
*Validations and the Flow Logic Validations are always provided by SAP itself.
*I move back to the Screen Painter tool and draw a fields box of the VBAK database table taking VBELN, ERDAT, ERZET and ERNAM fields. I draw
*a 'Box' around it, name it 'BX3' and set its text to 'Module_pool_validations'.
*I would like all the input fields of that section to be filled automatically with data upon providing the VBELN and pressing Enter. Pressing
*the Enter key in the input field triggers the PAI event and it is here where I need to define my desired logic. To have such an action be
*carried out upon pressing Enter in a particular field, I need to utilize the syntax of 'FIELD <field_name> MODULE <module_name>' and thus
*define a separate module for the action.
*The PAI event's section within the flow logic of my MP program now looks like this:
********************************************************************
PROCESS AFTER INPUT.
 CHAIN.
  FIELD kna1-kunnr.
  FIELD mara-matnr.
  FIELD mara-mtart VALUES ('COUP', 'FERT', 'FRIP').
 ENDCHAIN.
 MODULE USER_COMMAND_0100.
 MODULE super_cancel AT EXIT-COMMAND.
 FIELD vbak-vbeln MODULE get_data.
********************************************************************
 
*The 'get_data' module is created within the TOP INCLUDE and looks like this:
********************************************************************
MODULE get_data INPUT.
  IF vbak-vbeln IS NOT INITIAL.
*I am using a key field in the WHERE clause so SELECT SINGLE it is.
    SELECT SINGLE erdat erzet ernam
      FROM vbak
        INTO (vbak-erdat, vbak-erzet, vbak-ernam)
          WHERE vbeln = vbak-vbeln.
    IF sy-subrc = 0.
      MESSAGE 'The sales document has been found' TYPE 'S'.
    ELSE.
      MESSAGE 'The sales document has not been found' TYPE 'S'.
    ENDIF.
  ELSE.
    MESSAGE 'Please enter a sales document' TYPE 'S'.
  ENDIF.
ENDMODULE.
********************************************************************

*The above will so far not work because if I want to use screen fields in my program, I need to declare them explicitly. I am using four
*fields of the VBAK table and I could use the TABLES keyword complete with the VBAK addition but that would decrease the performance given
*the large number of fields in VBAK itself (TABLES creates a work area and thus a work area with around 200 fields would be made). I could 
*create a structure containing only the four fields of my choosing instead and use it side by side with the TABLES keyword.
*I can also simply declare the fields separately with the DATA keyword but I need to change the names of the fields within the Screen Painter
*tool so that they no longer contain a hyphen. I thus change 'vbak-vbeln' into 'v_vbeln' and all other fields similarly. All mentions of
*the fields need to be amended. I am choosing this method this time.

*The PAI event's section in the flow logic now looks like this:
********************************************************************
PROCESS AFTER INPUT.
 CHAIN.
  FIELD kna1-kunnr.
  FIELD mara-matnr.
  FIELD mara-mtart VALUES ('COUP', 'FERT', 'FRIP').
 ENDCHAIN.
 MODULE USER_COMMAND_0100.
 MODULE super_cancel AT EXIT-COMMAND.
 FIELD v_vbeln MODULE get_data.
********************************************************************
 
*The top part of my TOP INCLUDE looks like this:
********************************************************************
PROGRAM Z_BM_TEST_MPP4.

DATA: v_vbeln TYPE vbak-vbeln,
      v_erdat TYPE vbak-erdat,
      v_erzet TYPE vbak-erzet,
      v_ernam TYPE vbak-ernam.
********************************************************************

*The 'get_data' module looks like this:
********************************************************************
MODULE get_data INPUT.
  IF v_beln IS NOT INITIAL.
    SELECT SINGLE erdat erzet ernam
      FROM vbak
        INTO (v_erdat, v_erzet, v_ernam)
          WHERE vbeln = v_vbeln.
    IF sy-subrc = 0.
      MESSAGE 'The sales document has been found' TYPE 'S'.
    ELSE.
      MESSAGE 'The sales document has not been found' TYPE 'S'.
    ENDIF.
  ELSE.
    MESSAGE 'Please enter a sales document' TYPE 'S'.
  ENDIF.
ENDMODULE.
********************************************************************

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------