*---------------------------------------------------------------------------------------------------------------------------------
*CREATING CUSTOM DATABASE TABLES. DICTIONARY OBJECTS.
*---------------------------------------------------------------------------------------------------------------------------------

*There are many standard database tables provided by SAP itself. To maintain data within them, one uses standard transactions also
*provided by SAP.
*E.g.
*Customer data -> transaction XD01 (Creating customer). Data is persisted in KNA1, KNBK...
*Material data -> transaction MM01 (Creating material). Data is persisted in MARA, MAKT, MARC, MARD...
*Sales order data -> transaction VA01 (Creating sales order). Data is persisted in VBAK, VBAP...
*Purchase order data -> transaction ME21 (Creating purchase order). Data is persisted in EKKO, EKPO...
*
*Sometimes standard tables are not enough to represent all the data required by a specific customer. In such a scenario I need to
*create "customer specific tables" which hold data specific to a customer.
*
*Database tables are accessed within the dictionary - SE11. There are a few steps that need to be followed in order to create a
*database table:
* - Delivery and Maintenance:
*                Delivery Class needs to be specified. It is used for controlling the transportation of the table's data. The transportation
*                               refers to sending the table between the systems (development, quality and production). I can choose whether
*                               to transport only the structure or the structure along with the date. That transportaion is controlled by
*                               the Delivery Class.
*                                      "A - Application Table (master and transaction data)" - whenever I want to store master or transaction
*                                           data, A is the choice. Master data means data which has more read than write operations,
*                                           e.g. a bank account's number, the holder's name, etc. They do not keep on changing, so
*                                           they are master data. Transaction data is when I have more write operations. It's day to
*                                           day business data.
*                                      "C - Customizing table, maintenance only by cust., not SAP import" - my custom customer specific tables.
*
*                              The master and transaction data is maintained through the aforementioned standard transactions. In the case of
*                              "C" tables, it should be taken care of by the customer themselves. The majority of the tables provided by SAP
*                              are "A". Whenever I create my own tables, they are "C".
*
*                Data Browser/Table View Editing provides three possible options:
*                                      "Display/Maintenance Allowed with Restrictions" - I can only view the data but cannot insert, update nor
*                                           delete records. Almost all of the standard tables provided by SAP have this options.
*                                      "Display/Maintenance Allowed" - I can perform all the operations.
*                                      "Display/Maintenance Not Allowed" - I cannot perform any of the operations.
* - Fields:
*               Also called columns. Just like with internal tables. Names, data types, sizes. I can create my fields either basing them on
*               direct data types or data elements/domains. There are limitations to using direct data types here - the fields' values are always
*               captured in the upper case, I cannot impose any validation on the data, it doesn't support reusability and I cannot maintain field's
*               labels. E.g. I might want to have my column Designation provide only four possible values. I cannot impose any validation on what's
*               being provided if the data type is a simple string. Thus it is better to use Data Elements - see line 9668.
* - Technical settings:
*               Data class needs to be specified because the SAP database is partitioned into multiple schemas. There is a master schema which
*                              stores master tables that have more read operations than others. There is a transaction schema with transaction
*                              tables, etc. Thus Data Class specifies in which schema the database table is to be stored.
*                                      APPL0 - Master Data, Transparent Tables. This means the table is used for storing master data.
*                                      APPL1 - Transaction Data, Transparent Tables. This means the table is used for storing day to day data,
*                                              sales orders data.
*               Size category means the number of records expected to be stored in the database table. E.g. setting the size to 3 will make SAP
*                             initially allocate enough memory to store a maximum of 7400 records. It doesn't mean no more will fit - it's just
*                             the initial amount of memory. If the threshold is exceeded though, the allocated memory is extended by the initial
*                             amount, e.g. if I add 7401th record to the database table of the size 3, the table will receive memory for additional
*                             7400 records and will thus have memory for 14800 records in total.
*                             The extending of the database table requires some work from SAP, so choosing too small a size is discouraged. Having
*                             to enlarge the database table will degrade the performance.
*                             Likewise, it's not a good idea to assume too big the size of a table as it will waste memory.
* - Enhancement category:
*               If a customer wants 260 fields in a master data table, but SAP's standard KNA1 only has 251 and not all the fields match anyway,
*               I can use the enhance option to augment the SAP standard. The enhancement category controls the extensibility of SAP database
*               tables.
*               I can check the category of the database table by opening the table in SE11, going to Extras and checking Ehancement Category.
*               E.g. KNA1 has the "Can be enhanced (character-like or numeric)" option. This means additional fields can be added here and they
*               need to either be character or numeric fields. The "Can be enhanced (Deep)" option - "deep" means a structure within a structure
*               (any kind of data type can be added).

*---MANDT's purpose---
*If a table contains MANDT as the first field - it's a client dependent table. It stores the client's number. A client independent table does not
*have a MANDT field and the rows (records - the actual values stored) are not specific to any client. If I want records accessible across all the
*clients, I can create a client independent table (without the MANDT).

*---Primary Key and Initial Values---
*Every table should have at least one primary key (16 is maximum). Making a field a primary key field prevents it from having duplicate values.
*A combination of more than one primary key is called a composite key.
*The Initial Values option forces a not null policy. If no value is provided then a default value (specific to a data type the field is of) is
*inserted. It is automatically checked for primary key fields.

