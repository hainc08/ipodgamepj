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
#import "DataList.h"
#import "NaviViewController.h"
#import "HttpRequest.h"

@implementation CartMyShippingList

@synthesize CustomerTable;
@synthesize	CustomerArr;
@synthesize	InfoOrder;
@synthesize noRegImage;
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	CustomerTable.backgroundColor = [UIColor clearColor];
	CustomerTable.opaque = NO;
	
	CustomerArr = [[NSMutableArray alloc] initWithCapacity:0];
	
	[noRegImage setAlpha:0];
	httpRequest = [[HTTPRequest alloc] init];
	
	NSString *string = @"<NewDataSet>\
	<item>\
	<cust_id>seyogo</cust_id>\
	<seq>1</seq>\
	<phone>01029281740</phone>\
	<si>서울특별시</si>\
	<gu>영등포구</gu>\
	<dong>여의도동</dong>\
	<bunji/>\
	<building>한양아파트</building>\
	<addr_desc>1층 101호</addr_desc>\
	<branch_id>99999999</branch_id>\
	<cust_flag>2</cust_flag>\
	<reg_date>20101227</reg_date>\
	<reg_time>135000</reg_time>\
	<upd_date/>\
	<upd_time/>\
	</item>\
	<item>\
	<cust_id>seyogo</cust_id>\
	<seq>1</seq>\
	<phone>01029281740</phone>\
	<si>서울특별시</si>\
	<gu>영등포구</gu>\
	<dong>여의도동</dong>\
	<bunji/>\
	<building>한양아파트</building>\
	<addr_desc>1층 101호</addr_desc>\
	<branch_id>99999999</branch_id>\
	<cust_flag>2</cust_flag>\
	<reg_date>20101227</reg_date>\
	<reg_time>135000</reg_time>\
	<upd_date/>\
	<upd_time/>\
	</item>\
	</NewDataSet>";
	
	
	XmlParser* xmlParser = [XmlParser alloc];
	[xmlParser parserString:string];
	Element* root = [xmlParser getRoot:@"NewDataSet"];
	
	for(Element* t_item = [root getFirstChild] ; nil != t_item   ; t_item = [root getNextChild] )
	{
		
		CustomerDelivery *Customer  = [[[CustomerDelivery alloc] init] retain];
		[Customer setCustid:[[t_item getChild:@"cust_id"] getValue]];
		[Customer setSeq:[[t_item getChild:@"seq"] getValue]];
		[Customer setPhone:[[t_item getChild:@"phone"] getValue]];
		[Customer setSi:[[t_item getChild:@"si"] getValue]];
		[Customer setGu:[[t_item getChild:@"gu"] getValue]];
		[Customer setDong:[[t_item getChild:@"dong"] getValue]];
		[Customer setBunji:[[t_item getChild:@"bunji"] getValue]];
		[Customer setBuilding:[[t_item getChild:@"building"] getValue]];
		[Customer setAddrdesc:[[t_item getChild:@"addr_desc"] getValue]];
		[Customer setBranchid:[[t_item getChild:@"branch_id"] getValue]];
		[Customer setRegdate:[[t_item getChild:@"reg_date"] getValue]];
		[Customer setRegtime:[[t_item getChild:@"reg_time"] getValue]];
		[Customer setUpddate:[[t_item getChild:@"upd_date"] getValue]];
		[Customer setUpdtime:[[t_item getChild:@"upd_time"] getValue]];
		
		[CustomerArr  addObject:Customer];
	}	
	[xmlParser release];
//	[self GetShippingList];
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
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[CustomerTable reloadData];	
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (IBAction)ShipRegButton:(id)sender
{

//	ShipSearchViewController *Search = [[ShipSearchViewController alloc] initWithNibName:@"ShipSearchView" bundle:nil];
	NaviViewController *controller = [[NaviViewController alloc] init];
	[controller setIdx:4];
	[self  presentModalViewController:controller animated:YES];
//	[Search release];
	[controller release];
}


#pragma mark -
#pragma mark HttpRequestDelegate

