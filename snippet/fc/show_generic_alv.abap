FORM SHOW_GENERIC_ALV " Simple alv generation
  USING
    IT_DATA      TYPE STANDARD TABLE
    VALUE(P_FIELD1) TYPE LVC_FNAME
    VALUE(P_TEXT1)  TYPE STRING
    VALUE(P_FIELD2) TYPE LVC_FNAME
    VALUE(P_TEXT2)  TYPE STRING
    VALUE(P_FIELD3) TYPE LVC_FNAME
    VALUE(P_TEXT3)  TYPE STRING
    VALUE(P_CURR)   TYPE LVC_FNAME
    VALUE(P_CURR_TX) TYPE STRING.

  " References for SALV table and its columns 
  DATA: LR_SALV     TYPE REF TO CL_SALV_TABLE, 
        LR_COLUMNS  TYPE REF TO CL_SALV_COLUMNS_TABLE,
        LR_COLUMN   TYPE REF TO CL_SALV_COLUMN.

  " Create ALV object
  TRY.
      CALL METHOD CL_SALV_TABLE=>FACTORY
        IMPORTING
          R_SALV_TABLE = LR_SALV
        CHANGING
          T_TABLE      = IT_DATA.

      " Set column texts
      LR_COLUMNS = LR_SALV->GET_COLUMNS( ).

      " Field 1
      CALL METHOD LR_COLUMNS->GET_COLUMN
        EXPORTING
          COLUMNNAME = P_FIELD1
        RECEIVING
          VALUE      = LR_COLUMN.
      LR_COLUMN->SET_SHORT_TEXT( P_TEXT1 ).
      LR_COLUMN->SET_MEDIUM_TEXT( P_TEXT1 ).
      LR_COLUMN->SET_LONG_TEXT( P_TEXT1 ).

      " Field 2
      CALL METHOD LR_COLUMNS->GET_COLUMN
        EXPORTING
          COLUMNNAME = P_FIELD2
        RECEIVING
          VALUE      = LR_COLUMN.
      LR_COLUMN->SET_SHORT_TEXT( P_TEXT2 ).
      LR_COLUMN->SET_MEDIUM_TEXT( P_TEXT2 ).
      LR_COLUMN->SET_LONG_TEXT( P_TEXT2 ).

      " Field 3 (amount)
      CALL METHOD LR_COLUMNS->GET_COLUMN
        EXPORTING
          COLUMNNAME = P_FIELD3
        RECEIVING
          VALUE      = LR_COLUMN.
      LR_COLUMN->SET_SHORT_TEXT( P_TEXT3 ).
      LR_COLUMN->SET_MEDIUM_TEXT( P_TEXT3 ).
      LR_COLUMN->SET_LONG_TEXT( P_TEXT3 ).
      LR_COLUMN->SET_CURRENCY_COLUMN( P_CURR ).

      " Currency field
      CALL METHOD LR_COLUMNS->GET_COLUMN
        EXPORTING
          COLUMNNAME = P_FIELD4
        RECEIVING
          VALUE      = LR_COLUMN.
      LR_COLUMN->SET_SHORT_TEXT( P_CURR_TX ).
      LR_COLUMN->SET_MEDIUM_TEXT( P_CURR_TX ).
      LR_COLUMN->SET_LONG_TEXT( P_CURR_TX ).

      " Display ALV
      CALL METHOD LR_SALV->DISPLAY.

    CATCH CX_SALV_MSG INTO DATA(LX_SALV).
      MESSAGE 'Error occurred while displaying ALV: ' && LX_SALV->GET_TEXT( ) TYPE 'E'.
  ENDTRY.

ENDFORM.


----- EXPECTED OUTPUT --------

+-------------+----------------+---------------+----------------+
| P_FIELD1    |   P_FIELD2     |    P_FIELD3   |    P_FIELD4    |
+-------------+----------------+---------------+----------------+
| F1-DATA1    |    F2-DATA1    |     F3-DATA1  |   F4-DATA1     |
| F1-DATA2    |    F2-DATA2    |     F3-DATA2  |   F4-DATA2     | 
| F1-DATA3    |    F2-DATA2    |     F3-DATA3  |   F4-DATA3     |
+-------------+----------------+---------------+----------------+
