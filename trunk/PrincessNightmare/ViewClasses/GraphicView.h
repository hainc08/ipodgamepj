#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "DataManager.h"

@interface GraphicView : BaseView {
	IBOutlet id backButton;
	IBOutlet id nextButton;
	IBOutlet id prevButton;

	UIButton* imageButton[12];
	UIButton* imageBigButton;
	
	int curPage;

	EventList* eList;
	UIImage* baseImg;
}

- (IBAction)ButtonClick:(id)sender;
- (void)loadPage:(int)page;

@end
