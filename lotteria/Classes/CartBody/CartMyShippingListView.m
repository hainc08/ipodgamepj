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
	httpRequest = [[HTTPRequest alloc] init];

	[self GetShippingList];
	[CustomerTable reloadData];	
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
	[httpRequest release];
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
	// POST로 전송할 데이터 설정
	NSDictionary *bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
								@"seyogo",@"cust_id",
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
	if(![result compare:@"error"])
	{
		[self ShowOKAlert:@"Data Fail" msg:@"서버에서 데이터 불러오는데 실패하였습니다."];	
	}
	else {
		XmlParser* xmlParser = [XmlParser alloc];
		[xmlParser parserString:result];
		Element* root = [xmlParser getRoot:@"NewDataSet"];
		
		if( [root childCount] == 0 )
		{
			[self ShowOKAlert:nil msg:@"등록된 배송지 목록이 없습니다."];	
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
				[Customer setBranchname:[[t_item getChild:@"BRANCH_NM"] getValue]];
				[Customer setGis_x:[[t_item getChild:@"GIS_X"] getValue]];
				[Customer setGis_y:[[t_item getChild:@"GIS_Y"] getValue]];
				[CustomerArr  addObject:Customer];
			}	

			if([CustomerArr count] > 0)
			{
				[CustomerTable setAlpha:1];
				[noRegImage setAlpha:0];
				[CustomerTable reloadData];	
			}
			else
			{
				[CustomerTable setAlpha:0];
				[noRegImage setAlpha:1];
			}
			
		}
		[xmlParser release];

	}
}
#pragma mark -
#pragma mark ORDERMENUCHECK

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
	
	for (CartItem* objectInstance in ShopItemArr) {
		
		if (![objectInstance.menuId compare:@""] )
		{
			[MenuID	 addObject:[NSString stringWithFormat:@"menu_id=%@", 
								[ objectInstance.menuId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]]; // 메뉴ID
			
			[MenuDIS addObject:[NSString stringWithFormat:@"menu_dis=%@", 
								[[[DataManager getInstance] getProduct:objectInstance.menuId].menuDIS stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  ]]; // 할인코드		
		}
		if (![objectInstance.drinkId compare:@""] )
		{
			[MenuID	 addObject:[NSString stringWithFormat:@"menu_id=%@", 
								[ objectInstance.drinkId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]]; // 메뉴ID
			
			[MenuDIS addObject:[NSString stringWithFormat:@"menu_dis=%@", 
								[[[DataManager getInstance] getProduct:objectInstance.drinkId].menuDIS stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  ]]; // 할인코드		
		}
		if (![objectInstance.dessertId compare:@""] )
		{
			[MenuID	 addObject:[NSString stringWithFormat:@"menu_id=%@", 
								[ objectInstance.dessertId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]]; // 메뉴ID
			
			[MenuDIS addObject:[NSString stringWithFormat:@"menu_dis=%@", 
								[[[DataManager getInstance] getProduct:objectInstance.dessertId].menuDIS stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  ]]; // 할인코드		
		}
	}
	[Body addObjectsFromArray:MenuID];
	[Body addObjectsFromArray:MenuDIS];
	
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didReceiveMenuCheckFinished:)];
	
	// 페이지 호출
	[httpRequest requestUrl:@"/member.asmx/ws_getCustDeliveryXml" bodyObject:nil bodyArray:Body];
	
}

- (void)didReceiveMenuCheckFinished:(NSString *)result
{
	
	if(![result compare:@"error"])
	{
		[self ShowOKAlert:@"Data Fail" msg:@"서버에서 데이터 불러오는데 실패하였습니다."];	
	}
	else {
		XmlParser* xmlParser = [XmlParser alloc];
		[xmlParser parserString:result];
		Element* root = [xmlParser getRoot:@"NewDataSet"];
		
		
		if( [root childCount] == 0 )
		{
			[self ShowOKAlert:nil msg:@"등록된 배송지 목록이 없습니다."];	
		}
		else {
			
			for(Element* t_item = [root getFirstChild] ; nil != t_item   ; t_item = [root getNextChild] )
			{
				if ( [t_item.name compare:@"BRANCH"]  == NSOrderedSame ) {
					
				DeliveryAddrInfo *Customer  = [[DataManager getInstance] UserOrder];
				[Customer setSeq:[[t_item getChild:@"SEQ"] getValue]];
				[Customer setPhone:[[t_item getChild:@"PHONE"] getValue]];
				[Customer setSi:[[t_item getChild:@"SI"] getValue]];
				[Customer setGu:[[t_item getChild:@"GU"] getValue]];
				[Customer setDong:[[t_item getChild:@"DONG"] getValue]];
				[Customer setBunji:[[t_item getChild:@"BUNJI"] getValue]];
				[Customer setBuilding:[[t_item getChild:@"BUILDING"] getValue]];
				[Customer setAddrdesc:[[t_item getChild:@"ADDR_APPEND"] getValue]];
				[Customer setBranchid:[[t_item getChild:@"BRANCH_ID"] getValue]];
				[Customer setBranchname:[[t_item getChild:@"BRANCH_NM"] getValue]];
				[Customer setGis_x:[[t_item getChild:@"GIS_X"] getValue]];
				[Customer setGis_y:[[t_item getChild:@"GIS_Y"] getValue]];
					
				}
				else if( [t_item.name compare:@"ITEM"] == NSOrderedSame ) {
					
				[[DataManager getInstance] 	updateCartMenuStatus:[[t_item getChild:@"MENU_ID"] getValue] 
				 dis:[[t_item getChild:@"MENU_DIS"] getValue] 
				 flag:[[[t_item getChild:@"SHORT_FLAG"] getValue] compare:@"Y"] ? true : false];
				}

			}	
			
			if([CustomerArr count] > 0)
			{
				[CustomerTable setAlpha:1];
				[noRegImage setAlpha:0];
				[CustomerTable reloadData];	
			}
			else
			{
				[CustomerTable setAlpha:0];
				[noRegImage setAlpha:1];
			}
			
		}		
		[xmlParser release];
	}
}

/*
 Cell 에서 삭제 버튼 눌렀을때 해당 대상 삭제하기
 */

-(IBAction)CellDeleteButton:(id)sender
{

	UIButton *tmpButton	= (UIButton *)sender;
	RemoveNum	= tmpButton.tag;
//	CustomerDelivery  *tmp = [CustomerArr objectAtIndex:RemoveNum];

	// POST로 전송할 데이터 설정
	NSDictionary *bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
								[[DataManager getInstance] accountId] ,@"cust_id",
								1 ,@"seq",
								nil];
	
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didDataDelete:)];
	
	// 페이지 호출
	[httpRequest requestUrl:@"/MbCust.asmx/ws_delCustDelivery" bodyObject:bodyObject bodyArray:nil];
}

