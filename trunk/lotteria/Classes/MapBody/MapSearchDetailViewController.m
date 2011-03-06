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
	 [Info si], [Info gu], [Info dong], [Info bunji],
	 [Info building], [Info addrdesc]];
	
	[StoreAddress setText:Store];
	
	if(Info.storetype == TIMESTORE)
	{
		[StoreType setText:@"24 시간매장"];
		[StoreImg setImage:[UIImage imageNamed:@"icon_store_24.png"]];
	}
	else if(Info.storetype == DELIVERYSTORE )
	{
		[StoreType setText:@"배달매장"];
		[StoreImg setImage:[UIImage imageNamed:@"icon_store_delivery.png"]];
	}
	else if(Info.storetype == NORMALSTORE)
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
