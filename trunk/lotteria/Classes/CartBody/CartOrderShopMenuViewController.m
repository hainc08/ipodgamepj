//
//  OrderShopMenuViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 27..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CartOrderShopMenuViewController.h"
#import "DataManager.h"
#import "HttpRequest.h"
#import "UITableViewCellTemplate.h"

#import "XmlParser.h"
#import "CartOrderViewController.h"


@implementation CartOrderShopMenuViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	menuTable.backgroundColor = [UIColor clearColor];
	menuTable.opaque = NO;
	menuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
	menuTable.separatorColor = [UIColor clearColor];
	

	
	[Scroll addSubview:menuTable];
	Scroll.frame = CGRectMake(12, 5, 297, 232);
	buttontype = true;
	
	[menuTable reloadData];
	[self SetButton];
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
- (void)SetButton
{
	if(buttontype && [[DataManager getInstance] getCartPrice] >= 8000 )
	{
		[orderButton setAlpha:1];
		[againButton setAlpha:0];
	}
	else {
		[orderButton setAlpha:0];
		[againButton setAlpha:1];
	}

}

/*
 Cell 에서 삭제 버튼 눌렀을때 해당 대상 삭제하기
 */

- (void)didDataDelete:(NSString *)result
{
	[menuTable	reloadData];
	[self SetButton];
}

/* 
 */
- (IBAction)OrderButton:(id)sender
{
	
	if(sender == orderButton)
	{
		if( [[DataManager getInstance] getCartPrice] < 8000)
		{
			[self ShowOKAlert:ALERT_TITLE msg:ORDER_COND_MSG];
		}
		else {
			Order *order = [[DataManager getInstance] UserOrder];
			[order setOrderMoney:[[DataManager getInstance] getCartPrice]];
			[order setOrderSaleMoney:[[DataManager getInstance] getCartSalePrice]];
			
			CartOrderViewController *Order = [[CartOrderViewController alloc] initWithNibName:@"CartOrderView" bundle:nil];
			[self.navigationController pushViewController:Order animated:YES];
			[Order release];
		}
	}
	else {
		// 메뉴로 돌아가기..
		// 장바구니 창으로 이동~
		//[self.navigationController popToRootViewControllerAnimated:YES];
		[[[UIApplication sharedApplication] delegate]UpdateMoveView:0 viewType:-1];
	}

}

#pragma mark -
#pragma mark TableView


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *CellIdentifier = @"OrderMenuCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil)
	{
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier 
													 owner:self options:nil];
		for (id oneObject in nib)
		{
			if ([oneObject isKindOfClass:[OrderMenuCell class]])
			{
				cell = oneObject;
				break;
			}
		}
	}
	
	OrderMenuCell *tmp_cell = (OrderMenuCell *)cell;
	/* cell에서 삭제하는 데이터가 있으면 ReloadData 호출하기..*/
	CartItem *item = [[DataManager getInstance] getCartItem:indexPath.row];
	
	buttontype &= item.StoreMenuOnOff;
	[self SetButton];
	[tmp_cell setDelegate:self selector:@selector(didDataDelete:)];
	[tmp_cell setMenuData:indexPath.section  :item];
	
	return cell;
}


////////////////////////////////Price////////////////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 108;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	int itemCount = [[[DataManager getInstance] getShopCart] count] ;
	return itemCount;
}

	
@end
