#import <UIKit/UIKit.h>

@class ClockView;
@class DateView;
@class SceneView;
@class MenuController;
@class MenuSelectController;
@class AlarmShakeController;

@interface DataParam : NSObject {
	int iData;
	NSString *sData;
}

@property (readwrite)	int iData;
@property (retain)	NSString *sData;

@end


enum VIEWMODE {
	VIEWNORMAL = 0,
	VIEWUPDATE,
};
	
@interface MainView : UIViewController {
	
	
	CGFloat initTouchPoint;
	
	AlarmShakeController	*alarmshake;
	MenuSelectController	*selectmenu;
	
	BOOL	viewrotate;
	BOOL	editenable;
	BOOL	weekViewTouched;
	UIViewController* touchedCon;
	
	CGPoint dragOffset;
	
	BOOL hiddenButton;
	BOOL menuEnable;

	int		viewmode;
	DateView *weekview;
	ClockView *clockview;
	DateView *dateview;
	SceneView *sceneView;
	
	UInt32 frameTick;
	NSTimer *updateTimer;
	bool isInit;
	
	float framePerSec;
/* Button */
	UIButton *AlarmButton;
}

-(CGRect)viewcentersettle:(CGRect) rect;
- (void) resizeview:(int)_type value:(int)value;
- (void)update;
- (void)stopTimer;
- (void)resumeTimer;
- (void)FrameUpdate;
- (void)ConfigSetup;
@end

