//
//  ShipStreetBuilding.m
//  lotteria
//
//  Created by embmaster on 11. 2. 26..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShipStreetBuilding.h"
#import "ShipAddressTable.h"

@implementation ShipStreetBuilding




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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
- (IBAction)ButtonClick:(id)sender
{
	if(sender == Street || sender == Building )
	{
		ShipAddressTable *shiptable = [[ShipAddressTable alloc] initWithNibName:@"ShipAddressTable" bundle:nil];
		//ShipAddressTable *shiptable = [[ShipAddressTable alloc] init];
		[shiptable setDong:Search.text];
		shiptable.ShipType = 0;
		[self.navigationController pushViewController:shiptable animated:YES];
		[shiptable release];
	}
	else if(sender == Back)
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
}
@end
