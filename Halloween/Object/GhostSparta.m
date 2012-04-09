#import "GhostSparta.h"
#import "GOManager.h"
#import "TexManager.h"

@implementation GhostSparta

- (id)initWithType:(int)type
{
	self = [super initWithType:type];

	cenOffset = CGPointMake(0, -12.5);
	shieldAlpha = 1;
	shieldHealth = 30;
	
	return self;
}

- (void)hit:(float)damage :(int)type :(bool)dir
{
	//움직이는 방향으로 맞았을 때...
	if ((shieldHealth > 0) && (dir == (ghost_state == GHOST_NONE)))
	{
		shieldHealth -= damage;
	}
	else
	{
		[super hit:damage :type :dir];
	}
}

- (void)reset
{
	[super reset];
}

- (bool)update:(UInt32)tick
{
	if ((shieldHealth <= 0)&&(shieldAlpha > 0))
	{
		shieldAlpha -= 0.1;
		[Shield setAlpha:shieldAlpha];
	}
	
	return [super update:tick];
}


@end
