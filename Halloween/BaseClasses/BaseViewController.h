#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController {
	int frameTick;
}

- (void)reset:(NSObject*)param;
- (void)update;

@end

