*---------------------------------------------------------------------------------------------------------------------------------
*LSMW - LEGACY SYSTEM MIGRATION WORKBENCH. BATCH INPUT RECORDING.
*---------------------------------------------------------------------------------------------------------------------------------

*LSMW is a tool provided by SAP used for migrating the data from a legacy system to a SAP system. The tool can be used in four
*different ways:
*1. By using the Batch Input Recording.
*2. By using the Direct Input Method.
*3. By using IDOC.
*4. By using BAPI.
*To present LSMW, I will perform the migration of the material data from a locally stored text file to the SAP system. I need to
*go to the LSMW transaction. I should see a pop-up welcome message here. I need to provide the name of the 'Project' here - in
*my case it's "ZBM_TEST_LSMW_PRJ". In the Application Toolbar there is the 'Create Entry' button which needs pressing right now. I will
*be prompted to provide a description. When that's done I will need to provide the name of the 'Subproject' and it's description.
*In my case it's "ZBM_TEST_LSMW_SUB". And when that's done I will also need to provide the name of the 'Object' and its description.
*For me it's "ZBM_TEST_LSMW_OBJ". When all that's done, I need to click the execute button (F8).
*Now I should see a screen displaying a list of various steps I need to take.
 
*----------THE FIRST STEP----------
*The first one is 'Maintain Object Attributes'. Here I need to choose the technique - Batch Input Recording, Direct Input Technique, 
*IDOC, BAPI. The step should already be highlighted. In order to proceed - I need to Execute (F8).
*In this case I am using the Batch Input Recording technique. Using this technique requires me to provide the name of the recording
*and record the steps I want taken by walking through them with a sample record. The file with the legacy data contains the material
*data in my example. The transaction thus is MM01. I press the 'Execute' button and change the mode from 'Display' to 'Change' if
*necessary. In the section 'Object Type and Import Method' I should see all the techniques I can choose from. I choose the Batch
*Input Recording one. In the input box available I should provide the name of the recording, e.g. 'R100'. Next I should click the
*'Recordings: Overview' button to the right of the input box. And to the right of the button with an arrow on it. In the next screen
*I should click the 'Create Recording' button, the white sheet on the left hand side of the Application Toolbar. Here I provide
*the recording's name ('R100') and a short description. Here I am prompted to provide the name of the transaction I want to record
*which is MM01.
*Here I need to provide three pieces of information about the sample material I am using for the recording. For example 'Codigo Material'
*can be '7AMAT666', 'Industry sector' might be 'Pharmaceuticals' and 'Material Type' can be 'FERT - Finished Product'. When I press Enter
*now, I will be asked to select a view. It refers to the kind of data about the material I will be additionally providing. In my case,
*apart from the three fields I filled previously, I also want to add a description and a basic unit of measure. These are part of
*'Basic Data 1'. In order to determine the kind of every piece of data I might need the help of a functional consultant. Thus I select
*the 'Basic Data 1' option and proceed.
*In the following screen I provide the description of 'Material 7AMAT666' within the input box to the right of the 'CoMaterial' input
*box and the 'Base Unit of Measure' with 'CM'. Thus I have provided SAP with all the data about the sample record from the legacy file.
*I do not fill any other field as the legacy records do not have any more information about them. When I save my progress, I should
*be transported to another screen where I should be able to see the recorded details mapped to the BDCDATA structure. On the left hand
*side I see the fields' names, a little bit to the right there are their values and on the far right side there are orange fields that
*are all blank. I need to press the 'Default All' button in the Application Toolbar in order to fill these blank orange fields with
*the data element of every field that particular orange box is in line with.
*Now I need to save the progress and go back (F3). I should see the screen with the information about my recording which I need to
*leave by pressing F3. Here I can save again and go back (F3) again.
*Now I should be back in the screen displaying all the steps I need to take. In the first step I have chosen the technique type
*(Batch Input Recording), given the recording a name and recorded the MM01 transaction by manually providing sample data to all
*the necessary fields.

*----------THE SECOND STEP----------
*The second step is Maintain Source Structures. Here I will need to create my own structure. If the second step (row) is selected,
*I need to Execute the program (F8) and change the mode to Change if it's in the Display one. When that's done, I should click the
*'Create a Structure' button in the Application Toolbar. I need to give it a name, e.g. 'Z7AMMATSTR' and a description, e.g.
*'Material structure' and proceed. Now I need to save my progress and go back. In this step I created a blank structure.