*---Manipulating the data---
*A new record can be added from the level of the database table's creation - SE11 -> enter a table -> Utilities -> Table Contents -> Create Entries.
*I can also manipulate the existing records by going to Utilities -> Table Contents -> Display (or pressing the Contents button in the Application
*Bar). When displaying the contents I can select the option of Table Entry and manipulate any record in a capacity allowed by the
*"Data Browser/Table View Maint." option selected when creating the table.

*---Table Maintenance---
*After the table has been created, I need to generate Table Maintenance which will create an interface through which the end user can maintain
*the table. To generate Table Maintenance, I need a Function Group.
*Whenever I generate Table Maintenance, some dependent objects are generated. They are stored within the Function Group. A Function Group can
*be created in SE80. When it's there, I need to activate it (right click its name).
*To generate Table Maintenance, I need to open the table in SE11, go to Utilities and select Table Maintenance Generator.
*- Authorization Group specifies what users can maintain the table in case I didn't want just any end-user to be able to do this. E.g. the
*                      option of "&NC&" means "without authorization group so anyone can maintain the table.
*- Maintenance Type needs to be specified as either One Step or Two Step.
*                   a) One Step - one screen is generated - the Overview Screen. In this screen all the CRUD operations can be performed
*                                 (adding, removing, updating and deleting records). I need to provide the screen number - any number up to
*                                 9999. I can have this number generated automatically by SAP. In the Application Toolbar there is a button
*                                 "Find Scr. Number(s)". I have three options there, one of which is "Propose screen number(s)". If this is
*                                 the first Table Maintenance created within the Function Group, the proposed number will be 1.
*                   B) Two Step - the Overview Screen is generated and the Single Screen is generated. In the Overview Screen I can only read
*                                 the data and the other three operations can be performed in the Single Screen.
*                   When that's done, I can click the white sheet button ("Create") and save the Table Maintenance. Then I F3 out of the Table
*                   Maintenance genertaion environment back to the database table in SE11, save and activate it.

*The user can maintain the table in SM30. Though here the user needs to remember the name of the table and specifically select the Maintain
*button out of all the available ones. I should provide them with a better tailored interface - I need to provide them with a tool that
*requires minimum navigating from them.
*For this purpose - I should create my own custom Transaction Code.

*To skip the initial screen of SM30 and create a Transaction Code that initially fires up the Maintain option, I need to collect the function call
*of the Maintain button - by moving the focus onto that button with Tab keyboard button and pressing F1.
*The creation of new Transaction Codes is carried out in SE93 transaction. I need to provide the name and the short description. I should choose
*the last of the options in the Start Object section ("Transaction with parameters (parameter transaction)") - it is the correct choice for the
*Transaction Code for the table maintenance.
*In the next screen in the "Default values for" section, I need to add SM30 to the "Transaction" box and mark the "Skip initial screen" checkbox.
*Furthermore, in the "GUI support" section, I need to mark the "SAPGUI for Windows" checkbox. Since I am skipping the initial screen, I need
*to provide my transaction with the information that I was providing in SM30 - the name of my database table and the pressing of the Maintain
*button. In the "Default Values" I need to provide the names of the screen fields I require - the input box and the button.
*The input box most likely is "VIEWNAME" and the Value is the name of my table.
*The second row should have "UPDATE" as Name of screen field and "X" as Value. "UPDATE" is the name of the Maintain's function call and "X" informs
*it's the button that's being pressed. Technically F1-ing the Maintain button in SM30 will give me "UPD", but I need to provide "UPDATE" here
*anyway.
*Whenever there are changes made to the database table - I need to generate the table maintenance again. In order to do so, I need to open my table
*in SE11 in the Change mode. The reason for change does not matter much, I can mark all the checkboxes. Then I need to tell SAP which screen
*I want generated again - in case I chose the Two Steps maintenance type - I should mark both checkboxes (Overview screen and Single screen).

*----------------------------------------------------------------------*
*       DATA ELEMENTS
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*It is recommended to declare the table's fields using Data Elements and Domains instead of direct data types.

*A Data Element is a reusable dictionary object which provides a description for the field. Which means I can maintain the descriptions when I
*               create Data Elements. These descriptions, specified in the Field Label sheet of the Data Element screen (when I double-click one)
*               appear automatically in the screens wherever the Data Element is referred to. Any Data Element can be associated with a direct
*               Data Type, a Domain or a Reference Type. I can see this in the Data Type sheet of the Data Element screen.
*               - a Domain - a reusable dictionary object which stores technical properties of the field like the data type or size. E.g. MANDT
*                            is associated with the domain also named MANDT - the name can be the same but doesn't have to.
*                            A domain allows me to make my variables retain the exact way they were stored instead of converting all letters to
*                            the uppercase. In the Definition sheet if I select Lower Case checkbox, it will do just that - retain the way the
*                            data was provided. Thus, when I create my own Data Elements, I can use a Domain for CHAR fields (to have them retain
*                            how they were stored) and use a Predefined Type for numeric fields since they don't have either uppercase or lowercase.
*                            A Domain allows me to create a set of possible values that can be selected for the Data Element associated.
*               - a Predefined Type.
*               - Object Oriented Interfaces of classes (Reference Type).

