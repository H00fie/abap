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



*---------------------------------------------------------------------------------------------------------------------------------
*PURCHASE ORDERS.
*---------------------------------------------------------------------------------------------------------------------------------

*********************************************
*PURCHASE ORDER HEADER CDS VIEW.
*********************************************
//Specifies the view in the database.
@AbapCatalog.sqlViewName: 'ZIPurHdr1'
//The filter conditions of the path expression are compared. If they are the same, the associated join expression 
//is evaluated only once. If the compareFilter is false, then the associate part is evaluated over and over again.
@AbapCatalog.compiler.compareFilter: true
//CDS View specifies the definition of the key fields to be the same as that of the associated database table's.
@AbapCatalog.preserveKey: true
//The authorization check for the view is required.
@AccessControl.authorizationCheck: #CHECK
//Specifies the label for the CDS View.
@EndUserText.label: 'Purchase Order Header'
//VDM is intended to be interpreted by view browsers and other functionality which is based on the virtual data model.
//A Basic view is directly above the database and only Basic views are allowed to select from the database.
@VDM.viewType: #BASIC
//To expose the view as an oData service. This annotation will create the service for the view in the system.
@OData.publish: true
define view ZI_PurOrderHdr as select from ekko 
 //The purchase order header can have 0 or more purchase items, so the cardinality is from 0 to many.
 //The associated CDS View can have a minimum of 0 and a maximum of unlimitied entries. In my case, there might be 
 //no purchase order items for my header CDS View or there can be an unlimited number of purchase order items.
 //"to" is the equivalent of "from". "on $projection." is a join condition - the "projected" field maps to the
 //associated table's field of(...).  The naming convention is that the alias for the association should always start with the underscore.
    association [0..*] to ZI_PurOrderItem as _POItem on $projection.PurchaseOrder = _POItem.PurchaseOrder
{

//The key field for the CDS View (the same as the key field of the purchase table itself).
//The aliases used will become the names of the columns.
    key ebeln as PurchaseOrder,
//PurchaseOrderTypes' name's are just short codes. I can replace these codes with custom names to improve
//the understanding of their meanings. A case statement can be used for it.
//First, I specify the operand which I want evaluated ('bsart' in the bracket). After "when" comes the
//condition and after "then" comes the result. The result of the case comes as the field specified after
//the "as" keyword.
//The below section with "case" replaced a simple "bsart as PurchaseOrderType,".
            case(bsart)
                when 'RQ' then 'External Quotation'
                when 'UB' then 'Stock transport order'
                else 'Other order'
            end as PurchaseOrderType,
        ekorg as PurOrganization,
        ekgrp as PurGroup,
        lifnr as Supplier,
        waers as DocCurrency,
        aedat as CreationDate,
//The annotation here is "exposing the association". Purchase Order Item CDS View is the child view here.
//Since the association is exposed, the OData service (courtesy of @OData(...)) will receive the association's
//metadata.
        @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
        _POItem
    
}

*********************************************
*PURCHASE ORDER ITEMS CDS VIEW.
*********************************************
@AbapCatalog.sqlViewName: 'ZIPurItm1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Order Item'
define view ZI_PurOrderItem as select from ekpo
 //One purchase order item can belong to just a single purchase order header hence the
 //cardinality is 1 to 1.
    association [1..1] to ZI_PurOrderHdr as _POHdr on $projection.PurchaseOrder = _POHdr.PurchaseOrder
//An additional association to a material providing CDS View. For each purchase order item there is only
//one material, hence the cardinality.
    association [1..1] to Z007_DEMO_ASSOCIATION as _Material on $projection.Material = _Material.Material
{
    
    key ebeln as PurchaseOrder,
    key ebelp as PurchaseOrderItem,
        matnr as Material,
//From the second association.
        _Material.MaterialType as MaterialType,
        txz01 as POItemText,
        matkl as MaterialGroup,
        werks as Plant,
        lgort as StorageLocation,
//A quantity field requires us to specify which field should be referred to for its unit. E.g. in
//'ekpo' 'menge' references 'meins' (from 'ekpo') as its unit. In CDS Views it's done with annotations.
//The quantity refers its units field by its name.
        @Semantics.quantity.unitOfMeasure: 'OrderUnit'
        menge as OrderQuantity,
//To inform the system that 'meins' contains the unit.
        @Semantics.unitOfMeasure: true
        meins as OrderUnit,
        netpr as NetPrice,
//Cast operations can be used for determining the type of the calculated field or for converting
//the type of the existing fields on the database level.
//The syntax starts from the specifying which field I want to cast and into what data type (what comes
//after the first "as"). In this case the data will be cast into abap floating type of the length of 16
//and multipled in order to have the tax amount included. The result is stored in the new field
//(TaxAmount) which does not exist in the database. Hence it's called a calculated field. I am
//adding a new field, not changing any existing one.
        cast( netpr as abap.fltp(16) ) * 0.35 as TaxAmount,
        netwr as NetOrderValue,
 //I can use arithmetic operations here as well, e.g. say I have a 25% discount  on the net value. 
 //"0.75" is a floating point type, so I need to cast the 'netwr' to a 'fltp' too. There's a lot
 //of trailing decimal places though.
        cast( netwr as abap.fltp(16) ) * 0.75 as DiscountedNetOrder,
//Numeric functions are also available. I can, e.g. round the DiscountedNetOrder in order to get rid
//of all the trailing decimal places. All the calculations in the CDS View are performed in the
//database layer, thus the application logic is pushed to the database layer.
        ceil(cast( netwr as abap.fltp(16) ) * 0.75) as DiscountedRoundedNetOrd,
//String functions can also be utilized.
        concat_with_space( werks, lgort, 1) as StorageDetails,
//Purchase order item is the child, so the header is the parent. The header is also the
//root view.
        @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
        _POHdr,
        _Material
       
}

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*ASSOCIATIONS.
*---------------------------------------------------------------------------------------------------------------------------------

@AbapCatalog.sqlViewName: 'ZDEMOASSOCIATION'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'demo association'
define view Z007_DEMO_ASSOCIATION as select from mara {

    key matnr as Material,
        mtart as MaterialType,
        meins as BaseUnit
    
}

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*UNIONS.
*---------------------------------------------------------------------------------------------------------------------------------

@AbapCatalog.sqlViewName: 'zuniondemo'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'demo union cds'
//A list of materials for which there is a purchase requisition or a purchase order for a specific plant.
//'eban' is a purchase requisition database table.
define view Z007_DEMO_UNION as select from eban {
    
    matnr as material
    
}
//A specific plant.
where werks = '0002'

//Union has selects from two different tables.
union

//To combine the materials from the purchase requisition table and the purchase order table (ekpo).
select from ekpo {

    matnr as material

}
where werks = '0002'

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*JOINS.
*---------------------------------------------------------------------------------------------------------------------------------

@AbapCatalog.sqlViewName: 'zdemojoin'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'demo join cds'
//To get a list of purchase order items created from purchase requisitions. The purchase order item table (ekpo) has a purchase requisition
//reference in 'banfn' and 'bnfpo' (both are key fields for 'eban').
define view Z007_DEMO_JOIN as select from ekpo as po
//I want only the records from the purchase order table which are created from the purchase requisitions so an inner join it is.
inner join eban as pr
on po.banfn = pr.banfn
and po.bnfpo = pr.bnfpo {
    
    po.ebeln as PONum,
    po.matnr as Material,
    pr.banfn as PRNum,
    pr.bnfpo as PRItemNum
    
}

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------