#import "CartListViewController.h"
#import "UIViewControllerTemplate.h"

@class Order;
@interface CartBodyViewController : UIViewControllerTemplate {
	IBOutlet UIScrollView* scrollView;
	CartListViewController* cartList[5];
		Order	*InfoOrder;
	IBOutlet UILabel* priceLabel;
}
@property (nonatomic ,retain) Order *InfoOrder;
-(IBAction)OrderButton;
@end
