//
//  OrderShopMenuViewController.h
//  lotteria
//
//  Created by embmaster on 11. 2. 27..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@class HTTPRequest;
@interface CartOrderShopMenuViewController : UIViewControllerTemplate {
	HTTPRequest	*httpRequest;
	IBOutlet UITableView *menuTable;
	IBOutlet UIButton	*orderButton;
	IBOutlet UIButton	*againButton;
	bool buttontype;
	
}

- (IBAction)OrderButton:(id)sender;
- (void)didDataDelete:(NSString *)result;
- (void)SetButton;
@end