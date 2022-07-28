*---------------------------------------------------------------------------------------------------------------------------------
*EMPLOYEES REPORT.
*---------------------------------------------------------------------------------------------------------------------------------

*As the CDS view I have created does not have a key, WITH EMPTY KEY is required.
DATA: lt_so_emp_cdsv TYPE STANDARD TABLE OF z_cdsview_demo01 WITH EMPTY KEY.

*Instead of the below, I could also declare the data within the syntax of the select:
*"(...) into table @Data(lt_so_emp_cdsv)."
*Using OpenSQL like that allows me to get the data stored within the CDS view.
SELECT * FROM z_cdsview_demo01 INTO TABLE lt_so_emp_cdsv.

*This is a standard SAP class used for the displaying of the output.
cl_demo_output=>display(
    EXPORTING
        data = lt_so_emp_cdsv
        name = 'so and employees list' ).
		
*********************************************
*THE CDS VIEW.
*********************************************
@AbapCatalog.sqlViewName: 'Z_CDSView_DEMO01' //The name needs to be shorter than 16 characters' long.
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'demo view 1'
define view Z_DEMO_JOIN_01 as select from snwd_so
inner join snwd_employees
on snwd_so.created_by = snwd_employees.node_key {
    
	//With the inner join displayed will be what's common for both the tables.
    //Only the fields that match the criteria ("on" section) will be displayed.
    //There needs to be a match between both tables for them to be displayed.
    //If there is no match both tables' data for that particular row is omitted.
    snwd_so.so_id,
    snwd_so.gross_amount,
    snwd_employees.first_name,
    snwd_employees.last_name,
    snwd_employees.email_address
    
}

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*EMPLOYEES AND BUSINESS PARTNERS REPORT.
*---------------------------------------------------------------------------------------------------------------------------------

DATA: lt_so_emp_cdsv TYPE STANDARD TABLE OF z_cdsview_demo02 WITH EMPTY KEY.

SELECT * FROM z_cdsview_demo02 INTO TABLE lt_so_emp_cdsv.

cl_demo_output=>display(
    EXPORTING
        data = lt_so_emp_cdsv
        name = 'so, employees and business partners list' ).
		
*********************************************
*THE CDS VIEW.
*********************************************
@AbapCatalog.sqlViewName: 'Z_CDSView_DEMO02'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Demo SO Emp and Business Partner'
define view Z_DEMO_JOIN_02 as select from snwd_so 
 //On the stage of the left outer join the data will already have been
 //filtered by the inner join. The result of the inner join will undergo
 //the left outer join.
    inner join snwd_employees
        on snwd_so.created_by = snwd_employees.node_key
 //Left outer join - all the fields in the first table, if found in the
 //second table - the join will happen (based on the joining condition).
 //If there's no match in the second table, the first table's data will
 //be added to the output matched with nulls on the other side.
 //The left outer join is done when the left table's data is required even
 //when there's no match in the right table.   
    left outer join snwd_bpa
        on snwd_so.buyer_guid = snwd_bpa.node_key {
    
    snwd_so.so_id,
    snwd_so.gross_amount,
    snwd_so.currency_code,
    snwd_employees.first_name,
    snwd_employees.last_name,
    snwd_bpa.bp_id as bus_par_id, //The id of the business partner with an alias.
    snwd_bpa.email_address as bus_par_email //The email of the business partner with an alias.
    
}

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------