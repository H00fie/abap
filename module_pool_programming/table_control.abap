*---------------------------------------------------------------------------------------------------------------------------------
*A PROGRAM CONTAINING THE TABLE CONTROL COMPONENT.
*---------------------------------------------------------------------------------------------------------------------------------

*When I generate the Table Maintenance, I need to specify the Maintenance Type - either One Step or Two Step. The Two Step means
*that two screens will be generated - the Overview Screen and the Single Screen. In the Overview Screen I can perfom operations
*like View, Delete and Update and in the Single Screen I can Insert the data.
*If I open SM30 transaction, provide a table's name and click the 'Maintain' button, the Overview Screen will be displayed. If
*I select 'New Entries', the Single Screen will be displayed.
*In the Overview Screen I can see the records displayed. This section is called Table Control. My transactions might contain the
*screen element called Table Control. Its purpose is to display the records in the form of rows and columns. In the Single Screen
*I can see only Input Fields. Input Fields can show only one value.

*I want to create a program which takes the sales document's number as a parameter and when Enter is pressed, the corresponding
*header and item data should be provided and displayed. The header data needs to be displayed in separate fields and the item
*data needs to be displayed in Table Control.
*I need to go to SE80, pick the 'Program' option and provide the name of my program. In my case it's 'Z_BM_TEST_MPP3'. Now I am
*to press Enter and create the object with the TOP INCLUDE. The 'Type' is the 'Module Pool'. I need to create a Screen now. In
*order to do it, I should right-click my program's name, select Create and then Screen. A short description and the number of the
*screen should be provided (100 in my case). In the Layout I will be using the fields of the VBAK and VBAP tables. I could refer
*to these tables directly, but I will require only four fields from each table so for the sake of performance I elect to trade
*the entire tables for my custom structures each of whom contains the aforementioned four fields - one from VBAK and one from VBAP.
*1) The structure containing VBAK's fields is called: 'ZBMIERZWI_TEST_VBAK_STRUCT' and its field are:
*- VBELN type VBELN_VA,
*- ERDAT type ERDAT,
*- ERZET type ERZET,
*- ERNAM type ERNAM.
*2) The structure containing VBAP's fields is called: 'ZBMIERZWI_TEST_VBAP_STRUCT' and its field are:
*- VBELN type VBELN_VA,
*- POSNR type POSNR_VA,
*- MATNR type MATNR,
*- NETWR type NETWR_AP.
*I should go to the Screen Painter tool now by pressing the 'Layout' button. I now need to go to Goto (hehe) -> Secondary Window ->
*Dictionary/Program Fields. In the input box that takes the tables' names I can also provide the names of the structures, so I can
*type in 'ZBMIERZWI_TEST_VBAK_STRUCT' and push the 'Get from Dictionary' button. Now I should press the book icon in the upper left
*hand corner of the list of the displayed fields and proceed with that. I would now like to make the EMPNO field a mandatory one.
*In the SELECTION-SCREEN kind of a program, I would use the addition of OBLIGATORY. In an MPP, I need to double click the input field,
*go to the 'Program' tab of the 'Attributes' section and next to the 'Input' label I can see a drop-down list - I need to select the
*'required' option. An MPP indicated that a field is mandatory by having a question mark placed within its input box in the Screen
*Painter tool.
*Now I proceed to create the 'Exit' button. Within the Screen Painter tool I need to select the 'Button' option and draw my button
*in my preferred place in the screen. I name the button 'B1', the text is 'Exit' and the function code is 'FC1'. Now I write the
*logic for the 'Exit' button. I move to the Screen in SE80, uncomment the 'MODULE USER_COMMAND_0100' and create the object within the
*TOP INCLUDE.
*The logic looks as follows:
*******************************************************************
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'FC1'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*******************************************************************

*Now to create the transaction. I need to right-click the name of my program in SE80, select 'Create' and then select 'Transaction'.
*The name I gave is 'ZBMI5' and the 'Start object' is 'Program and screen (dialog transaction)' as it always the case for MPP. I then
*need to provide the name of the program the transaction is for, the screen number (100) and check the 'SAPGUI for Windows' checkbox
*in the 'GUI Support' section.

*I want all the screen fields to be filled with data associated with the provided sales document's number upon pressing Enter. In case
*of selection screen programs, pressing the Enter key in the selection screen input field the AT SELECTION-SCREEN ON <field> event is
*triggered and then followed by AT SELECTION-SCREEN and AT SELECTION-SCREEN OUTPUT. In case of MP, the PAI comes first and the PBO comes
*afterwards. Since PAI comes first when Enter is pressed it is within PAI that I should write the logic for fetching the data for all
*input fields.
*To request that SAP triggers that piece of code when Enter is pressed in the particular input field, I need to name that field (the name
*comes from the Screen Painter tool) before specifying the module that should be triggered.
*The syntax looks as below:
*******************************************************************
PROCESS AFTER INPUT.
 MODULE USER_COMMAND_0100.
 FIELD zbmierzwi_test_vbak_struct-vbeln MODULE get_sales_header_data.