/*
 
 <NewDataSet>
 <item>
 <cust_id>seyogo</cust_id>
 <seq>1</seq>
 <phone>01029281740</phone>
 <si>서울특별시</si>
 <gu>영등포구</gu>
 <dong>여의도동</dong>
 <bunji/>
 <building>한양아파트</building>
 <addr_desc>1층 101호</addr_desc>
 <branch_id>99999999</branch_id>
 <cust_flag>2</cust_flag>
 <reg_date>20101227</reg_date>
 <reg_time>135000</reg_time>
 <upd_date/>
 <upd_time/>
 </item>
 </NewDataSet>
 */
- (void)GetShippingList
{
	
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
			
			CustomerDelivery *Customer  = [[[CustomerDelivery alloc] init] retain];
			[Customer setCustid:[[t_item getChild:@"cust_id"] getValue]];
			[Customer setSeq:[[t_item getChild:@"seq"] getValue]];
			[Customer setPhone:[[t_item getChild:@"phone"] getValue]];
			[Customer setSi:[[t_item getChild:@"si"] getValue]];
			[Customer setGu:[[t_item getChild:@"gu"] getValue]];
			[Customer setDong:[[t_item getChild:@"dong"] getValue]];
			[Customer setBunji:[[t_item getChild:@"bunji"] getValue]];
			[Customer setBuilding:[[t_item getChild:@"building"] getValue]];
			[Customer setAddrdesc:[[t_item getChild:@"addr_desc"] getValue]];
			[Customer setBranchid:[[t_item getChild:@"branch_id"] getValue]];
			[Customer setRegdate:[[t_item getChild:@"reg_date"] getValue]];
			[Customer setRegtime:[[t_item getChild:@"reg_time"] getValue]];
			[Customer setUpddate:[[t_item getChild:@"upd_date"] getValue]];
			[Customer setUpdtime:[[t_item getChild:@"upd_time"] getValue]];
			
			[CustomerArr  addObject:Customer];
		}	
		[xmlParser release];
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
}

/*
 Cell 에서 삭제 버튼 눌렀을때 해당 대상 삭제하기
 */

-(IBAction)CellDeleteButton:(id)sender
{
	// page order 
#ifdef LOCALTEST
	// 회사 내부 테스트 용 */
	NSString *url = @"http://192.168.106.203:8010/ws/member.asmx/ws_delCustDelivery";
#else
	// 롯데리아 사이트 테스트 
	NSString *url = @"http://192.168.106.203:8010/ws/member.asmx/ws_delCustDelivery";
#endif
	UIButton *tmpButton	= (UIButton *)sender;
	RemoveNum	= tmpButton.tag;
	CustomerDelivery  *tmp = [CustomerArr objectAtIndex:RemoveNum];
	// HTTP Request 인스턴스 생성

	// POST로 전송할 데이터 설정
	NSDictionary *bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
								tmp.custid ,@"cust_id",
								tmp.seq ,@"seq",
								nil];
	
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didDataDelete:)];
	
	// 페이지 호출
	[httpRequest requestUrl:url bodyObject:bodyObject];
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
	/* cell에서 삭제하는 Button 엑션에 대한 클릭 이벤트 넣기 */
	[tmp_cell.delbutton setTag:indexPath.row];
	[tmp_cell.delbutton addTarget:self action:@selector(CellDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
	
	CustomerDelivery  *tmp = [CustomerArr objectAtIndex:indexPath.row];
	
	NSString *s_tmp	= [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", 
					   [tmp si], [tmp gu], [tmp dong], [tmp bunji], [tmp building], [tmp addrdesc]];
	
	[tmp_cell setInfo:[tmp branchname] :[tmp branchtime] :s_tmp :[tmp phone] ];

	return cell;
}


////////////////////////////////////////////////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 97;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	CustomerDelivery  *Tmp = [CustomerArr objectAtIndex:indexPath.row];
	OrderUserInfo *User = InfoOrder.User;
	[User setBranchid:Tmp.branchid];
	[User setBranchid:Tmp.branchname];
	[User setBranchid:Tmp.branchtime];
	[User setSi:Tmp.si];
	[User setGu:Tmp.gu];
	[User setDong:Tmp.dong];
	[User setBunji:Tmp.bunji];
	[User setBuilding:Tmp.building];
	[User setAddrdesc:Tmp.addrdesc];

	
	CartOrderViewController *Order = [[CartOrderViewController alloc] initWithNibName:@"CartOrderView" bundle:nil];
	Order.InfoOrder = self.InfoOrder;	
	[self.navigationController pushViewController:Order animated:YES];
	 [Order release];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [CustomerArr count];
}


@end
