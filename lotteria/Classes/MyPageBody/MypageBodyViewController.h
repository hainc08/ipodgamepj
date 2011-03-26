
#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"		

@class LoginViewController;
@class HTTPRequest;
@interface MypageBodyViewController : UIViewControllerTemplate  {

	IBOutlet UIButton *OrderList;
	IBOutlet UIButton *LogOut;
	
	HTTPRequest *httpRequest;
	UINavigationController* loginCon;
}

- (IBAction)OrderListButton;
- (IBAction)LogOutButton;

@end
