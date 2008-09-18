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
	//0: ?��? - 뽑힌 ?�인??주�????�들???�택???�률??많이 ??��?? 50%??.
	//1: 보통 - 뽄힌 ?�인??주�????�들???�택???�률??조금 ??��?? 20%??.
	//2: ?�려?� - 100%?�덤?�로 뽑는??
}

@end

@interface GameView1P : BaseView
{
	//step?� pointCount???�배가 ?�다.
	//?�겼?? ?��???
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
	bool gameStart;

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
