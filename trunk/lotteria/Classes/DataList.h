//
//  DataList.h
//  lotteria
//
//  Created by embmaster on 11. 2. 24..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


@interface CustomerDelivery : NSObject {
	NSString *custid;
	NSString *seq;
	NSString *phone;
	NSString *si;
	NSString *gu;
	NSString *dong;
	NSString *bunji;
	NSString *building;
	NSString *addrdesc;
	NSString *branchid;
	NSString *branchname;
	NSString *branchtime;
	NSString *regdate;
	NSString *regtime;
	NSString *upddate;
	NSString *updtime;
}

@property (retain) NSString *custid;
@property (retain) NSString *seq;
@property (retain) NSString *phone;
@property (retain) NSString *si;
@property (retain) NSString *gu;
@property (retain) NSString *dong;
@property (retain) NSString *bunji;
@property (retain) NSString *building;
@property (retain) NSString *addrdesc;
@property (retain) NSString *branchid;
@property (retain) NSString *branchname;
@property (retain) NSString *branchtime;
@property (retain) NSString *regdate;
@property (retain) NSString *regtime;
@property (retain) NSString *upddate;
@property (retain) NSString *updtime;

@end



@interface OrderProductInfo : NSObject {
	NSString *MenuMainID;	// 메뉴 대분류 ID
	NSString *MenuID;		// 메뉴 ID
	NSString *MenuName;		// 메뉴 이름	
	NSString *MenuNumber;	// 메뉴 개수 
	NSString *MenuPrice;	// 메뉴 가격
	bool	 MenuOnOff;		// 주문 매장에서 판매여부 
}
@property (retain) 	NSString *MenuMainID;
@property (retain) NSString *MenuID;
@property (retain) NSString *MenuName;
@property (retain) NSString *MenuNumber;
@property (retain) NSString *MenuPrice;
@property (readwrite)	bool	 MenuOnOff;
@end


@interface OrderUserInfo : NSObject {
	NSString *custid;	// 앱로그인 사용자
	NSString *OrderUser;	// 주문사용자
	NSString *phone;		// 주문자 핸드폰
	NSString *branchid;
	NSString *branchname;
	NSString *branchtime;
	NSString *si;	
	NSString *gu;
	NSString *dong;
	NSString *adong;
	NSString *ldong;
	NSString *bunji;
	NSString *building;
	NSString *addrdesc;
}

@property (retain) NSString *custid;
@property (retain) NSString *OrderUser;
@property (retain) NSString *phone;
@property (retain) NSString *branchid;
@property (retain) NSString *branchname;
@property (retain) NSString *branchtime;
@property (retain) NSString *si;
@property (retain) NSString *gu;
@property (retain) NSString *dong;
@property (retain) NSString *adong;
@property (retain) NSString *ldong;
@property (retain) NSString *bunji;
@property (retain) NSString *building;
@property (retain) NSString *addrdesc;

@end

@interface Order : NSObject
{
	NSMutableArray	*Product; // OrderProductInfo
	NSString		*OrderMoney;
	NSString		*OrderSale;
	NSString		*OrderTotal;
	
	OrderUserInfo	*User;
	int				OrderType;
	NSString		*OrderTime;

}

@property (retain) NSMutableArray *Product;
@property (retain) OrderUserInfo *User;
@property (readwrite) int	OrderType;
@property (retain) NSString *OrderMoney;
@property (retain) NSString *OrderSale;
@property (retain) NSString *OrderTotal;
@property (retain) NSString	*OrderTime;
@end

