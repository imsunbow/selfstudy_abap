*------------------------------------------------------------*
* 1. INITIALIZATION - SET DEFAULT DATE
*------------------------------------------------------------*
INITIALIZATION.
  " Declare local variables for current date and month
  DATA: LV_CURR_DATE  TYPE SY-DATUM,    " Current date (YYYYMMDD)
        LV_CURR_MONTH TYPE CHAR6.       " Current year and month (YYYYMM)

  " Get system date
  LV_CURR_DATE  = SY-DATUM.
  " Extract year and month from the date
  LV_CURR_MONTH = LV_CURR_DATE(6).

  " Concatenate with '01' to get the first day of the current month
  CONCATENATE LV_CURR_MONTH '01' INTO PA_MONTH.

  " Display the first day of the current month
  WRITE: / 'FIRST DATE OF THIS MONTH :', PA_MONTH.

  " Example: Set icon text for function key on selection screen
  GS_DYNTXT-ICON_ID     = ICON_DISPLAY.                     " Icon symbol
  GS_DYNTXT-ICON_TEXT   = 'ICON_TEXT'.                      " Button label
  GS_DYNTXT-QUICKINFO   = 'WATCH OTHER DETAILS OF THE TABLE'. " Tooltip
  SSCRFIELDS-FUNCTXT_01 = GS_DYNTXT.                        " Assign to function key F1
