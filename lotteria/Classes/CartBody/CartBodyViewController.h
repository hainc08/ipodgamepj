#import "CartListViewController.h"
#import "UIViewControllerTemplate.h"		
	
@class Order;

@interface CartBodyViewController : UIViewControllerTemplate {

	IBOutlet UIScrollView* scrollView;
	CartListViewController* cartList[5];

	IBOutlet UILabel* priceLabel;
	NSTimer *updateTimer;
	
	Order	*InfoOrder;
}

@property (nonatomic ,retain) Order *InfoOrder;

-(void)setupData;
-(IBAction)OrderButton;
-(void)update;

@end
