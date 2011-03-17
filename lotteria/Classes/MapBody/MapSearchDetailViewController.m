//
//  MapSearchDetailViewController.m
//  lotteria
//
//  Created by embmaster on 11. 3. 2..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapSearchDetailViewController.h"


@implementation MapSearchDetailViewController

@synthesize Info;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	int len = [Info.storename length];
	if ([[Info.storename substringFromIndex:len - 1] compare:@"점"] == NSOrderedSame)
	{
		[StoreName setText:[NSString stringWithFormat:@"롯데리아 %@", Info.storename]];
	}
	else
	{
		[StoreName setText:[NSString stringWithFormat:@"롯데리아 %@점", Info.storename]];
	}

	NSString *p_tmp;
	len = [[Info storephone] length];
	int t = 3;
	if ([[[Info storephone] substringWithRange:NSMakeRange(0, 2)] compare:@"02"] == NSOrderedSame) t = 2;
	
	p_tmp = [NSString stringWithFormat:@"%@-%@-%@",
			 [[Info storephone] substringWithRange:NSMakeRange(0, t)],
			 [[Info storephone] substringWithRange:NSMakeRange(t, len - 4 - t)],
			 [[Info storephone] substringWithRange:NSMakeRange(len - 4, 4)]];
	[StorePhone setText:p_tmp];
	[StoreAddress setText:[NSString stringWithFormat:@"%@\n\n\n\n\n\n\n\n\n\n\n\n\n\n",[Info getAddressStr]]];
	
	if(Info.store_flag == TIMESTORE)
	{
		[StoreType setText:@"24 시간매장"];
		[StoreImg setImage:[UIImage imageNamed:@"icon_store_24.png"]];
	}
	else if(Info.store_flag == DELIVERYSTORE )
	{
		[StoreType setText:@"배달매장"];
		[StoreImg setImage:[UIImage imageNamed:@"icon_store_delivery.png"]];
	}
	else if(Info.store_flag == NORMALSTORE)
	{
		[StoreType setText:@"일반매장"];
		[StoreImg setImage:[UIImage imageNamed:@"icon_store_general.png"]];
	}

	self.navigationItem.title = @"매장정보";
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

- (IBAction)callbutton
{// 핸드폰에서 전하걸림.
	NSString *p_tmp;
	int len = [[Info storephone] length];
	int t = 3;
	if ([[[Info storephone] substringWithRange:NSMakeRange(0, 2)] compare:@"02"] == NSOrderedSame) t = 2;
	
	p_tmp = [NSString stringWithFormat:@"tel://%@-%@-%@",
			 [[Info storephone] substringWithRange:NSMakeRange(0, t)],
			 [[Info storephone] substringWithRange:NSMakeRange(t, len - 4 - t)],
			 [[Info storephone] substringWithRange:NSMakeRange(len - 4, 4)]];
	
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:p_tmp]];
}

@end
