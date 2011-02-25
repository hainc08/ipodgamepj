#import "DetailViewController.h"
@interface NaviViewController : UINavigationController
{
	int idx;
	UIButton* helpButton;
	UIButton* listButton;
}

@property (readwrite) int idx;
@property (retain) UIButton* helpButton;
@property (retain) UIButton* listButton;

@end
