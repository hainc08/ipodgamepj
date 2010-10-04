#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "DataManager.h"

@interface ItemView : BaseView {
	IBOutlet id closeButton;

	IBOutlet id backButton;
	IBOutlet id nextButton;
	IBOutlet id prevButton;

	IBOutlet id descView;
	IBOutlet id itemImg;
	IBOutlet id itemName;
	IBOutlet id itemDesc;

	IBOutlet UILabel* pageLabel;
	
	UIButton* imageButton[15];
	UIButton* imageBigButton;
	
	int curPage;

	EventList* eList;
}

- (IBAction)ButtonClick:(id)sender;
- (void)loadPage:(int)page;

@end
