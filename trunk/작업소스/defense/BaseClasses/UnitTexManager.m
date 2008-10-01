#import "UnitTexManager.h"
static UnitTexManager *unitTexManagerInst;

@implementation UnitTexManager

+ (UnitTexManager*)getInstance
{
	return unitTexManagerInst;
}

+ (void)initManager
{
	unitTexManagerInst = [UnitTexManager alloc];
	for (int i=0; i<8; ++i)
	{
		unitTexManagerInst->enemyTex[i] = [UIImage imageNamed:[NSString stringWithFormat:@"e%d.png", i+1]];
		unitTexManagerInst->enemyShadowTex[i] = [UIImage imageNamed:[NSString stringWithFormat:@"e%d_s.png", i+1]];
	}
}

- (UIImage*)getEnemyTex:(int)idx
{
	return enemyTex[idx-1];
}

- (UIImage*)getEnemyShadowTex:(int)idx
{
	return enemyShadowTex[idx-1];
}

- (void)closeManager
{
	for (int i=0; i<8; ++i)
	{
		[enemyTex[i] release];
		[enemyShadowTex[i] release];
	}
}

@end
