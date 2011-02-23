//
//  MyGetCustDelivery.m
//  lotteria
//
//  Created by embmaster on 11. 2. 22..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyCustomerDelivery.h"
#import "UITableViewCellTemplate.h"
#import "HttpRequest.h"
#import "XmlParser.h"
#import "DataList.h"

@implementation MyCustomerDelivery

@synthesize CustomerArr;
@synthesize CustomerTable;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	CustomerArr = [[NSMutableArray alloc] init ];

	
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
	
/*

	NSString *url = @"http://your.webpage.url";
	
	// HTTP Request 인스턴스 생성
	HTTPRequest *httpRequest = [[HTTPRequest alloc] init];
	
	// POST로 전송할 데이터 설정
	NSDictionary *bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
								@"1234",@"cust_id",
								@"12345", @"cust_passwd",
								nil];
	
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
	
	// 페이지 호출
	[httpRequest requestUrl:url bodyObject:bodyObject];
	*/
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
		[CustomerTable reloadData];	
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

	static NSString *CellIdentifier = @"OldOrderCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil)
	{
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier 
													 owner:self options:nil];
		for (id oneObject in nib)
		{
			if ([oneObject isKindOfClass:[OldOrderCell class]])
			{
				cell = oneObject;
				break;
			}
		}
		
	}
	OldOrderCell *tmp_cell = (OldOrderCell *)cell;
	CustomerDelivery  *tmp = [CustomerArr objectAtIndex:indexPath.row];
	[tmp_cell setInfo:[tmp seq] :[tmp regdate ] :[tmp branchid]];
	return cell;
}


////////////////////////////////////////////////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [CustomerArr count];
}


@end
