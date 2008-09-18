#import <UIKit/UIKit.h>
#import "BaseView.h"

@class TouchPoint;

@interface Game2PParam : NSObject
{
	
}

@end

@interface GameView2P : BaseView {
	int pointCount;
	TouchPoint *touchPoints[11];
}
	
- (void)setUpTouchPoint;
	
@end
