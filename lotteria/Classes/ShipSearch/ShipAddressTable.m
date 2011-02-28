//
//  ShipAddressTable.m
//  lotteria
//
//  Created by embmaster on 11. 2. 25..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShipAddressTable.h"
#import "HttpRequest.h"
#import "XmlParser.h"
#import "ShipStreetBuilding.h"
@implementation ShipAddressTable
@synthesize ShipType;
@synthesize ShipTable;
@synthesize ShipAddressArr;
@synthesize dong;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	[super viewDidLoad];	
	
	ShipAddressArr = [[NSMutableArray alloc] init ];
	
	NSString *result;
	if(ShipType)
	{
		result= @"<NewDataSet>\
		<item>\
		<si>서울특별시</si>\
		<gu>영등포구</gu>\
		<adong>신길5동</adong>\
		<ldong>신길동</ldong>\
		<poi_nm>411-11</poi_nm>\
		<POINT_X>303230.84375</POINT_X>\
		<POINT_Y>544574.0625</POINT_Y>\
		</item>\
		<item>\
		<si>경기도</si>\
		<gu>팔달구</gu>\
		<adong>어드레스</adong>\
		<ldong>신길동</ldong>\
		<poi_nm>411-11</poi_nm>\
		<POINT_X>304303.4375</POINT_X>\
		<POINT_Y>545587.25</POINT_Y>\
		</item>\
		<item>\
		<SI>서울특별시</SI>\
		<GU>영등포구</GU>\
		<ADONG>신길1동</ADONG>\
		<LDONG>신길동</LDONG>\
		<POI_NM>111-11</POI_NM>\
		<POINT_X>304584.75</POINT_X>\
		<POINT_Y>546160.5</POINT_Y>\
		</item>\
		</NewDataSet>";
	}
	else {
		
		result= @ "<NewDataSet>\
		<item>\
		<si>서울특별시</si>\
		<gu>영등포구</gu>\
		<dong>신길동</dong>\
		<DONG_X>304135.85</DONG_X>\
		<DONG_Y>545416.1</DONG_Y>\
		</item>\
		<item>\
		<si>경기도</si>\
		<gu>팔달구</gu>\
		<dong>신길동</dong>\
		<DONG_X>291008.9</DONG_X>\
		<DONG_Y>526149.65</DONG_Y>\
		</item>\
		</NewDataSet>"
		;
	}
#if 0 


	XmlParser* xmlParser = [XmlParser alloc];
	[xmlParser parserString:result];
	
	Element* root = [xmlParser getRoot:@"NewDataSet"];
	
	for(Element* t_item = [root getFirstChild] ; nil != t_item   ; t_item = [root getNextChild] )
	{
		
		OrderUserInfo *ShipInfo  = [[OrderUserInfo alloc] init];
		
	
		if(ShipType)
		{	[ShipInfo setSi:[[t_item getChild:@"si"] getValue]];
			[ShipInfo setGu:[[t_item getChild:@"gu"] getValue]];
			[ShipInfo setAdong:[[t_item getChild:@"adong"] getValue]];
			[ShipInfo setLdong:[[t_item getChild:@"ldong"] getValue]];
			[ShipInfo setBunji:[[t_item getChild:@"poi_nm"] getValue]];
		}
		else {
			[ShipInfo setSi:[[t_item getChild:@"si"] getValue]];
			[ShipInfo setGu:[[t_item getChild:@"gu"] getValue]];
			[ShipInfo setDong:[[t_item getChild:@"dong"] getValue]];
		}

		
		[ShipAddressArr  addObject:ShipInfo];
		[ShipInfo release];
	}
	
	[xmlParser release];
	[ShipTable reloadData];	
#endif

