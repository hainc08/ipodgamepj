#import "BaseViewController.h"
#import "BackViewController.h"

@interface GameViewController : BaseViewController {
	BackViewController* backView;
	int testDelay;
}

- (void)reset:(NSObject*)param;

@end

