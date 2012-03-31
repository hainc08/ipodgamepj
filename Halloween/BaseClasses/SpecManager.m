#import "SpecManager.h"
#import "PointManager.h"
#import "SoundManager.h"

static SpecManager *SpecManagerInst;

@implementation SpecManager

+ (SpecManager*)getInstance
{
	return SpecManagerInst;
}

+ (void)initManager;
{
	SpecManagerInst = [SpecManager alloc];
	[SpecManagerInst initSpec];
}

- (void)closeManager
{
	
}

- (void)initSpec
{
	enemy[0].maxLife = 30;
	enemy[0].speed = 1.5;
	enemy[0].point = 20;
}

- (void)loadFromFile
{
}

- (void)saveToFile
{
}

- (BaseSpec*)getEnemySpec:(int)idx
{
	return &enemy[idx];
}

@end
