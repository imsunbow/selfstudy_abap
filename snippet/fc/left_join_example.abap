*------------------------------------------------------------*
* LEFT JOIN example – fetch related info including optional entries
*------------------------------------------------------------*
SELECT
  A~KEY1,                " Primary key from main table
  B~FIELD1,              " Related field from table B (e.g., name)
  A~KEY2,                " Foreign key (e.g., project ID)
  C~FIELD2,              " Related field from table C (e.g., project name)
  D~FIELD3,              " Related field from table D (e.g., client name)
  A~CATEGORY,            " Some field in main table (e.g., module code)
  E~DDTEXT AS CATEGORY_DESC, " Text description from domain table
  A~PERIOD_FROM,         " Start period
  A~PERIOD_TO            " End period
INTO TABLE @DATA(LT_RESULT)
FROM MAIN_TABLE     AS A
LEFT JOIN TABLE_B   AS B ON A~KEY1     = B~KEY1
LEFT JOIN TABLE_C   AS C ON A~KEY2     = C~KEY2
LEFT JOIN TABLE_D   AS D ON C~CLIENTID = D~CLIENTID
LEFT JOIN DD07T     AS E ON A~CATEGORY = E~DOMVALUE_L
                        AND E~DOMNAME  = 'DOMAIN_NAME'
                        AND E~DDLANGUAGE = @SY-LANGU
WHERE A~KEY1 = @P_KEY.

*------------------------------------------------------------*
* Notes on New ABAP Syntax Used in This Snippet
*------------------------------------------------------------*

" @DATA(...)  
" → Inline declaration: Declares the internal table LT_RESULT at the point of assignment. 
"   No need for separate DATA statement above. Scope is local to the processing block.

" @SY-LANGU and @P_KEY  
" → Escape host variables using '@' symbol. 
"   **Required in New ABAP Syntax when using variables inside SQL statements** 
"   to clearly distinguish them from column names.

" SELECT ... INTO TABLE  
" → This approach is efficient for bulk reading and directly fills the internal table.

" LEFT JOIN  
" → Ensures that even if related records are missing in joined tables, 
"  the main table’s data will still be retrieved (NULLs in place of missing values).

