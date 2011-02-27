//
//  CartOrderViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 23..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CartOrderViewController.h"
#import "CartOrderReservationsView.h"
#import "CartOrderUserViewController.h"
#import "DataList.h"

@implementation CartOrderViewController

@synthesize InfoOrder;
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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
		CartOrderUserViewController *Order = [[CartOrderUserViewController alloc] initWithNibName:@"CartOrderUserView" bundle:nil];
		Order.InfoOrder = self.InfoOrder;
		[self.navigationController pushViewController:Order animated:YES];
		[Order release];
	}
	else {
		[InfoOrder setOrderType:1];
		CartOrderReservationsView *Order = [[CartOrderReservationsView alloc] initWithNibName:@"CartOrderReservationsView" bundle:nil];
		Order.InfoOrder = self.InfoOrder;
		[self.navigationController pushViewController:Order animated:YES];
		[Order release];
	}

}

- (void)dealloc {
    [super dealloc];
}


@end
