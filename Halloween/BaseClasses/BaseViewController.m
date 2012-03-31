#import "BaseViewController.h"

@implementation BaseViewController

- (void)reset:(NSObject*)param
{
	frameTick = 0;
}

- (void)update
{
	++frameTick;
}

@end
