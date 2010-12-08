//
//  MainViewController.m
//  AlarmGitaiFinal
//
//  Created by Sasin on 10. 11. 25..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "MainClockViewController.h"


@implementation MainViewController


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	MainClockViewController *controller = [[MainClockViewController alloc] init];

	controller.delegate = self;
	UINavigationController *navController = [[UINavigationController alloc] init];
	
	navController.navigationBarHidden = YES;
	[navController initWithRootViewController:controller];

	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:navController animated:YES];
	[navController release];
	[controller release];
}

- (void)flipsideViewControllerDidFinish:(UIViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[touch setAlpha:0];
	
	[UIView beginAnimations:@"anime2" context:NULL];
	[UIView setAnimationDuration:2];
	[UIView setAnimationDelay:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[touch setAlpha:1];
	[UIView commitAnimations];
	
}


- (void)dealloc {
    [super dealloc];
}


@end
