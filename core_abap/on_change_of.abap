*---------------------------------------------------------------------------------------------------------------------------------
*A HIERARCHIAL REPORT.
*---------------------------------------------------------------------------------------------------------------------------------

*An exercise program with the following requirements:
*- default the sales document input values to from 10 to 100,
*- restrict the user to enter only a single range,
*- fetch the corresponding header and item data of sales orders and display it in a hierarchial sequential list.

DATA: v_vbeln TYPE vbak-vbeln.

SELECT-OPTIONS so_vbeln FOR v_vbeln DEFAULT 10 TO 100 NO-EXTENSION. "Both 'I' and string value types will do for DEFAULT.

*I will be taking 'vbeln', 'erdat', 'erzet' and 'ernam' from VBAK and 'vbeln', 'posnr', 'matnr' and 'netwr' from VBAP.
*It is recommended that the fields are selected in the same sequence they are placed within the database table.
*I will need two internal tables, because I need multiple header records and multiple item records.
TYPES: BEGIN OF t_sales_header,
        vbeln TYPE vbak-vbeln,
        erdat TYPE vbak-erdat,
        erzet TYPE vbak-erzet,
        ernam TYPE vbak-ernam,
END OF t_sales_header.

DATA: it_sales_header TYPE TABLE OF t_sales_header,
      wa_sales_header TYPE t_sales_header.

TYPES: BEGIN OF t_sales_items,
        vbeln TYPE vbap-vbeln,
        posnr TYPE vbap-posnr,
        matnr TYPE vbap-matnr,
        netwr TYPE vbap-netwr,
END OF t_sales_items.

DATA: it_sales_items TYPE TABLE OF t_sales_items,
      wa_sales_items TYPE t_sales_items.

START-OF-SELECTION.
*First I am getting the data for the header of every document.
  PERFORM get_header_data.
*If data is there, for every document that's in the header table - I am getting the data for all the items included in that document.
  IF it_sales_header IS NOT INITIAL.
    PERFORM get_item_data.
  ENDIF.

*Both of the above functions simply select the data. So I've got two tables, hopefully filled with data, prepared for me to process
*further.
*I want to display a record from the header table, all the items for that document and only then the next record from the header table
*and so on.
  PERFORM display_data.

*&---------------------------------------------------------------------*
*&      Form  get_header_data
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM get_header_data.
  SELECT vbeln erdat erzet ernam
    FROM vbak
    INTO TABLE it_sales_header
    WHERE vbeln IN so_vbeln.
ENDFORM.                    "get_header_data

*&---------------------------------------------------------------------*
*&      Form  get_item_data
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*This is the optimal solution, without a SELECT in a LOOP.
*FOR ALL ENTRIES does the same thing, but does not require a loop. The SELECT statement is performed only once and SAP, instead of taking
*'vbelns' from 'wa_sales_header' one by one and performing a separate loop for them all, carries out a single SELECT during which it takes
*all desired data in one fell swoop.
FORM get_item_data.
  SELECT vbeln posnr matnr netwr
    FROM vbap
    INTO TABLE it_sales_items
    FOR ALL ENTRIES IN it_sales_header
    WHERE vbeln = it_sales_header-vbeln.
ENDFORM.

**The below solution is correct and gives the expexted results, but performing a SELECT statement inside the loop is not recommended. If
**a loop goes around 300 times, SELECT will be performed 300 times, increasing the network traffic, increasing the load on the database
**server and thus decreasing the overall performance.
*FORM get_item_data.
*  LOOP AT it_sales_header INTO wa_sales_header.
*    SELECT vbeln posnr matnr netwr
*      FROM vbap
**If I used INTO TABLE here, it would be overwriting the previously selected record
**with every loop. APPENDING TABLE appends every selected records to the table before
**moving on to the next one.
*      APPENDING TABLE it_sales_items
**INTO TABLE it_sales_items
*      WHERE vbeln = wa_sales_header.
*  ENDLOOP.
*ENDFORM.                    "get_item_data

