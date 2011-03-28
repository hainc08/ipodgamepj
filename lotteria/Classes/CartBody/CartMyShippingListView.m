//
//  MyShippingList.m
//  lotteria
//
//  Created by embmaster on 11. 2. 24..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CartMyShippingListView.h"
#import "XmlParser.h"
#import "CartOrderViewController.h"
#import "UITableViewCellTemplate.h"
#import "ShipSearchViewController.h"

#import "NaviViewController.h"
#import "HttpRequest.h"
#import "CartOrderShopMenuViewController.h"
#import "DataManager.h"
#import "LoginViewController.h"
#import "ViewManager.h"
@implementation CartMyShippingList

- (void)viewDidLoad {
	

	
	CustomerTable.backgroundColor = [UIColor clearColor];
	CustomerTable.opaque = NO;
	
	CustomerArr = [[NSMutableArray alloc] initWithCapacity:0];

	[noRegImage setAlpha:0];
	
	self.navigationItem.title = @"배송지선택";
	
    [super viewDidLoad];

	if ([[DataManager getInstance] isLoginNow] == false)
	{
		LoginViewController* popView = [[LoginViewController alloc] init];
		[[ViewManager getInstance] popUp:popView owner:self];
	}
	else
	{
		[self refresh];
	}
}

- (void)refresh
{
	if ( [CustomerArr count] > 0)
		[CustomerArr removeAllObjects];	
	[self GetShippingList];
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
	
	if (httpRequest != nil) {
		[ httpRequest release];
	}
	[CustomerArr release];
    [super dealloc];
}


- (IBAction)ShipRegButton:(id)sender
{
	ShipSearchViewController *ShipData  = [[ShipSearchViewController alloc] init];
	[[ViewManager getInstance] popUp:ShipData owner:self];
}


#pragma mark -
#pragma mark HttpRequestDelegate

/*
 <NewDataSet>
 <item>
 <PHONE>01012345678</PHONE>
 <SI>서울특별시</SI>
 <GU>은평구</GU>
 <DONG>증산동</DONG>
 <BUNJI />
 <BUILDING>증산동사무소</BUILDING>
 <ADDR_APPEND>증산동사무소</ADDR_APPEND>
 <BRANCH_ID>11136</BRANCH_ID>
 <BRANCH_NM>응암사거리</BRANCH_NM>
 </item>
 </NewDataSet>
 */
- (void)GetShippingList
{
	httpRequest = [[HTTPRequest alloc] init];

	// POST로 전송할 데이터 설정
	NSDictionary *bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
								[[DataManager getInstance] cust_id] ,@"cust_id",
								@"3",@"cust_flag",
								nil];
	
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
	// 페이지 호출
	[httpRequest requestUrl:@"/MbCust.asmx/ws_getCustDeliveryXml" bodyObject:bodyObject bodyArray:nil];
	[[ViewManager getInstance] waitview:self.view	isBlock:YES];
}

- (void)didReceiveFinished:(NSString *)result
{
	[[ViewManager getInstance] waitview:self.view isBlock:NO];

	XmlParser* xmlParser = [XmlParser alloc];
	[xmlParser parserString:result];
	if ([self checkSession:xmlParser] == false) 
	{
		[xmlParser release];
		[httpRequest release];
		httpRequest = nil;
		return;
	}
	Element* root = [xmlParser getRoot:@"NewDataSet"];
		
	if( [root childCount] == 0 )
	{
		[CustomerTable setAlpha:0];
		[noRegImage setAlpha:1];
	}
	else {
		for(Element* t_item = [root getFirstChild] ; nil != t_item   ; t_item = [root getNextChild] )
		{	
			DeliveryAddrInfo *Customer  = [[[DeliveryAddrInfo alloc] init] retain];
			[Customer setSeq:[[t_item getChild:@"SEQ"] getValue]];
			[Customer setPhone:[[t_item getChild:@"PHONE"] getValue]];
			[Customer setSi:[[t_item getChild:@"SI"] getValue]];
			[Customer setGu:[[t_item getChild:@"GU"] getValue]];
			[Customer setDong:[[t_item getChild:@"DONG"] getValue]];
			[Customer setBunji:[[t_item getChild:@"BUNJI"] getValue]];
			[Customer setBuilding:[[t_item getChild:@"BUILDING"] getValue]];
			[Customer setAddrdesc:[[t_item getChild:@"ADDR_APPEND"] getValue]];
			[Customer setBranchid:[[t_item getChild:@"BRANCH_ID"] getValue]];
			[Customer setBranchname:[[DataManager getInstance] smartBranchName:[[t_item getChild:@"BRANCH_NM"] getValue]]];
			[Customer setGis_x:[[t_item getChild:@"POINT_X"] getValue]];
			[Customer setGis_y:[[t_item getChild:@"POINT_Y"] getValue]];
			[CustomerArr  addObject:Customer];
		}	
	}
	[xmlParser release];
	if([CustomerArr count] > 0)
	{
		[CustomerTable setAlpha:1];
		[noRegImage setAlpha:0];
		[CustomerTable reloadData];	
	}
	else {
		[CustomerTable setAlpha:0];
		[noRegImage setAlpha:1];
	}
	[httpRequest release];
	httpRequest = nil;
}



