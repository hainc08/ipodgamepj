#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface SceneView : UIView {
	bool showOK;
	bool showEnd;
	int waitTick;

	IBOutlet id backImg;
	IBOutlet id subTitle;
}

@property (readonly) bool showEnd;

- (void)update;
- (bool)makeScene:(Scene*)scene;

@end
