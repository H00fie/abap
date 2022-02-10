*---------------------------------------------------------------------------------------------------------------------------------
*PARAMETERS.
*---------------------------------------------------------------------------------------------------------------------------------

TABLES: zbm_order.

PARAMETERS: p_order TYPE zbm_order-order_num, "Variable names of the parameters has to be maximum of 8 characters' length.
            p_mat   TYPE zbm_order-material.

SELECT * FROM zbm_order WHERE order_num = p_order AND material = p_mat.
  WRITE: zbm_order-order_num, zbm_order-creation_date, 25(20) zbm_order-cust_name, 44 zbm_order-item.
ENDSELECT.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------------------------------------------------
*PURCHASE ORDER TABLE. TWO PRIMARY KEYS.
*---------------------------------------------------------------------------------------------------------------------------------

*The table had two columns set as Primary Keys, it is then called a Composite Primary Key.
TABLES: zbm_porder.

PARAMETERS: p_order TYPE zbm_porder-order_num,
            p_mat   TYPE zbm_porder-material.

SELECT * FROM zbm_porder WHERE order_num = p_order AND material = p_mat.
  WRITE: / zbm_porder-order_num, zbm_porder-line, zbm_porder-material.
ENDSELECT.

*---------------------------------------------------------------------------------------------------------------------------------
*END OF PROGRAM.
*---------------------------------------------------------------------------------------------------------------------------------