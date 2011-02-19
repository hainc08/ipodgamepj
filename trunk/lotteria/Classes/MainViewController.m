//
//  MainViewController.m
//  lotteria
//
//  Created by Sasin on 11. 2. 18..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

#import "MainBodyViewController.h"
#import "KartBodyViewController.h"
#import "MypageBodyViewController.h"
#import "MapBodyViewController.h"

@implementation MainViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
//	[self.view addSubview:
	MainBodyViewController* mainBody = [[MainBodyViewController alloc] init];
	curView = mainBody.view;

	[self.view addSubview:curView];
	[self.view sendSubviewToBack:curView];
	
	lastTag = 0;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
	if (lastTag == [item tag]) return;

	UIViewController* body;

	switch ([item tag]) {
		case 0:
			body = [[MainBodyViewController alloc] init];
			break;
		case 1:
			body = [[KartBodyViewController alloc] init];
			break;
		case 2:
			body = [[MypageBodyViewController alloc] init];
			break;
		case 3:
			body = [[MapBodyViewController alloc] init];
			break;
	}

	UIView* oldView = curView;
	curView = body.view;

	[self.view addSubview:curView];
	[self.view sendSubviewToBack:curView];

	[self.view sendSubviewToBack:oldView];
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
