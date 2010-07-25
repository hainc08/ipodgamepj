#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "SaveView.h"

@interface SceneView : UIView {
	bool showOK;
	bool showEnd;
	int waitTick;

	IBOutlet id backImg;
	IBOutlet id backImg2;
	IBOutlet id backImg3;
	IBOutlet id subTitle;
	IBOutlet id subTitle2;

	IBOutlet id saveButton;
	IBOutlet id yesButton;
	IBOutlet id noButton;
	
	int phase;

	SaveView* saveView;
}

@property (readonly) bool showEnd;

- (IBAction)ButtonClick:(id)sender;
- (void)update;
- (bool)makeAfterScene:(Scene*)scene;
- (bool)makeBeforeScene:(Scene*)scene;

@end
