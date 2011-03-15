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
@class HTTPRequest;

@interface CartMyShippingList : UIViewControllerTemplate<UITableViewDataSource, UITableViewDelegate > {
	IBOutlet UITableView *CustomerTable;
    IBOutlet UIButton	*regButton;
	IBOutlet UIImageView *noRegImage;
	NSMutableArray *CustomerArr;
	
	
	HTTPRequest *httpRequest;
	int		RemoveNum;
	

}
- (void)refresh;
- (void)GetShippingList;
- (IBAction)ShipRegButton:(id)sender;
-(IBAction)CellDeleteButton:(id)sender;

@end
