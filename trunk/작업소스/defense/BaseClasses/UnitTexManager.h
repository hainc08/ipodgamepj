
@interface UnitTexManager : NSObject
{
	UIImage* enemyTex[8];
	UIImage* enemyShadowTex[8];
}

+ (UnitTexManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (UIImage*)getEnemyTex:(int)idx;
- (UIImage*)getEnemyShadowTex:(int)idx;

@end
