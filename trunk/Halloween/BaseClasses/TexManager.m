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
    
    for (int i=0; i<BOXCOUNT; ++i)
	{
		boxImg[i] = [UIImage imageNamed:[NSString stringWithFormat:@"box%d.png", i]];
	}

    for (int i=0; i<GUMCOUNT; ++i)
	{
		gumImg[i] = [UIImage imageNamed:[NSString stringWithFormat:@"gum%d.png", i]];
		for (int j=0; j<6; ++j)
		{
			gumPopImg[i][j] = [UIImage imageNamed:[NSString stringWithFormat:@"gum_pop_%d_%d.png", i, j]];
		}
	}
	
	for (int j=0; j<6; ++j)
	{
		icePopImg[j] = [UIImage imageNamed:[NSString stringWithFormat:@"ice_pop_%d.png", j]];
	}
	
	for (int j=0; j<4; ++j)
	{
		boxPopImg[j] = [UIImage imageNamed:[NSString stringWithFormat:@"BoxPop_%d.png", j]];
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

- (UIImage*)getGumImg:(int)type
{
	return gumImg[type];
}

- (UIImage*)getGumPopImg:(int)type :(int)idx
{
	return gumPopImg[type][idx];
}

- (UIImage*)getIcePopImg:(int)idx
{
	return icePopImg[idx];
}

- (UIImage*)getBoxPopImg:(int)idx
{
	return boxPopImg[idx];
}

@end
