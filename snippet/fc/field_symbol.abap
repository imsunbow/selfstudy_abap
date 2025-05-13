DATA : LV_FIELDNAME TYPE STRING.

FIELD-SYMBOLS : <LS_ROW> TYPE ANY, " Adjust type based on your structure
                <LV_VALUE> TYPE ANY. " Adjust type based on your structure 
                
LV_FIELDNAME = 'ZTARGET'. " Set the target field name

LOOP AT GT_RESULT ASSIGNING <LS_ROW>.

    " Dynamically assign the target field in the current row
    ASSIGN COMPONENT LV_FIELDNAME OF STRUCTURE <LS_ROW> TO <LV_VALUE>

    IF SY-SUBRC = 0 AND <LV_VALUE> IS ASSIGNED.
      CONTINUE. " Skip this row if field not found or assignment failed

      " Example : Set default value if field is initial
      IF <LV_VALUE> IS INITIAL. " If field data is empty
        <LV_VALUE> = '1000' " Set default value to target field
      ENDIF.

    ENDIF.
    
ENDLOOP.
