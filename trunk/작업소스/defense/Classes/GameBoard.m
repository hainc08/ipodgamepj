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

- (void)setUpGameBoard
{
	for (int i=0; i<20; ++i)
	{
		enemy[i] = (Enemy*)([[ViewManager getInstance] getInstView:@"Enemy"]);
		[enemy[i] setEnemy:2 level:0];
		[self addSubview:enemy[i]];
		[enemy[i] setCenter:CGPointMake(320, 70*i-300)];
	}
}

@end
