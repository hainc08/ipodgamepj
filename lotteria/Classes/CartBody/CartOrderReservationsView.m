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
	
	[Picket addTarget:self action:@selector(controlEventValueChanged:) forControlEvents:UIControlEventValueChanged];
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

-(void)controlEventValueChanged:(id)sender
{
	if ( [[Picket date] timeIntervalSince1970] < [[NSDate date] timeIntervalSince1970] )
	{
		[Picket setDate:[[NSDate date] addTimeInterval:10*60]] ;
		[self ShowOKAlert:nil msg:@"배달 가능한 시간이 아닙니다."];
	}
	else if ( [[Picket date] timeIntervalSince1970] < [[NSDate date] timeIntervalSince1970] )
	{
		[Picket setDate:[[NSDate date] addTimeInterval:10*60]] ;
		[self ShowOKAlert:nil msg:@"배달 가능한 시간이 아닙니다."];
	}
	

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
	
	[tmp_cell setInfo:[Data.UserAddr branchname] :[Data.UserAddr getAddressStr] :[[DataManager getInstance] getPhoneStr:[Data.UserAddr branchtel]] ];
	
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
