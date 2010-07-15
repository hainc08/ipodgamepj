#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "DataManager.h"

@interface ItemView : BaseView {
	IBOutlet id backButton;
	IBOutlet id nextButton;
	IBOutlet id prevButton;

	UIButton* imageButton[15];
	UIButton* imageBigButton;
	
	int curPage;

	EventList* eList;
}

- (IBAction)ButtonClick:(id)sender;
- (void)loadPage:(int)page;

@end
