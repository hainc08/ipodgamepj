#import <UIKit/UIKit.h>
#import "Enemy.h"

@interface GameBoard : UIView {
	Enemy* enemy[20];
	CGPoint* path;
	
	UInt32 frameTick;
}

- (void)setUpGameBoard:(CGPoint*)p count:(int)c;
- (void)update:(UInt32)tick;
@end
