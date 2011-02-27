//
//  LoginViewController.h
//  lotteria
//
//  Created by embmaster on 11. 2. 20..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"		
	
@interface LoginViewController : UIViewControllerTemplate <UITextFieldDelegate> {

	IBOutlet UITextField	*ID;
	IBOutlet UITextField	*Password;
	
	IBOutlet UIButton		*ID_Save;
	IBOutlet UIButton		*Login;
	
}

- (IBAction)LoginButton;
- (IBAction)IDSaveButton;
- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message;

@end
