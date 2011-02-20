#import "DetailViewController.h"

@interface MainBodyViewController : UIViewController<UIScrollViewDelegate> {
	DetailViewController* detailView;

	IBOutlet UIButton* burgerButton;
	IBOutlet UIButton* chickenButton;
	IBOutlet UIButton* dessertButton;
	IBOutlet UIButton* drinkButton;
	IBOutlet UIButton* packButton;
	
	CGPoint buttonOrigin[5];
	
	IBOutlet UIView* topList;
	IBOutlet UIScrollView* topScrollView;

	IBOutlet UIView* bottomList;
	IBOutlet UIScrollView* bottomScrollView;
}

- (IBAction)ButtonClick:(id)sender;
- (void)addIcon:(int)idx isTop:(bool)isTop;
- (void)iconClicked:(int)idx;

@end
