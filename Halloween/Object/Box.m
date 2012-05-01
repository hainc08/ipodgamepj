#import "Box.h"
#import "TexManager.h"
#import "GOManager.h"

@implementation Box

@synthesize fallYpos;
@synthesize isFall;

- (id)init
{
	self = [super init];
	
	pos = BoxPoint;
	[[GOManager getInstance] addBox:self];
	effectView = NULL;
	
	return self;
}

- (void)reset
{
	if (effectView == NULL)
	{
		effectView = [[UIImageView alloc] initWithFrame:CGRectMake(-60, 32, 220, 68)];
		[self.view addSubview:effectView];
		[effectView setAlpha:0];
	}
	
	popEffect = -1;
	[self.view setCenter:pos];
	[self.view setTransform:CGAffineTransformMake(0.5, 0, 0, 0.5, rand()%3 - 6, 0)];
}

- (bool)update:(UInt32)tick
{
	if (fallYpos > pos.y)
	{
		isFall = true;

		fallSpeed += 2;
		pos.y += fallSpeed;

		if (fallYpos <= pos.y)
		{
			isFall = false;
			popEffect = 0;
			pos.y = fallYpos;
		}
		
		[self.view setCenter:pos];
		
		if ([[GOManager getInstance] HitGhostByBox:pos])
		{
			fallSpeed = -7;
			popEffect = 0;
		}
	}
	
	if (popEffect != -1)
	{
		if (popEffect == 4)
		{
			[effectView setAlpha:0];
			popEffect = -1;
		}
		else
		{
			[effectView setImage:[[TexManager getInstance] getBoxPopImg:popEffect]];
			[effectView setAlpha:1];
			++popEffect;
		}
	}

	return [super update:tick];
}

- (void)drop:(int)xPos :(int)yPos :(int)yPos2;
{
	pos.x = xPos;
	pos.y = yPos;
	fallYpos = yPos2;
	
	fallSpeed = 5;
}

@end