*----------------------------------------------------------------------*
*       REUSABLE FIELDS (AS STRUCTURES)
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*If I want to add new fields to the table, I can do it directly within the table unless I want to have them reusable - possible to use by other
*structures or other dictionary objects as well.
*A dictionary structure is essentially a work area, but on a database level. I can declare it, have it as many fields as I want and include that
*structure in different dictionary objects, e.g. database tables.
*After having created my structure, I should specify the enhancement category for it, just like with tables.
*When I want my custom structure included in a particular database table, I need to type '.include' as a new field of the table and provide the
*name of the structure as a Data Element field. Upon hitting Enter, the Data Type field will be filled with 'STRU' - indicating that it's indeed
*a structure being included in the database table.
*I need to keep in mind, I will need to generate the table maintenance for my table again! Whenever I add additional fields, modify existing ones
*or modify the labels - these changes will not be reflected in the existing table maintenance - it needs to be remade.
*I also need to remember that in the custom transaction code standing for the table maintenance for my custom table, the Two Step mainetance's
*Overview Screen will show only a handful of fields. If I select New Entries option, all the fields should be visible. If I want to display all the
*data for the particular records - I need to select it and choose Details option from the Application Toolbar.

*----------------------------------------------------------------------*
*       EVENTS AS PART OF TABLE MAINTENANCE
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*I can define events as part of Table Maintenance in order to e.g. have my Table Maintenance set the date and time fields to the current date and
*time in case the user has not provided actual values for these fields.
*I should open the database table in SE11, go to Utilities, Table Maintenance Generator, then go to Environment, Modification and select Events.
*There I should select New Entries and choose the value of 'T' (a table/time event). This is to specify when the subroutine I am going to specify
*should be triggered. For example, the number '05' stands for 'Creating a new entry' - I can use it to write a subroutine assigning values to
*specific fields at the time of the creation of a new record. I should also provide the name of my subroutine. Upon hitting Enter, the Editor button
*to the right should change and allow me to select it - doing so will take me to the editor.
*Whenever I implement events as part of table level, I need to reactivate the function group, so that all the objects are adjusted. When all that
*is done, adding a new record in my Table Maintenance with omitting the date and time fields and saving the record will make the current date and
*time be inserted into their respective fields automatically.

*----------------------------------------------------------------------*
*       INDEXES IN DATABASE TABLES
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*An index is a process of arranging data in a specifc order. If data is sorted, the searching is faster. The purpose of indexes is to increase
*the searching speed. If I want to search for a specifc record among a huge amount of data, I should sort the data and then search - like using
*the READ statement with internal tables - first I should sort the internal table based on the search field.
*There are two types of indexes:
*- primary - I don't have any control over it. It is automatically created by SAP. Internally it is going to arrange the table data in an order
*            based on the primary key fields. Whenever I search for a record based on a primary key field, SAP will make use of a primary index
*            to look for the record.
*- secondary - should be created by me and created on non-primary key fields. It increases the performance. There are two types of a secondary
*              index.
*            a) unique - if I create it on a field, it will not accept duplicate values for that field.
*            b) non-unique.

*I can improve the performance of SELECT queries that utilize non-primary key fields in their WHERE clause by creating a secondary index
*on a non-primary key field. If I am making a SELECT comparing non-primary key fields that had a secondary index created, SAP will make
*use of that secondary index and thus make the query faster.

*If I want to create a secondary index, I need to open my database table in SE11 and select 'Indexes...' option from the application toolbar.
*Then I should select 'Create' and 'Create index'. I should provide my custom index' name, e.g. 'ID1'. Then I ought to provide a short description
*for the secondary index I am creating.
*Then I can choose what kind of an index I want to create - a uniqe or non-unique. I can choose 'Table fields' button to choose the field on
*which I want the index created. If my database table is not client-independent (has MANDT), MANDT needs to be included in the index and has to be
*selected alongside my chosen field.
*If I am trying to create a unique secondary index on a field with duplicate values - SAP will refuse to do so. Blanks are also counted as
*duplicates! If at least two records have a blank space in the field on which I want my unique secondary index - it will not come to pass.
*When a unique secondary index is created on a field, I won't be able to insert a new record with the same value as held in that field by one
*of the other records.

*----------------------------------------------------------------------*
*       TYPE GROUP IN SE11
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*A reusable dictionary object which is a collection of global types and global constants. Much like I can have types and constant variables locally
*in my programs, I can create a Type Group if many dictionary objects will share the same types or constants and have them global and reusable.
*If I want to use variables of an include program, I need to type 'INCLUDE program'. In the same manner, but only until SAP GUI 6.0 -  if I wanted
*to use components of a type group, I needed to declare that type group. It was done by typing 'TYPE-POOL my_type_group'.
*In the newer versions, I no longer need to explicitly declare the type group. SAP will recognize I am using the components of a particular type
*group.
*Whatever the components I declare in my type group, these components have to have the name of the type group as a prefix, e.g. a type group going
*by the name of 'NezukoBestGirl' needs to have all of its components have a prefix of 'nezukobestgirl_'.

*----------------------------------------------------------------------*
*       LOCK OBJECTS
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*A reusable dictionary object which is used for row level locking. It's purpose is to prevent two users from updating the same record. If two users
*are trying to update the same record, it can lead to a deadlock. In operating systems a deadlock can occur when multiple users are trying to use
*the same resource. A lock object is used to lock a particular record and perform the operation and lift the lock afterwards.
*Row locking is performed based on the primary key column. The key fields are the lock object's parameters. Only one row can be locked at a time.

*Similarily, object level locking is performed by SAP itself - if one user edits a particular program, the other user cannot open that program in an
*edit mode. So only one user can edit an object at any given time. If a user opens an object, a lock is placed on top of that object automatically.

