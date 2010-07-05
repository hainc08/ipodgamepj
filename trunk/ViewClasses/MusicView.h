#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "DataManager.h"

@interface MusicView : BaseView {
	IBOutlet id backButton;
	IBOutlet id nextButton;
	IBOutlet id prevButton;

	IBOutlet id stopButton;

	UIButton* imageButton[16];
	
	int curPage;
}

- (IBAction)ButtonClick:(id)sender;
- (void)loadPage:(int)page;

@end
