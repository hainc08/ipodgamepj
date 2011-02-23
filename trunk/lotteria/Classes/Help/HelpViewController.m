//
//  HelpViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 23..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HelpViewController.h"


@implementation HelpViewController
@synthesize topBar;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
 UIImage *buttonImage = [UIImage imageNamed:@"btn_box_close_on.png"];
 UIButton *closebutton = [UIButton buttonWithType:UIButtonTypeCustom];
 
 [closebutton setImage:buttonImage forState:UIControlStateNormal];
 
 closebutton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
 
 UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:closebutton];
 
 [closebutton addTarget:self action:@selector(CloseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
 
 self.topBar.topItem.leftBarButtonItem = leftButton;									
 
 [closebutton release];
 [leftButton release];
 
 
 
 self.view.backgroundColor = 
 [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_content.png"]];
 
}

- (IBAction)CloseButtonClicked:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