*&---------------------------------------------------------------------*
*&      Form  display_data
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*In the below solution I am looping through the item table data only and every time a 'vbeln' changes (when the loop takes on a new 'vbeln'),
*ON CHANGE OF event is triggered. When that happens, READ TABLE places a record of the header table into the header work area and chooses what
*record it picks by comparing it to the currently processed 'vbeln' in the item table. Due to this section being placed at the start of the code,
*the data from the header table will be displayed first.
*When this is done, the loop proceeds to print out the data of the currently processed record from the item table. When the loop ends and goes
*back to the beginning - a new record is selected and if a change of 'vbeln' occurs - ON CHANGE OF is triggered again. Item table can contain
*many rows for the same 'vbeln' (document number) so making the reaching for the data from the header table dependant on the change of 'vbeln'
*makes sure that all the data for the current 'vbeln' from the item table will be printed out one after another.
*This solution loops only through the item table and "injects" the data about the same 'vbeln' from the item data table as is being currently
*processed at the beginning of the processing of every new document number ('vbeln').
FORM display_data.
  LOOP AT it_sales_items INTO wa_sales_items.
    ON CHANGE OF wa_sales_items-vbeln.
      CLEAR wa_sales_header.
      READ TABLE it_sales_header INTO wa_sales_header WITH KEY vbeln = wa_sales_items.
      IF sy-subrc = 0.
        FORMAT COLOR 3.
        WRITE: / wa_sales_header-vbeln,
                 wa_sales_header-erdat,
                 wa_sales_header-erzet,
                 wa_sales_header-ernam.
      ENDIF.
    ENDON.
    FORMAT COLOR 7.
    WRITE: / wa_sales_items-vbeln,
             wa_sales_items-posnr,
             wa_sales_items-matnr,
             wa_sales_items-netwr.
    FORMAT COLOR OFF.
  ENDLOOP.
ENDFORM.

**Below solution is correct, but not optimal due to nested loops.
*FORM display_data.
*  SORT it_sales_header BY vbeln.
*  SORT it_sales_items BY vbeln posnr.
*  LOOP AT it_sales_header INTO wa_sales_header.
*    FORMAT COLOR 3.
*      WRITE: / wa_sales_header-vbeln,
*               wa_sales_header-erdat,
*               wa_sales_header-erzet,
*               wa_sales_header-ernam.
**     WHERE clause is possible here! Due to that I will get only the items for the same document
**     that is being processed at the time. Without the WHERE, all items would be displayed,
**     regardless of their document number.
*      LOOP AT it_sales_items INTO wa_sales_items WHERE vbeln = wa_sales_header-vbeln.
*        FORMAT COLOR 7.
*          WRITE: /5 wa_sales_items-vbeln, "'5' means 'leave 5 spaces first'.
*                    wa_sales_items-posnr,
*                    wa_sales_items-matnr,
*                    wa_sales_items-netwr.
*       ENDLOOP.
*  ENDLOOP.
*ENDFORM.                    "display_data

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*CUSTOMERS' COUNTRIES REPORT.
*---------------------------------------------------------------------------------------------------------------------------------

*I want to display customers from various countries, but the country itself I want displayed only once for all the citizens hailing
*from that land.
TYPES: BEGIN OF t_customer,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kna1-land1,
  name1 TYPE kna1-name1,
  ort01 TYPE kna1-ort01,
END OF t_customer.

DATA: it_customer TYPE TABLE OF t_customer,
      wa_customer TYPE t_customer.

SELECT kunnr land1 name1 ort01
  FROM kna1
  INTO TABLE it_customer
  UP TO 500 ROWS.
