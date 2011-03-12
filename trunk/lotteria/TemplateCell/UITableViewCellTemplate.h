//
//  CostomerCell.h
//  lotteria
//
//  Created by embmaster on 11. 2. 22..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

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
	
	/*전화번호	,	  FontColor : White */
	IBOutlet UILabel* OrderPhone;
}

@property (nonatomic, retain) IBOutlet UILabel* ShippingName;  
@property (nonatomic, retain) IBOutlet UILabel* ShippingAddress;  
@property (nonatomic, retain) IBOutlet UILabel* OrderPhone;  

-(void)setInfo:(NSString*)_inName :(NSString *)_inAddr :(NSString *)_inPhone;
@end


/* 배송지 Cell 
 
 ---  사용처 ---
 * 배송지선택 페이지
 * 주문하기   페이지
 */
@interface ShippingCell : UITableViewCell
{
	/*  모란점*/
	IBOutlet UILabel* ShippingName;  
	
	/* 배송지 주소	*/
	IBOutlet UILabel* ShippingAddress;
	
	/* 배송지 전화번호  */
	IBOutlet UILabel* ShippingCall;
	
	IBOutlet UIButton	*delbutton;
}

@property (nonatomic, retain) IBOutlet UILabel* ShippingName;  
@property (nonatomic, retain) IBOutlet UILabel* ShippingAddress;  
@property (nonatomic, retain) IBOutlet UILabel* ShippingCall;
@property (nonatomic, retain) IBOutlet UIButton  *delbutton;
-(void)setInfo:(NSString*)_inName :(NSString *)_inAddr :(NSString *)_inCall;

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

@interface OrderMenuCell : UITableViewCell
{
	IBOutlet UILabel *MainCategory;
	IBOutlet UILabel *SubCategory;
	IBOutlet UILabel *Money;
	IBOutlet UILabel *MenuCount;
	IBOutlet UILabel *stock;
	IBOutlet UIButton *delbutton;
	CartItem	*item;
	id target;
	SEL selector;
}
@property (nonatomic, retain) IBOutlet UILabel *MainCategory;
@property (nonatomic, retain) IBOutlet UILabel *SubCategory;
@property (nonatomic, retain) IBOutlet UILabel *Money;
@property (nonatomic, retain) IBOutlet UILabel *MenuCount;
@property (nonatomic, retain) IBOutlet UILabel *stock;
@property (nonatomic, retain) IBOutlet UIButton *delbutton;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL selector;

-(void)setBackgroundImage:(bool)_intype;
-(void)setMenuData:(int)category :(CartItem *)_inData;
- (void)setDelegate:(id)aTarget selector:(SEL)aSelector;

-(IBAction)CellDeleteButton;
@end


/* 맵 주소  Cell 
 
 ---  사용처 ---
 * 맵 상세 주소 정보
 */
@interface StoreAddressCell : UITableViewCell
{
	IBOutlet UILabel* StoreName;  
	IBOutlet UILabel* StoreAddress;
	
}

@property (nonatomic, retain) IBOutlet UILabel* StoreName;  
@property (nonatomic, retain) IBOutlet UILabel* StoreAddress;  

-(void)setInfo:(NSString*)_inName :(NSString *)_inAddr;
@end