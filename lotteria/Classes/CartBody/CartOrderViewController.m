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
#import "DataManager.h"

@implementation CartOrderViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"주문방법 선택";
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (IBAction)OrderButton:(id)sender
{
	Order *Data = [[DataManager getInstance] UserOrder];
	if(sender == normalButton)
	{
		[Data setOrderType:0];
		CartOrderUserViewController *Order = [[CartOrderUserViewController alloc] initWithNibName:@"CartOrderUserView" bundle:nil];
		[self.navigationController pushViewController:Order animated:YES];
		[Order release];
	}
	else {
		//시간을 체크해서 밤 열시 이후에는 예약이 되지 않게 한다.
		NSLocale *locale	=	[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
		NSDateFormatter *dateFormatter		=	[[NSDateFormatter alloc] init];
		[dateFormatter setLocale:locale];
		[dateFormatter setDateFormat:@"HH"];
		NSString* hour = [dateFormatter stringFromDate:[NSDate date]];
		if ([hour intValue] >= 22)
		{
			[self ShowOKAlert:ALERT_TITLE msg:DELI_TIME_ERROR_22_MSG];
		}
		else
		{
			[Data  setOrderType:1];
			CartOrderReservationsView *Order = [[CartOrderReservationsView alloc] initWithNibName:@"CartOrderReservationsView" bundle:nil];
			[self.navigationController pushViewController:Order animated:YES];
			[Order release];
		}
	}

}

- (void)dealloc {
    [super dealloc];
}


@end
