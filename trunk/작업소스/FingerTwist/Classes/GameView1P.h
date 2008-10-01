#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "MessageView.h"

#define PCOUNT 45

@class TouchPoint;

@interface Game1PParam : NSObject
{
@public
	int stageNumber;
	int pointCount;
	int difficult;
	//0: 쉬움 - 뽑힌 포인트 주변의 점들이 선택될 확률을 많이 낮춘다. 50%씩..
	//1: 보통 - 뽄힌 포인트 주변의 점들이 선택될 확률을 조금 낮춘다. 20%씩..
	//2: 어려움 - 100%랜덤으로 뽑는다.
}

@end

@interface GameView1P : BaseView
{
	//step은 pointCount으 두배가 된다.
	//생겼다, 눌렀다.
	int stageNumber;
	int difficult;
	
	int processStep;
	int pointCount;
	int touchCount;
	TouchPoint *touchPoints[11];
	CGPoint pointPosition[11];	
	CGPoint touchPosition[11];
	int newPointTick;

	bool gameEnd;
	int introStep;
	int introTick;

	CGPoint pointPos[PCOUNT];
	int prop[PCOUNT];
	int totProp;

	MessageView *msgView;

    IBOutlet id targetCircle;
}
	
- (Game1PParam*)makeNextParam;
- (void)setUpTouchPoint;
- (void)setUpMessageView;
- (void)resetTouchPoint;
- (int)getNextTouchPointIdx;
- (CGPoint)getPointPos:(int)idx;
- (float)checkDistance:(CGPoint)p1 to:(CGPoint)p2;

@end
