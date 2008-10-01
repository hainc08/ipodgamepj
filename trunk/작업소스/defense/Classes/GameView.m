#import "GameView.h"
#import "ViewManager.h"

@implementation GameView

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	[self setUpGameBoard];
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	[self setUpGameBoard];
	return self;
}

- (void)reset:(NSObject*)param
{
	[super reset:param];

	zoomed = true;
	[board setCenter:[self center]];
	[self zoomOut];
	menuState = -1;
	[self showMenu:0 Ani:false];
}

- (IBAction)ButtonClick:(id)sender
{
	if (!zoomed) return;

	if (sender == selector)
	{
		[self showMenu:1 Ani:true];
	}
	else if (sender == moveButton)
	{
		moveMode = true;
		[moveImg setAlpha:1.0];
		[selector setAlpha:0.0];
		[self showMenu:0 Ani:true];
	}
	else if (sender == selectButton)
	{
		moveMode = false;
		[moveImg setAlpha:0.0];
		[selector setAlpha:1.0];
	}	
	else if (sender == zoomOutButton)
	{
		[self zoomOut];
	}
}

//ButtonClick에 너무 많이 붙어서 그냥 둘로 나눈것...
- (IBAction)MenuButtonClick:(id)sender
{
	if (!zoomed) return;
	
	if (sender == buildButton)
	{
		[self showMenu:3 Ani:true];
	}
}

- (void)zoomOut
{
	CGPoint pos;
	[self setBoardMove:pos Zoomed:false];
	[self showMenu:0 Ani:true];
}