IF sy-subrc = 0.
*If I didn't sort the results first, I would have multiple separate sections for the same country, because the loop just goes one by
*one through the internal table and triggers ON CHANGE OF with every change. If the first record is DE, the second is PL and the third
*is DE again, I'll have two DE sections. SORTing the table solves that problem on arrival.
  SORT it_customer BY land1.
  LOOP AT it_customer INTO wa_customer.
    ON CHANGE OF wa_customer-land1.
      FORMAT COLOR 4.
      WRITE: / 'Customer country: ', wa_customer-land1.
      FORMAT COLOR OFF.
    ENDON.
    FORMAT COLOR 2.
    WRITE: / wa_customer-kunnr,
             wa_customer-name1,
             wa_customer-ort01.
    FORMAT COLOR OFF.
  ENDLOOP.
ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*SELECT-ENDSELECT.
*---------------------------------------------------------------------------------------------------------------------------------

*I want to retrieve data about customers from three countries using SELECT-ENDSELECT and displaying the country's name only once.

TYPES: BEGIN OF t_customer,
  kunnr TYPE kna1-kunnr,
  land1 TYPE kna1-land1,
  name1 TYPE kna1-name1,
  ort01 TYPE kna1-ort01,
END OF t_customer.

DATA: wa_customer TYPE t_customer.

**SELECT-ENDSELECT is a looping statment. SELECT-ENDSELECT acts like a work area. It will retrieve one record after another and
**print them before moving back to taking another record. Every loop is another request to the database server. Every following
**record is overwriting the previous one because I am using a work area and not an internal table.
**The records selected from the database table are grouped by the country's key which means they are sorted. Then every record
**is being displayed and the loop goes back to the beginning to process another record. Every time my loop encounteres a new
**country's key ('land1') - that key is being displayed and the loop goes back to its standard processing of the records.
*SELECT kunnr land1 name1 ort01
*  FROM kna1
*  INTO wa_customer
*  WHERE land1 IN ('AR', 'AU', 'BE')
*  ORDER BY land1. "This is the equivalent of SORT which I cannot use here because I have no table to SORT.
*    ON CHANGE OF wa_customer-land1.
*      FORMAT COLOR 2.
*      WRITE: / 'Country key: ', wa_customer-land1.
*      FORMAT COLOR OFF.
*    ENDON.
*  FORMAT COLOR 5.
*  WRITE: / wa_customer-kunnr,
*           wa_customer-name1,
*           wa_customer-ort01.
*  FORMAT COLOR OFF.
*ENDSELECT.

**SELECT-ENDSELECT will act as a loop and every SELECT will request a single record which means that a lot of requests to the database
*will be sent which is a performance issue. The usage of SELECT-ENDSELECT is discouraged.
*Instead, an internal table should be used. ORDER BY also increases the load on the database because it attempts to perform the sorting
*on the database itself so it should be avoided (it attempts to perform the sorting during the data retrieval itself). Instead, I should
*fetch the data into the internal table and SORT it.

*To create the internal table that wasn't here before.
DATA: it_customer TYPE TABLE OF t_customer.

*The select is executed only once and all the data comes to my internal table in one fell swoop. No ENDSELECT is required because I am
*inserting the retrieved data into an internal table, not a work area, so SAP does not need to send multiple requests to the database
*server as the structure where it keeps the retrieved data no longer can conatin but a single record as was the case with a work area.
SELECT kunnr land1 name1 ort01
  FROM kna1
  INTO TABLE it_customer
  WHERE land1 IN ('AR', 'AU', 'BE').
    IF sy-subrc = 0.
      SORT it_customer BY land1.
      LOOP AT it_customer INTO wa_customer.
        ON CHANGE OF wa_customer-land1.
          FORMAT COLOR 2.
          WRITE: / 'Country key: ', wa_customer-land1.
          FORMAT COLOR OFF.
        ENDON.
          FORMAT COLOR 5.
          WRITE: / wa_customer-kunnr,
                   wa_customer-name1,
                   wa_customer-ort01.
          FORMAT COLOR OFF.
      ENDLOOP.
    ELSE.
      WRITE: / 'No data available.'.
    ENDIF.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------