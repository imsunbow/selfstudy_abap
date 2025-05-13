*------------------------------------------------------------*
* FOR ALL ENTRIES – Fetch related records based on base result set
*------------------------------------------------------------*

" Step 1: Get base entries using selection condition (e.g., project ID)
SELECT KEY1 KEY2 CATEGORY PERIOD_FROM PERIOD_TO
  INTO CORRESPONDING FIELDS OF TABLE LT_BASE
  FROM MAIN_TABLE
  WHERE KEY2 IN SO_KEY2.

" Step 2: If base result is not empty, fetch related data
IF LT_BASE IS NOT INITIAL.
  SELECT KEY1 FIELD1
    INTO CORRESPONDING FIELDS OF TABLE LT_RELATED
    FROM RELATED_TABLE
    FOR ALL ENTRIES IN LT_BASE
    WHERE KEY1 = LT_BASE-KEY1.
ENDIF.
