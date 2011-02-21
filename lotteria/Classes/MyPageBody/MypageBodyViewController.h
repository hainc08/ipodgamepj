#import "LoginViewController.h"

@class LoginViewController;

@interface MypageBodyViewController : UIViewController <LoginViewDelegate> {
	
	LoginViewController	*Login;
	
	IBOutlet UIButton *OrderList;
}

- (IBAction)OrderListButton;

@property (nonatomic,retain) LoginViewController	*Login;


@end
