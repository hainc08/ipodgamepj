#import "BaseViewController.h"

@interface GameViewController : BaseViewController {
	int testDelay;
	IBOutlet UIView* objectView;
	
	UIViewController* backView;
	UIViewController* gameUIView;
}

- (void)reset:(NSObject*)param;

@end

