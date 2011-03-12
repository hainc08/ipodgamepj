//
//  OrderEndViewController.h
//  lotteria
//
//  Created by embmaster on 11. 2. 28..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@class HTTPRequest;
@interface OrderEndViewController : UIViewControllerTemplate {
	IBOutlet UIButton *OrderInfo;
	IBOutlet UILabel *Store;
	IBOutlet UILabel *StorePhone;
	
	HTTPRequest *httpRequest;
}

-(IBAction) OrderInfo;
- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message;

@end
