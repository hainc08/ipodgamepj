#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface MainTopView : BaseView {
	IBOutlet id start;
	IBOutlet id load;
	IBOutlet id config;
	IBOutlet id extra;
	IBOutlet id exit;

	IBOutlet id loadingtime;
	
	bool loadingDone;
}

- (IBAction)ButtonClick:(id)sender;
@end
