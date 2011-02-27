//
//  OrderShopMenuViewController.h
//  lotteria
//
//  Created by embmaster on 11. 2. 27..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@class Order;
@class HTTPRequest;
@interface CartOrderShopMenuViewController : UIViewControllerTemplate {
	HTTPRequest	*httpRequest;
	IBOutlet UITableView *menuTable;
	IBOutlet UIButton	*orderButton;
	IBOutlet UIButton	*againButton;
	
	Order *InfoOrder;
	bool buttontype;
}
@property (nonatomic , retain) Order *InfoOrder;
@property (nonatomic , retain) IBOutlet UIButton	*orderButton;;
@property (nonatomic , retain) IBOutlet UIButton	*againButton;;

- (IBAction)CellDeleteButton:(id)sender;
- (IBAction)OrderButton:(id)sender;

- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message;
- (void)didReceiveFinished:(NSString *)result;
- (void)GetOrderMenuSearch;
- (void)SetButton;
@end
