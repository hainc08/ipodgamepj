#import "BaseViewController.h"
#import "BackViewController.h"

@interface GameViewController : BaseViewController {
	BackViewController* backView;

}

- (void)reset:(NSObject*)param;

@end

