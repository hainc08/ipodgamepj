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
	//0: ?ฌ์? - ๋ฝํ ?ฌ์ธ??์ฃผ๋????๋ค??? ํ???๋ฅ ??๋ง์ด ??ถ?? 50%??.
	//1: ๋ณดํต - ๋ฝํ ?ฌ์ธ??์ฃผ๋????๋ค??? ํ???๋ฅ ??์กฐ๊ธ ??ถ?? 20%??.
	//2: ?ด๋ ค? - 100%?๋ค?ผ๋ก ๋ฝ๋??
}

@end

@interface GameView1P : BaseView
{
	//step? pointCount???๋ฐฐ๊ฐ ?๋ค.
	//?๊ฒผ?? ?๋???
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
