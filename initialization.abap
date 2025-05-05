*------------------------------------------------------------*
* 1. INITIALIZATION - 기본 날짜 설정
*------------------------------------------------------------*
INITIALIZATION.
  DATA: lv_curr_date  TYPE sy-datum,
        lv_curr_month TYPE char6.

  lv_curr_date  = sy-datum.
  lv_curr_month = lv_curr_date(6).

  CONCATENATE lv_curr_month '01' INTO pa_month.

  WRITE: / '현재 월의 시작일:', pa_month.

  " 다른 초기화 예시: 아이콘 텍스트 설정
  gs_dyntxt-icon_id = icon_display.
  gs_dyntxt-icon_text = '기본정보 보기'.
  gs_dyntxt-quickinfo = '사원 상세 정보 조회'.
  sscrfields-functxt_01 = gs_dyntxt.
