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
@property (retain) NSString *regdate;
@property (retain) NSString *regtime;
@property (retain) NSString *upddate;
@property (retain) NSString *updtime;

@end



@interface OrderProductInfo : NSObject {
	NSString *MenuID;		// 메뉴 ID
	NSString *MenuName;		// 메뉴 이름	
	NSString *MenuNumber;	// 메뉴 개수 
	NSString *MenuPrice;	// 메뉴 가격
}

@property (retain) NSString *MenuID;
@property (retain) NSString *MenuName;
@property (retain) NSString *MenuNumber;
@property (retain) NSString *MenuPrice;
@end


@interface OrderUserInfo : NSObject {
	NSString *custid;	// 앱로그인 사용자
	NSString *OrderUser;	// 주문사용자
	NSString *phone;		// 주문자 핸드폰
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
	OrderUserInfo	*User;
	int				OrderType;
}

@property (retain) NSMutableArray *Product;
@property (retain) OrderUserInfo *User;
@property (readwrite) int	OrderType;

@end

