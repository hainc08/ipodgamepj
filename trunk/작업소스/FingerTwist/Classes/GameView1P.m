#import "GameView1P.h"
#import "ViewManager.h"
#import "TouchPoint.h"

@implementation Game1PParam
@end

@implementation GameView1P

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	[self setUpTouchPoint];
	[self setUpMessageView];
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	[self setUpTouchPoint];
	[self setUpMessageView];
	return self;
}

- (void)reset:(NSObject*)param
{
	[super reset:param];
	Game1PParam* gameParam = (Game1PParam*)param;

	[self resetTouchPoint];
	[msgView reset];

	newPointTick = 0;
	processStep = 0;
	touchCount = 0;
	stageNumber = gameParam->stageNumber; 
	pointCount = gameParam->pointCount;
	gameEnd = false;
	gameStart = false;

	difficult = gameParam->difficult;

	CGPoint pos;
	pos.x = -300;
	pos.y = -300;
	[targetCircle setCenter: pos];
	
	[gameParam release];
}

- (int)getNextTouchPointIdx
{
	int r = rand() % totProp;
	int idx;
	
	for (idx=0; idx<PCOUNT; ++idx)
	{
		r -= prop[idx];
		if (r < 0) break;
	}

	totProp -= prop[idx];
	prop[idx] = 0;
	float downPer;

	switch (difficult)
	{
		case 0:
			downPer = 0.5f;
			break;
		case 1:
			downPer = 0.8f;
			break;
		case 2:
			return idx;
	}

	for (int idx2=0; idx2<PCOUNT; ++idx2)
	{
		if ([self checkDistance:pointPos[idx] to:pointPos[idx2]] < 70.f)
		{
			totProp -= prop[idx2] * (1 - downPer);
			prop[idx2] *= downPer;
		}
	}
	
	return idx;
}

- (CGPoint)getPointPos:(int)idx
{
	CGPoint pos;

	int a = idx / 15;
	int b = idx % 15;
	if (b < 8)
	{
		pos.x = a * 102 + 32;
		pos.y = b * 57 + 50;
		//?¤ì œ ?¬ê¸°ê°€ 60?´ì?ë§??„ì— ?¬ì© ?˜ë ¤ ?˜ê?ê¸??Œë¬¸??60???„ë‹ˆ??58ë¡??œë‹¤.
		//pos.y = b * 60 + 30;
	}
	else
	{
		pos.x = a * 102 + 83;
		pos.y = (b - 8) * 57 + 70;
		//pos.y = (b - 8) * 60 + 60;
	}

	return pos;
}

- (Game1PParam*)makeNextParam
{
	Game1PParam* param = [Game1PParam alloc];

	param->stageNumber = stageNumber + 1;
	switch (param->stageNumber)
	{
		case 2:
			param->pointCount = 2;	
			param->difficult = 0;
			break;
		case 3:
			param->pointCount = 3;	
			param->difficult = 0;
			break;
		case 4:
			param->pointCount = 5;	
			param->difficult = 0;
			break;
		case 5:
			param->pointCount = 7;	
			param->difficult = 1;
			break;
		case 6:
			param->pointCount = 9;	
			param->difficult = 1;
			break;
		case 7:
			param->pointCount = 10;	
			param->difficult = 0;
			break;
		case 8:
			param->pointCount = 10;	
			param->difficult = 1;
			break;
		case 9:
			param->pointCount = 10;	
			param->difficult = 2;
			break;
		case 10:
			param->pointCount = 11;	
			param->difficult = 1;
			break;
	}
	
	return param;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!gameStart) return;
	
	if (gameEnd)
	{
		if (processStep == -1)
		{
			[[ViewManager getInstance] changeView:@"MainMenuView"];
		}
		else if (stageNumber == 10)
		{
			//ê²Œì„ ?”ë”©...
			[[ViewManager getInstance] changeView:@"MainMenuView"];
		}
		else
		{
			[[ViewManager getInstance] changeView:@"GameView1P" param:[self makeNextParam]];
		}
		return;
	}

	int pointIdx = (processStep / 2) + 1;
	int count = [touches count];
	UITouch *touch;
	NSEnumerator *touchEnum = [touches objectEnumerator];
	
	for (int j=0; j<count; ++j)
	{
		if (touchCount > 11)
		{
			//?¬ê¸°??ì¢…ë£Œ...
			//?¼ë‹¨ ?€ê°•ë§Œ??ì¢…ë£Œì¡°ê±´...
			//?€?´ë¨¸ ì²˜ë¦¬ë¥?ì¶”ê??´ì„œ ë°€?˜ê²Œ ë§Œë“ ??
			processStep = -1;
			return;
		}

		//?¤ì œ ?¥ë¹„?ì„œ ??ë¶€ë¶„ì„ ?´ë–»ê²?ì²˜ë¦¬? ì?ê°€ ê´€ê±?..
		touch = [touchEnum nextObject];
		touchPosition[touchCount] = [touch locationInView: self];
		++touchCount;
	}

	processStep = 0;
	for (int i=0; i<pointIdx; ++i)
	{
		for (int j=0; j<touchCount; ++j)
		{
			if ([self checkDistance:pointPosition[i] to:touchPosition[j]] < 25.f)
			{
				processStep += 2;
				break;
			}
		}
	}
}

