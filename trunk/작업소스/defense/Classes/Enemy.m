#import "Enemy.h"
#import "UnitTexManager.h"

@implementation Enemy

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	return self;
}

-(void)setEnemy:(int)idx level:(int)level
{
	//나중에 메니져 하나 만들어서 중앙에서 관리하게 해준다.
	UIImage* img1 = [[UnitTexManager getInstance] getEnemyTex:idx];
	UIImage* img2 = [[UnitTexManager getInstance] getEnemyShadowTex:idx];
	[EnemyImage setImage:img1];
	[EnemyImage setSize:[img1 size]];
	[EnemyShadow setImage:img2];
	[EnemyShadow setSize:[img2 size]];}

@end
