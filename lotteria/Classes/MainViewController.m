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
	curView = navi.view;
	
	[self.view addSubview:curView];
	[self.view addSubview:logoBody.view];

	[self.view sendSubviewToBack:curView];
	[self.view sendSubviewToBack:backImg];
	[self.view bringSubviewToFront:helpButton];

	[self.view bringSubviewToFront:logoBody.view];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
	if (lastTag == [item tag]) return;
	[self dismissModalViewControllerAnimated:YES];
	NaviViewController* navi = [[NaviViewController alloc] init];
	[navi setIdx:[item tag]];

	UIView* oldView = curView;
	curView = navi.view;

	[self.view addSubview:curView];
	[self.view sendSubviewToBack:curView];
	[self.view sendSubviewToBack:backImg];
	[self.view bringSubviewToFront:helpButton];

	[oldView removeFromSuperview];
	
	lastTag = [item tag];
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


@end
