#import "PointManager.h"
#import "HighScoreManager.h"

static PointManager *PointManagerInst;

@implementation PointManager

@synthesize point;
@synthesize maxIdx;

+ (PointManager*)getInstance
{
	return PointManagerInst;
}

+ (void)initManager
{
	PointManagerInst = [PointManager alloc];
	PointManagerInst->point = 0;
	for (int i=0; i<2; ++i)
	{
		PointManagerInst->maxPoint[i] = [[HighScoreManager getInstance] getHighScore:i];
	}
}

- (void)addPoint:(int)p
{
	point += p;
	if (maxPoint[maxIdx] < point) maxPoint[maxIdx] = point;
}

- (void)closeManager
{
}

- (int)getMaxPoint
{
	return maxPoint[maxIdx];
}

@end