*----------THE THIRD STEP----------
*Now I should be back in the screen where all the steps are displayed. The third step is Maintain Source Fields. This step is about
*creating the fields for the currently blank structure created in the previous step. I will need to create five fields as this is
*the number of fields present in the file with the legacy data I am working with. With the third row (step) selected, I am to click
*the Execute button (F8). In this screen I should see the structure I previously created. If it's the Display mode, I need to change
*it into the Change one (hehehehehe). I need to choose my structure and then click the 'Table maintenance' button in the Application
*Toolbar. Here I need to provide the data elements of every field that my structure is to have. These can be collected from the first
*step as I can simply go back (F3) and access the first step just like I did it before and then return here once again. In my case
*the fields are as follows ('Field Name', 'Type', 'Length', 'Field description'):
*MATNR, C, 18.
*MBRSH, C, 1.
*MTART, C, 4.
*MAKTX, C, 40.
*MEINS, C, 3.
*Yes, the 'Field description' is left blank for every field. That is because when I press Enter, the descriptions will appear automatically.
*And that is because I am using data elements known to SAP, so she knows what to make of them.

*----------THE FOURTH STEP----------
*With that done - the fourth step is 'Maintain Structure Relations'. In this step I need to assign my recording to the previously
*created structure. Since I have only a single recording in this case and just one structure, the assignment shall be done automatically.
*If I select the fourth step and Execute it (F8), I should see the name of my recording ('R100' in this case) and the name of my structure
*('Z7AMMATSTR' in this case) to the right. If I wanted to I could delete this relationship. I'd have to select the structure (click the
*four arrows pointing at the recording's name) and press the 'Relationship' button with the garbage can in the Application Toolbar. I can
*create relationships manually by clicking the 'Relationship' button with the white sheet in the Application Toolbar.

*----------THE FIFTH STEP----------
*The fifth step is 'Maintain Field Mapping and Conversion Rules'. In this step I need to map the fields of the recording to the fields
*of the structure. After the mapping has been done the conversion rules can also be defined.
*With the fifth step selected I need to Execute (F8) the program and change the mode from Display to Change if need be. In the current
*screen I should be able to see the fields of my recording - their data elements to be precise. In order to perform the mapping I need
*to choose the field (in my case the first field is MATNR) and press the 'Source Field' button in the Application Toolbar. I should see
*a pop-up window showing me the fields of the structure. I am to decide to which field of the structure I want to assign the selected
*field (which is MATNR). In order to do it it is sufficient to just double-click the chosen field. If the fields' names in the recording
*and the fields' names in the structure are the same I do not need to manually assign every field. Instead I could place the cursor
*onto one of the fields of my recording, then choose the 'Extras' option and 'Auto-Field Mapping'. SAP should show me a pop-up window
*here named 'Auto Field Mapping: Settings' which I am legally allowed to ignore and simply commence forth to the second pop-up window
*of the name of 'Auto Field Mapping: Proposals". In this part of the process, SAP will ask me if her idea of what fields should be
*paired is correct. At the top of the window in the 'Target Field' section is the field of the recording. The 'Source Field' section
*contains SAP's proposal of the target field within the structure. If I like the proposition, I should 'Accept Proposal'.
*When I am done assigning all the fields, the screen should be enriched with three more lines per every field of my recording. These
*are 'Source', 'Rule' and 'Code'. The 'Source' line conveys the information about what field of the structure the particular field
*has been assigned to. The 'Code' section essentially does the assigning. The 'Rule' section is set to the value 'Transfer (MOVE)' by
*default after the mapping. This default rule means that whatever data is stored within the file it will be moved as it is. For the sake
*of making it more interesting - I want to augment that rule. I want to prefix every material number with '666' because hail Lilith.
*Moreover, whenever the material type is 'COUP', I want to change it into 'HAL'.
*In order to modify a rule I need to place the cursor onto the field whose rule I want changed and press the 'Rule' button in the
*Application Toolbar. A pop-up window displays various kinds of rules for me to choose from. For now I am choosing the 'Prefix' one.
*Now I should see another pop-up window, this time with an input box. Here I need to provide the prefix I am interested in. Thus I
*type in '666' here and proceed. Now every material number read from the legacy file will be prefixed with '666'.
*Upon doing that I should see the 'Rule' and 'Code' sections changed for that particular field (MATNR in this case). The 'Rule' section
*should display the value of 'Prefix' and the 'Code' section should have a bit of automatically generated code that concatenates the
*value of the prefix with the material number.
*The second rule I want implemented is the replacement of the material type of 'COUP' with 'HAL'. To accomplish that I place the cursor
*onto the MTART field and press the 'Rule' button again. The rule I need for this task is 'User-Defined Routine (Reusable)'. Upon proceeding
*I should have a pop-up window gracefully thrown at me which should be asking me for the name of the subroutine complete with a
*proposal. I want to provide my own name so I check the 'Own selection' radiobutton and give the name - 'CONVERT_MTART' proving my
*creativity unparalelled. The 'Rule' section of MTART should reflect the new reality and the 'Code' section should be showing me that
*the PERFORM is being performed (hehehe)... but there's no implementation yet. The defining of the rules takes place in the next step.