*******************************************************************
 
*The module needs to be double-clicked and created within the TOP INCLUDE. Now, based on the value of VBELN, I should get the rest of
*the data. The sales document (VBELN) is a primary key field in VBAK so I will get only one record's data as a result of my query, thus
*I use SELECT SINGLE.
*The module looks as follows:
*******************************************************************
 MODULE get_sales_header_data INPUT.
  SELECT SINGLE vbeln erdat erzet ernam
    FROM vbak
      INTO (zbmierzwi_test_vbak_struct-vbeln,
            zbmierzwi_test_vbak_struct-erdat,
            zbmierzwi_test_vbak_struct-erzet,
            zbmierzwi_test_vbak_struct-ernam)
        WHERE vbeln = zbmierzwi_test_vbak_struct-vbeln.
ENDMODULE.
*******************************************************************

*Whenever I am using screen fields in a program, I need to declare them explicitly. I need to add the below at the top of the INCLUDE:
*******************************************************************
DATA: zbmierzwi_test_vbak_struct-vbeln TYPE zbmierzwi_test_vbak_struct-vbeln,
      zbmierzwi_test_vbak_struct-erdat TYPE zbmierzwi_test_vbak_struct-erdat,
      zbmierzwi_test_vbak_struct-erzet TYPE zbmierzwi_test_vbak_struct-erzet,
      zbmierzwi_test_vbak_struct-ernam TYPE zbmierzwi_test_vbak_struct-ernam.
*******************************************************************

*The names of the fields seem bizzare because they need to be the same as the screen fields' names created in the Screen Painter tool
*and this is what they look like.
*If I want to use the screen fields in my program, I need to declare them in my program but I cannot have a variable name containing
*a hyphen and if the data for the fields in the Screen Painter is loaded from the database, then SAP automatically gives the fields
*names consisting of the database's name and the field's name joined by a hyphen. Thus, I won't be able to refer to that field
*because my declared field cannot be named e.g. 'kna1-kunnr' and such will be the screen field's name is the data was loaded from
*KNA1.
*I can either change the names of the screen fields in the Screen Painter or I can utilize the TABLES declaration. The TABLES declaration 
*counts as the explicit declaration of the screen fields. The TABLES statement will create a work area with all the table's/structure's
*fields. I could declare VBAK here... but that would create a work area with over 200 fields which is unnecessary. My structure has only
*the four fields that I require and is thus perfect here.
*Thus the top part of my TOP INCLUDE looks like that:
*******************************************************************
*DATA: zbmierzwi_test_vbak_struct-vbeln TYPE zbmierzwi_test_vbak_struct-vbeln,
*      zbmierzwi_test_vbak_struct-erdat TYPE zbmierzwi_test_vbak_struct-erdat,
*      zbmierzwi_test_vbak_struct-erzet TYPE zbmierzwi_test_vbak_struct-erzet,
*      zbmierzwi_test_vbak_struct-ernam TYPE zbmierzwi_test_vbak_struct-ernam.
TABLES: zbmierzwi_test_vbak_struct.
*******************************************************************

