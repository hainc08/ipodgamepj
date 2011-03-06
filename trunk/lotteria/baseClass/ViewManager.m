#import "ViewManager.h"
#import "CartBodyViewController.h"
#import "MainViewController.h"
#import "NaviViewController.h"

static ViewManager *ViewManagerInst;

@implementation ViewManager

@synthesize cartView;
@synthesize mainView;
@synthesize naviImgIdx;

+ (ViewManager*)getInstance
{
	return ViewManagerInst;
}

+ (void)initManager;
{
	ViewManagerInst = [ViewManager alloc];
	[ViewManagerInst reset];
}

- (void)closeManager
{

}

- (void)reset
{
	cartView = nil;
	
	naviImgIdx = 0;
	naviBackImg[0] = [UIImage imageNamed: @"bg_titlebar.png"];
	naviBackImg[1] = [UIImage imageNamed: @"bg_logo_titlebar.png"];
	
	popUpView = nil;
}

- (void)cartUpdate
{
	if (cartView != nil)
	{
		[(CartBodyViewController*)cartView update];
	}
	if (mainView != nil)
	{
		[(MainViewController*)mainView cartUpdate];
	}
}

- (UIImage*)getNaviImg
{
	return naviBackImg[naviImgIdx];
}

- (void)popUp:(UIViewController*)pop button:(UIButton*)button owner:(UIViewController*)owner
{
	if (popUpView != nil)
	{
		[popUpView.view removeFromSuperview];
		[popUpView release];
		popUpView = nil;
	}
	
	popUpView = [[NaviViewController alloc] init];
	popButton = button;
	popOwner = owner;
	[(NaviViewController*)popUpView setBody:pop];
	
	[mainView.view addSubview:popUpView.view];
	[mainView.view sendSubviewToBack:popUpView.view];
	[mainView viewAlign];
	
	if (popButton != nil) [popButton setAlpha:0];
}

- (void)closePopUp
{
	[[(NaviViewController*)popUpView body] back];
	if (popButton != nil) [popButton setAlpha:1];
	if (popOwner != nil) [popOwner refresh];
}

@end