*----------THE SIXTH STEP----------
*In the 'Maintaind Fixed Values, Translations, User-Defined Routines' step I am to implement the rules defined in the previous step.
*The step selected, the Execute button (F8) pressed need be. In the screen displayed I should see the subroutine I created listed
*under the 'User-Defined Routines' catalogue. The routine in question is 'CONVERT_MTART'. That's implementing the second rule I declared
*before. The prefix one is not available here as it is pretty straightforward and does not require any additional coding on my part.
*I need to place the cursor onto the rule's name and press the 'Edit Entry' button in the Application Toolbar. Here there's a mini
*editor that already contains a little bit of the code of the subroutine proposed by SAP. I have two parameters to work with - 'p_in'
*that holds the initial value from the legacy file that I want to be replaced and 'p_out' that holds the changed value that SAP will
*receive instead of what initially arrived within 'p_in'. I need to implement the logic that changes the value of the incoming parameter
*into 'HAL' if initially it was equal to 'COUP'. If it wasn't equal to 'COUP', the returned value is to remain unchanged. The code 
*hence looks as follows:
*FORM ur_CONVERT_MTART USING p_in CHANGING p_out.
*  IF p_in = 'COUP'.
*    p_out = 'HAL'.
*  ELSE.
*    p_out = p_in.
*  ENDIF.
*ENDFORM.

*----------THE SEVENTH STEP----------
*The 'Specify Files' step is about uploading the file containing the legacy data to the LSMW tool. The file is stored locally. The step
*is to be selected and the Execute button (F8) is to be pressed. In the next screen I need to change the mode to Change from Display if
*the latter is the active one. The screen should be displaying a few rows, two uppermost of which being:
*- 'Legacy Data On the PC (Frontend)'.
*- 'Legacy Data On the R/3 server (application server)'.
*I need to put the cursor onto one of the above options - the one that applies (the first one in my case) and press the 'Add Entry' button
*in the Application Toolbar.
*The following pop-up window requires me to provide the path to the file (the 'File' input box) and a name of my choosing for the file,
*e.g. '7AMMATERIALS'. I need to specify the type of the delimiter in the 'Delimiter' section below. In my case it's a comma so the 'Comma'
*radiobutton gets checked. The 'File Structure' section allows me to specify whether the legacy file's records contain a field name at the
*start of the file. If they do not and such is the case in my case (xDDD) I need to check the second checkbox - 'Field Order Matches Source
*Structure Definition'. With that done, I commence forth. I should now see the name of file alongside the path to it and the options I
*have chosen under the 'Legacy Data On the PC (Frontend)' catalogue. I need to save the progress and move on to the next step.

*----------THE EIGHT STEP----------
*The 'Assign Files' step is about assigning the file to the structure. In the current example I only have a single file and a single
*structure so the assignment is done automatically. The selection of the row with the step needs to precede the pressing of the Execute
*button (F8) much like the changing of the mode from Display to Change in the following screen needs to precede any further action. In
*my case I will see the file already assigned to the structure due to the aforementioned reason. I could technically delete that
*assignment by placing the cursor onto the file's name which is in the second row to the left of the path to the file and pressing
*the 'Assignment' with a grabage can button in the Application Toolbar. In order to assign a file to a structure I need select the
*structure's name and press the 'Assignment' with a white sheet button in the Application Toolbar. Since there's only one file to be
*assigned in my case it will be done automatically. I need to save the progress and go back (F3) to the screen listing all the steps.

*----------THE NINTH STEP----------
*In the 'Read Data' step I will be, to everyone's shock, reading the data from the file. Whatever SAP reads will be stored within the
*file called 'LSMW.READ'. Upon executing this step, I will be taken to the screen where technically I can provide a range of values
*called 'Transaction Number' but I am not doing that. The name is a little bit misleading because, I think, it refers to which records
*of the file I want read, supposedely from which line to which line. I want the entire file read so I just need to execute the program
*again without providing any values. I will be asked if I want to allow SAP to access the file which I should because SAP is great and
*only wants to help. <3 Now I should see another screen which informs me what file was read and what file was written. The former should
*essentially be the path to the legacy file and the latter the newly created LSMW.READ file.

