#import "ViewManager.h"
#import "CartBodyViewController.h"
#import "MainViewController.h"
#import "NaviViewController.h"
#import "WaitViewController.h"
#import "OnlinePayViewController.h"

static ViewManager *ViewManagerInst;

@implementation ViewManager

@synthesize cartView;
@synthesize mainView;
@synthesize naviImgIdx;
@synthesize WaitView;
@synthesize helpButton;

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
	onlinePayView = nil;
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

- (void)popUp:(UIViewController*)pop owner:(UIViewController*)owner
{
	if (popUpView != nil)
	{
		[popUpView.view removeFromSuperview];
		[popUpView release];
		popUpView = nil;
	}
	
	popUpView = [[NaviViewController alloc] init];
	popOwner = owner;
	[(NaviViewController*)popUpView setBody:pop];
	
	[mainView.view addSubview:popUpView.view];
	[mainView.view sendSubviewToBack:popUpView.view];
	[mainView viewAlign];
	
	[helpButton setAlpha:0];
}

- (void)closePopUp
{
	if (popUpView != nil) [[(NaviViewController*)popUpView body] closePopUp];
	[helpButton setAlpha:1];
	if (popOwner != nil)
	{
		[popOwner refresh];
		popOwner = nil;
	}
}

#pragma mark WaitViewController
- (void) waitview: (UIView *) view isBlock: (BOOL) isBlock {
	if (isBlock) {
		if (self.WaitView == nil) {
			self.WaitView = [[WaitViewController alloc] init];
			self.WaitView.view.frame = CGRectMake(0, 0, 320, 460);
		}
		WaitView.view.frame = CGRectMake(0, 0, 320, 460);
		[view addSubview: self.WaitView.view];
	}
	else {
		[self.WaitView.view removeFromSuperview];
	}
}

- (void) showOnlinePayView:(NSString *)url bodyArray:(NSMutableArray *)bodyarr
{
	if (onlinePayView == nil)
	{
		onlinePayView = [[OnlinePayViewController alloc] init];
		[mainView.view addSubview:onlinePayView.view];
	}

	[onlinePayView.view setCenter:CGPointMake(160, 720)];

	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	[onlinePayView.view setCenter:CGPointMake(160, 230)];
	
	[UIView commitAnimations];
	
	[onlinePayView showPage:url bodyArray:bodyarr];
}

@end
