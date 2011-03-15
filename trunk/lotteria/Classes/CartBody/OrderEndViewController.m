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
	[StorePhone setText:tmp.UserPhone ];
	
	httpRequest = [[HTTPRequest alloc] init];
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

- (void)didReceiveFinished:(NSString *)result
{
	
	// 로그인 성공하면 이뷰는 사라진다. 
	// xml에서 로그인처리 
	
	if(![result compare:@"error"])
	{
	[self ShowOKAlert:@"Login Error" msg:@"로그인에 실패 했습니다."];	
	}
	else 
	{
	}
}

- (void)dealloc {
	[httpRequest release];
    [super dealloc];
}


@end