*When creating lock objects, their names should start with 'e' (compulsorily, SAP will demand it) and 'z' afterwards (that SAP won't demand). Then,
*I should provide a short description. In the 'Tables' tab I need to provide the name of the table whose row I want to have a lock for. Next, the
*'Lock Mode' means the type of lock. The three most important ones are:
*- Write Lock - also known as Exclusive/Acumulative Lock. In this lock only one user can read or edit the locked record. If other users request access
*               to the locked row, the request will be rejected but stored in the queue. Once the first user releases the lock, the exclusive access
*               is given to the user in the queue.
*- Read Lock - also known as Shared Lock. Multiple users can read the locked record and if a user modifies the locked record, the modified data is not
*              accessible to other users.
*- Exclusive, not cumulative - similar to the Write Lock, but other users' request for access are not stored in the queue. They have to send a fresh
*                              request themselves.
*Moving forward, in the 'Lock parameter' tab, I can see the key fields of the chosen table. Save and activate.
*When a lock object is created, SAP creates two function modules:
*- 'ENQUEUE_<LOCK_OBJECT_NAME>' - used for locking the row.
*- 'DEQUEUE_<LOCK_OBJECT_NAME>' - used for releasing the row.
*I can see these function modules if I open my lock object, select Goto and pcik Lock Modules. Both of the created FMs will be displayed.

*---In order to use a lock object---:
*In the case below, two separate users could access the same KUNNR. It might lead to a deadlock situation. If one user tries to modify
*the record and the other tries to access it, the second one might get invalid data. The record needs to be locked once a user has already
*accessed that record.
******************************************************************
*PARAMETERS: p_kunnr TYPE kna1-kunnr.
*DATA: v_name1 TYPE kna1-name1,
*      v_ort01 TYPE kna1-ort01.
*SELECT SINGLE name1 ort01
*  FROM kna1
*    INTO (v_name1, v_ort01)
*      WHERE kunnr = p_kunnr.
*IF sy-subrc = 0.
*  WRITE: / 'Customer found.'.
*  WRITE: / 'Customer name:', v_name1.
*  WRITE: / 'Customer city:', v_ort01.
*ELSE.
*  WRITE: / 'Customer not found.'.
*ENDIF.
******************************************************************
*In order to have a lock object put onto a record, I need to add 'SET PF-STATUS'. It is used to define my own GUI STATUS. As part of the
*GUI STATUS, I can add my own buttons to the application toolbar or enable or disable standard ones.
*To do this, I need to provide a preferred name ('ABC' in this case) and double-click the name to create the object. Then I need to provide
*a short description which can be just the status' name. The status type can remain as 'Normal Screen' which is a default. Now the Menu Painter
*(SE41) is open. Since I want to add custom buttons to the Application Toolbar, I need to select the button to the right of the Application
*Toolbar box. There I should provide the function call of my button (e.g. 'FC1') in one of the boxes available (I think they refer to the position
*of the button on the Application Toolbar), press Enter and continue (the default Static Text is good). Here I need to provide the text my button
*will display (e.g. Leave, Unlock, etc). Then I need to assign my function the function key. It is a shortcut - much like F3 means "go back". Only
*the available buttons are displayed as options. This is why I cannot choose F3 because it's reserved by SAP. If I create one button and assign it
*e.g. F2 and then create a second one, F2 will no longer be available, because the first button reserved it. I will still need to define the functions
*for my custom made buttons.
*Whenever I define my own GUI STATUS, SAP will lose the functionality of the standard back button. I thus need to create my own.
*My custom buttons are components of the Application Toolbar of the List Processing Screen. If I click any of the buttons on the selection screen's
*Application Toolbar, AT-SELECTION-SCREEN event is triggered, but my custom made buttons are placed in the Application Toolbar of the LPS and they
*trigger another event - AT USER-COMMAND.
*In order to finally lock the record, when I created my Lock Object, two function modules were created. ENQUEUE to lock the record and DEQUEUE to
*unlock.
******************************************************************
*PARAMETERS: p_kunnr TYPE kna1-kunnr.
*DATA: v_name1 TYPE kna1-name1,
*      v_ort01 TYPE kna1-ort01.
**My custom GUI STATUS.
*SET PF-STATUS 'ABC'.
**To lock the record, I need to call the automatically created ENQUEUE FM. 'MODE_KNA1 = 'E'' refers to the 'exclusive lock' or 'write lock'. If
**'sy-subrc' equals one, that means the record is locked.
**Upon executing the program (F8) the record will be locked first and then retrieved. While this session is active, if another user tries to
**access the same record - they will receive an error message informing them that the record is locked. It's important that the message is of
**type 'E'. If it's 'I', it will still proceed to display the record after the pop-up window!
**It is recommended to lock a record before performing an operation. Thus, the ENQUEUE function module is called before any operation is performed.
**The operation locks only the particular record, all other records will be free to be accessed by another user.
**I should lock the record even if I am just reading because there is a possibility that other users might seek to modify the record and I would
**be seeing outdated data.
*CALL FUNCTION 'ENQUEUE_EZBMIERZWILOCK'
* EXPORTING
*   MODE_KNA1            = 'E'
*   MANDT                = SY-MANDT
*   KUNNR                = p_kunnr
* EXCEPTIONS
*   FOREIGN_LOCK         = 1
*   SYSTEM_FAILURE       = 2
*   OTHERS               = 3.
*IF sy-subrc = 1.
*  MESSAGE 'The record is currently locked.' TYPE 'E'.
*ENDIF.
*
*SELECT SINGLE name1 ort01
*  FROM kna1
*    INTO (v_name1, v_ort01)
*      WHERE kunnr = p_kunnr.
*IF sy-subrc = 0.
*  WRITE: / 'Customer found.'.
*  WRITE: / 'Customer name:', v_name1.
*  WRITE: / 'Customer city:', v_ort01.
*ELSE.
*  WRITE: / 'Customer not found.'.
*ENDIF.
**I created a 'FC1' button and called it 'Leave' in my custom GUI STATUS. 'FC2' is assigned to my custom button named 'Unlock'. Pressing this
**button should unlock the record. These are defined within the boundaries of AT USER-COMMAND event as these buttons are part of the Application
**Toolbar of the List Processing Screen and AT USER-COMMAND is the go-to event here. If the user pressed a button back in the Application
**Toolbar of the selection screen, then AT SELECTION-SCREEN would be triggered instead.
**Leaving the program will also unlock the record.
*AT USER-COMMAND.
*  CASE sy-ucomm.
*    WHEN 'FC1'.
*      LEAVE PROGRAM.
*    WHEN 'FC2'.
*      CALL FUNCTION 'DEQUEUE_EZBMIERZWILOCK'
*       EXPORTING
*         MODE_KNA1       = 'E'
*         MANDT           = SY-MANDT
*         KUNNR           = p_kunnr.
*  ENDCASE.
******************************************************************

*----------------------------------------------------------------------*
*       FOREIGN KEY RELATIONSHIP BETWEEN TWO TABLES
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*The foreign key relationship is created between two tables in order to maintain the data consistency as this relationship is to be created when
*the data within one table is dependant on the data from the second table. The prerequisite is that the tables have at least one field of the
*same domain (data element can be different!) and in one of these tables that field has to be a primary key field. The table that has this field
*as a primary key field is called a Check Table. It contains unique data. The second table houses the foreign key and is called a Foreign Key Table.

*---In order to create the foreign key relationship---
*Say I have a table that houses the department data and the field with the department number is the primary key field and a second table with the
*employee data that also has a department number field but not as a primary key field.
*These fields need to have a common domain. The department table is a check table because it stores all the unique department numbers. Thus it stores
*all the master records, unique values (in terms of the logically related field - the department number).

*The foreign key is to be created in the other table. I need to select the proper field (in the example it's the department number in the employee
*data table) and select the 'Foreign Keys' button above the tables' fields' list. I should provide the 'Short text' explaining what tables are
*being joined. In the 'Check table' I need to provide the name of the parent table - the one that houses the field I am making into a foreign key
*and has it as the primary key field. When I press 'Generate proposal' button, SAP will show me all the fields of the parent table that share the
*domain with the field I selected in the foreign key table where I am performing the operation. I need to select 'Copy' (essentially 'Continue') to
*proceed. I should activate the table now.
*When I create the foreing key, the records that were already present will not be checked but from now on the newly added records will be. Whenever
*I create the foreign key relationship between two tables, SAP will maintain the referential integrity between them. According to the referential
*integrity, I will not be allowed to insert a child row in the foreign key table if there is no corresponding parent record in the check table, e.g.
*I will not be able to add a new employee to the employee table unless the department number I want them to have already exists in the department
*table. When adding a new record to the employee table, the department number field will have the F4 help available and it will display the values
*I can choose from. They are loaded from my department table.

*----------------------------------------------------------------------*
*       TABLE TYPE
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*Whenever I am working with multiple records, I am using internal tables in order to avoid doing the processing on the database. Instead, I am
*retrieving the data into a temporary table - an internal table. Within it I process the data the way I want and then I update the database. An
*internal table is local to my program - its lifetime and scope are limited by bounds of my program. Once the program's execution is finished,
*the internal table is destroyed.
*A Table Type is an internal table structure created at the database level.
*Like any other dictionary object a table type is reusable. I create it whenever I want a reusable internal table.
*In order to create a Table Type, I need to go to SE11, choose the Data Type radiobutton, provide a name of my Table Type and select Create. I
*should provide a short description here. A Type Table can be created in three various ways:
*- by referring to a Line Type,
*- by referring to a Predefined Type - a direct data type.
*- by referring to a Reference Type - a class or an interface.

*If I want to use the same internal table across many repository objects (programs), I can create a Table Type instead of a regular internal
*table every time separately.

*---Predefined Type---
*Below are two blocks of code, the first creates an internal table locally and uses it, the second uses a Table Type (so a "global" internal
*table) created as described above. It is a Table Type with a Predefined Type of CHAR of the length of 20.
******************************************************************
*This is a "regular" way of declaring and using an internal table. It is created locally.
*A local types declaration.
TYPES: BEGIN OF t_abc,
  f1(20) TYPE c,
END OF t_abc.

*A local internal table and a work area based on a local types declaration.
DATA: lt_abc  TYPE TABLE OF t_abc,
      lwa_abc TYPE t_abc.

CLEAR lwa_abc.
lwa_abc-f1 = 'Hasani'.
APPEND lwa_abc TO lt_abc.
CLEAR lwa_abc.
lwa_abc-f1 = 'Narsani'.
APPEND lwa_abc TO lt_abc.
CLEAR lwa_abc.
lwa_abc-f1 = 'Balisani'.
APPEND lwa_abc TO lt_abc.

FORMAT COLOR 5.
WRITE: / 'Data of the local internal table:'.
FORMAT COLOR OFF.
ULINE.
LOOP AT lt_abc INTO lwa_abc.
  WRITE: / lwa_abc-f1.
ENDLOOP.
ULINE.

*This block of code utilizes a "global" internal table, a table type.
*When creating a local internal table, I am using TYPE TABLE OF keywords. Below a simple TYPE is enough because 'zbmierzwi_test_tt' already
*is an internal table, just global. When creating a Table Type's version of a work area, I can use LIKE LINE OF keywords, because each line
*of 'lt_abc2' is a work area.
*Trying to use 'TYPE lt_abc2' wouldn't work as SAP requires a TYPES declaration to be the target of the TYPE for the work area. Here it would
*suggest that 't_abc' is available. Since using TYPE 'zbmierzwi_test_tt' would yield an internal table, instead of a work area, LIKE LINE OF
*is used instead.
DATA: lt_abc2  TYPE zbmierzwi_test_tt,
      lwa_abc2 LIKE LINE OF lt_abc2.

*I do not need to specify which field of the work area I am assigning a value to because 'zbmierzwi_test_tt' is of the Predefined Type and
*only has one field (CHAR of the length of 20).
CLEAR lwa_abc2.
lwa_abc2 = 'Dalisani'.
APPEND lwa_abc2 TO lt_abc2.
CLEAR lwa_abc2.
lwa_abc2 = 'Numisani'.
APPEND lwa_abc2 TO lt_abc2.
CLEAR lwa_abc2.
lwa_abc2 = 'Erisani'.
APPEND lwa_abc2 TO lt_abc2.

FORMAT COLOR 5.
WRITE: / 'Data of the Table Type internal table:'.
FORMAT COLOR OFF.
ULINE.
LOOP AT lt_abc2 INTO lwa_abc2.
  WRITE: / lwa_abc2.
ENDLOOP.
ULINE.

*---Line Type---
*If I want to create a Table Type (a "global" internal table) with multiple fields, I need to select the Line Type option. The Line Type is a
*Structure. I can provide the name of the Structure here and double click it in order to create it - I will be redirected to the panel of a Structure's
*creation. I should create it as usual. After adding all the necessary fields, I should (as usual) provide the Enhancement Category. I should go to
*Extras -> Enhancement Category... -> "Can be enhanced (character-type or numeric)" is a good option!
*When declaring a work area I can either make it LIKE LINE OF the local implementation of my global internal table or TYPE of the Structure I
*created to be the Line Type of my Table Type (the global internal table).
DATA: lt_abc3 TYPE zbmierzwi_test_tt2,
*      lwa_abc3 LIKE LINE OF lt_abc3
      lwa_abc3 TYPE zsbmierzwinski.

CLEAR lwa_abc3.
lwa_abc3-empno = 1.
lwa_abc3-ename = 'Sylasani'.
lwa_abc3-empdesig = 'Junior Developer'.
APPEND lwa_abc3 TO lt_abc3.

CLEAR lwa_abc3.
lwa_abc3-empno = 2.
lwa_abc3-ename = 'Elusani'.
lwa_abc3-empdesig = 'Developer'.
APPEND lwa_abc3 TO lt_abc3.

CLEAR lwa_abc3.
lwa_abc3-empno = 3.
lwa_abc3-ename = 'Measani'.
lwa_abc3-empdesig = 'Senior Developer'.
APPEND lwa_abc3 TO lt_abc3.

FORMAT COLOR 5.
WRITE: / 'Data of the Table Type internal table of the Line Type:'.
FORMAT COLOR OFF.
ULINE.
LOOP AT lt_abc3 INTO lwa_abc3.
  WRITE: / lwa_abc3-empno,
           lwa_abc3-ename,
           lwa_abc3-empdesig.
ENDLOOP.
ULINE.
******************************************************************

*----------------------------------------------------------------------*
*       VIEWS
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*A View is a reusable dictionary object which doesn't exist physically - it is a virtual (an "imaginary") table. The View is populated with the
*data during the runtime, it does not hold any data be default. A regular table on the other hand exists physically and strores the data physically.
*Views are used for hiding the original tables' names, fields' names, restricting access to a table's data or to read data from multiple tables.
*A View allows me to get the dprvifiv fields from different tables and put them in a single object, but it can also refer to just a single table.
*Once a View is created, it is a reusable dictionary object and I can use it my repository objects (programs). E.g. in order to fetch the data from
*multiple tables, I need to use a Select Statement with a Join. Using Joins is complex and using too many of them will degrade the performance of
*the program. Creating a View on top of multiple tables allows me to avoid using Joins - I select the data from the View which functions as as
*table that stores all the fields from different tables I would need to use a Join to get without a View.
*SE11 Views are being replaced by CDS Views. For the advantages of the latter over the former refer to:
*https://answers.sap.com/questions/13027498/what-is-the-difference-between-cds-view-database-v.html
*There are four kinds of Views in ABAP dictionary:
*1) Database View - can be created either on a single or on multiple tables. It supports both the projection and the selection. The projection is
*                   a process of selecting only the required fields - if I have a table with 200 fields and I only want 4 of them exposed, I can
*                   create a View for that - that's projection. The selection is a process of imposing conditions on accessing the table's
*                   data. If that View is created on a single table, then the maintenance status can either be "Read only" (the only database
*                   operation I can perform is read) or "Read and Change" (all database operations are allowed). The changes made to the data at the
*                   level of the View will be automatically reflected in the corresponding database table. If the View is created on multiple
*                   tables, it is always "Read only". A Table Maintenance cannot be generated for a Database View. Whenever I create a View based
*                   on multiple tables, I need to provide the Join conditions - I need to compare logically related fields, just like with a regular
*                   Join. Failing to do so will result in a "Cartesian product'.
*
*                   ---Implementation example - a View on one Table---
*                   In order to create a Database View, I need to go to SE11 and check the 'View' radiobutton, provide the name of my View and 'Create'.
*                   Here I need to select the 'Database view' option and proceed. A short description should be given now. In the 'Table/Join Conditions'
*                   tab I need to supply the name of the table within the 'Tables' section to the left. If I am making a View on just a single
*                   database table, say, KNA1, I do not need to give any Join conditions in the section to the right.
*                   Now I should proceed to the 'View Flds' tab and name the required fields. This process of called Projection - I am providing the
*                   full list of fields I want my View to have. I don't need to write all the desired fields manually, I can push the 'Table fields'
*                   button and SAP will give me a complete list of all the fields of the table/s I named previously to choose from. It is recommended
*                   (not compulsory) I select all the key fields. After choosing the desired fields, I am welcome to change their names - these changes
*                   are limited to the View and do not translate to the table it has come from. Moving on I should go to the 'Selection Conditions' tab
*                   in order to decide what kind of records I want loaded into my View (e.g. only the records with the country code of Japan). I should
*                   provide the name of the table on whose field the condition will be placed, the field itself, the oparator deciding what kind of a
*                   comparison will be used, the value of the comparison and I can also specify the AND/OR values in case I want more than a single
*                   condition. It essentially works like a WHERE clause of a SELECT statement.
*                   In the 'Maint.Status' tab I can see the radiobuttons 'read only' and 'read and change'. Changes made to the data within my View
*                   will be reflected in the base table. 
*                   
*                   ---Implementation example - a View on multiple Tables---
*                   If the data I am interested in is stored in many tables, I can have my View combine the required fields from all these tables into
*                   a single object. The way of creating such a View is almost the same as described above, for a database View on one table, but in the
*                   'Table/Join Conditions' tab I need to supply the names of all the tables I will be taking the data from complete with Join conditions
*                   for these tables. Failing to provide the Join conditions would result in a 'Cartesian product' which is a collection of all possible
*                   pairs, e.g. if I have a table A with values {1, 2 } and a table B with values {3, 4, 5}, then the 'Cartesian product' of A and B is
*                   {(1, 3), (1, 4), (1, 5), (2, 3), (2, 4), (2, 5)}.
*                   A database View created on multiple tables utilizes an inner join. Each entry of the left hand side table will be compared with the
*                   row of the right hand side table. If the matching is found - only then that entry will be included.
*                   Since the View here is being created on multiple tables, the only possible 'Maint.Status' is 'Read only'. I cannot change the content
*                   of the tables my View is created on if it's not just a single table.
*                   When I am providing conditions in the "WHERE clause" ('Selection Conditions' tab), I need to make sure I am providing the 'Comparison
*                   Value' correctly - e.g. if I want a VBELN here, I need to make sure the value has enough leading 0s added to it so that there is exactly
*                   10 digits. That means '0000000666' instead of '666'. This wouldn't be a problem in a SELECTION-SCREEN, as '666' would be accepted and
*                   understood, but here I need to be specific.

