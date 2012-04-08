#import "BoxGum.h"
#import "TexManager.h"

@implementation Gum

@synthesize damage;

- (id)initWithPos:(CGPoint)p  attack:(GumAttectInfo)a;
{
	self = [super initWithImage:[[TexManager getInstance] getGumImg:rand()%GUMCOUNT]];
	[self setTransform:halfForm];
	pos = p;
	attack = a;
	[self setCenter:pos];

	return self;
}

- (bool)update
{
	pos.x += attack.speed;
	[self setCenter:pos];
	
	//유령에게 맞은지 체크해야한다.
	
	return ((pos.x > 0)&&(pos.x < 480));
}

@end

@implementation BoxGum

- (id)init
{
	self = [super init];

	return self;
}

- (void)reset
{
	[super reset];
	gums = [[NSMutableArray alloc] initWithCapacity:0];
	discardedGums = [[NSMutableIndexSet alloc] init];
	shotWait = shotDelay = 20.f;
	waitStep = 1.f;
}

- (bool)update:(UInt32)tick
{
	shotWait -= waitStep;

	if (shotWait <= 0)
	{
		CGPoint p = [nozzle center];
		p.x = pos.x - 25 + (p.x * 0.5);
		p.y = pos.y - 25 + (p.y * 0.5);

		Gum* gum = [[Gum alloc] initWithPos:p attack:[[DefaultManager getInstance] getGumInfo:boxtype]];
		[gums addObject:gum];
		//박스의 상위 뷰에다가 추가해준다.
		[[self.view superview] addSubview:gum];

		shotWait = shotDelay;
	}
	
	NSUInteger index = 0;
	[discardedGums removeAllIndexes];
	
	for (Gum* gum in gums)
	{
		if ([gum update] == false)
		{
			[discardedGums addIndex:index];
			[gum removeFromSuperview];
			[gum release];
		}
		
		++index;
	}
	
	[gums removeObjectsAtIndexes:discardedGums];

	return [super update:tick];
}

@end
