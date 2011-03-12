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
	[Store setText:tmp.branchname];
	[StorePhone setText:tmp.branchPhone];
	
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

#pragma mark -
#pragma mark AlertView
- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
												   delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// 필요한 엑션이 있으면 넣자 ..
}

- (void)dealloc {
	[httpRequest release];
    [super dealloc];
}


@end
