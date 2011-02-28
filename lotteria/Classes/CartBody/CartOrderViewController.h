//
//  CartOrderViewController.h
//  lotteria
//
//  Created by embmaster on 11. 2. 23..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"
@class Order;
@interface CartOrderViewController : UIViewControllerTemplate {
	IBOutlet	UIButton *normalButton;
	IBOutlet	UIButton *delayButton;
}
- (IBAction)OrderButton:(id)sender;
@end
