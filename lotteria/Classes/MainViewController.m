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

@implementation MainViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];

	LogoViewController* logoBody = [[LogoViewController alloc] init];
	NaviViewController* navi = [[NaviViewController alloc] init];
	[navi setHelpButton:helpButton];
	[navi setListButton:listButton];
	
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
	helpView = nil;

	[self cartUpdate];
	[[DataManager getInstance] setMainView:self];
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
	[navi setIdx:idx];

	UIView* oldView = curView;
	curView = navi.view;

	[self.view addSubview:curView];
	[self viewAlign];

	[oldView removeFromSuperview];
	if (helpView != nil) [[helpView body] back];

	[helpButton setAlpha:1];
	lastButton = sender;
}

- (IBAction)helpClick
{
	[self dismissModalViewControllerAnimated:YES];

	if (helpView != nil)
	{
		[helpView.view removeFromSuperview];
		[helpView release];
		helpView = nil;
	}
	
	helpView = [[NaviViewController alloc] init];
	[(NaviViewController*)helpView setIdx:4];
	[(NaviViewController*)helpView setHelpButton:helpButton];
	
	[self.view addSubview:helpView.view];

	[self.view sendSubviewToBack:helpView.view];
	[self viewAlign];

	[helpView.view setCenter:CGPointMake(160, 480 + 206)];
	
	[UIView beginAnimations:@"helpAni" context:NULL];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	
	[helpView.view setCenter:CGPointMake(160, 220)];
	
	[UIView commitAnimations];

	[helpButton setAlpha:0];
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
	int count = [[DataManager getInstance] itemCount:-1];

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
