//
//  OrderSettlementViewController.h
//  lotteria
//
//  Created by embmaster on 11. 2. 27..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@interface OrderPriceViewController : UIViewControllerTemplate {
	IBOutlet UIButton *Money;
	IBOutlet UIButton *Card;
	IBOutlet UIButton *Money2;
	IBOutlet UIButton *Card2;
	IBOutlet UILabel *MoneyTxt;
	IBOutlet UITextField *Comment;
}

- (IBAction) OrderButton:(id)sender;
- (void)ShowOKCancleAlert:(NSString *)title msg:(NSString *)message;
@end
