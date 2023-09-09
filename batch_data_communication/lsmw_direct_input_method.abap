*---------------------------------------------------------------------------------------------------------------------------------
*LSMW - LEGACY SYSTEM MIGRATION WORKBENCH. DIRECT INPUT METHOD.
*---------------------------------------------------------------------------------------------------------------------------------

*First I need to go to the LSMW transaction. After providing just the name in the 'Project' input box, I click the 'Create project'
*button in the Application Toolbar. In this example the name is 'Z7DPRJ'. In the pop-up window I need to provice the desccription
*of the new project and press Enter. The window will be expanded and I will be asked to provide the name of the subproject, e.g.
*'Z7DSPRJ' and its description. After pressing Enter again the window will again expand this time asking me for the Object's name.
*This refers to the Session Object's name. I also need to provide the description.
*When all that's done, I should click the Execute button (F8). I should be taken to the screen listing all the necessary steps.

*----------THE FIRST STEP----------
*'Maintain Object Attributes' is the step where I am to choose the type of technique. I should select the step and Execute it (F8).
*If the mode is Display, I need to make it into Change. The 'Object Type and Import Method' section is the place where I can inform
*SAP which technique I would prefer. Since I want to utilize the Direct Input Method, I should make sure that the
*'Standard Batch/Direct Input' radiobutton is selected. Now I am to provide an 'Object'. This refers to the type of data I will
*be migrating. In order to fill that fields with input I should click the white sheet button and see which number corresponds to the
*type of data within the legacy file. In my case it's going to be '0020' since my file contains material data ('Material master').
*I should treat the 'Method' box in the same manner but when I click the white sheet button the input box should be filled
*automatically with the value of '0000'. Likewise, the 'Program Name' field should be automatically filled with the value of
*'RMDATIND' and the 'Program Type' field with the value of 'D'. The 'RMDATIND' program is a standard program provided by SAP to 
*migrate the material master data. I can open it in SE38 if I wish to behold it. At this stage I should save my progress
*If I wanted to employ the Batch Input Recording technique I would select the relevant radiobutton, provide the recording's name in
*the input box next to the 'Recording' field and pressed the 'Recordings: Overview' button, on the far right side of the screen in
*the same line. I would be asked which transaction I want recorded which would be MM01 in my case and I would proceed to record
*the process of going through the MM01 transaction, providing the necessary data on the way.
*In case of the 'Standard Batch/Direct Input' radiobutton being selected, SAP provides the program herself depending on the 'Object'
*that I chose. I ought to go back now to the screem displaying all the steps.

*----------THE SECOND STEP----------
*In the second step - 'Maintain Source Structures', I will create a structure. Step selected, the Execute button (F8) pushed, a new
*screen arrives where I need to make sure I am in the Change mode. Click the 'Create a Structure' button in the Application Toolbar
*I must. Here I am prompted to provide the 'Source Structure' which essentially means the name for the structure I want created and
*its 'Description'. In my case these are 'Z7AMMATSTR' and '7AM MATERIAL STR' respectively.
*The structure should now be created and I should save my progress and go back (F3) to the screen listing all the steps.

*----------THE THIRD STEP----------
*The next step is 'Maintain Source Fields'. I need to access it and should see the screen with the structure I created previously.
*I need to make sure the mode is in the Change mode (xDDD). With the stucture selected, I should click the 'Table Maintenance'
*button in the Application Toolbar. In the next screen I should provide all the necessary information about the fields I want to
*see in my structure. Which are the fields supposed to hold the data currently stored in the legacy file. In my case the fields
*are as follows ('Field Name', 'Type', 'Length', 'Field description'):
*MATNR, C, 18.
*MBRSH, C, 1.
*MTART, C, 4.
*MAKTX, C, 40.
*MEINS, C, 3.
*Yes, the 'Field description' is left blank for every field. That is because when I press Enter, the descriptions will appear automatically.
*And that is because I am using data elements known to SAP, so she knows what to make of them.

*----------THE FOURTH STEP----------
*In the 'Maintain Structure Relations' step in case of the 'Batch Input Recording' technique I need to map the data from the recording
*to the structure. If there's only one structure and one recording, the mapping is done automatically.
*I ought to access the step and make sure I am in the Change mode. In the screen I should see a bunch of standard structures. If I tried
*to save my progress here, I should see a pop-up window telling me "You must assign a source structure to target structure BGR00." Right
*now I don't know which of the structures available I should assign to it. If I checked BGR00 in SE11, I would see that its fields do not
*match the five fields of my structure. If I checked BMM00, I would see it contains MATNR, MBRSH and MTART which are also fields present
*in my structure. Thus out of five fields present in my structure, three of them are present here. Thus I select BMM00 and click the
*'Create Relationship' button in the Application Toolbar. On the right hand side of the screen in the same line as BMM00 should appear the
*name of my structure, automatically connected to BMM00 now.
*I still have two more fields to cover, so I keep checking the standard structures in SE11. BMMH1 contains the MEINS and MAKTX fields which
*are the two remianing fields of my structure. Hence I select BMMH1, click the 'Create Relationship' button in the Application Toolbar and
*watch SAP assign my structure herself.
*Now I should save the progress... aaand I should see a pop-up window telling me that I must assign a structure to the target BGR00 structure.
*There are no matching fields in BGR00 but I need to perform the assigning all the same as this seems to be some form of a mandatory
*structure - it contains session data. I select BGR00, click the 'Create Relationship' button in the Application Toolbar. Now I should 
*save and go back (F3) to the screen displaying all the necessary steps.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------