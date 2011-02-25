//
//  MyShippingList.h
//  lotteria
//
//  Created by embmaster on 11. 2. 24..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@class Order;

@interface MyShippingList : UIViewControllerTemplate<UITableViewDataSource, UITableViewDelegate > {
	IBOutlet UITableView *CustomerTable;
    IBOutlet UIButton	*regButton;
	
	NSMutableArray *CustomerArr;
	
	
	Order	*InfoOrder;
}
@property (nonatomic, retain)     NSMutableArray *CustomerArr;
@property (nonatomic, retain) IBOutlet UITableView *CustomerTable;
@property (nonatomic, retain) Order *InfoOrder;

- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message;
- (IBAction)ShipRegButton:(id)sender;
@end
