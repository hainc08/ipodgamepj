#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "LoadSaveBar.h"

@interface LoadView : BaseView {
	IBOutlet id backButton;
	IBOutlet id nextButton;
	IBOutlet id prevButton;

	LoadSaveBar* bars[4];

	int curPage;
}

- (IBAction)ButtonClick:(id)sender;
- (void)loadPage:(int)page;

@end
