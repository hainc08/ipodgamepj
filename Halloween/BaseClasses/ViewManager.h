#import "BaseViewController.h"

@interface ViewManager : NSObject
{
    UIWindow *mainWindow;
	BaseViewController* curController;

	BaseViewController* nextController;
	NSObject* nextParam;

	NSTimer *updateTimer;

	float framePerSec;
}

+ (ViewManager*)getInstance;
+ (void)initManager:(UIWindow*)window;
- (void)closeManager;
- (void)changeView:(BaseViewController*)controller :(NSObject*)param;
- (void)changeView:(BaseViewController*)controller :(float)fps :(NSObject*)param;

- (BaseViewController*)getCurViewController;

- (void)stopTimer;
- (void)resumeTimer;
- (void)update;

@end
