#import "DetailViewController.h"

@interface MainBodyViewController : UIViewController {
	DetailViewController* detailView;

	IBOutlet UIButton* burgerButton;
	IBOutlet UIButton* chickenButton;
	IBOutlet UIButton* dessertButton;
	IBOutlet UIButton* drinkButton;
	IBOutlet UIButton* packButton;
	
	CGPoint buttonOrigin[5];
	
	IBOutlet UIView* topList;
	IBOutlet UIView* bottomList;
}

- (IBAction)ButtonClick:(id)sender;

@end
