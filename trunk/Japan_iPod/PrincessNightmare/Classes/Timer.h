#import <UIKit/UIKit.h>

@interface Timer : UIView {
	IBOutlet id sandUp;
	IBOutlet id sandDown;

	IBOutlet id sandUpMask;
	IBOutlet id sandDownMask;

	IBOutlet id timerBase;
	IBOutlet id timeOver;
	
	int leftTime;
	int maxTime;
}

- (void)startTimer:(float)t;
- (bool)update;
- (void)stop;

@end
