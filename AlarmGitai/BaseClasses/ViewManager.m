#import "ViewManager.h"
static ViewManager *viewManagerInst;

@implementation ViewManager

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
/*
	viewManagerInst->views[0].controller = controller;
	viewManagerInst->views[0].viewName = @"Main";
	viewManagerInst->viewCount = 1;*/
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

/* 현재 view에 추가할 경우에만 사용한다 */
- (UIView*)addSubInstView:(NSString*)viewName
{
	int viewConIdx = -1;
	
	for (int i=0; i<viewCount; ++i)
	{
		if ([views[i].viewName isEqualToString:viewName])
		{
			viewConIdx = i;
		}
	}
	if( viewConIdx == -1 )
	{
		if (viewCount >= MaxViewCount) return nil;
		
		UIViewController *controller = [[UIViewController alloc] initWithNibName:viewName bundle:[NSBundle mainBundle]];
		[controller view].transform = CGAffineTransformMake(0.0, 1.0, -1.0, 0.0, 0.0, 0.0);	
		[[controller view] setCenter:CGPointMake(160, 240)];
		
		views[viewCount].controller = controller;
		views[viewCount].viewName = viewName;
		viewConIdx = viewCount;
		++viewCount;
		
	}
	curView = (BaseView*)[views[viewConIdx].controller view];

	return curView;
}

/* super view 를 reset 하고 자기자신을 지워버린다. */
- (void)changeSuperView:(NSString*)changeSuperName param:(NSObject*)param
{
	int viewConIdx = -1;
	
	for (int i=0; i<viewCount; ++i)
	{
		if ([views[i].viewName isEqualToString:changeSuperName])
		{
			viewConIdx = i;
		}
	}
	
 	if (curView != nil) [curView removeFromSuperview];
	
	curView = (BaseView*)[views[viewConIdx].controller view];
	
	[curView reset:param];
}

 

- (BaseView*)getCurView
{
	return curView;
}

@end
