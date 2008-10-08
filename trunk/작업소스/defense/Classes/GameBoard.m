#import "GameBoard.h"
#import "ViewManager.h"

@implementation GameBoard

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	return self;
}

- (void)update:(UInt32)tick
{
	frameTick = tick;
	for (int i=0; i<20; ++i)
	{
		[enemy[i] update:tick];
	}
}

- (void)setUpGameBoard:(CGPoint*)p count:(int)c
{
	path = p;
	int waitTime = 0;
	for (int i=0; i<20; ++i)
	{
		enemy[i] = (Enemy*)([[ViewManager getInstance] getInstView:@"Enemy"]);
		[enemy[i] setEnemy:5 level:0 wait:waitTime];
		[enemy[i] setPath:p count:c];
		[self addSubview:enemy[i]];
		waitTime += 5 + (rand() % 10);
	}
}

@end
