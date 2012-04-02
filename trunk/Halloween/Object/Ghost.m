#import "Ghost.h"
#import "GOManager.h"
#import "TexManager.h"

@implementation Ghost

- (id)initWithType:(int)type
{
	self = [super init];
	
	[[GOManager getInstance] addEnemy:self];
	pos = MakePoint[0];
	
	for (int i=0; i<4; ++i)
	{
		img[i] = [[TexManager getInstance] getGhostImg:type :i];
	}

	imgIdx = 0;
	
	return self;
}

- (void)reset
{
	[self.view setCenter:pos];
	[self.view setTransform:halfForm];
}

- (bool)update:(UInt32)tick
{
	imgIdx = (imgIdx + 1) % 4;
	[imgView setImage:img[imgIdx]];
	
	pos.x += 3;
	[self.view setCenter:pos];

	return [super update:tick];
}


@end
