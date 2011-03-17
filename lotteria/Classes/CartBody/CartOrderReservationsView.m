//
//  CartOrderReservationsView.m
//  lotteria
//
//  Created by embmaster on 11. 2. 26..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CartOrderReservationsView.h"
#import "UITableViewCellTemplate.h"
#import "CartOrderUserViewController.h"
#import "DataManager.h"


@implementation CartOrderReservationsView

@synthesize Picket;
@synthesize reButton;
@synthesize	OrderBurial;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	Picket.date = [NSDate date];
	Picket.backgroundColor = [UIColor clearColor];
	[OrderBurial reloadData];
	self.navigationItem.title = @"주문하기";
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
	[dateFormatter setDateFormat:@"hhmi"];
	Order *Data = [[DataManager getInstance] UserOrder];
	[Data setOrderTime:[dateFormatter stringFromDate:[Picket date]]];
	[locale release];
	[dateFormatter release];
	
	CartOrderUserViewController *Order = [[CartOrderUserViewController alloc] initWithNibName:@"CartOrderUserView" bundle:nil];
	[self.navigationController pushViewController:Order animated:YES];
	[Order release];
}

#pragma mark -
#pragma mark TableView


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *CellIdentifier = @"ShippingOrderCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil)
	{
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier 
													 owner:self options:nil];
		for (id oneObject in nib)
		{
			if ([oneObject isKindOfClass:[ShippingOrderCell class]])
			{
				cell = oneObject;
				break;
			}
		}
		
	}
	
	ShippingOrderCell *tmp_cell = (ShippingOrderCell *)cell;
	Order *Data = [[DataManager getInstance] UserOrder];
	
	NSString* p_tmp;
	int len = [[Data.UserAddr phone] length];
	int t = 3;
	
	if ([[[Data.UserAddr  phone] substringWithRange:NSMakeRange(0, 2)] compare:@"02"] == NSOrderedSame) t = 2;
	
	p_tmp = [NSString stringWithFormat:@"%@-%@-%@",
			 [[Data.UserAddr  phone]  substringWithRange:NSMakeRange(0, t)],
			 [[Data.UserAddr  phone] substringWithRange:NSMakeRange(t, len - 4 - t)],
			 [[Data.UserAddr  phone] substringWithRange:NSMakeRange(len - 4, 4)]];
	
	[tmp_cell setInfo:[Data.UserAddr branchname] :[Data.UserAddr getAddressStr] :p_tmp ];
	
	return cell;
}


////////////////////////////////////////////////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 75;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}


@end