*----------THE TENTH STEP----------
*The next step is 'Display Read Data'. Here SAP will display the data loaded into the LSMW.READ file. Upon executing this step I should
*be presented with a pop-up window in which I can specify which records I want to inspect. I can do this by providing the 'From Line' and
*'To Line' input boxes with relevant values. If I want to read all the records I can simply not provide any values leaving the input
*boxes as they are and proceed. Now I should see the screen displaying all the data now available in LSMW.READ. I can click a record
*and see it displayed in a separate screen. At this stage the conversion rules I specified have not been applied yet! The material
*number isn't prefixed with '666' and the material type hasn't been changed from 'COUP' to 'HAL'. The execution of the rules will take
*place in the next step.

*----------THE ELEVENTH STEP----------
*In the 'Convert Data' step SAP will execute the conversion rules I requested. The rules shall be applied to the LSMW.READ file's data
*and thus converted data will be stored in the LSMW.CONV file. When I Execute (F8) the step the process takes place internally. I should
*see a screen asking me to provide a range of values. This refers to which lines of the LSMW.READ I want the rules to apply to. If I
*want all the content to experience this wonderful fate, I ought to just not provide anything and simply Execute (F8) the program. The
*screen should now be showing me what file was read ('LSMW.READ') and what file was written ('LSMW.CONV'). There is nothing for me to
*save here so I need to just go back (F3)!

*----------THE TWELFTH STEP----------
*During the 'Display Converted Data' step I am to check whether the rules I defined were made flesh or not. When I execute the step,
*I will see a pop-up window where I can specify the lines I want to see. If I want to see all of them, I can just commence forth without
*doing anything here. I should now see the screen displaying all the lines of the LSMW.CONV file. All the material numbers should now
*be prefixed with '666' and all occurences of the 'COUP' material type should be changed into 'HAL'. I can click any of the records to
*see more details about that particular record in another screen.

*----------THE THIRTEENTH STEP----------
*In this step the data present in the LSMW.CONV file is mapped to the Session Object. When I execute this step, I shoul see the screen
*showing me the name of the LSMW.CONV file and a few other things. One of these things is a checkbox named 'Keep batch input folder(s)?'.
*I should check it if I want to keep the Session Object even after processing for the purpose of analisys. The 'Name of Batch Input
*Folder(s)' field is the name of the Session Object. I should press the Execute button (F8), accept the pop-up window's information
*and I will be back in the screen listing all the steps.

*----------THE FOURTEENTH STEP----------
*The 'Run Batch Input Session' step takes the control to the SM35 transaction when executed. I should see my newly created Session
*Object here with the 'New' state. I ought to select the object and push the 'Process' button in the Application Toolbar. A pop-up
*window will ask me about my preferred 'Processing Mode'.
*I would choose the 'Background' option but first I need to modify one of the previous steps. When I was creating the recording I
*chose 'Basic View 1'. I need to mark that field for the recording. I ought to go back (F3) to the screen displaying all the steps,
*select the fifth step and execute it. Here I have the 'KZSEL_01' field which I need to select and press the 'Rule' button in the
*Application Toolbar in order to insert a new rule. I should check the 'Constant' radiobutton and put 'X' in the input box to the left
*of 'KZSEL'. Thanks to that, the 'Basic View 1' option will be automatically selected from now on. I should save it... and execute the
*following steps and save them too. In the 'Read Data' I should read the data (F8 inside) again. The same with the 'Convert Data' step.
*I should also execute 'Create Batch Input Session' again.

*When I execute the 'Run Batch Input Session' step and am transported to SM35 I choose the newly created Session Object and click the
*'Process' button in the Application Toolbar. Then I choose the 'Background' option and press the 'Process' button.

*In case it's taking a lot of time and seems to be unable to finish, I can carry out this process another way. I can scroll the table
*control to the right and at the end of it I should see the 'Queue ID' column. I should copy the number of the Session that isn't
*very cooperative and open a program called 'RSBDCBTC' in SE38. Upon executing it I will be prompted to provide 'Queue_ID' which is
*the number I copied previously after which I should execute the program. I should see a pop-up window telling me 'Processing of batch
*input session completed'. When I click the 'Session overview' button I will be taken back to SM35 and the status of the Session
*should be changed.

*If I want to analise the processing of the Session Object, I should select the record with the Session I am interested in and click
*the 'Analysis' button in the Application Toolbar. In the 'Transactions' tab which should be active by default I will see a list
*of all the records that were processed and what is their status. In order to see the details of the process I should access the
*'Log created on <date>' tab.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------