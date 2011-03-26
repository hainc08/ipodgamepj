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

#define ADDINTERVAL 120*60+30*60

@implementation CartOrderReservationsView

@synthesize Picket;
@synthesize reButton;
@synthesize	OrderBurial;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[Picket addTarget:self action:@selector(controlEventValueChanged:) forControlEvents:UIControlEventValueChanged];
	[Picket setDate:[[NSDate date] addTimeInterval:ADDINTERVAL]] ;
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
	[self checkTime];
}

- (IBAction)ReservationButton
{
	if ([self checkTime] == false) return;

	NSLocale *locale	=	[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
	NSDateFormatter *dateFormatter		=	[[NSDateFormatter alloc] init];
	[dateFormatter setLocale:locale];
	[dateFormatter setDateFormat:@"hhmm"];
	Order *Data = [[DataManager getInstance] UserOrder];
	[Data setOrderTime:[dateFormatter stringFromDate:[Picket date]]];
	[locale release];
	[dateFormatter release];
	
	CartOrderUserViewController *Order = [[CartOrderUserViewController alloc] initWithNibName:@"CartOrderUserView" bundle:nil];
	[self.navigationController pushViewController:Order animated:YES];
	[Order release];
}

- (bool)checkTime
{
	Order *Data = [[DataManager getInstance] UserOrder];
	DeliveryAddrInfo *deli = [Data UserAddr];
	
	NSLocale *locale	=	[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
	NSDateFormatter *dateFormatter		=	[[NSDateFormatter alloc] init];
	[dateFormatter setLocale:locale];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HHmmss"];
	NSDate* now = [[NSDate alloc] init];
	NSString* toDay = [[dateFormatter stringFromDate:now] substringToIndex:10];
	
	NSDate* openDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@", toDay, [deli opendate]]];
	NSDate* closeDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@", toDay, [deli closedate]]];
	NSDate* pickDate = [Picket date];
	
	bool isOK = true;
	
	if ([pickDate timeIntervalSince1970] < [[[NSDate date] addTimeInterval:120*60] timeIntervalSince1970] )
	{
		[Picket setDate:[[NSDate date] addTimeInterval:ADDINTERVAL]] ;
		[self ShowOKAlert:ALERT_TITLE msg:DELI_TIME_ERROR_2HOUR_MSG];
		
		isOK = false;
	}
	else if (([pickDate timeIntervalSince1970] < [openDate timeIntervalSince1970]) ||
			 ([pickDate timeIntervalSince1970] > [closeDate timeIntervalSince1970]))
	{
		[Picket setDate:[[NSDate date] addTimeInterval:ADDINTERVAL]] ;
		[self ShowOKAlert:ALERT_TITLE msg:DELI_TIME_ERROR_MSG];

		isOK = false;
	}
	
	[locale release];
	[dateFormatter release];
	
	return isOK;
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
