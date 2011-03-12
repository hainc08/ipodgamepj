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
	[self GetOrderMenuSearch];
	
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
	if(buttontype && [[DataManager getInstance] getCartPrice] > 8000 )
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
	
	// POST로 전송할 데이터 설정
	NSMutableArray	*Body = [[NSMutableArray alloc] initWithCapacity:0];
	NSMutableArray	*MenuID = [[NSMutableArray alloc] initWithCapacity:0];	
	NSMutableArray	*MenuDIS = [[NSMutableArray alloc] initWithCapacity:0];		
	
	[Body addObject:[NSString stringWithFormat:@"gis_x=%@", [[DataManager getInstance] UserOrder].UserAddr.gis_x]];
	[Body addObject:[NSString stringWithFormat:@"gis_y=%@", [[DataManager getInstance] UserOrder].UserAddr.gis_y]];
	
	NSMutableArray *ShopItemArr = [[DataManager getInstance] getShopCart];
	

	for (objectInstance in ShopItemArr) {
		
		if (![objectInstance.menuId compare:@""] )
		{
			[MenuID	 addObject:[NSString stringWithFormat:@"menu_id=%@", 
								[ objectInstance.menuId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]]; // 메뉴ID
			
			[MenuDIS addObject:[NSString stringWithFormat:@"menu_dis=%@", 
					[[[DataManager getInstance] getProduct:objectInstance.menuId].menuDIS stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  ]]; // 할인코드		
		}
	}
	[Body addObjectsFromArray:MenuID];
	[Body addObjectsFromArray:MenuDIS];
	
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
	
	// 페이지 호출
	[httpRequest requestUrl:@"/member.asmx/ws_getCustDeliveryXml" bodyObject:nil bodyArray:Body];
	
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
			
			NSString *menu_id = [[t_item getChild:@"menu_id"] getValue];
			NSString *menu_dis =  [[t_item getChild:@"menu_dis"] getValue];
			
			NSString *short_flag = [[t_item getChild:@"short_flag"] getValue];
			// 비교 처리.. 비교 하는데 세트메뉴는 어쩌나?ㅡ.ㅡ;
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
	[self SetButton];
	[menuTable	reloadData];
}

/* 
 */
- (IBAction)OrderButton:(id)sender
{
	
	if(sender == orderButton)
	{
		if( [[DataManager getInstance] getCartPrice] < 8000)
		{
			[self ShowOKAlert:@"주문" msg:@"8000원 이상주문하셔야 합니다."];
		}
		else {
			CartOrderViewController *Order = [[CartOrderViewController alloc] initWithNibName:@"CartOrderView" bundle:nil];
			[self.navigationController pushViewController:Order animated:YES];
			[Order release];
		}
	}
	else {
		// 메뉴로 돌아가기..
		// 장바구니 창으로 이동~
		[self.navigationController popToRootViewControllerAnimated:YES];
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
	int itemCount = [[[DataManager getInstance] getShopCart] count] ;
	return itemCount;
}

	
@end
