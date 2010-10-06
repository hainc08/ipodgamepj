#import <UIKit/UIKit.h>

@class ClockView;
@class DateView;
@class SceneView;
@class MenuController;

@interface MainView : UIViewController {
	
	MenuController *menuconfig;
	
	BOOL	editenable;
	BOOL	clockViewTouched;
	BOOL	dateViewTouched;
	BOOL	weekViewTouched;
	
	
	BOOL hiddenButton;
	BOOL menuEnable;

	UINavigationController *menuNavi;
	UINavigationController *alarmNavi;
	
	DateView *weekview;
	ClockView *clockview;
	DateView *dateview;
	SceneView *sceneView;
	
	UInt32 frameTick;
	NSTimer *updateTimer;
	bool isInit;
	
	float framePerSec;
/* Button */
	UIButton *MenuXbox;
	UIButton *MenuButton;
	UIButton *AlarmButton;
}
- (void) setTransView:(int)_inTrans;
- (void)update;
- (void)stopTimer;
- (void)resumeTimer;
- (void)FrameUpdate;
@end

