//
//  ShipAddressTable.h
//  lotteria
//
//  Created by embmaster on 11. 2. 25..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@class OrderUserInfo;
@interface ShipAddressTable : UIViewController <UITableViewDataSource, UITableViewDelegate > {
	IBOutlet UITableView *ShipTable;
    NSMutableArray *ShipAddressArr;
	int ShipType ; // 0 : 동   1 : 주소 
	OrderUserInfo *Info;
	NSString *dong;
	IBOutlet UIButton *BackButton;
}
@property (nonatomic, retain) NSMutableArray	*ShipAddressArr;
@property (nonatomic, retain) IBOutlet UITableView *ShipTable;
@property (nonatomic, retain) NSString *dong;
@property (readwrite) int ShipType;
- (IBAction)BackButton:(id)sender;

- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message;
@end
