#import "ViewManager.h"
static ViewManager *viewManagerInst;

@implementation ViewManager

+ (ViewManager*)getInstance
{
	return viewManagerInst;
}

+ (void)initManager:(UIWindow*)window:(UIViewController*)controller;
{
	viewManagerInst = [ViewManager alloc];
	viewManagerInst->viewCount = 0;
	viewManagerInst->mainWindow = window;
	viewManagerInst->mainController = controller;
	viewManagerInst->curView = nil;
}

- (void)closeManager
{
	for (int i=0; i<viewCount; ++i)
	{
		[views[i].controller release];
		[views[i].viewName release];
	}
}

- (void)changeView:(NSString*)changeViewName
{
	[self changeView:changeViewName param:NULL];
}

- (void)changeView:(NSString*)changeViewName param:(NSObject*)param
{
	int viewConIdx = -1;

	for (int i=0; i<viewCount; ++i)
	{
		if ([views[i].viewName isEqualToString:changeViewName])
		{
			viewConIdx = i;
		}
	}
	
	if (viewConIdx == -1)
	{
		if (viewCount >= MaxViewCount) return;
	
		UIViewController *controller = [[UIViewController alloc] initWithNibName:changeViewName bundle:[NSBundle mainBundle]];
			
		views[viewCount].controller = controller;
		views[viewCount].viewName = changeViewName;
		viewConIdx = viewCount;
		++viewCount;
	}

 	if (curView != nil) [curView removeFromSuperview];
	
	mainController = views[viewConIdx].controller;
	[curView stopTimer];
	curView = (BaseView*)[mainController view];

	[curView reset:param];
	[mainWindow addSubview:curView];
	[mainWindow makeKeyAndVisible];
}

- (UIView*)getInstView:(NSString*)viewName
{
	UIViewController *controller = [[UIViewController alloc] initWithNibName:viewName bundle:[NSBundle mainBundle]];
	UIView* uiview = [controller view];
	[controller release];
	return uiview;
}

@end
