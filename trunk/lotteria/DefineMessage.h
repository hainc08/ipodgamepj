/* 
 * TITLE는 에러든 어떤거든 같이 쓰자고 함 
 */
#define ALERT_TITLE					@"알림"			
#define ERROR_TITLE					@"알림"
#define UPDATE_TITLE				@"업데이트"
#define ORDERFAIL_TITLE				@"주문오류" 
#define ORDER_TITLE					@"주문"
/*
 *  LOGO View 에서 사용됨 
 */
#define UPDATE_AGAIN				@"다시시도"
#define EXIT_APP					@"어플닫기"

#define VER_ERROR_MSG				@"서버에서 버전정보를 읽는데 실패하였습니다."
#define MENU_ERROR_MSG				@"서버에서 메뉴정보를 읽는데 실패하였습니다."
#define VER_MISMATCH_MSG			@"최신버전의 어플이 아닙니다.\n앱스토어에서 최신버전으로\n업데이트 하시기바랍니다."


/* 
 *	HttpRequest 에서 didFailWithError 에서  에러 나는 정보 표현 
 */

#define HTTP_ERROR_MSG				@"데이터 전송에 실패하셨습니다."

/* 
 *	배송지 삭제 실패
 */

#define DELI_ERROR_MSG				@"삭제 실패하였습니다."

/* 
 *	배송 목적지 & 품절 메뉴 검색 실패 
 */

#define DELI_SEARCH_ERROR_MSG		@"배달가능 매장이 없습니다."

/*
 *  장바구니 정보가  비어있을때 , 장바구니가 8000원이 안되었을때 ( 장바구니에서 사용됨 )
 */ 
#define ORDER_COND_MSG				@"8000원 이상시 주문 가능합니다."
#define ORDER_CLEAN_MSG				@"장바구니가 비어있습니다"


/*
 *  주문을 넣었는데 실패 했을때
 */ 
#define ORDER_ERROR_MSG				@"주문에 실패하였습니다."


/*
 *  예약 주문시 매장에 주문 가능 시간과 비교 
 */ 

#define DELI_TIME_ERROR_MSG			@"배달 가능한 시간이 아닙니다."

/* 
 *   수령자 정보정보가 입력이 잘못되었을때.
 */

#define ORDER_USER_ERROR_MSG		@"수령자명과 핸드폰 번호를 입력 해주세요."

/*
 *   로그인 정보가 정확히 입력 되지 않았을때.
 */ 

#define LOGIN_INPUT_ERROR_MSG		@"ID 와 Password를 입력해주세요."


/*
 *	 MAP에서 사용되는 메시지
 */ 

#define MAP_RESULT_ERROR_MSG		@"위치정보를 불러오는데 실패하였습니다."
#define MAP_RESULT_NOTFOUND_MSG		@"주변(반경 2KM)에 매장이 없습니다."

#define MAP_24STORE_NOTFOUND_MSG	@"24시 매장이 없습니다."
#define MAP_DELI_NOTFOUND_MSG		@"배달 매장이 없습니다."


/* 
 *	결제 TYPE 메시지 
 */ 

#define ONLINE_PAY_MSG				@"온라인 결제는 준비중입니다."
#define CARD_PAY_MSG				@"신용카드(단말기) 주문이 맞습니까?"
#define MONEY_PERSONAL_PAY_MSG		@"현금+현금영수증 주문이 맞습니까?"
#define MONEY_PAY_MSG				@"현금주문이 맞습니까?"