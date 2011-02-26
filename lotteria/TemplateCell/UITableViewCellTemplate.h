//
//  CostomerCell.h
//  lotteria
//
//  Created by embmaster on 11. 2. 22..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


/*주문목록 Cell 
 
 ---  사용처 ---
 * 주문목록
 */
@interface OldOrderCell : UITableViewCell
{
	/*  주문번호 , FontColor : White */
	IBOutlet UILabel* OrderNumber;  
	
	/* 주문일자	, FontColer : White */
	IBOutlet UILabel* OrderDate;
	
	/* 주문구분	  , FontColer : White */
	IBOutlet UILabel* OrderClass;
}
@property (nonatomic, retain) IBOutlet UILabel* OrderNumber;  
@property (nonatomic, retain) IBOutlet UILabel* OrderDate;  
@property (nonatomic, retain) IBOutlet UILabel* OrderClass;  

-(void)setInfo:(NSString*)_inNumber :(NSString *)_inDate :(NSString *)_inClass;
@end

/* 상세주문 Cell 
 
 ---  사용처 ---
 * 상세주문 내역
 */
@interface ShippingOrderCell : UITableViewCell
{
	/*  모란점 (031-758-5000)  , FontColor : Yellow */
	IBOutlet UILabel* ShippingName;  
	
	/* 배송지 주소		, FontColor : White */
	IBOutlet UILabel* ShippingAddress;
	
	/* 주문한사람	,	  FontColor : White */
	IBOutlet UILabel* OrderName; 
	/*전화번호	,	  FontColor : White */
	IBOutlet UILabel* OrderPhone;
}

@property (nonatomic, retain) IBOutlet UILabel* ShippingName;  
@property (nonatomic, retain) IBOutlet UILabel* ShippingAddress;  
@property (nonatomic, retain) IBOutlet UILabel* OrderName;  
@property (nonatomic, retain) IBOutlet UILabel* OrderPhone;  

-(void)setInfo:(NSString*)_inName :(NSString *)_inCall :(NSString *)_inAddr :(NSString *)_inOrdrName :(NSString *)_inPhone;
@end


/* 배송지 Cell 
 
 ---  사용처 ---
 * 배송지선택 페이지
 * 주문하기   페이지
 */
@interface ShippingCell : UITableViewCell
{
	/*  모란점 (Min)  , FontColor : Yellow */
	IBOutlet UILabel* ShippingName;  
	
	/* 배송지 주소		, FontColer : White */
	IBOutlet UILabel* ShippingAddress;
	
	/* 배송지 전화번호 , FontColor : White */
	IBOutlet UILabel* ShippingCall;
	
	IBOutlet UIButton	*delbutton;
}

@property (nonatomic, retain) IBOutlet UILabel* ShippingName;  
@property (nonatomic, retain) IBOutlet UILabel* ShippingAddress;  
@property (nonatomic, retain) IBOutlet UILabel* ShippingCall;
@property (nonatomic, retain) IBOutlet UIButton  *delbutton;
-(void)setInfo:(NSString*)_inName :(NSString *)_inMin :(NSString *)_inAddr :(NSString *)_inCall;

-(void)setDelButtonEnable:(bool)_inenable;
@end

/* 상세주문 Cell 
 
 ---  사용처 ---
 * 상세주문 내역
 */
@interface OrderListTopCell : UITableViewCell
{
}
@end

@interface OrderListMiddleCell : UITableViewCell
{
	/* 주문 제품    : FontColor : White */
	IBOutlet UILabel* OrderProduct;  
	
	/* 주문 수량		, FontColor : Yellow */
	IBOutlet UILabel* OrderCount;
	
	/* 주문한 가격	,	  FontColor : White */
	IBOutlet UILabel* OrderPrice; 
}
@property (nonatomic, retain) IBOutlet UILabel* OrderProduct;  
@property (nonatomic, retain) IBOutlet UILabel* OrderCount;  
@property (nonatomic, retain) IBOutlet UILabel* OrderPrice;  

-(void)setInfo:(NSString*)_inOPd :(NSString *)_inOCnt :(NSString *)_inOPr;
@end
/* 상세주문 Cell 
 
 ---  사용처 ---
 * 상세주문 내역
 */
@interface OrderListBottomCell : UITableViewCell
{
	/* 주문 가격	*/
	IBOutlet UILabel* OrderMoney;  
	
	/* 주문 세일	*/
	IBOutlet UILabel* OrderSale;
	
	/* 주문한 총합,	 */
	IBOutlet UILabel* OrderTotal; 
}
@property (nonatomic, retain) IBOutlet UILabel* OrderMoney;  
@property (nonatomic, retain) IBOutlet UILabel* OrderSale;  
@property (nonatomic, retain) IBOutlet UILabel* OrderTotal;  

-(void)setInfo:(NSString*)_inOrderMoney :(NSString *)_inOrderSale :(NSString *)_inOrderTotal;
@end


/* 가격정보 Cell 
 
 ---  사용처 ---
 * 상세주문 내역
 * 주문하기 
 */
@interface OrderMoneyCell : UITableViewCell
{
	/* 주문금액    : FontColor : White */
	IBOutlet UILabel* OrderMoney;  
	
	/* 할인금액	, FontColor : White */
	IBOutlet UILabel* SaleMoney;
	
	/* 결제금액	,	  FontColor : White */
	IBOutlet UILabel* TotalMoney; 
}
@property (nonatomic, retain) IBOutlet UILabel* OrderMoney;  
@property (nonatomic, retain) IBOutlet UILabel* SaleMoney;  
@property (nonatomic, retain) IBOutlet UILabel* TotalMoney;  

-(void)setInfo:(NSString*)_inOMoney :(NSString *)_inSMoney :(NSString *)_inTMoney;
@end
