#import "DetailViewController.h"

@interface MainBodyViewController : UIViewController<UIScrollViewDelegate> {
	DetailViewController* detailView;

	IBOutlet UIView* baseView;
	IBOutlet UIView* buttonView;
	IBOutlet UIView* findView;

	IBOutlet UIButton* burgerButton;
	IBOutlet UIButton* chickenButton;
	IBOutlet UIButton* dessertButton;
	IBOutlet UIButton* drinkButton;
	IBOutlet UIButton* packButton;
	
	CGPoint buttonOrigin[6];
	
	IBOutlet UIView* topList;
	IBOutlet UIScrollView* topScrollView;

	IBOutlet UIView* bottomList;
	IBOutlet UIScrollView* bottomScrollView;

	IBOutlet UIImageView* burgerBG;
	IBOutlet UIImageView* chickenBG;
	IBOutlet UIImageView* dessertBG;
	IBOutlet UIImageView* drinkBG;
	IBOutlet UIImageView* packBG;
	
	id lastButton;
}

- (IBAction)ButtonClick:(id)sender;
- (void)addIcon:(int)idx isTop:(bool)isTop;
- (void)iconClicked:(int)idx;

@end
