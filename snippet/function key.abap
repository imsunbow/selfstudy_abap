*------------------------------------------------------------*
* Setup a function key to call a transaction from selection screen
*------------------------------------------------------------*

INITIALIZATION.
  PERFORM set_transaction_key.

AT SELECTION-SCREEN.
  PERFORM call_transaction_on_key.

*---------------------------------------------------------------------*
* FORM set_transaction_key
* Purpose: Register a function key with icon and label
*---------------------------------------------------------------------*
FORM set_transaction_key.
  gs_dyntxt-icon_id     = icon_change.
  gs_dyntxt-icon_text   = 'Maintain Data'.
  gs_dyntxt-quickinfo   = 'Go to maintenance transaction'.
  sscrfields-functxt_01 = gs_dyntxt.
ENDFORM.

*---------------------------------------------------------------------*
* FORM call_transaction_on_key
* Purpose: Call transaction when function key is pressed
*---------------------------------------------------------------------*
FORM call_transaction_on_key.
  IF sscrfields-ucomm = 'FC01'.
    CALL TRANSACTION 'ZHR_MAINTAIN'.
  ENDIF.
ENDFORM.
