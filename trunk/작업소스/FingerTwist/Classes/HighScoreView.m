#import "HighScoreView.h"
#import "ViewManager.h"
#import "HighScoreBoard.h"

@implementation HighScoreView

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	[self setUpHighScoreBoard];
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	[self setUpHighScoreBoard];
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//다음뷰로 이동 한다. - 여기는 단순한 화면터치...
}

- (void)setUpHighScoreBoard {
	for (int i=0; i<10; ++i)
	{
		highScoreBoard[i] = (HighScoreBoard*)([[ViewManager getInstance] getInstView:@"HighScoreBoard"]);
		CGPoint pos = self.center;
		pos.y = 30 + 30 * i;
		
		highScoreBoard[i].center = pos;
		[self addSubview:highScoreBoard[i]];
	}
}

- (IBAction)ButtonClick:(id)sender
{
	if (sender == ResetPButton)
	{
		//HighScore리셋...
	}
	else if (sender == MainMenuButton)
	{
		[[ViewManager getInstance] changeView:@"MainMenuView"];
	}
}

- (void)dealloc {
	for (int i=0; i<10; ++i)
	{
		[highScoreBoard[i] release];
	}
	[super dealloc];	
}

@end
