    //
//  DataList.m
//  lotteria
//
//  Created by embmaster on 11. 2. 24..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataList.h"


@implementation CustomerDelivery

@synthesize custid,seq ,phone ,si , gu;
@synthesize dong,bunji , building ,addrdesc ,branchid;
@synthesize regdate, regtime, upddate, updtime;
@synthesize branchname, branchtime;
- (void)dealloc {
    [custid release];
    [seq release];
    [phone release];
    [si release];
    [gu release];
	[dong release];
    [bunji release];
    [building release];
    [addrdesc release];
    [branchid release];
	[branchname release];
	[branchtime release];
	[regdate release];
    [regtime release];
    [upddate release];
    [updtime release];
	[super dealloc];
}

@end



@implementation OrderProductInfo
@synthesize MenuMainID;
@synthesize MenuID,MenuName ,MenuNumber ,MenuPrice;
@synthesize  MenuOnOff;
- (void)dealloc {
    [MenuID release];
    [MenuName release];
    [MenuNumber release];
    [MenuPrice release];
	
	[super dealloc];
}

@end


@implementation OrderUserInfo

@synthesize custid,OrderUser ,phone ,si , gu;
@synthesize dong,bunji , building ,addrdesc;
@synthesize branchid, branchtime, branchname;
- (void)dealloc {
	[branchid release];
	[branchname release];
	[branchtime release];
    [custid release];
    [OrderUser release];
    [phone release];
    [si release];
    [gu release];
	[dong release];
	[adong release];
	[ldong release];
    [bunji release];
    [building release];
    [addrdesc release];
	
	[super dealloc];
}

@end


@implementation Order 
@synthesize Product,User ,OrderType;  
@synthesize OrderMoney, OrderSale, OrderTotal;
@synthesize OrderTime;
- (void)dealloc {
	[OrderTime release];
	[OrderMoney release];
	[OrderSale	release];
	[OrderTotal	 release];
	[Product release];
	[User release];
	[super dealloc];
}

@end
