#import "Box.h"
#import "TexManager.h"
#import "GOManager.h"

@implementation Box
@synthesize floor;
- (id)init
{
	self = [super init];
	
	pos = BoxPoint;
	[[GOManager getInstance] addBox:self];

	return self;
}

- (void)reset
{

    pos.y -= (50 * floor);
    
	[self.view setCenter:pos];
	[self.view setTransform:halfForm];
}

- (bool)update:(UInt32)tick
{
	return [super update:tick];
}


@end
