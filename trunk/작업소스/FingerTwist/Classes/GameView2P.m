#import "GameView2P.h"
#import "ViewManager.h"
#import "TouchPoint.h"

@implementation GameView2P

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	[self setUpTouchPoint];
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	[self setUpTouchPoint];
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//다음뷰로 이동 한다. - 여기는 단순한 화면터치...
}

- (void)setUpTouchPoint {
	for (int i=0; i<11; ++i)
	{
		touchPoints[i] = (TouchPoint*)([[ViewManager getInstance] getInstView:@"TouchPoint"]);
	}

	touchPoints[0].center = self.center;
	[self addSubview:touchPoints[0]];
}

- (void)dealloc {
	for (int i=0; i<11; ++i)
	{
		[touchPoints[i] release];
	}
	[super dealloc];	
}

@end
