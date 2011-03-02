//
//  MapSearchViewController.m
//  lotteria
//
//  Created by embmaster on 11. 3. 2..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapSearchViewController.h"
#import "UITableViewCellTemplate.h"
#import "MapSearchDetailViewController.h"
#import "HttpRequest.h"
#import "XmlParser.h"

@implementation MapSearchViewController



- (void)viewDidLoad {
    [super viewDidLoad];
	httpRequest = [[HTTPRequest alloc] init];
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
    [super dealloc];
}

- (IBAction)MapButton
{
	[self.navigationController popViewControllerAnimated:YES];
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
			
			[AddressArr  addObject:Customer];
		}	
		[xmlParser release];

		[SearchTable reloadData];	
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
		
	}
	
	ShippingCell *tmp_cell = (ShippingCell *)cell;
	Order *Data = [[DataManager getInstance] UserOrder];
	
	NSString *s_tmp	= [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", 
					   [Data.UserAddr si], [Data.UserAddr gu], [Data.UserAddr dong], [Data.UserAddr bunji],
					   [Data.UserAddr building], [Data.UserAddr addrdesc]];
	
	[tmp_cell setDelButtonEnable:false];
	[tmp_cell setInfo:[Data branchname] :s_tmp :[Data branchPhone] ];
	
	return cell;
}


////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	 MapSearchDetailViewController *SearchControl = [[MapSearchDetailViewController alloc] initWithNibName:@"MapSearchDetailView" bundle:nil];
	[self.navigationController pushViewController:SearchControl animated:YES];
	[SearchControl release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 97;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

@end
