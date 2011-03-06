//
//  OrderViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 24..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderPriceViewController.h"
#import "UITableViewCellTemplate.h"
#import "DataManager.h"\

@implementation OrderViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	OrderTable.backgroundColor = [UIColor clearColor];
	OrderTable.opaque = NO;
	OrderTable.separatorStyle = UITableViewCellSeparatorStyleNone;
	OrderTable.separatorColor = [UIColor clearColor];
	self.navigationItem.title = @"주문하기";
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[OrderTable reloadData];	
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];	
}
-(IBAction) PriceButton
{
	OrderPriceViewController *Priceview = [[OrderPriceViewController alloc] initWithNibName:@"OrderPrice"  bundle:nil];
	
	[self.navigationController pushViewController:Priceview animated:YES];
	[Priceview release];
}

#pragma mark -
#pragma mark AlertView
- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
												   delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// 필요한 엑션이 있으면 넣자 ..
}

#pragma mark -
#pragma mark TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	if(section == 1)
	{
		
		UIView *SectionHeader = [[[UIView alloc] initWithFrame:CGRectMake(0, 0,  85, 31)] autorelease];
		SectionHeader.backgroundColor = [UIColor clearColor];
		UIImageView *headerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tit_order_list.png"]];
		[SectionHeader addSubview:headerImage];
		[headerImage release];
		return SectionHeader;
	}
	else {
		return	 nil;
	}

	
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if(section == 1) return 31;
	else return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier ;
	if(indexPath.section == 0)
	{
		CellIdentifier = @"ShippingCell";
	
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
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		ShippingCell *tmp_cell = (ShippingCell *)cell;
		tmp_cell.backgroundColor = [UIColor clearColor];
		

		Order *UserInfo =  [[DataManager getInstance] UserOrder];
		NSString *s_tmp	= [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", 
					   [UserInfo.UserAddr si], [UserInfo.UserAddr gu], [UserInfo.UserAddr dong], 
					   [UserInfo.UserAddr bunji], [UserInfo.UserAddr building], [UserInfo.UserAddr addrdesc]];
		[tmp_cell setInfo:[UserInfo branchname] :s_tmp :[UserInfo branchPhone] ];
		[tmp_cell setDelButtonEnable:false];
	
		return cell;
	}
	else if(indexPath.section == 1)
	{
		if(indexPath.row == 0)
			CellIdentifier = @"OrderListTopCell";
		else if( indexPath.row -1  <  [[[DataManager getInstance] getShopCart]  count] )
			CellIdentifier = @"OrderListMiddleCell";
		else 
			CellIdentifier = @"OrderListBottomCell";


		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
		if (cell == nil)
		{
			NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier 
																owner:self options:nil];
			for (id oneObject in nib)
			{
				if(indexPath.row == 0 )
				{
					if ([oneObject isKindOfClass:[OrderListTopCell class]])
					{
						cell = oneObject;
						break;
					}
				}
				else if(indexPath.row -1 < [[[DataManager getInstance] getShopCart]  count])
				{
					if ([oneObject isKindOfClass:[OrderListMiddleCell class]])
					{
						cell = oneObject;
						break;
					}
				}
				else 
				{
					if ([oneObject isKindOfClass:[OrderListBottomCell class]])
					{
						cell = oneObject;
						break;
					}
				}
			}
		}
		
		if(indexPath.row == 0)
		{
			
		}
		else if(indexPath.row -1 <   [[[DataManager getInstance] getShopCart]  count] )
		{
			OrderListMiddleCell *tmp_cell = (OrderListMiddleCell *)cell;
			//tmp_cell.backgroundColor = [UIColor clearColor];
			
			CartItem  *tmp =  [[[DataManager getInstance] getShopCart] objectAtIndex:indexPath.row-1] ;	
			ProductData *p_data = [[DataManager getInstance] getProduct:tmp.menuId];
			[tmp_cell setInfo:[p_data  category]
							 :[NSString stringWithFormat:@"%d", tmp.count]
							 : [[DataManager getInstance] getPriceStr:[p_data price] *  tmp.count ]];
		}
		else {
			OrderListBottomCell *tmp_cell = (OrderListBottomCell *)cell;
			//tmp_cell.backgroundColor = [UIColor clearColor];

			[tmp_cell setInfo:[[DataManager getInstance] getPriceStr:[[DataManager getInstance] getCartPrice]]
					:@"0"
					:[[DataManager getInstance] getPriceStr:[[DataManager getInstance] getCartPrice]]];
		}
		return cell;
	}

	
	return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.section == 0) return 112;
	else {
		if(indexPath.row == 0) return 14.0f;
		else if (indexPath.row-1 < [[[DataManager getInstance] getShopCart]  count]) return 51.0f;
		else  return 116.0f;
	}

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section == 0)
		return 1;
	else
		return [[[DataManager getInstance] getShopCart]  count] +2;
}


@end
