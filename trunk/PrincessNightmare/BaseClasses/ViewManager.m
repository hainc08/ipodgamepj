#import "ViewManager.h"
static ViewManager *viewManagerInst;

@implementation ViewManager

@synthesize movieMode;

+ (ViewManager*)getInstance
{
	return viewManagerInst;
}

+ (void)initManager:(UIWindow*)window:(UIViewController*)controller
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

- (void)changeViewWithInit:(NSString*)changeViewName
{
	[self changeViewWithInit:changeViewName param:NULL];
}

- (void)changeViewWithInit:(NSString*)changeViewName param:(NSObject*)param
{
 	if (curView != nil)
	{
		[curView removeFromSuperview];
		[curView stopTimer];
		curView = nil;
	}

	for (int i=0; i<viewCount; ++i)
	{
		[views[i].controller release];
		[views[i].viewName release];
	}
	
	viewCount = 0;
	
	[self changeView:changeViewName param:param];
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
		[controller view].transform = CGAffineTransformMake(0.0, 1.0, -1.0, 0.0, 0.0, 0.0);	
		[[controller view] setCenter:CGPointMake(160, 240)];
			
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

- (BaseView*)getCurView
{
	return curView;
}

@end
