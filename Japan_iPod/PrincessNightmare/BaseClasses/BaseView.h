#import <UIKit/UIKit.h>

@interface BaseView : UIView {
	UInt32 frameTick;
	NSTimer *updateTimer;
	bool isInit;
	
	float framePerSec;
}

- (void)reset:(NSObject*)param;
- (void)update;
- (void)stopTimer;
- (void)resumeTimer;

@end

