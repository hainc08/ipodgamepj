@interface TexManager : NSObject
{
	UIImage* ghostImg[ENEMYCOUNT][4];
	UIImage* candyImg[CANDYCOUNT];
    UIImage* boxImg[BOXCOUNT];
    UIImage* gumImg[GUMCOUNT];
    UIImage* gumPopImg[GUMCOUNT][6];
    UIImage* icePopImg[6];
    UIImage* boxPopImg[4];
}

+ (TexManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (void)loadImgs;

- (UIImage*)getGhostImg:(int)type :(int)idx;
- (UIImage*)getCandyImg:(int)type;
- (UIImage*)getBoxImg:(int)type;
- (UIImage*)getGumImg:(int)type;
- (UIImage*)getGumPopImg:(int)type :(int)idx;
- (UIImage*)getIcePopImg:(int)idx;
- (UIImage*)getBoxPopImg:(int)idx;

@end