/*
 Cell 에서 삭제 버튼 눌렀을때 해당 대상 삭제하기
 */

-(IBAction)CellDeleteButton:(id)sender
{
	httpRequest = [[HTTPRequest alloc] init];
	UIButton *tmpButton	= (UIButton *)sender;
	RemoveNum	= tmpButton.tag;
	
	DeliveryAddrInfo  *Tmp = [CustomerArr objectAtIndex:RemoveNum];
	// POST로 전송할 데이터 설정
	NSDictionary *bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
								[[DataManager getInstance] cust_id] ,@"cust_id",
								[Tmp Seq] ,@"seq",
								nil];
	
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didDataDelete:)];
	
	// 페이지 호출
	[httpRequest requestUrl:@"/MbCust.asmx/ws_delCustDeliveryXml" bodyObject:bodyObject bodyArray:nil];
	[[ViewManager getInstance] waitview:self.view	isBlock:YES];
}

- (void)didDataDelete:(NSString *)result
{	
	[[ViewManager getInstance] waitview:self.view	isBlock:NO];
	
	if(![result compare:@"error"])
	{
		[self ShowOKAlert:ERROR_TITLE msg:HTTP_ERROR_MSG];	
	}
	else {
		
		XmlParser* xmlParser = [XmlParser alloc];
		[xmlParser parserString:result];
		if ([self checkSession:xmlParser] == false) 
		{
			[xmlParser release];
			[httpRequest release];
			httpRequest = nil;
			return;
		}
		Element* root = [xmlParser getRoot:@"RESULT_CODE"];
	
		if([[root getValue] compare:@"Y"] == NSOrderedSame)
		{
			[CustomerArr removeObjectAtIndex:RemoveNum];
			if([CustomerArr count] > 0)
			{
				[CustomerTable setAlpha:1];
				[CustomerTable reloadData];	
			}
			else
			{
				[CustomerTable setAlpha:0];
				[noRegImage setAlpha:1];
			}
		}
		else	[self ShowOKAlert:ERROR_TITLE msg:DELI_ERROR_MSG];	
	}
	[httpRequest release];
	httpRequest = nil;
}
#pragma mark -
#pragma mark ORDERMENUCHECK

