#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "DataManager.h"

@interface ScineView : BaseView {
	IBOutlet id backButton;
	IBOutlet id nextButton;
	IBOutlet id prevButton;

	UILabel* buttonLabel[10];
	UIButton* imageButton[10];
	UIButton* imageBigButton;
	
	int curPage;

	EventList* eList;
	UIImage* baseImg[2];
}

- (IBAction)ButtonClick:(id)sender;
- (void)loadPage:(int)page;

@end
