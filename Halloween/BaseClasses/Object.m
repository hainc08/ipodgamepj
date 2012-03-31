#import "Object.h"

@implementation Object

@synthesize isDead;

- (bool)update:(UInt32)tick
{
	if (isDead)
	{
		if (holdTick == 0)
		{
			return [self removeProcess];
		}
		--holdTick;
	}

	return true;
}

- (id)init
{
	self = [super init];

	isDead = false;
	holdTick = 40;	//기본적으로 죽더라도 2초를 유지시키자...

	return self;
}

- (void)die
{
	isDead = true;
}

- (void)debugDraw:(CGContextRef)context
{
	//할게 있나?
}

- (bool)removeProcess
{
	[self.view removeFromSuperview];
	return false;
}

@end
