#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "LoadView.h"

@interface MainTopView : BaseView {
	IBOutlet id start;
	IBOutlet id load;
	IBOutlet id config;
	IBOutlet id extra;

	IBOutlet id loadingtime;
	
	bool loadingDone;
	LoadView* loadView;
}

- (IBAction)ButtonClick:(id)sender;
@end
