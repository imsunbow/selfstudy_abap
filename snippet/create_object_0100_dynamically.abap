*&---------------------------------------------------------------------*
*&      Form  CREATE_OBJECT_0100
*&---------------------------------------------------------------------*
*       Create and display simple ALV grid with dynamic columns
*----------------------------------------------------------------------*
FORM CREATE_OBJECT_0100 .

  DATA: LS_FIELDCAT TYPE LVC_S_FCAT,
        LV_NEXT_YR  TYPE N LENGTH 4,
        LV_NEXT_MO  TYPE N LENGTH 2,
        LV_IDX      TYPE I,
        LV_CURR_KEY TYPE CHAR6,
        LV_MON_STR  TYPE CHAR6.

  " Initialize start period
  LV_CURR_KEY = SO_PERIOD-LOW.
  LV_MON_STR  = LV_NEXT_MO.

  IF GO_DOCKING_CONTAINER IS INITIAL.

   " Create ALV docking container (top-docked, 2000px height)
   " REPID/DYNNR: current report/screen number for embedding

    CREATE OBJECT GO_DOCKING_CONTAINER
      EXPORTING
        REPID     = SY-REPID
        DYNNR     = SY-DYNNR
        SIDE      = GO_DOCKING_CONTAINER->DOCK_AT_TOP
        EXTENSION = 2000.

    " Create ALV grid
    CREATE OBJECT GO_GRID
      EXPORTING
        I_PARENT = GO_DOCKING_CONTAINER.

    " ALV layout settings
    GS_LAYOUT-GRID_TITLE = 'Assignment Overview'.
*    GS_LAYOUT-CWIDTH_OPT = 'X'. " Column width optimization (may truncate dynamic columns)
    GS_LAYOUT-CTAB_FNAME = 'CELLCOLOR'. " Cell background color field. must exist in the GT_RESULT(OUTPUT) structure.

    " Static columns: FIELDNAME 1,2
    LS_FIELDCAT-FIELDNAME = 'FIELD_NAME1'.
    LS_FIELDCAT-COLTEXT   = 'FIELDNAME-TEXT1'.
    LS_FIELDCAT-OUTPUTLEN = 10. " statically assign output length
    APPEND LS_FIELDCAT TO GT_FIELDCAT.
    CLEAR LS_FIELDCAT.

    LS_FIELDCAT-FIELDNAME = 'FIELD_NAME2'.
    LS_FIELDCAT-COLTEXT   = 'FIELDNAME-TEXT2'.
    LS_FIELDCAT-OUTPUTLEN = 15. 
    APPEND LS_FIELDCAT TO GT_FIELDCAT.
    CLEAR LS_FIELDCAT.

    " Dynamic month columns (UP TO 12 months)
    DO GV_DIFF_MONTHS TIMES. " We've got to save our GV_DIFF_MONTHS from check_date_form
      LV_IDX = SY-INDEX.
      LS_FIELDCAT-FIELDNAME  = |COL{ LV_IDX }|.
      LS_FIELDCAT-COLTEXT    = LV_CURR_KEY. " Label: YYYYMM
      LS_FIELDCAT-OUTPUTLEN  = 6. " Statically assign output length cause we need to ensure full visibility output fieldname to our client

      " Calculate next month
      LV_NEXT_YR = LV_CURR_KEY(4).
      LV_NEXT_MO = LV_CURR_KEY+4(2) + 1.

      IF LV_NEXT_MO > 12.
        LV_NEXT_YR = LV_NEXT_YR + 1.
        LV_NEXT_MO = 1.
      ENDIF.

      LV_CURR_KEY = |{ LV_NEXT_YR }{ LV_NEXT_MO WIDTH = 2 PAD = '0' }|.

      APPEND LS_FIELDCAT TO GT_FIELDCAT.
      CLEAR LS_FIELDCAT.
    ENDDO.

    " Optional static columns: Fieldname such as start/end period, remarks, etc.
    LS_FIELDCAT-FIELDNAME = 'FIELDNAME3'.
    LS_FIELDCAT-COLTEXT   = 'FIELDNAME-TEXT3'.
    LS_FIELDCAT-OUTPUTLEN = 6.
    APPEND LS_FIELDCAT TO GT_FIELDCAT.
    CLEAR LS_FIELDCAT.

    LS_FIELDCAT-FIELDNAME = 'FIELDNAME4'.
    LS_FIELDCAT-COLTEXT   = 'FIELDNAME-TEXT4'.
    LS_FIELDCAT-OUTPUTLEN = 6.
    APPEND LS_FIELDCAT TO GT_FIELDCAT.
    CLEAR LS_FIELDCAT.

    " Bind table and field catalog to grid
    GO_GRID->SET_TABLE_FOR_FIRST_DISPLAY(
      EXPORTING
        IS_LAYOUT       = GS_LAYOUT
      CHANGING
        IT_OUTTAB       = GT_RESULT
        IT_FIELDCATALOG = GT_FIELDCAT ).

  ENDIF.

ENDFORM.

--------------------------- Expected output example  ---------------------------------------------

+---------+-----------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
| FIELD1  | FIELD2    | 202401 | 202402 | 202403 | 202404 | 202405 | 202406 | 202407 | 202408 | 202409 | 202410 | 202411 | 202412 | FIELD3 | FIELD4 |
+---------+-----------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
| NAME1   | Project1 | 진행    | 진행    | 종료    |        |        |        |        |        |        |        |        |        | 202401 | 202403 |
| NAME2     | ProjectB |        | 진행    | 진행   | 진행  | 종료    |        |        |        |        |        |        |        | 202402 | 202405 |
+---------+-----------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+

