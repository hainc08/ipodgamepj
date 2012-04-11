#import "BoxGum.h"
#import "TexManager.h"
#import "GOManager.h"

@implementation Gum

- (id)initWithPos:(CGPoint)p  attack:(GumAttactInfo*)a;

{
	gumColor = rand()%GUMCOUNT;
	self = [super initWithImage:[[TexManager getInstance] getGumImg:gumColor]];
	[self setTransform:halfForm];
	attack = a;
    pos     = p;
	isPop = false;
    popTime =  -1;
	attackDir = (attack->speed < 0);

	[self setCenter:pos];

	return self;
}

- (bool)update
{

	if (isPop)
	{
		++popTime;
		if (popTime == 6) return false;

		[self setImage:[[TexManager getInstance] getGumPopImg:gumColor :popTime]];
	}
	else
	{
		pos.x += attack->speed;
		[self setCenter:pos];
		
		//유령에게 맞은지 체크해야한다.
		Object* hitGhost = (Object*)[[GOManager getInstance] hitCheck:[self center] :attack->rad :attackDir];
		if (hitGhost != nil)
		{
			[hitGhost hit:attack->damage :BOX_GUM :attackDir];

			[self setImage:[[TexManager getInstance] getGumPopImg:gumColor :0]];
			[self setFrame:CGRectMake(pos.x - 40, pos.y - 40, 80, 80)];

			isPop = true;
			popTime = -1;
			return true;
		}
	}

	return ((pos.x > 0)&&(pos.x < 480));
}

@end

@implementation BoxGum

- (id)init
{
	self = [super init];
	boxtype = BOX_GUM;

	return self;
}

- (void)reset
{
	[super reset];
	gums = [[NSMutableArray alloc] initWithCapacity:0];
	discardedGums = [[NSMutableIndexSet alloc] init];
	shotWait = shotDelay = 10.f;
	waitStep = 1.f;
	attackInfo = [[DefaultManager getInstance] getGumInfo:boxtype];
}

- (bool)update:(UInt32)tick
{
	shotWait -= waitStep;

	if (shotWait <= 0)
	{
		CGPoint p = [nozzle center];
		p.x = pos.x - 25 + (p.x * 0.5);
		p.y = pos.y - 25 + (p.y * 0.5);

		Gum* gum = [[Gum alloc] initWithPos:p attack:&attackInfo];
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
