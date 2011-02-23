//
//  MyGetCustDelivery.h
//  lotteria
//
//  Created by embmaster on 11. 2. 22..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"



@interface MyCustomerDelivery : UIViewControllerTemplate<UITableViewDataSource, UITableViewDelegate > {

	IBOutlet UITableView *CustomerTable;
    NSMutableArray *CustomerArr;
	
}

@property (nonatomic, retain) NSMutableArray	*CustomerArr;
@property (nonatomic, retain) IBOutlet UITableView *CustomerTable;


- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message;

@end
