//
//  CartOrderUserViewController.h
//  lotteria
//
//  Created by embmaster on 11. 2. 23..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@class Order;
@interface CartOrderUserViewController : UIViewControllerTemplate {
	IBOutlet UITextField	*Name;
	IBOutlet UITextField	*Phone;
	NSString *OrgPhone;

    UIButton *doneButton;
}

- (IBAction)ContinueButton:(id)sender;
- (IBAction)done:(id)sender;
- (void)makeDoneButton;
- (UIView*)findKeyboard:(UIView*)tempWindow;

@end
