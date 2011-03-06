
#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"		

@class LoginViewController;
@interface MypageBodyViewController : UIViewControllerTemplate  {

	IBOutlet UIButton *OrderList;
	IBOutlet UIButton *LogOut;
	
	UINavigationController* loginCon;
}

- (IBAction)OrderListButton;
- (IBAction)LogOutButton;

@end
