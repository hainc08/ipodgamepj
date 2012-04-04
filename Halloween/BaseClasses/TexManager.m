#import "TexManager.h"
static TexManager *texManagerInst;

@implementation TexManager

+ (TexManager*)getInstance
{
	return texManagerInst;
}

+ (void)initManager
{
	texManagerInst = [TexManager alloc];
	[texManagerInst loadImgs];

	return;
}

- (void)closeManager
{
}

- (void)loadImgs
{
	for (int i=0; i<ENEMYCOUNT; ++i)
	{
		for (int j=0; j<4; ++j)
		{
			ghostImg[i][j] = [UIImage imageNamed:[NSString stringWithFormat:@"ghost%d_%d.png", i, j]];
		}
	}
	
	for (int i=0; i<CANDYCOUNT; ++i)
	{
		candyImg[i] = [UIImage imageNamed:[NSString stringWithFormat:@"candy%d.png", i]];
	}
    
    for (int i=0; i< BOXCOUNT; ++i)
	{
		boxImg[i] = [UIImage imageNamed:[NSString stringWithFormat:@"box%d.png", i]];
	}
	
}

- (UIImage*)getGhostImg:(int)type :(int)idx
{
	return ghostImg[type][idx];
}

- (UIImage*)getCandyImg:(int)type
{
	return candyImg[type];
}

- (UIImage*)getBoxImg:(int)type
{
	return boxImg[type];
}
@end
