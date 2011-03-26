//
//  MainViewController.m
//  lotteria
//
//  Created by Sasin on 11. 2. 18..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "NaviViewController.h"
#import "LogoViewController.h"

#import "HelpViewController.h"

#import "WaitViewController.h"
#import "MyCustomerDelivery.h"
@implementation MainViewController
@synthesize WaitView;
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];

	LogoViewController* logoBody = [[LogoViewController alloc] init];
	NaviViewController* navi = [[NaviViewController alloc] init];
	[navi setListButton:listButton];
	
	[[ViewManager getInstance] setHelpButton:helpButton];
	
	curView = navi.view;
	
	[self.view addSubview:curView];
	[self.view addSubview:logoBody.view];
	
	[self.view sendSubviewToBack:curView];
	[self.view sendSubviewToBack:backImg];
	[self.view bringSubviewToFront:helpButton];
	[self.view bringSubviewToFront:listButton];

	[self.view bringSubviewToFront:logoBody.view]; 
	[listButton setAlpha:0];
	
	lastButton = nil;

	[self cartUpdate];
	[[ViewManager getInstance] setMainView:self];
}

- (IBAction)buttonClick:(id)sender
{
	if (lastButton == sender) return;

	int idx;
	if (sender == tapButton1) idx= 0;
	else if (sender == tapButton2) idx= 1;
	else if (sender == tapButton3) idx= 2;
	else if (sender == tapButton4) idx= 3;
	
	[selectedBack setCenter:CGPointMake(40 + idx * 80, 24)];
	
	[self dismissModalViewControllerAnimated:YES];
	NaviViewController* navi = [[NaviViewController alloc] init];
	[navi setParentView:self];
	[navi setIdx:idx];
	
	[[ViewManager getInstance] setHelpButton:helpButton];

	UIView* oldView = curView;
	curView = navi.view;

	[self.view addSubview:curView];
	[self viewAlign];

	[oldView removeFromSuperview];
	[[ViewManager getInstance] closePopUp];

	lastButton = sender;
}

/* MYPAGE이동  , 메뉴선택 이동 ...*/
- (void)ClieckEvent:(int)index  viewType:(int)Type
{
	
	[selectedBack setCenter:CGPointMake(40 + index * 80, 24)];
	
	[self dismissModalViewControllerAnimated:YES];
	NaviViewController* navi = [[NaviViewController alloc] init];
	[navi setParentView:self];
	[navi setIdx:index];
	
	[[ViewManager getInstance] setHelpButton:helpButton];
	
	UIView* oldView = curView;
	curView = navi.view;
	
	[self.view addSubview:curView];
	[self viewAlign];
	
	[oldView removeFromSuperview];
	[[ViewManager getInstance] closePopUp];
	if(Type == MYPAGEMOVE)
	{
		MyCustomerDelivery *Coustomer = [[MyCustomerDelivery alloc] initWithNibName:@"MyCustomerDelivery" bundle:nil];
		[navi pushViewController:Coustomer animated:YES];
		[Coustomer release];
	}
	id sender;
	if (index == 0 ) sender = tapButton1;
	else if (index == 0 ) sender =tapButton2;
	else if (index == 0 ) sender =tapButton3;
	else if (index == 0 ) sender =tapButton4;
	lastButton = sender;
}


- (IBAction)helpClick
{
	[[ViewManager getInstance] popUp:[[HelpViewController alloc] init] owner:nil];
	lastButton = nil;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
    [super dealloc];
}

- (void)cartUpdate
{
	int count = [[DataManager getInstance] itemAllCount];

	[cartCountBack1 setAlpha:0];
	[cartCountBack2 setAlpha:0];
	[cartCountBack3 setAlpha:0];
	[cartCountLabel setAlpha:0];
	
	if (count > 0)
	{
		[cartCountLabel setAlpha:1];
		[cartCountLabel setText:[NSString stringWithFormat:@"%d", count]];

		if (count < 10) [cartCountBack1 setAlpha:1];
		else if (count < 100) [cartCountBack2 setAlpha:1];
		else if (count < 1000) [cartCountBack3 setAlpha:1];
	}
}

- (void)viewAlign
{
	[self.view sendSubviewToBack:curView];
	[self.view sendSubviewToBack:backImg];
	[self.view bringSubviewToFront:helpButton];
}
@end
