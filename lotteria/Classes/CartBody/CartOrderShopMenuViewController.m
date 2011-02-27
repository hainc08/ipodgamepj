//
//  OrderShopMenuViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 27..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CartOrderShopMenuViewController.h"
#import "DataList.h"
#import "HttpRequest.h"
#import "UITableViewCellTemplate.h"

#import "XmlParser.h"
#import "CartOrderViewController.h"



@implementation CartOrderShopMenuViewController
@synthesize InfoOrder;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	menuTable.backgroundColor = [UIColor clearColor];
	menuTable.opaque = NO;
	menuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
	menuTable.separatorColor = [UIColor clearColor];
	
	buttontype = true;
	[self GetOrderMenuSearch];
	
	[menuTable reloadData];
	[self SetButton];
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
	if(buttontype && [InfoOrder.Product count] > 0)
	{
		[orderButton setAlpha:1];
		[againButton setAlpha:0];
	}
	else {
		[orderButton setAlpha:0];
		[againButton setAlpha:1];
	}

}

- (void)GetOrderMenuSearch
{
	/* Menu 불러와서 Order정보에 판매매장에서 파는지 여부 확인해야 함 */
	
	
#ifdef LOCALTEST
	// 회사 내부 테스트 용 */
	NSString *url = @"http://192.168.106.203:8010/ws/member.asmx/ws_getCustDeliveryXml";
#else
	// 롯데리아 사이트 테스트 
	NSString *url = @"http://192.168.106.203:8010/ws/member.asmx/ws_getCustDeliveryXml";
#endif
	
	// POST로 전송할 데이터 설정
	NSDictionary *bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
								@"seyogo",@"cust_id",
								@"", @"buindid",
								@"", @"menulist",
								nil];
	
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
	
	// 페이지 호출
	[httpRequest requestUrl:url bodyObject:bodyObject];
	
}

- (void)didReceiveFinished:(NSString *)result
{
	
	if(![result compare:@"error"])
	{
		[self ShowOKAlert:@"Data Fail" msg:@"서버에서 데이터 불러오는데 실패하였습니다."];	
	}
	else {
		XmlParser* xmlParser = [XmlParser alloc];
		[xmlParser parserString:result];
		Element* root = [xmlParser getRoot:@"NewDataSet"];
		
		for(Element* t_item = [root getFirstChild] ; nil != t_item   ; t_item = [root getNextChild] )
		{
			
		}	
		[xmlParser release];
		[menuTable reloadData];
		[self SetButton];
	}
}

/*
 Cell 에서 삭제 버튼 눌렀을때 해당 대상 삭제하기
 */

- (void)didDataDelete:(NSString *)result
{
	[menuTable	reloadData];
}

/* 
 */
- (IBAction)OrderButton:(id)sender
{
	if(sender == orderButton)
	{
		CartOrderViewController *Order = [[CartOrderViewController alloc] initWithNibName:@"CartOrderView" bundle:nil];
		Order.InfoOrder = self.InfoOrder;
		[self.navigationController pushViewController:Order animated:YES];
		[Order release];
	}
	else {
		// 메뉴로 돌아가기..
	}

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
	return 5;
}


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
	CartItem *item = [[DataManager getInstance] getCartItem:indexPath.row listIdx:indexPath.section];
	//buttontype &= item.StoreMenuOnOff;
	buttontype &= true;
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
	int itemCount = [[DataManager getInstance] itemCount:section];
	return itemCount;
}

	
@end
