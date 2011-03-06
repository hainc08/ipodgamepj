    //
//  UITableViewControllerTemplate.m
//  lotteria
//
//  Created by embmaster on 11. 2. 23..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIViewControllerTemplate.h"
#import "HelpViewController.h"

@implementation UINavigationBar (CustomImage)
- (void)drawRect:(CGRect)rect {
	//DataManager에 들어갈만한 함수는 아니지만 싱글턴이 이것밖에 없어서 걍 이걸로...
	UIImage *image = [[DataManager getInstance] getNaviImg];
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

	[[DataManager getInstance] setNaviImgIdx:naviImgIdx];
	[navi.navigationBar setNeedsDisplay];
}

- (void)back
{
	[self.navigationController popViewControllerAnimated:YES];
	[[DataManager getInstance] setNaviImgIdx:[(UIViewControllerTemplate*)backView naviImgIdx]];
	[navi.navigationBar setNeedsDisplay];
}

- (IBAction)HelpButtonClicked:(id)sender
{
	HelpViewController *Help = [[HelpViewController alloc] initWithNibName:@"HelpView" bundle:nil];
	[self presentModalViewController:Help animated:YES];
	[Help release];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	[backButton release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end


@implementation UIViewControllerDownTemplate
@synthesize navi;
@synthesize backButton;
@synthesize closetype;
@synthesize naviImgIdx;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[super viewDidLoad];
	self.view.backgroundColor = 
	[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_content.png"]];
	
	if( closetype)
	{
	UIImage *buttonImage = [UIImage imageNamed:@"btn_box_close_on.png"];
	
	backButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[backButton setImage:buttonImage forState:UIControlStateNormal];

	backButton.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
	
	[backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
	self.navigationItem.leftBarButtonItem = customBarItem;
	[customBarItem release];
	}
	else
	self.navigationItem.leftBarButtonItem = nil;

	[[DataManager getInstance] setNaviImgIdx:naviImgIdx];
	[navi.navigationBar setNeedsDisplay];
}

- (IBAction)HelpButtonClicked:(id)sender
{
	HelpViewController *Help = [[HelpViewController alloc] initWithNibName:@"HelpView" bundle:nil];
	[self presentModalViewController:Help animated:YES];
	[Help release];
}

- (void)back
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload {
	[backButton release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void)dealloc {
    [super dealloc];
}


@end