******************************************************************
*The below piece of code with a select with an inner join works exactly the same as the piece of code below it, with the structure that includes the
*View that has been created. The View is on tables VBAK and VBAP joined by MANDT and VBELN. The list of fields included is the same as the list of
*fields included in 't_sales'.
*A piece of code with a join.
TYPES: BEGIN OF t_sales,
  vbeln TYPE vbak-vbeln,
  erdat TYPE vbak-erdat,
  erzet TYPE vbak-erzet,
  ernam TYPE vbak-ernam,
  posnr TYPE vbap-posnr,
  matnr TYPE vbap-matnr,
END OF t_sales.

DATA: lt_sales TYPE STANDARD TABLE OF t_sales,
      lwa_sales TYPE t_sales.

SELECT vbak~vbeln vbak~erdat vbak~erzet vbak~ernam posnr matnr
  FROM vbak INNER JOIN vbap
    ON vbak~vbeln = vbap~vbeln
      INTO TABLE lt_sales
        WHERE vbak~vbeln IN ( '2770200001', '2770200002' ). "The values are exemplary and may vary depending on the system.

IF sy-subrc = 0.
  WRITE: / 'Number of records: ',sy-dbcnt.
  LOOP AT lt_sales INTO lwa_sales.
    WRITE: / lwa_sales-vbeln,
             lwa_sales-erdat,
             lwa_sales-erzet,
             lwa_sales-ernam,
             lwa_sales-posnr,
             lwa_sales-matnr.
  ENDLOOP.
