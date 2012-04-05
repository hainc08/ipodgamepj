#import "SpecManager.h"

@interface TexManager : NSObject
{
	UIImage* ghostImg[ENEMYCOUNT][4];
	UIImage* candyImg[CANDYCOUNT];
    UIImage* boxImg[BOXCOUNT];
}

+ (TexManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (void)loadImgs;

- (UIImage*)getGhostImg:(int)type :(int)idx;
- (UIImage*)getCandyImg:(int)type;
- (UIImage*)getBoxImg:(int)type;
@end