#import <UIKit/UIKit.h>

@class ClockView;
@class DateView;
@class SceneView;
@class MenuController;
@class MenuSelectController;

@interface DataParam : NSObject {
	int iData;
	NSString *sData;
}

@property (readwrite)	int iData;
@property (retain)	NSString *sData;

@end

enum ROOTUPDATE {
	TRANSUPDATE = 0,
	ROTAGEUPDATE
};
	
@interface MainView : UIViewController {

	MenuSelectController *selectmenu;
	MenuController *menuconfig;
	
	BOOL	viewrotate;
	BOOL	editenable;
	BOOL	clockViewTouched;
	BOOL	dateViewTouched;
	BOOL	weekViewTouched;
	
	
	BOOL hiddenButton;
	BOOL menuEnable;

	
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

-(CGRect)viewcentersettle:(CGRect) rect;
-(void)menuViewFrameUpdate:(CGRect ) rect;
- (void) reset:(int)_type value:(NSObject *)_inValue;
- (void)update;
- (void)stopTimer;
- (void)resumeTimer;
- (void)FrameUpdate;
@end

