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
	introStep = 0;

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
		//실제 크기가 60이지만 위에 슬쩍 잘려 나가기 때문에 60이 아니라 58로 한다.
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
	if (introStep < 3)
	{
		if (introStep == 1)
		{
			introTick = frameTick;
			introStep = 2;
		}
		return;
	}

	if (gameEnd)
	{
		if (processStep == -1)
		{
			[[ViewManager getInstance] changeView:@"MainMenuView"];
		}
		else if (stageNumber == 10)
		{
			//게임 엔딩...
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
			//여기서 종료...
			//일단 대강만든 종료조건...
			//타이머 처리를 추가해서 밀하게 만든다.
			processStep = -1;
			return;
		}

		//실제 장비에서 이 부분을 어떻게 처리할지가 관건...
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

	if (introStep < 3)
	{
		switch (introStep)
		{
			case 0:
				[msgView showStageInfo:stageNumber button:pointCount diff:difficult];
				introStep = 1;
				break;
			case 2:
				if (frameTick < (introTick + 10))		[msgView setMessage:@"Ready"];
				else if (frameTick < (introTick + 20)) 	[msgView setMessage:@"Start"];
				else if (frameTick < (introTick + 30)) 
				{
					[msgView reset];
					introStep = 3;
				}
				break;
		}
	}
	else if (processStep == -1)
	{
		//게임종료...
		[msgView setMessage:@"GameOver" showNext:true];
		gameEnd = true;
	}
	else if (processStep == 100)
	{
		//스테이지 클리어
		[msgView setMessage:@"StageClear" showNext:true];
		gameEnd = true;
	}
	else if ((processStep % 2) == 0)
	{
		int pointIdx = (processStep / 2);
		if (pointIdx == pointCount)
		{
			//스테이지 클리어
			processStep = 100;
		}
		else
		{
			[UIView beginAnimations:@"button" context:NULL];
			[UIView setAnimationDuration:0.15];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];			
			touchPoints[pointIdx].transform = CGAffineTransformMakeScale(0.5, 0.5);
			touchPoints[pointIdx].transform = CGAffineTransformMakeScale(1.0, 1.0);
			[UIView commitAnimations];
			
			[touchPoints[pointIdx] setAlpha:1.f];
			newPointTick = frameTick;	
			[targetCircle setCenter: pointPosition[pointIdx]];
			++processStep;
		}
	}
	else
	{
		//보통상태...
		if ((newPointTick + 50) < frameTick)
		{
			//TimeOver
			processStep = -1;		
		}
		//타겟이 띠용띠용~하게...
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
	[msgView initImg];
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
