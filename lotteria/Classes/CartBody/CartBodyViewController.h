#import "CartListViewController.h"
#import "UIViewControllerTemplate.h"		
	
@class LoginViewController;
@interface CartBodyViewController : UIViewControllerTemplate {

	IBOutlet UIScrollView* scrollView;
	CartListViewController* cartList[5];

	IBOutlet UILabel* priceLabel;
	NSTimer *updateTimer;
	

}


-(void)setupData;
-(IBAction)OrderButton;
-(void)update;
@end