ENDIF.
ULINE.

*A piece of code without a join, utilizing a View. The TYPES declaration is a little bit different when I want to INCLUDE a structure within. There
*should be a point, not a comma, preceding the INCLUDE keyword and there needs to be a point afterwards. If the end of the TYPES occurs after the
*INCLUDE, then I need to add TYPES again.
*In the SELECT itself I do not need to add the conditions (the WHERE clause) as it is already defined in the View itself in the 'Selection Conditions'
*tab. They are the same as used in the piece of code above.
TYPES: BEGIN OF t_sales2.
  INCLUDE TYPE zbmviewtest2.
TYPES END OF t_sales2.

DATA: lt_sales2 TYPE STANDARD TABLE OF t_sales2,
      lwa_sales2 TYPE t_sales2.

SELECT * FROM zbmviewtest2 INTO TABLE lt_sales2.

IF sy-subrc = 0.
  WRITE: / 'Number of records: ',sy-dbcnt.
  LOOP AT lt_sales2 INTO lwa_sales2.
    WRITE: / lwa_sales2-vbeln,
             lwa_sales2-erdat,
             lwa_sales2-erzet,
             lwa_sales2-ernam,
             lwa_sales2-posnr,
             lwa_sales2-matnr.
  ENDLOOP.
ENDIF.
ULINE.
******************************************************************

