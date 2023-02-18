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