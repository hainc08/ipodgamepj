#import <UIKit/UIKit.h>
#import "BaseView.h"

@class TouchPoint;

@interface GameView1P : BaseView {
	int pointCount;
	TouchPoint *touchPoints[11];
}
	
- (void)setUpTouchPoint;
	
@end
