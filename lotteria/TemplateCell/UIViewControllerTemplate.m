    //
//  UITableViewControllerTemplate.m
//  lotteria
//
//  Created by embmaster on 11. 2. 23..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIViewControllerTemplate.h"
#import "HelpViewController.h"
#import "ViewManager.h"

@implementation UINavigationBar (CustomImage)
- (void)drawRect:(CGRect)rect {
	//DataManager에 들어갈만한 함수는 아니지만 싱글턴이 이것밖에 없어서 걍 이걸로...
	UIImage *image = [[ViewManager getInstance] getNaviImg];
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end

@implementation UIViewControllerTemplate
@synthesize navi;
@synthesize backView;
@synthesize backButton;
@synthesize naviImgIdx;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.view.backgroundColor = 
	[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_content.png"]];
	
	[super viewDidLoad];

	if ([[self.navigationController viewControllers] count] > 1)
	{
		UIImage *buttonImage = [UIImage imageNamed:@"btn_com_top_back_off.png"];
		UIImage *buttonImage2 = [UIImage imageNamed:@"btn_com_top_back_on.png"];
		
		backButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[backButton setImage:buttonImage forState:UIControlStateNormal];
		[backButton setImage:buttonImage2 forState:UIControlStateHighlighted];
		[backButton setImage:buttonImage2 forState:UIControlStateSelected];
		
		backButton.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
		
		[backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
		
		UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
		self.navigationItem.leftBarButtonItem = customBarItem;
		[customBarItem release];
	}

	[[ViewManager getInstance] setNaviImgIdx:naviImgIdx];
	[navi.navigationBar setNeedsDisplay];
	lastMsg = nil;
}

- (void)back
{
	[self.navigationController popViewControllerAnimated:YES];
	[[ViewManager getInstance] setNaviImgIdx:[backView naviImgIdx]];
	[navi.navigationBar setNeedsDisplay];
}

- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
												   delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
	
	lastMsg = message;
}
- (void)ShowOKCancleAlert:(NSString *)title msg:(NSString *)message
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
												   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];

	lastMsg = message;
}

#pragma mark -
#pragma mark AlertView
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (lastMsg == LOGIN_SESSION_FAIL_MSG)
		[[self navigationController]  popToRootViewControllerAnimated:true];
}

- (bool)checkSession:(XmlParser*)parser
{
	if ([[DataManager getInstance] checkSession:parser] == false)
	{
		//도중에 세션이 날아가서 끊겼다.
		//맨처음으로 돌아가자...
		[self ShowOKAlert:ERROR_TITLE msg:LOGIN_SESSION_FAIL_MSG];
		return false;
	}
	
	return true;
}

- (void)viewDidUnload {
	[backButton release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end

@implementation UIViewControllerDownTemplate
@synthesize closetype;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	if( closetype)
	{
		UIImage *buttonImage = [UIImage imageNamed:@"btn_box_close_on.png"];
		
		closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[closeButton setImage:buttonImage forState:UIControlStateNormal];
		
		closeButton.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
		
		[closeButton addTarget:self action:@selector(viewClose) forControlEvents:UIControlEventTouchUpInside];
		
		UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
		self.navigationItem.rightBarButtonItem = customBarItem;
		[customBarItem release];
	}
	else
	self.navigationItem.leftBarButtonItem = nil;

	if ([[self.navigationController viewControllers] count] == 1)
	{
		[navi.view setCenter:CGPointMake(160, 480 + 206)];
		
		[UIView beginAnimations:@"helpAni" context:NULL];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		
		[navi.view setCenter:CGPointMake(160, 220)];
		
		[UIView commitAnimations];
	}
}

- (void)viewClose
{
	[[ViewManager getInstance] closePopUp];
}

- (void)closePopUp
{
	[UIView beginAnimations:@"helpAni" context:NULL];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		
	[navi.view setCenter:CGPointMake(160, 480 + 206)];
		
	[UIView commitAnimations];

	self.navigationItem.rightBarButtonItem = nil;
}

@end