//
//  OrderEndViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 28..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OrderEndViewController.h"
#import "DataManager.h"

@implementation OrderEndViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	Order *tmp =	[[DataManager getInstance] UserOrder ];
	[Store setText:tmp.branchname];
	[StorePhone setText:tmp.branchPhone];
	self.navigationItem.title = @"주문완료";
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(IBAction) OrderInfo
{
}

- (void)dealloc {
    [super dealloc];
}


@end
