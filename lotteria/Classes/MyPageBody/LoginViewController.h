//
//  LoginViewController.h
//  lotteria
//
//  Created by embmaster on 11. 2. 20..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"		
enum TYPE {
	MYPAGE = 0,
	CART,
};
@class HTTPRequest;
@interface LoginViewController : UIViewControllerDownTemplate <UITextFieldDelegate, UIWebViewDelegate> {

	IBOutlet UITextField	*ID;
	IBOutlet UITextField	*Password;
	
	IBOutlet UIButton		*ID_Save;
	IBOutlet UIButton		*ID_Save2;
	IBOutlet UIButton		*Login;
	int		LoginNextType;
	HTTPRequest *httpRequest;

	IBOutlet UIWebView* webView;
	int finishCount;
	
	bool processNow;
}
@property (readwrite) int LoginNextType;

- (IBAction)LoginButton;
- (IBAction)IDSaveButton;
- (void)reset;
@end
