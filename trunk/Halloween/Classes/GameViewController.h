#import "BaseViewController.h"

@interface GameViewController : BaseViewController {
	int testDelay;
	IBOutlet UIView* objectView;
	IBOutlet UIView* boxView;
	IBOutlet UIView* frontGround;
	
	UIViewController* backView;
	UIViewController* gameUIView;
}

@property (retain) UIView* objectView;
@property (retain) UIView* boxView;

- (void)reset:(NSObject*)param;

@end

