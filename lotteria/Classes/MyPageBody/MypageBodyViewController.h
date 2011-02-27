
#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"		
	
@interface MypageBodyViewController : UIViewControllerTemplate  {

	
	IBOutlet UIButton *OrderList;
	IBOutlet UIButton *LogOut;
}

- (IBAction)OrderListButton;
- (IBAction)LogOutButton;

@end