- (void)setBoardMove:(CGPoint)pos Zoomed:(bool)zoom
{
	if (!zoom && !zoomed) return;

	[self showMenu:0 Ani:true];

	[UIView beginAnimations:@"move" context:NULL];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	
	if (zoom)
	{
		pos.x = pos.x * 40 + 20 - 160;
		pos.y = pos.y * 40 + 20 - 240;

		boardPos.x = 160 - pos.x;
		boardPos.y = 240 - pos.y;
		board.transform = CGAffineTransformMake(1.0, 0.0, 0.0, 1.0, boardPos.x, boardPos.y);
		if (!moveMode)
		{
			[selector setAlpha:1.0];
			[zoomOutButton setAlpha:1.0];
			[moveButton setAlpha:1.0];
		}
	}
	else
	{
		//줌아웃 시에는 포지션은 무시된다.
		board.transform = CGAffineTransformMake(0.5, 0.0, 0.0, 0.5, 0.0, 0.0);
		[moveImg setAlpha:0.0];
		[selector setAlpha:0.0];
		[zoomOutButton setAlpha:0.3];
		[moveButton setAlpha:0.3];
	}

	[UIView commitAnimations];
	
	zoomed = zoom;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	int count = [touches count];
	
	if (count == 1)
	{
		if (!moveMode) return;
		
		selectedPos.x = (int)((320 - boardPos.x)/40);
		selectedPos.y = (int)((480 - boardPos.y)/40);

		[self setBoardMove:selectedPos Zoomed:true];
	}	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	int count = [touches count];
	UITouch *touch;
	NSEnumerator *touchEnum = [touches objectEnumerator];
	
	if (count == 1)
	{
		if (!moveMode) return;
		touch = [touchEnum nextObject];
		CGPoint dragMove = [touch locationInView: self];

		boardPos.x += dragMove.x - dragBegin.x;
		boardPos.y += dragMove.y - dragBegin.y;
		board.transform = CGAffineTransformMake(1.0, 0.0, 0.0, 1.0, boardPos.x, boardPos.y);
		dragBegin = dragMove;
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	int count = [touches count];
	UITouch *touch;
	NSEnumerator *touchEnum = [touches objectEnumerator];

	if (count == 1)
	{
		if (moveMode)
		{
			touch = [touchEnum nextObject];
			dragBegin = [touch locationInView: self];
		}
		else
		{
			//셀렉트...
			touch = [touchEnum nextObject];
			CGPoint pos = [touch locationInView: board];

			selectedPos.x = (int)((pos.x + 160) / 40);
			selectedPos.y = (int)((pos.y + 240) / 40);

			[self setBoardMove:selectedPos Zoomed:true];
		}
	}
}

- (void)setUpGameBoard;
{
	board = (GameBoard*)([[ViewManager getInstance] getInstView:@"GameBoard"]);
	[board setUpGameBoard];
	[self addSubview:board];
	[self sendSubviewToBack:board];
	
	menuPos[0] = CGPointMake(160, 155);
	menuPos[1] = CGPointMake(232, 196);
	menuPos[2] = CGPointMake(232, 288);
	menuPos[3] = CGPointMake(160, 325);
	menuPos[4] = CGPointMake(88, 288);
	menuPos[5] = CGPointMake(88, 196);
}

- (void)dealloc {
	[board release];
	[super dealloc];	
}

- (void)showMenu:(int)idx Ani:(bool)isAni
{
	if (menuState == idx) return;

	if (isAni)
	{
		[UIView beginAnimations:@"menu" context:NULL];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	}
	
	switch(idx)
	{
		case 0:
			//모두 숨기기...
			[self menuButtonSet:10 show:false];
			[self menuButtonSet:20 show:false];
			[self menuButtonSet:21 show:false];
			[self menuButtonSet:30 show:false];
			[self menuButtonSet:31 show:false];
			[self menuButtonSet:32 show:false];
			[self menuButtonSet:33 show:false];
			[self menuButtonSet:34 show:false];
			[self menuButtonSet:35 show:false];
			break;
		case 1:
			[self menuButtonSet:10 show:true];
			[self menuButtonSet:20 show:false];
			[self menuButtonSet:21 show:false];
			[self menuButtonSet:30 show:false];
			[self menuButtonSet:31 show:false];
			[self menuButtonSet:32 show:false];
			[self menuButtonSet:33 show:false];
			[self menuButtonSet:34 show:false];
			[self menuButtonSet:35 show:false];
			break;
		case 2:
			[self menuButtonSet:10 show:false];
			[self menuButtonSet:20 show:true];
			[self menuButtonSet:21 show:true];
			[self menuButtonSet:30 show:false];
			[self menuButtonSet:31 show:false];
			[self menuButtonSet:32 show:false];
			[self menuButtonSet:33 show:false];
			[self menuButtonSet:34 show:false];
			[self menuButtonSet:35 show:false];
			break;
		case 3:
			[self menuButtonSet:10 show:false];
			[self menuButtonSet:20 show:false];
			[self menuButtonSet:21 show:false];
			[self menuButtonSet:30 show:true];
			[self menuButtonSet:31 show:true];
			[self menuButtonSet:32 show:true];
			[self menuButtonSet:33 show:true];
			[self menuButtonSet:34 show:true];
			[self menuButtonSet:35 show:true];
			break;
	}

	if (isAni) [UIView commitAnimations];
	menuState = idx;
}

- (void)menuButtonSet:(int)idx show:(bool)isShow
{
	id buttonId;
	switch (idx)
	{
		case 10: buttonId = buildButton; break;
		case 20: buttonId = sellButton; break;
		case 21: buttonId = upgradeButton; break;
		case 30: buttonId = build0; break;
		case 31: buttonId = build1; break;
		case 32: buttonId = build2; break;
		case 33: buttonId = build3; break;
		case 34: buttonId = build4; break;
		case 35: buttonId = build5; break;
	}
	
	if (isShow)
	{
		[buttonId setCenter:menuPos[idx%10]];	
		[buttonId setAlpha:1.0];
	}
	else
	{
		[buttonId setCenter:[self center]];	
		[buttonId setAlpha:0.0];
	}
}

@end
