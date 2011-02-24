//
//  CartOrderViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 23..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CartOrderViewController.h"
#import "OrderViewController.h"

@implementation CartOrderViewController

@synthesize InfoOrder;
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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
- (IBAction)OrderButton:(id)sender
{
	if(sender == normalButton)
	{
		[InfoOrder setOrderType:0];
		OrderViewController *Order = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
		Order.InfoOrder = self.InfoOrder;
			[self presentModalViewController:Order animated:YES];
		[Order release];
	}
	else {
		[InfoOrder setOrderType:1];
	}

}

- (void)dealloc {
    [super dealloc];
}


@end
