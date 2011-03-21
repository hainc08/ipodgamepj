//
//  OrderEndViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 28..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OrderEndViewController.h"
#import "DataManager.h"
#import "HttpRequest.h"

@implementation OrderEndViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	Order *tmp =	[[DataManager getInstance] UserOrder ];
	[Store setText:tmp.UserAddr.branchname];
	[StorePhone setText:[[DataManager getInstance] getPhoneStr:tmp.UserAddr.branchtel]];
	UIBarButtonItem *flexibleSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease]; 

	self.navigationItem.backBarButtonItem = flexibleSpace;
	self.navigationItem.leftBarButtonItem = flexibleSpace;
	
	self.navigationItem.title = @"주문완료";
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
-(IBAction) OrderInfo
{
	[[[UIApplication sharedApplication] delegate]UpdateMoveView:2 viewType:MYPAGEMOVE];
}

- (void)dealloc {
    [super dealloc];
}


@end
