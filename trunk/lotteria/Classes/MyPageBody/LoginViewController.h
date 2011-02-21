//
//  LoginViewController.h
//  lotteria
//
//  Created by embmaster on 11. 2. 20..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequest.h"



@interface LoginViewController : UIViewController {

	IBOutlet UITextField	*ID;
	IBOutlet UITextField	*Password;
	
	IBOutlet UIButton		*ID_Save;
	IBOutlet UIButton		*Login;
	
	HTTPRequest				*Request;
}

- (IBAction)LoginButton;
- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message;

@property (nonatomic,retain) HTTPRequest *Request;
@end