*2) Projection View - the main idea behind Projection Views is to hide the original table's fields. A Projection View can be created only on one table.
*                     It does not support Selection which means I cannot limit the number of the base table's records that will be included in the View.
*                     All of the table's data will be available. Essentially, the Projection Views do not allow their version of the WHERE clause. A 
*                     Projection View can be used if I want to expose all of the table's data but with the limited number of fields displayed.
*                     If I want to create a Projection View and have already provided the ever present short description, I need to supply the name of
*                     the 'Basis Table' in the 'View Fields' tab and select the desired fields via 'Table fields' button.
*                     Since the Projection Views are created on a single table, they can be either 'Read only' or 'Read and change' in the 
*                     'Maintenance Status' tab. The changes to the data through the Projection View will be reflected in the base table.
*                     I cannot generate Table Maintenance for a Projection View.
*
*3) Maintenance View - can be created on one or multiple tables. The main purpose of the Maintenance View is to grant access to multiple tables' data
*                      through a single object (the Maintenance View being that object). The difference between the Maintenance View and the
*                      Database View is that the Maintenance View allows for the generation of the Table Maintenance while the Database View does not.
*                      Moreover, the Database View requires me to provide the Join condition if I am creating it on multiple tables. In case of the
*                      Maintenance View I can select multiple tables which have a foreign key relationship and this the Join condition will be
*                      provided by SAP itself. For example, if I created a Maintenance View on VBAK and wanted to add more tables to the list, I cannot
*                      do so manually. After having provided the first table's name in the 'Tables' section in the 'Table/Join Conditions' tab, I can
*                      only press the 'Relationships' pushbutton below the section. SAP will provide me with a complete list of all tables with
*                      which VBAK has a foreign key relationship. When I select a table, Join conditions will be provided for me, e.g. if I selected
*                      KNA1, SAP would join the two tables by MANDT and KNA1's KUNNR being compared with VBAK's KNKLI.
*                      Both the Projection and the Selection are supported.
*                      In case of the Maintenance View, even if I am creating the View on multiple tables, both reading and modifying the data is
*                      possible which means the changes made to the data through the View will be reflected in the base tables. In the 'Maint.Status'
*                      tab I have four 'Access' options to choose from. 'Read only' allows for reading alone, 'Read, change, delete and insert' allows
*                      for all four of the database operations, 'Read and change' lets me read and modify the data. The fourth is not relevant at the
*                      moment.
*                      For the Maintenance View it is mandatory to generate the Table Maintenance. Maintenance View cannot be used in SELECT queries.
*                      It is to be used from the Table Maintenance level. Maintenance View is used to link all the dependent tables and maintain them
*                      as a single object. This is called a 'View Cluster'.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*SENDING EMAIL WITH BCS.
*---------------------------------------------------------------------------------------------------------------------------------

