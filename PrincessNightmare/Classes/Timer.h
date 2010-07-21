#import <UIKit/UIKit.h>

@interface Timer : UIView {
	IBOutlet id sandUp;
	IBOutlet id sandDown;

	IBOutlet id sandUpMask;
	IBOutlet id sandDownMask;
}

- (void)startTimer:(float)t;

@end
