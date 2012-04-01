#import <UIKit/UIKit.h>

@interface Object : UIViewController {
	//죽더라도 holdTick을 지날 때까지 유지한다.
	bool isDead;
	int holdTick;
	CGPoint pos;
}

@property (readonly) bool isDead;

- (id)init;

- (void)die;
- (bool)update:(UInt32)tick;
- (void)debugDraw:(CGContextRef)context;
- (bool)removeProcess;

@end
