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
	[regdate release];
    [regtime release];
    [upddate release];
    [updtime release];
	[super dealloc];
}

@end



@implementation OrderProductInfo

@synthesize MenuID,MenuName ,MenuNumber ,MenuPrice;

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

- (void)dealloc {
    [custid release];
    [OrderUser release];
    [phone release];
    [si release];
    [gu release];
	[dong release];
    [bunji release];
    [building release];
    [addrdesc release];
	
	[super dealloc];
}

@end


@implementation Order 
@synthesize Product,User ,OrderType;  

- (void)dealloc {
	[Product release];
	[User release];
	[super dealloc];
}

@end
