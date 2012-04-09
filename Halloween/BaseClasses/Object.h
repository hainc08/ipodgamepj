#import <UIKit/UIKit.h>

@interface Object : UIViewController {
	//죽더라도 holdTick을 지날 때까지 유지한다.
	bool isDead;
	int holdTick;
	CGPoint pos;
	float rad;
}

@property (readonly) bool isDead;
@property (readonly) float rad;

- (id)init;

- (void)die;
- (void)hit:(float)damage :(int)type :(bool)dir;
- (bool)update:(UInt32)tick;
- (void)debugDraw:(CGContextRef)context;
- (bool)removeProcess;
- (CGPoint*)GetCenPos;

@end
