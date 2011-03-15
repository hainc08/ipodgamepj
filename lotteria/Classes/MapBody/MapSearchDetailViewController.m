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
	[StoreName setText:Info.storename];
	[StorePhone setText:Info.storephone];
	
	NSString *Store = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", 
					   ([Info si] ? [Info	si] : @""), ([Info gu] ? [Info gu] : @"" ) , 
					   ([Info dong] ? [Info dong] : @"") , ( [Info bunji] ? [Info bunji] : @""),
					   ( [Info building] ? [Info building] : @""), ([Info addrdesc] ? [Info addrdesc] : @"")];
	
	[StoreAddress setText:Store];
	
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
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[Info storephone]]];
}

@end