- (void)didDataDelete:(NSString *)result
{	
	if(![result compare:@"error"])
	{
		[self ShowOKAlert:@"ERROR" msg:@"서버에서 응답이 없습니다."];	
	}
	else {
		if(![result compare:@"<int>1<int>"])
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
		else {
			[self ShowOKAlert:@"ERROR" msg:@"서버에서 데이터 삭제하는데 실패하였습니다."];	
		}

	}
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
	
	NSString *s_tmp	= [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", 
					   ([tmp si]?[tmp si]:@""),
					   ([tmp gu]?[tmp si]:@""),
					   ([tmp dong]?[tmp dong]:@""),
					   ([tmp bunji]?[tmp bunji]:@""),
					   ([tmp building]?[tmp building]:@""),
					   ([tmp addrdesc]?[tmp addrdesc]:@"")];
	
	NSString* p_tmp;
	int len = [[tmp phone] length];
	int t = 3;
	
	if ([[[tmp phone] substringWithRange:NSMakeRange(0, 2)] compare:@"02"] == NSOrderedSame) t = 2;
	
	p_tmp = [NSString stringWithFormat:@"%@-%@-%@",
			 [[tmp phone] substringWithRange:NSMakeRange(0, t)],
			 [[tmp phone] substringWithRange:NSMakeRange(t, len - 4 - t)],
			 [[tmp phone] substringWithRange:NSMakeRange(len - 4, 4)]];
					   
	[tmp_cell setInfo:[tmp branchname] :s_tmp :p_tmp ];

	return cell;
}


////////////////////////////////////////////////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 112;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self GetOrderMenuSearch];
	DeliveryAddrInfo  *Tmp = [CustomerArr objectAtIndex:indexPath.row];
	Order *OrderUser = [[DataManager getInstance] UserOrder];
							
	[OrderUser.UserAddr setSi:Tmp.si];
	[OrderUser.UserAddr setGu:Tmp.gu];
	[OrderUser.UserAddr setDong:Tmp.dong];
	[OrderUser.UserAddr setBunji:Tmp.bunji];
	[OrderUser.UserAddr setBuilding:Tmp.building];
	[OrderUser.UserAddr setAddrdesc:Tmp.addrdesc];

	CartOrderShopMenuViewController *Order = [[CartOrderShopMenuViewController alloc] initWithNibName:@"CartOrderShopMenu" bundle:nil];
	[self.navigationController pushViewController:Order animated:YES];
	[Order release];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [CustomerArr count];
}


@end
