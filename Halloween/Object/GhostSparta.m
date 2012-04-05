#import "GhostSparta.h"
#import "GOManager.h"
#import "TexManager.h"

@implementation GhostSparta

- (id)initWithType:(int)type
{
	self = [super initWithType:type];

	cenOffset = CGPointMake(0, -12.5);
	
	return self;
}

- (void)reset
{
	[super reset];
}

- (bool)update:(UInt32)tick
{
	return [super update:tick];
}


@end