DATA: lv_subject    TYPE so_obj_des VALUE 'Email subject',
      lv_sender     TYPE ad_smtpadr VALUE 'bartosz.mierzwinski@cedc.com',
      it_email_body TYPE bcsy_text,
      it_receivers  TYPE bcsy_smtpa.

*I need to send the information to proper class and methods. For that, I need declarations:
DATA: obj_docu           TYPE REF TO cl_document_bcs,
      obj_sender         TYPE REF TO if_sender_bcs,
      obj_sender_request TYPE REF TO cl_bcs,
      obj_receivers      TYPE REF TO if_recipient_bcs.

it_email_body = VALUE #( ( line = 'Configuration Fails Notification' )
                         ( line = 'Please, call someone' ) ).

it_receivers = VALUE #( ( 'bartosz.mierzwinski@cedc.com' ) ).

*To send the email...
*Creating the document to be sent.
TRY.
  obj_docu = cl_document_bcs=>create_document(
    EXPORTING
      i_type         = 'HTM'
      i_text         = it_email_body
      i_subject      = lv_subject ).

*Sender.
  obj_sender = cl_cam_address_bcs=>create_internet_address(
    EXPORTING
      i_address_string = lv_sender ).

*Preparing the request.
*The sender for the request.
  obj_sender_request = cL_bcs=>create_persistent( ).
  CALL METHOD obj_sender_request->set_sender
    EXPORTING
      i_sender = obj_sender.

*The document for the request - which document needs to be sent?
  CALL METHOD obj_sender_request->set_document
    EXPORTING
      i_document = obj_docu.

*Receiver for the request. It's within a loop because I specified the e-mail address within an internal table.
  LOOP AT it_receivers INTO DATA(wa_receivers).
    obj_receivers = cl_cam_address_bcs=>create_internet_address(
      EXPORTING
        i_address_string = wa_receivers ).

    CALL METHOD obj_sender_request->add_recipient
      EXPORTING
        i_recipient  = obj_receivers
        i_express    = 'X'. "Send immediately!
  ENDLOOP.

  CALL METHOD obj_sender_request->send
    EXPORTING
      i_with_error_screen = 'X'
    RECEIVING
      result              = DATA(lv_sent).
  COMMIT WORK.
  CATCH cx_bcs INTO DATA(obj_exception).
ENDTRY.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------