#import "ViewManager.h"

static ViewManager *viewManagerInst;

@implementation ViewManager

+ (ViewManager*)getInstance
{
	return viewManagerInst;
}

+ (void)initManager:(UIWindow*)window
{
	viewManagerInst = [ViewManager alloc];
	viewManagerInst->mainWindow = window;
	viewManagerInst->curController = NULL;
	viewManagerInst->nextController = NULL;
	
	viewManagerInst->framePerSec = 10;
	[viewManagerInst resumeTimer];
}

- (void)closeManager
{

}

- (void)changeView:(BaseViewController*)controller :(NSObject*)param
{
	[self changeView:controller :10.f :param];
}

- (void)changeView:(BaseViewController*)controller :(float)fps :(NSObject*)param
{
	nextController = controller;
	framePerSec = fps;
	nextParam = param;
}

- (BaseViewController*)getCurViewController
{
	return curController;
}

- (void)stopTimer
{
	[updateTimer invalidate]; 
	[updateTimer release]; 
}

- (void)resumeTimer
{
	updateTimer = [[NSTimer scheduledTimerWithTimeInterval: (1.0f/framePerSec)
													target: self
												  selector: @selector(update)
												  userInfo: self
												   repeats: YES] retain];	
}

- (void)update
{
	if (nextController != NULL)
	{
		[self stopTimer];
		
		if (curController != nil)
		{
			[curController.view removeFromSuperview];
			curController = nil;
		}

		[mainWindow addSubview:nextController.view];
		[mainWindow makeKeyAndVisible];
		
		[nextController.view setFrame:CGRectMake(0, 0, 480, 320)];
		[nextController.view setTransform:CGAffineTransformMake(0.0, 1.0, -1.0, 0.0, 0.0, 0.0)];
		[nextController.view setCenter:CGPointMake(160, 240)];
		
		curController = nextController;
		[curController reset:nextParam];
		
		nextController = NULL;
		
		[self resumeTimer];
	}

	if (curController != NULL) [curController update];
}

@end
