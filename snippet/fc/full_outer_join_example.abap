*------------------------------------------------------------*
* Full Outer Join Snippet - Classic ABAP Syntax (Emulated)
*------------------------------------------------------------*
* This snippet emulates a full outer join using a combination
* of left outer join and right outer join with internal tables.

* Notes: There's no way to use FULL-OUTER JOIN directly in abap-syntax. That's why we cannot perform join at once.
* Instead, We've got to join at twice, like left join first and right join afterwards.

* ⚠️ Performance Notes:
* We're using READ ... BINARY SEARCH (BS) for matching.
* So make sure to SORT the internal table by the same key **before** doing BS.
*
* In this snippet, the dataset is small for demonstration purposes.
* But in real use (e.g. 10,000+ rows), BS significantly outperforms linear search.
* Sorting once and using BS in a loop is much more efficient than nested LOOPs.
*------------------------------------------------------------*

* Structure for table A
DATA : BEGIN OF LS_A,
         ID  TYPE CHAR10,
         TEXT TYPE CHAR40,
      END OF LS_A.

* Structure for table B
DATA: BEGIN OF LS_B,
        ID  TYPE CHAR10,
        INFO TYPE CHAR40,
      END OF LS_RESULT.

* Sample data for A
APPEND VALUE #( ID = 'ID1' TEXT = 'TEXT1' ) TO LT_A.
APPEND VALUE #( ID = 'ID2' TEXT = 'TEXT2' ) TO LT_A.

* Sample data for B
APPEND VALUE #( ID = 'ID2' INFO = 'INFO B' ) TO LT_B.
APPEND VALUE #( ID = 'ID3' INFO = 'INFO C' ) TO LT_B.

* LEFT OUTER JOIN : A to B
LOOP AT LT_A INTO LS_A.
  READ TABLE LT_B INTO LS_B WITH KEY ID = LS_A-ID.
  CLEAR LS_RESULT.
  LS_RESULT-ID = LS_A-ID.
  LS_RESULT-TEXT = LS_A-TEXT.
  " Success
  IF SY-SUBRC = 0.
    LS_RESULT-INFO = LS_B-INFO.
  ENDIF.
  APPEND LS_RESULT TO LT_RESULT.
ENDLOOP.

* RIGHT ONLY : B to A where not matched
LOOP AT LT_B INTO LS_B.
  READ TABLE LT_A INTO LS_A WITH KEY ID = LS_B-ID.
  IF SY-SUBRC <> 0.
    CLEAR LS_RESULT.
    LS_RESULT-ID = LS_B-ID.
    LS_RESULT-INFO = LS_B-INFO.
    APPEND LS_RESULT TO LT_RESULT.
  ENDIF.
ENDLOOP.

* Display results
LOOP AT LT_RESULT INTO LS_RESULT.
  WRITE: / LS_RESULT-ID, LS_RESULT-TEXT, LS_RESULT-INFO.
ENDLOOP.

*------------------------------------------------------------*
* Expected Output (Result of Full Outer Join Emulation)
*------------------------------------------------------------*
* ID     | TEXT    | INFO
*--------+---------+----------
* ID1    | TEXT1   |
* ID2    | TEXT2   | INFO B
* ID3    |         | INFO C
*------------------------------------------------------------*
      
