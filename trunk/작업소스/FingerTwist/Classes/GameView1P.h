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
	//0: ?¬ì? - ë½‘íŒ ?¬ì¸??ì£¼ë????ë“¤??? íƒ???•ë¥ ??ë§ì´ ??¶˜?? 50%??.
	//1: ë³´í†µ - ë½„íŒ ?¬ì¸??ì£¼ë????ë“¤??? íƒ???•ë¥ ??ì¡°ê¸ˆ ??¶˜?? 20%??.
	//2: ?´ë ¤?€ - 100%?œë¤?¼ë¡œ ë½‘ëŠ”??
}

@end

@interface GameView1P : BaseView
{
	//step?€ pointCount???ë°°ê°€ ?œë‹¤.
	//?ê²¼?? ?Œë???
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
