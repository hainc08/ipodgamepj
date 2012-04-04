#import "Box.h"
#import "TexManager.h"

@implementation Box
@synthesize floor;
- (id)init
{
	self = [super init];
	
	pos = BoxPoint;

	return self;
}

- (void)reset
{
	[imgView setImage:[[TexManager getInstance] getBoxImg:rand()%BOXCOUNT]];
    pos.y -= (50 * floor);
	[self.view setCenter:pos];
	[self.view setTransform:halfForm];
}

- (bool)update:(UInt32)tick
{
	return [super update:tick];
}


@end
