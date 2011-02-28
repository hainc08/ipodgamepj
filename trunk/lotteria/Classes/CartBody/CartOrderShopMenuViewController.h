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
	IBOutlet UIScrollView *Scroll;
	bool buttontype;
	
}

- (void)didDataDelete:(NSString *)result;
- (IBAction)CellDeleteButton:(id)sender;
- (IBAction)OrderButton:(id)sender;

- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message;
- (void)didReceiveFinished:(NSString *)result;
- (void)GetOrderMenuSearch;
- (void)SetButton;
@end
