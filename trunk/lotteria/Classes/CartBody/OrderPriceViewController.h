//
//  OrderSettlementViewController.h
//  lotteria
//
//  Created by embmaster on 11. 2. 27..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@class HTTPRequest;

enum ORDERTYPE {
	MONEY = 0,
	MONEY_PERSONAL,
	CARD ,
	ONLINE,
};

@interface OrderPriceViewController : UIViewControllerTemplate {
	IBOutlet UIButton *Money;
	IBOutlet UIButton *Card;
	IBOutlet UIButton *Money2;
	IBOutlet UIButton *Card2;
	IBOutlet UILabel *MoneyTxt;
	IBOutlet UITextField *Comment;
		HTTPRequest *httpRequest;
	int OrderType;
}
- (void)didReceiveFinished:(NSString *)result;
- (void)OrderParamSetting;
- (IBAction) OrderButton:(id)sender;
- (void)ShowOKCancleAlert:(NSString *)title msg:(NSString *)message;
@end
