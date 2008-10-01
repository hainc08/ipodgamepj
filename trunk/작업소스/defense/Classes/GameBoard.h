#import <UIKit/UIKit.h>
#import "Enemy.h"

@interface GameBoard : UIView {
	Enemy* enemy[20];
}

- (void)setUpGameBoard;
@end
