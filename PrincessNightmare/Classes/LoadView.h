#import <UIKit/UIKit.h>
#import "LoadSaveBar.h"

@interface LoadView : UIView {
	IBOutlet id backButton;
	IBOutlet id nextButton;
	IBOutlet id prevButton;

	IBOutlet UILabel* pageLabel;

	LoadSaveBar* bars[4];

	int curPage;
}

- (IBAction)ButtonClick:(id)sender;
- (void)loadPage:(int)page;
- (void)reset:(NSObject*)param;

@end
