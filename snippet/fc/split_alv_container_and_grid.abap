*&---------------------------------------------------------------------*
*&      Form  CREATE_SPLIT_ALV
*&---------------------------------------------------------------------*
*       Create split ALV with two containers and grids (LEFT/RIGHT)
*----------------------------------------------------------------------*
FORM CREATE_SPLIT_ALV .

  DATA: LO_SPLITTER      TYPE REF TO CL_GUI_SPLITTER_CONTAINER,
        LO_CONTAINER_LEFT  TYPE REF TO CL_GUI_CONTAINER,
        LO_CONTAINER_RIGHT TYPE REF TO CL_GUI_CONTAINER,
        GO_GRID_LEFT     TYPE REF TO CL_GUI_ALV_GRID,
        GO_GRID_RIGHT    TYPE REF TO CL_GUI_ALV_GRID.

  DATA: LT_FCAT_LEFT  TYPE LVC_T_FCAT,
        LT_FCAT_RIGHT TYPE LVC_T_FCAT.

  " Create splitter container inside custom control 'CC_SPLIT'
  CREATE OBJECT LO_SPLITTER
    EXPORTING
      PARENT  = CL_GUI_CONTAINER=>SCREEN0 " or custom container name (e.g., CC_SPLIT)
      ROWS    = 1
      COLUMNS = 2.

  " Get left and right containers
  CALL METHOD LO_SPLITTER->GET_CONTAINER
    EXPORTING
      ROW    = 1
      COLUMN = 1
    RECEIVING
      CONTAINER = LO_CONTAINER_LEFT.

  CALL METHOD LO_SPLITTER->GET_CONTAINER
    EXPORTING
      ROW    = 1
      COLUMN = 2
    RECEIVING
      CONTAINER = LO_CONTAINER_RIGHT.

  " Create left ALV grid
  CREATE OBJECT GO_GRID_LEFT
    EXPORTING
      I_PARENT = LO_CONTAINER_LEFT.

  " Create right ALV grid
  CREATE OBJECT GO_GRID_RIGHT
    EXPORTING
      I_PARENT = LO_CONTAINER_RIGHT.

  " OPTIONAL: Build your field catalogs for each grid
  PERFORM BUILD_FCAT_LEFT  CHANGING LT_FCAT_LEFT.
  PERFORM BUILD_FCAT_RIGHT CHANGING LT_FCAT_RIGHT.

  " Bind data and field catalog to left grid
  CALL METHOD GO_GRID_LEFT->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      I_STRUCTURE_NAME = 'YOUR_STRUCT1'  " or use FCAT
    CHANGING
      IT_OUTTAB        = GT_LEFT_DATA
      IT_FIELDCATALOG  = LT_FCAT_LEFT.

  " Bind data and field catalog to right grid
  CALL METHOD GO_GRID_RIGHT->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      I_STRUCTURE_NAME = 'YOUR_STRUCT2'
    CHANGING
      IT_OUTTAB        = GT_RIGHT_DATA
      IT_FIELDCATALOG  = LT_FCAT_RIGHT.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  BUILD FCAT_LEFT
*&---------------------------------------------------------------------*
*       FIELD CATALOG(LEFT SIDE)
*----------------------------------------------------------------------*

FORM BUILD_FCAT_LEFT CHANGING PT_FCAT TYPE LVC_T_FCAT.

  DATA: LS_FCAT TYPE LVC_S_FCAT.

  " Field 1: EMPLOYEE ID
  LS_FCAT-FIELDNAME  = 'EMP_ID'.
  LS_FCAT-COLTEXT    = 'Employee ID'.
  LS_FCAT-OUTPUTLEN  = 10.
  APPEND LS_FCAT TO PT_FCAT.
  CLEAR LS_FCAT.

  " Field 2: EMPLOYEE NAME
  LS_FCAT-FIELDNAME  = 'EMP_NAME'.
  LS_FCAT-COLTEXT    = 'Employee Name'.
  LS_FCAT-OUTPUTLEN  = 15.
  APPEND LS_FCAT TO PT_FCAT.
  CLEAR LS_FCAT.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  BUILD FCAT_RIGHT
*&---------------------------------------------------------------------*
*       FIELD CATALOG(RIGHT SIDE)
*----------------------------------------------------------------------*
FORM BUILD_FCAT_RIGHT CHANGING PT_FCAT TYPE LVC_T_FCAT.

  DATA: LS_FCAT TYPE LVC_S_FCAT.

  " Field 1: PROJECT ID
  LS_FCAT-FIELDNAME  = 'PROJ_ID'.
  LS_FCAT-COLTEXT    = 'Project ID'.
  LS_FCAT-OUTPUTLEN  = 10.
  APPEND LS_FCAT TO PT_FCAT.
  CLEAR LS_FCAT.

  " Field 2: PROJECT NAME
  LS_FCAT-FIELDNAME  = 'PROJ_NAME'.
  LS_FCAT-COLTEXT    = 'Project Name'.
  LS_FCAT-OUTPUTLEN  = 20.
  APPEND LS_FCAT TO PT_FCAT.
  CLEAR LS_FCAT.

  " Field 3: STATUS
  LS_FCAT-FIELDNAME  = 'STATUS'.
  LS_FCAT-COLTEXT    = 'Status'.
  LS_FCAT-OUTPUTLEN  = 8.
  APPEND LS_FCAT TO PT_FCAT.
  CLEAR LS_FCAT.

ENDFORM.

--------------------------Expected result ---------------------------------------------

┌───────────────────────────────┬────────────────────────────────────────────────────────┐
│         Left Grid             │                      Right Grid                         │
│    (Employee Information)     │                 (Project Assignment Info)               │
├──────────────┬────────────────┼──────────────┬────────────────────────────┬────────────┤
│ EMP_ID       │ EMP_NAME       │ PROJ_ID      │ PROJ_NAME                  │ STATUS     │
├──────────────┼────────────────┼──────────────┼────────────────────────────┼────────────┤
│ E001         │ Alice Kim      │ P1001        │ FI Rollout                 │ 진행       │
│ E002         │ Bob Lee        │ P1002        │ CRM Integration            │ 완료       │
│ E003         │ Charlie Park   │ P1003        │ Data Migration             │ 계획       │
└──────────────┴────────────────┴──────────────┴────────────────────────────┴────────────┘