- (float)checkDistance:(CGPoint)p1 to:(CGPoint)p2
{
	return sqrt((p1.x - p2.x)*(p1.x - p2.x) + (p1.y - p2.y)*(p1.y - p2.y));
}

- (void)update
{
	[super update];

	if (gameEnd) return;
	if (!gameStart)
	{
		if (frameTick < 10)			[msgView setMessage:@"Ready...3"];
		else if (frameTick < 20)	[msgView setMessage:@"Ready...2"];
		else if (frameTick < 30)	[msgView setMessage:@"Ready...1"];
		else if (frameTick < 40)	[msgView setMessage:@"Start!"];
		else if (frameTick < 50)
		{
			[msgView reset];
			gameStart = true;
		}
	}
	else if (processStep == -1)
	{
		//ê²Œì„ì¢…ë£Œ...
		[msgView setMessage:@"GameOver"];
		gameEnd = true;
	}
	else if (processStep == 100)
	{
		//?¤í…Œ?´ì? ?´ë¦¬?
		[msgView setMessage:@"StageClear"];
		gameEnd = true;
	}
	else if ((processStep % 2) == 0)
	{
		int pointIdx = (processStep / 2);
		if (pointIdx == pointCount)
		{
			//?¤í…Œ?´ì? ?´ë¦¬?
			processStep = 100;
		}
		else
		{
			[touchPoints[pointIdx] setAlpha:1.f];
			newPointTick = frameTick;	
			[targetCircle setCenter: pointPosition[pointIdx]];
			++processStep;
		}
	}
	else
	{
		//ë³´í†µ?íƒœ...
		if ((newPointTick + 50) < frameTick)
		{
			//TimeOver
			processStep = -1;		
		}
		//?€ê²Ÿì´ ? ìš©? ìš©~?˜ê²Œ...
	}
}

- (void)setUpTouchPoint
{
	for (int i=0; i<11; ++i)
	{
		touchPoints[i] = (TouchPoint*)([[ViewManager getInstance] getInstView:@"TouchPoint"]);
		[self addSubview:touchPoints[i]];
	}
}

- (void)setUpMessageView
{
	msgView = (MessageView*)([[ViewManager getInstance] getInstView:@"MessageView"]);
	[self addSubview:msgView];
}

- (void)resetTouchPoint
{
	totProp = PCOUNT * 100;

	for (int i=0; i<PCOUNT; ++i)
	{
		prop[i] = 100;
		pointPos[i] = [self getPointPos:i];
	}
	
	for (int i=0; i<11; ++i)
	{
		pointPosition[i] = pointPos[[self getNextTouchPointIdx]];
		touchPoints[i].center = pointPosition[i];
		[touchPoints[i] setAlpha:0.f];
	}
	processStep = 0;
}

- (void)dealloc {
	for (int i=0; i<11; ++i)
	{
		[touchPoints[i] release];
	}
	[msgView release];
	[super dealloc];	
}

@end
