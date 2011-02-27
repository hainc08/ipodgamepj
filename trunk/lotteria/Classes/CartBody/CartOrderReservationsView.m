//
//  CartOrderReservationsView.m
//  lotteria
//
//  Created by embmaster on 11. 2. 26..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CartOrderReservationsView.h"
#import "UITableViewCellTemplate.h"
#import "OrderViewController.h"
#import "DataList.h"


@implementation CartOrderReservationsView

@synthesize Picket;
@synthesize reButton;
@synthesize	OrderBurial;
@synthesize InfoOrder;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	Picket.date = [NSDate date];
	Picket.backgroundColor = [UIColor clearColor];
	[OrderBurial reloadData];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (IBAction)ReservationButton
{
	NSLocale *locale	=	[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
	NSDateFormatter *dateFormatter		=	[[NSDateFormatter alloc] init];
	[dateFormatter setLocale:locale];
	[dateFormatter setDateFormat:@"h:mm a"];
	InfoOrder.OrderTime = [dateFormatter stringFromDate:[Picket date]];
	[locale release];
	[dateFormatter release];
	
	OrderViewController *Order = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
	Order.InfoOrder = self.InfoOrder;
	[self.navigationController pushViewController:Order animated:YES];
	[Order release];
}

#pragma mark -
#pragma mark TableView


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *CellIdentifier = @"ShippingCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil)
	{
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier 
													 owner:self options:nil];
		for (id oneObject in nib)
		{
			if ([oneObject isKindOfClass:[ShippingCell class]])
			{
				cell = oneObject;
				break;
			}
		}
		
	}
	
	ShippingCell *tmp_cell = (ShippingCell *)cell;
	NSString *s_tmp	= [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", 
					   [InfoOrder.User si], [InfoOrder.User gu], [InfoOrder.User dong], [InfoOrder.User bunji],
					   [InfoOrder.User building], [InfoOrder.User addrdesc]];
	
	[tmp_cell setDelButtonEnable:false];
	[tmp_cell setInfo:[InfoOrder.User branchname]  :[InfoOrder.User branchtime] :s_tmp :[InfoOrder.User phone] ];
	
	return cell;
}


////////////////////////////////////////////////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 97;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}


@end