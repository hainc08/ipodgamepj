#import "DetailViewController.h"
#import "UIViewControllerTemplate.h"		

@interface MenuBodyViewController : UIViewControllerTemplate<UIScrollViewDelegate , UITextFieldDelegate> {
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
	float alphaValue[5];

	IBOutlet UIImageView* normalBG1;
	IBOutlet UIImageView* normalBG2;

	IBOutlet UITextField* searchField;
	UIToolbar *toolbar;
	id lastButton;
	id lastIconButton;
	
	IBOutlet UIView* fieldGuard;
}

- (void)back;
- (IBAction)ButtonClick:(id)sender;
- (IBAction)FindClick;
- (void)addIcon:(NSString*)menuId isTop:(bool)isTop;
- (void)iconClicked:(id)button :(NSString*)mid;
- (void)setScrollBar:(NSString*)category;

- (IBAction)FieldStart;
- (IBAction)FieldEnd;

@end
