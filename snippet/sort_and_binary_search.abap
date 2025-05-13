*------------------------------------------------------------*
* Binary Search Snippet - Classic ABAP Syntax
*------------------------------------------------------------*
* This snippet demonstrates how to sort an internal table by
* a key field and perform a binary search using READ TABLE.
*------------------------------------------------------------*

* Sample structure
DATA: BEGIN OF LS_ITEM,
        ID     TYPE CHAR10,
        VALUE  TYPE I,
      END OF LS_ITEM.

DATA: LT_ITEM   LIKE TABLE OF LS_ITEM,
      LV_ID     TYPE CHAR10,
      LS_FOUND  LIKE LS_ITEM.

* Sample data
APPEND VALUE #( ID = 'ID1' VALUE = 100 ) TO LT_ITEM.
APPEND VALUE #( ID = 'ID2' VALUE = 200 ) TO LT_ITEM.
APPEND VALUE #( ID = 'ID3' VALUE = 300 ) TO LT_ITEM.

* Sort the table by ID (mandatory for binary search)
SORT LT_ITEM BY ID.

* Set the target ID to search
LV_ID = 'ID2'.

* Perform binary search by key field
READ TABLE LT_ITEM INTO LS_FOUND WITH KEY ID = LV_ID BINARY SEARCH.

* Exception handling: check if entry was found
IF SY-SUBRC = 0.
  WRITE: / 'Found ID:', LS_FOUND-ID, 'Value:', LS_FOUND-VALUE.
ELSE.
  WRITE: / 'ID not found:', LV_ID.
ENDIF.
