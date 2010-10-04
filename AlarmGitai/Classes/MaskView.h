#import <UIKit/UIKit.h>

@interface MaskView : UIViewController {
	CGImageRef temp;
	UIImage* baseImg;
	UIImage* maskImg;
	
	CGPoint drawAt;
	CGPoint drawTo;
	CGContextRef testContext;
	
	UIImage* char1;
	UIImage* char2;

	NSTimer *updateTimer;
	bool isDirty;
	
	time_t profile1;
	time_t profile2;
}

- (void)reset;
- (void)stopTimer;
- (void)resumeTimer;

@end
