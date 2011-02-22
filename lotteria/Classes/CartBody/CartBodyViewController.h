#import "CartListViewController.h"

@interface CartBodyViewController : UIViewController {
	IBOutlet UIScrollView* scrollView;
	CartListViewController* cartList[5];
}
-(IBAction)OrderButton;
@end
