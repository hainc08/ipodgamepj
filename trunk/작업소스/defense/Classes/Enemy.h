#import <UIKit/UIKit.h>

@interface Enemy : UIView {
    IBOutlet id EnemyImage;
    IBOutlet id EnemyShadow;
}

-(void)setEnemy:(int)idx level:(int)level;

@end
