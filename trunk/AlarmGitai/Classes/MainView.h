#import <UIKit/UIKit.h>

@class ClockView;
@class DateView;
@class SceneView;

@interface MainView : UIViewController {
	BOOL hiddenButton;
	BOOL menuEnable;

	UINavigationController *menuNavi;
	UINavigationController *alarmNavi;
	
	ClockView *clockview;
	DateView *dateview;
	SceneView *sceneView;
	
	UInt32 frameTick;
	NSTimer *updateTimer;
	bool isInit;
	
	float framePerSec;
	UIButton *MenuButton;
	UIButton *AlarmButton;
}

- (void)update;
- (void)stopTimer;
- (void)resumeTimer;
- (void)FrameUpdate;
@end

