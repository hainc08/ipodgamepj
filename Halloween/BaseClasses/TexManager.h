#import "SpecManager.h"

@interface TexManager : NSObject
{
	UIImage* ghostImg[ENEMYCOUNT][4];
	UIImage* candyImg[CANDYCOUNT];
}

+ (TexManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (void)loadImgs;

- (UIImage*)getGhostImg:(int)type :(int)idx;
- (UIImage*)getCandyImg:(int)type;

@end