- (void)GetOrderMenuSearch:(NSString *)gis_x :(NSString *)gis_y
{
	httpRequest = [[HTTPRequest alloc] init];
	/* Menu 불러와서 Order정보에 판매매장에서 파는지 여부 확인해야 함 */
	
	// POST로 전송할 데이터 설정
	NSMutableArray	*Body = [[NSMutableArray alloc] initWithCapacity:0];
	NSMutableArray	*MenuID = [[NSMutableArray alloc] initWithCapacity:0];	
	
	[Body addObject:[NSString stringWithFormat:@"gis_x=%@", gis_x]];
	[Body addObject:[NSString stringWithFormat:@"gis_y=%@", gis_y]];
	
	NSMutableArray *ShopItemArr = [[DataManager getInstance] getShopCart];
	
	for (CartItem* objectInstance in ShopItemArr) {
		
		if (objectInstance.menuId != nil )
		{
			[MenuID	 addObject:[NSString stringWithFormat:@"menu_id=%@", 
								[ objectInstance.menuId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]]; // 메뉴ID
			
			[MenuID addObject:[NSString stringWithFormat:@"menu_dis=%@", 
								[[[DataManager getInstance] getProduct:objectInstance.menuId].menuDIS stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  ]]; // 할인코드		
		}
		if (objectInstance.drinkId != nil )
		{
			[MenuID	 addObject:[NSString stringWithFormat:@"menu_id=%@", 
								[ objectInstance.drinkId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]]; // 메뉴ID
			
			[MenuID addObject:[NSString stringWithFormat:@"menu_dis=%@", 
								[[[DataManager getInstance] getProduct:objectInstance.drinkId].menuDIS stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  ]]; // 할인코드		
		}
		if (objectInstance.dessertId != nil )
		{
			[MenuID	 addObject:[NSString stringWithFormat:@"menu_id=%@", 
								[ objectInstance.dessertId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]]; // 메뉴ID
			
			[MenuID addObject:[NSString stringWithFormat:@"menu_dis=%@", 
								[[[DataManager getInstance] getProduct:objectInstance.dessertId].menuDIS stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  ]]; // 할인코드		
		}
	}
	[Body addObjectsFromArray:MenuID ];	[MenuID release];

	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didReceiveMenuCheckFinished:)];
	
	// 페이지 호출
	[httpRequest requestUrl:@"/MbBranch.asmx/ws_getOrderBranchMenuXml" bodyObject:nil bodyArray:Body];
	[Body release];
	[[ViewManager getInstance] waitview:self.view	isBlock:YES];
}

- (void)didReceiveMenuCheckFinished:(NSString *)result
{
	[[ViewManager getInstance] waitview:self.view	isBlock:NO];
	if(![result compare:@"error"])
	{
		[self ShowOKAlert:ERROR_TITLE msg:HTTP_ERROR_MSG];	
	}
	else 
	{ 
		XmlParser* xmlParser = [XmlParser alloc];
		[xmlParser parserString:result];
		if ([self checkSession:xmlParser] == false) 
		{
			[xmlParser release];
			[httpRequest release];
			httpRequest = nil;
			return;
		}
		Element* root = [xmlParser getRoot:@"NewDataSet"];
		
		if( [root childCount] == 0 )
		{
			[self ShowOKAlert:ERROR_TITLE msg:DELI_SEARCH_ERROR_MSG];	
		}
		else {
			for(Element* t_item = [root getFirstChild] ; nil != t_item   ; t_item = [root getNextChild] )
			{
				if ( [t_item.name compare:@"BRANCH"]  == NSOrderedSame ) {
						
					DeliveryAddrInfo *Customer  = [[[DataManager getInstance] UserOrder] UserAddr];

					[Customer setSi:[[t_item getChild:@"SI"] getValue]];	
					[Customer setGu:[[t_item getChild:@"GU"] getValue]];
					[Customer setDong:[[t_item getChild:@"DONG"] getValue]];
					[Customer setBunji:[[t_item getChild:@"BUNJI"] getValue]];
					[Customer setBuilding:[[t_item getChild:@"BUILDING"] getValue]];
					[Customer setAddrdesc:[[t_item getChild:@"ADDR_APPEND"] getValue]];
					[Customer setBranchid:[[t_item getChild:@"BRANCH_ID"] getValue]];
					[Customer setBranchname:[[DataManager getInstance] smartBranchName:[[t_item getChild:@"BRANCH_NM"] getValue]]];
					[Customer setGis_x:[[t_item getChild:@"GIS_X"] getValue]];
					[Customer setGis_y:[[t_item getChild:@"GIS_Y"] getValue]];
					[Customer setTerminal_id:[[t_item getChild:@"TERMINAL_ID"] getValue]];
					[Customer setBusiness_date:[[t_item getChild:@"BUSINESS_DATE"] getValue]];
					[Customer setBranchtel:[[t_item getChild:@"BRANCH_TEL1"] getValue]];

					[Customer setOpendate:[[t_item getChild:@"DELI_OPEN_TIME"] getValue]];

					{
						NSString *data = [[t_item getChild:@"DELI_CLOSE_TIME"] getValue];
						if (([data compare:@"240000"] == NSOrderedSame) ||
							([data compare:@"000000"] == NSOrderedSame)) data = @"235900";

						[Customer setClosedate:data];
					}

					[Customer setBranchtel:[[t_item getChild:@"DELIVERY_TIME"] getValue]];
				
				}
				else if( [t_item.name compare:@"ITEM"] == NSOrderedSame ) {
					
					[[DataManager getInstance] 	updateCartMenuStatus:[[t_item getChild:@"MENU_ID"] getValue] 
																 dis:[[t_item getChild:@"MENU_DIS"] getValue] 
																flag: ( [[[t_item getChild:@"SHORT_FLAG"] getValue] compare:@"Y"] == NSOrderedSame ) ? false: true ]; // Y 이면 결품
				}

			}	
		
			CartOrderShopMenuViewController *Order = [[CartOrderShopMenuViewController alloc] initWithNibName:@"CartOrderShopMenu" bundle:nil];
			[self.navigationController pushViewController:Order animated:YES];
			[Order release];
			
		}		
		[xmlParser release];
	}
	[httpRequest release];
	httpRequest = nil;
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
		cell.selectedBackgroundView = [[[UIImageView alloc] init] autorelease];
		((UIImageView *)cell.selectedBackgroundView).image = [UIImage imageNamed:@"bg_delivery_box_on.png"] ;
	}
	
	ShippingCell *tmp_cell = (ShippingCell *)cell;
	/* cell에서 삭제하는 Button 엑션에 대한 클릭 이벤트 넣기 */
	[tmp_cell.delbutton setTag:indexPath.row];
	[tmp_cell.delbutton addTarget:self action:@selector(CellDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
	
	DeliveryAddrInfo  *tmp = [CustomerArr objectAtIndex:indexPath.row];
	
					   
	[tmp_cell setInfo:[tmp branchname] :[tmp getAddressStr] :[[DataManager getInstance] getPhoneStr:[tmp phone]]];

	return cell;
}


////////////////////////////////////////////////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 112;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	DeliveryAddrInfo  *Tmp = [CustomerArr objectAtIndex:indexPath.row];
	DeliveryAddrInfo *Customer  = [[[DataManager getInstance] UserOrder] UserAddr];
	[Customer setSeq:Tmp.Seq];
	[Customer setPhone:Tmp.phone];
	
	[self GetOrderMenuSearch:Tmp.gis_x :Tmp.gis_y ];			

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [CustomerArr count];
}


@end