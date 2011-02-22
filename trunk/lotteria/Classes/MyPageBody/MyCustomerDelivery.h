//
//  MyGetCustDelivery.h
//  lotteria
//
//  Created by embmaster on 11. 2. 22..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


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


@interface MyCustomerDelivery : UIViewController <UITableViewDataSource, UITableViewDelegate > {

	IBOutlet UITableView *CustomerTable;
    NSMutableArray *CustomerArr;
	
}

@property (nonatomic, retain) NSMutableArray	*CustomerArr;
@property (nonatomic, retain) IBOutlet UITableView *CustomerTable;


- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message;

@end
