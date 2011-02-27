//
//  OrderSettlementViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 27..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OrderPriceViewController.h"
#import "OrderEndViewController.h"

@implementation OrderPriceViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	Comment.returnKeyType = UIReturnKeyDone;
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
#pragma mark  -
#pragma mark TextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (IBAction) OrderButton:(id)sender
{
	if(sender == Money)
	{
		[self ShowOKCancleAlert:@"주문" msg:@"현금주문이 맞습니까?"];
	}
	else if(sender == Money2)
	{
		[self ShowOKCancleAlert:@"주문" msg:@"현금+현금영수증 주문이 맞습니까?"];
	}
	else if(sender == Card)
	{
		[self ShowOKCancleAlert:@"주문" msg:@"방문 카드결제 주문이 맞습니까?"];
	}
	else if(sender == Card2)
	{
		[self ShowOKCancleAlert:@"주문" msg:@"온라인 결제 주문이 맞습니까?"];
	}
}

#pragma mark -
#pragma mark AlertView

- (void)ShowOKCancleAlert:(NSString *)title msg:(NSString *)message
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
												   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
	if(buttonIndex)
	{
		OrderEndViewController *OrderEnd = [[OrderEndViewController alloc] initWithNibName:@"OrderEnd"  bundle:nil];
	
		[self.navigationController pushViewController:OrderEnd animated:YES];
		[OrderEnd release];
	}
}

@end
