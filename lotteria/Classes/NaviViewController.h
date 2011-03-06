#import "DetailViewController.h"
@interface NaviViewController : UINavigationController
{
	int idx;
	UIButton* helpButton;
	UIButton* listButton;
	
	UIViewController* body;
	UIViewController* parentView;
}

@property (readwrite) int idx;
@property (retain) UIButton* helpButton;
@property (retain) UIButton* listButton;
@property (retain) UIViewController* body;
@property (retain) UIViewController* parentView;

@end
