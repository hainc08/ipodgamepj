#import <UIKit/UIKit.h>

@interface BaseView : UIView {
	UInt32 frameTick;
	NSTimer *updateTimer;
}

- (void)reset;
- (void)update;
- (void)stopTimer;
- (void)resumeTimer;

@end

