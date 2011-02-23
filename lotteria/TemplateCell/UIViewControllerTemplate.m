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
	UIImage *image = [UIImage imageNamed: @"bg_com_top_logo.png"];
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end

@implementation UIViewControllerTemplate

@synthesize topBar;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIImage *buttonImage = [UIImage imageNamed:@"btn_com_top_help_off.png"];
	UIButton *helpbutton = [UIButton buttonWithType:UIButtonTypeCustom];

	[helpbutton setImage:buttonImage forState:UIControlStateNormal];

	helpbutton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);

	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:helpbutton];

	[helpbutton addTarget:self action:@selector(HelpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	self.topBar.topItem.rightBarButtonItem = rightButton;									

	[helpbutton release];
	[rightButton release];
	
	
	
	self.view.backgroundColor = 
	[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_content.png"]];

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