/*
	NSString *url;
	// POST로 전송할 데이터 설정
	NSDictionary *bodyObject;

	// HTTP Request 인스턴스 생성
	HTTPRequest *httpRequest = [[HTTPRequest alloc] init];
	
		// 접속할 주소 설정
	if(ShipType)
	{
		url = @"http://www.naver.com";	
		bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
									[Info si] ,@"si",
									[Info gu], @"gu",
									[Info dong], @"dong",
									[Info bunji], @"bunji",
									nil];
		
	}
	else 
	{
		url = @"http://www.naver.com";
		bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
					  dong,@"dong",
					  nil];
	}

	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
	
	// 페이지 호출
	[httpRequest requestUrl:url bodyObject:bodyObject];
 */
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
- (IBAction)BackButton:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
#if 0 
#pragma mark -
#pragma mark HttpRequestDelegate

/*
 동검색 
 "<NewDataSet>
 <item>
 <SI>서울특별시</SI>
 <GU>영등포구</GU>
 <DONG>신길동</DONG>
 <DONG_X>304135.85</DONG_X>
 <DONG_Y>545416.1</DONG_Y>
 </item>
 <item>
 <SI>경기도</SI>
 <GU>안산시단원구</GU>
 <DONG>신길동</DONG>
 <DONG_X>291008.9</DONG_X>
 <DONG_Y>526149.65</DONG_Y>
 </item>
 </NewDataSet>"
 
 
 // 번지 검색
 
 "<NewDataSet>
 <item>
 <SI>서울특별시</SI>
 <GU>영등포구</GU>
 <ADONG>신길5동</ADONG>
 <LDONG>신길동</LDONG>
 <POI_NM>411-11</POI_NM>
 <POINT_X>303230.84375</POINT_X>
 <POINT_Y>544574.0625</POINT_Y>
 </item>
 <item>
 <SI>서울특별시</SI>
 <GU>영등포구</GU>
 <ADONG>신길1동</ADONG>
 <LDONG>신길동</LDONG>
 <POI_NM>산111-11</POI_NM>
 <POINT_X>304303.4375</POINT_X>
 <POINT_Y>545587.25</POINT_Y>
 </item>
 <item>
 <SI>서울특별시</SI>
 <GU>영등포구</GU>
 <ADONG>신길1동</ADONG>
 <LDONG>신길동</LDONG>
 <POI_NM>111-11</POI_NM>
 <POINT_X>304584.75</POINT_X>
 <POINT_Y>546160.5</POINT_Y>
 </item>
 </NewDataSet>"
 
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
			
			OrderUserInfo *ShipInfo  = [[[OrderUserInfo alloc] init] retain];
			

			if(ShipType)
			{
				[ShipInfo setSi:[[t_item getChild:@"si"] getValue]];
				[ShipInfo setGu:[[t_item getChild:@"gu"] getValue]];
				[ShipInfo setAdong:[[t_item getChild:@"adong"] getValue]];
				[ShipInfo setDong:[[t_item getChild:@"ldong"] getValue]];
				[ShipInfo setBunji:[[t_item getChild:@"poi_nm"] getValue]];
			}
			else {
				[ShipInfo setSi:[[t_item getChild:@"si"] getValue]];
				[ShipInfo setGu:[[t_item getChild:@"gu"] getValue]];
				[ShipInfo setDong:[[t_item getChild:@"dong"] getValue]];
			}

			
			[ShipAddressArr  addObject:ShipInfo];
		}
		
		[xmlParser release];
		[ShipTable reloadData];	
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
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
	}
	
	OrderUserInfo  *tmp = [ShipAddressArr objectAtIndex:indexPath.row];
	
	NSString *s_tmp	;
	if(ShipType)
	{
	s_tmp	= [NSString stringWithFormat:@"%@ %@ %@ %@ %@", 
					   [tmp si], [tmp gu], [tmp adong], [tmp ldong], [tmp bunji]];
	}
	else {
		s_tmp	= [NSString stringWithFormat:@"%@ %@ %@", 
				   [tmp si], [tmp gu], [tmp dong]];
	}

	[ cell setText: s_tmp];
	
	return cell;
}


////////////////////////////////////////////////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	ShipStreetBuilding *street = [[ShipStreetBuilding alloc] initWithNibName:@"ShipStreetBuilding" bundle:nil];
	[self.navigationController pushViewController:street animated:YES];
	[street release];
	
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [ShipAddressArr count];
}
#endif
@end
