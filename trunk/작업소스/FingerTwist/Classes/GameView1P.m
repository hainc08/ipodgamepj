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
		//?�제 ?�기가 60?��?�??�에 ?�쩍 ?�려 ?��?�??�문??60???�니??58�??�다.
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
			//게임 ?�딩...
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
			//?�기??종료...
			//?�단 ?�강만??종료조건...
			//?�?�머 처리�?추�??�서 밀?�게 만든??
			processStep = -1;
			return;
		}

		//?�제 ?�비?�서 ??부분을 ?�떻�?처리?��?가 관�?..
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
		//게임종료...
		[msgView setMessage:@"GameOver"];
		gameEnd = true;
	}
	else if (processStep == 100)
	{
		//?�테?��? ?�리?
		[msgView setMessage:@"StageClear"];
		gameEnd = true;
	}
	else if ((processStep % 2) == 0)
	{
		int pointIdx = (processStep / 2);
		if (pointIdx == pointCount)
		{
			//?�테?��? ?�리?
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
		//보통?�태...
		if ((newPointTick + 50) < frameTick)
		{
			//TimeOver
			processStep = -1;		
		}
		//?�겟이 ?�용?�용~?�게...
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
