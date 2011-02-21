//
//  MyGetCustDelivery.h
//  lotteria
//
//  Created by embmaster on 11. 2. 22..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerDelivery : NSObject {
	NSString *s_cust_id;
	NSString *s_seq;
	NSString *s_phone;
	NSString *s_si;
	NSString *s_gu;
	NSString *s_dong;
	NSString *s_bunji;
	NSString *s_building;
	NSString *s_addrdesc;
	NSString *s_branchid;
	NSString *s_regdate;
	NSString *s_regtime;
	NSString *s_upddate;
	NSString *s_updtime;
}

@property (nonatomic, copy) NSString *s_cust_id;
@property (nonatomic, copy) NSString *s_seq;
@property (nonatomic, copy) NSString *s_phone;
@property (nonatomic, copy) NSString *s_si;
@property (nonatomic, copy) NSString *s_gu;
@property (nonatomic, copy) NSString *s_dong;
@property (nonatomic, copy) NSString *s_bunji;
@property (nonatomic, copy) NSString *s_building;
@property (nonatomic, copy) NSString *s_addrdesc;
@property (nonatomic, copy) NSString *s_branchid;
@property (nonatomic, copy) NSString *s_regdate;
@property (nonatomic, copy) NSString *s_regtime;
@property (nonatomic, copy) NSString *s_upddate;
@property (nonatomic, copy) NSString *s_updtime;

@end

@interface MyGetCustDelivery : UIViewController {
	CustomerDelivery *Customer;
    NSMutableArray *ArrCustomer;
    BOOL Characters;
	NSMutableString *currentString;
	
}
@property (nonatomic, retain) CustomerDelivery	*Customer;
@property (nonatomic, retain) NSMutableArray	*ArrCustomer;
@property (nonatomic, retain) NSMutableString	*currentString;

@end
