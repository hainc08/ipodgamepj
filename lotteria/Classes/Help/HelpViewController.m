//
//  HelpViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 23..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpWebViewController.h"

@implementation HelpViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	closetype = true;
	naviImgIdx = 1;
    [super viewDidLoad];
}

- (IBAction)CloseButtonClicked:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)HelpButtonInfo:(id)sender
{
	HelpWebViewController *Info  = [[HelpWebViewController alloc] initWithNibName:@"HelpWebView" bundle:nil];

	if		( OrderInfo == sender)			Info.URLInfo = @"";
	else if ( PersonalInfo == sender)		Info.URLInfo = @"";
	else if ( StipulationInfo == sender)	Info.URLInfo = @"";
	else if ( CalorieInfo == sender)		Info.URLInfo = @"";

	[self.navigationController pushViewController:Info animated:YES];
	[Info release];
	
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
