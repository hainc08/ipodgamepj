#import "Ghost.h"
#import "GOManager.h"

@implementation Ghost

- (id)init
{
	self = [super init];
	
	[[GOManager getInstance] addEnemy:self];
	pos = MakePoint[0];
	
	return self;
}

- (void)reset
{
	[self.view setCenter:pos];
	[self.view setTransform:halfForm];
}

- (bool)update:(UInt32)tick
{
	pos.x += 3;
	[self.view setCenter:pos];

	return [super update:tick];
}


@end
