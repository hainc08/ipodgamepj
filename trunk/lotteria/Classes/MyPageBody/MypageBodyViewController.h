
#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"		

@class LoginViewController;
@interface MypageBodyViewController : UIViewControllerTemplate  {

	IBOutlet UIButton *OrderList;
	IBOutlet UIButton *LogOut;
}

- (IBAction)OrderListButton;
- (IBAction)LogOutButton;

@end