*Now I need to design the Table Control component. I need to go to the Screen Painter tool and in the panel with tools on the left hand
*side of the window I will see the 'Table Control' button. I need to draw it on the screen. When that's done, I double-click the newly
*created component and name it 'TBCTRL' (there's no convention). The colour of the Table Control doesn't change yet because there's still
*no fields associated with it. As much as the fields above the Table Control contain the header data of a sales document, I want my
*Table Control to contain the item data of that document. The data I want is this in VBAP and I could take the data from there but
*I have created my own structure and populated it beforehand so that SAP would need to handle only a few columns instead of lots. I can
*have the Screen Painter tool use my Structure's structure to create its own columns' structure (hehe). 
*I need to go to Goto -> Secondary Window -> Dictionary/Program Fields, provide the name of my structure ('ZBMIERZWI_TEST_VBAP_STRUCT'), 
*select the 'Get from Dictionary' button, click the button in the upper left hand side of the window with the columns to select everything 
*that's just been displayed and proceed.
*Now I need to drop it on the Table Control and the proper columns will appear there. I can reduce the size of the Table Control to fit
*the columns just right. I can now double-click the Table Control (e.g. the space in the bottom right hand corner in front of the two
*arrows at the ends of the sliders - I need to make sure I am double-clicking the Table Control and not the columns and it can be a little
*bit tricky) and in the 'Attributes' section check the 'Vertical' and 'Horizontal' checkboxes. Due to that the fields in my Table Control
*will be neatly separated and thus the readability will be improved.
*If I tried to activate my MP program now, I would get an error saying that "the field ZBMIERZWI_TEST_VBAK_STRUCT-VBELN is not assigned to
*a loop. 'LOOP ... ENDLOPP' must appear in 'PBO' and 'PAI'." Whenever my screen contains a Table Control component, the loop is required
*in both PAI and PBO. Even simply declaring "LOOP. ENDLOOP" below both of these will do and the program will activate... but if I try to
*execute it, a runtime error will occur. That is because whenever my screen contains a Table Control component, that component needs to be
*declared explicitly within my program.
*This needs to be done within my TOP INCLUDE program (good practice, it could be declared elsewhere if I didn't want my Code Clean. Hehe)
*by using the CONTROLS keyword. Special controls like Table Control need to be declared using the CONTROLS and not DATA keyword. The data
*type for Table Control is 'tableview' and 'using screen' indicated on which screen the Table Control will be displayed.
*The upper part of my TOP INCLUDE program now looks like this:
*******************************************************************
TABLES: zbmierzwi_test_vbak_struct.
CONTROLS: tbctrl TYPE TABLEVIEW USING SCREEN 100.
*******************************************************************

*Now I need to populate my Table Control with item data for the sales document. Of course, only if the sales document has been found and
*its header data has been thus placed in the input boxes above the Table Control. So - if the 'sy'-subrc' after the SELECT fetching the header
*data yields 0. I need to declare the internal table for storing the item data.
*In this case I am first declaring a type and instead of mentioning every field separately, I am using the INCLUDE TYPE syntax, so all the
*fields present in my custom structures that is being thus included will become part of the new type. Here the TYPES keyword also needs to
*appear in front of the END OF because there's a full stop before it and that full stop is required because I am using the INCLUDE keyword
*as part of the TYPES I am creating. Instead of INCLUDE TYPE I could also use INCLUDE STRUCTURE but this syntax is obsolete in OOP.
*It's worth noting that the TYPES declaration is optional, it's just another level of abstraction, I could declare my internal table and
*work area directly on my custom structure instead (ZBMIERZWI_TEST_VBAP_STRUCT).
*The upper part of my TOP INCLUDE now looks as below:
*******************************************************************
TABLES: zbmierzwi_test_vbak_struct.
CONTROLS: tbctrl TYPE TABLEVIEW USING SCREEN 100.
TYPES: BEGIN OF t_items.
  INCLUDE TYPE zbmierzwi_test_vbap_struct.
TYPES END OF t_items.
DATA: lt_items  TYPE TABLE OF t_items,
      lwa_items TYPE t_items.
*******************************************************************

*The module for getting the data - adhering to the idea of the item data being fetched only if the header data has been found, looks like that:
*******************************************************************
MODULE get_sales_header_data INPUT.
  SELECT SINGLE vbeln erdat erzet ernam
    FROM vbak
      INTO (zbmierzwi_test_vbak_struct-vbeln,
            zbmierzwi_test_vbak_struct-erdat,
            zbmierzwi_test_vbak_struct-erzet,
            zbmierzwi_test_vbak_struct-ernam)
        WHERE vbeln = zbmierzwi_test_vbak_struct-vbeln.
*If the header data is found, I need to populate the Table Control with
*all the item data for that sales document.
  IF sy-subrc = 0.
    SELECT vbeln posnr matnr netwr
      FROM vbap
        INTO TABLE lt_items
          WHERE vbeln = zbmierzwi_test_vbak_struct-vbeln.
  ENDIF.
ENDMODULE.
*******************************************************************

*Now I need to move the data from the internal table (lt_items) to the table control. After executing PAI, PBO comes. The data is fetched
*in PAI. The screen refreshing logic should always be written in the final event that is being triggered. That is PBO in MP programs.
*That is why there has to be a LOOP within a MP program that contains a table control. I need to loop through the internal table that
*contains the item data (lt_items) and, obviously, into a work area as that is the way of ABAP. In order to have my table control populated
*I also need to add WITH CONTROL <table_control_name> at the end. That syntax means that while I am looping through the internal table, I
*also want to loop through the table control at the same time. That syntax can ONLY be in the PBO event in the flow logic section so I cannot
*move the loop itself into a module to modularize it, but I can modularize the logic happening for every iteration of the loop instead. I
*cannot write the entirety of the logic within the flow logic section as only a few keywords (e.g. loop, field, module) will be recognised
*here.
*The PBO part of my flow logic section looks like that:
*******************************************************************
PROCESS BEFORE OUTPUT.
LOOP AT lt_items INTO lwa_items WITH CONTROL tbctrl.
  MODULE transfer_item_data.
ENDLOOP.
*******************************************************************

*Now, in the 'transfer_item_data' module I will be referring to the table control fields and they, much like all the screen fields, need to
*be declared explicitly in my MP program.
*Thus, the upper part of my TOP INCLUDE now looks like that:
*******************************************************************
TABLES: zbmierzwi_test_vbak_struct,
        zbmierzwi_test_vbap_struct.
CONTROLS: tbctrl TYPE TABLEVIEW USING SCREEN 100.
TYPES: BEGIN OF t_items.
  INCLUDE TYPE zbmierzwi_test_vbap_struct.
TYPES END OF t_items.
DATA: lt_items  TYPE TABLE OF t_items,
      lwa_items TYPE t_items.
*******************************************************************

*The 'transfer_item_data' module itself looks like shown below. Within the flow logic I am looping through the internal table ('lt_items') that
*holds the previously fetched data. With every loop, a new record appears in the work area. For every record the below module is executed. Data is
*here assigned to the table control's fields. Whenever I am referring to the screen fields, I should declare them (that includes the table control
*fields) - they are declared with the TABLES keyword (instead of mentioning every field separately after the DATA and having to worry about the
*name containing a hyphen as that's how the Screen Painter tool names the screen fields). Using the TABLES keyword also creates a work area, hence
*when I type 'CLEAR zbmierzwi_test_vbap_struct' - it will clear the work area of that structure.
*This works despite the actual table control not being mentioned by its name ('tbctrl') because the screen fields created in the Screen Painter
*tool are called 'zbmierzwi_test_vbap_struct-vbeln', 'zbmierzwi_test_vbap_struct-posnr', 'zbmierzwi_test_vbap_struct-matnr' and
*'zbmierzwi_test_vbap_struct-netwr' and so when I mention them, from my program's perspective, I am talking about my table control's fields.
*******************************************************************
MODULE transfer_item_data OUTPUT.
  CLEAR zbmierzwi_test_vbap_struct. "Clearing a work area.
  zbmierzwi_test_vbap_struct-vbeln = lwa_items-vbeln.
  zbmierzwi_test_vbap_struct-posnr = lwa_items-posnr.
  zbmierzwi_test_vbap_struct-matnr = lwa_items-matnr.
  zbmierzwi_test_vbap_struct-netwr = lwa_items-netwr.
ENDMODULE.
*******************************************************************

*Now, when I provide the sales document's number and press Enter, the PAI event will be executed. The 'get_sales_header_data' module will be triggered
*and the data will be fetched - the header data will be put directly into the screen fields and, if that happens, the item data will land in an
*internal table. When that is finished the control goes to the PBO event. Here I have written the logic to populate the table control component. This is
*the only place where this action can occur. The item data from the internal table is assigned to the table control component in a loop.

*The data should now be displayed in the table control component. At this moment I have the ability to scroll horizontally through the table control
*component but not vertically. SAP does not provide the vertical scrolling by default and it needs to be enabled programatically. I am going to do
*it in the data fetching module because extending the length (height?) of the table control component is dependent on the number of lines it will
*contain. If any data has been found, so if the 'sy-subrc' variable equals 0, I refer to my table control component's 'line' property and set it
*to the number of records that has been found. The 'sy-dbcnt' variable contains the number of records that have been retrieved by the previous SELECT
*statement.
*The data fetching module in the PAI event now looks like this:
*******************************************************************
MODULE get_sales_header_data INPUT.
  SELECT SINGLE vbeln erdat erzet ernam
    FROM vbak
      INTO (zbmierzwi_test_vbak_struct-vbeln,
            zbmierzwi_test_vbak_struct-erdat,
            zbmierzwi_test_vbak_struct-erzet,
            zbmierzwi_test_vbak_struct-ernam)
        WHERE vbeln = zbmierzwi_test_vbak_struct-vbeln.
  IF sy-subrc = 0.
    SELECT vbeln posnr matnr netwr
      FROM vbap
        INTO TABLE lt_items
          WHERE vbeln = zbmierzwi_test_vbak_struct-vbeln.
    IF sy-subrc = 0.
      tbctrl-lines = sy-dbcnt.
    ENDIF.
  ENDIF.
ENDMODULE.
*******************************************************************

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------