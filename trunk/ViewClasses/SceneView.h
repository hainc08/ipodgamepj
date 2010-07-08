#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface SceneView : UIView {
	bool showOK;
	bool showEnd;
	int waitTick;
}

@property (readonly) bool showEnd;

- (void)update;
- (bool)makeScene:(Scene*)scene;

@end
