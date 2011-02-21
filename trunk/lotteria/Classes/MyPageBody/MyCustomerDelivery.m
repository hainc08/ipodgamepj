//
//  MyGetCustDelivery.m
//  lotteria
//
//  Created by embmaster on 11. 2. 22..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyCustomerDelivery.h"
#import "HttpRequest.h"
@implementation CustomerDelivery

@synthesize s_cust_id,s_seq ,s_phone ,s_si , s_gu;
@synthesize s_dong,s_bunji ,s_building ,s_addrdesc ,s_branchid;
@synthesize s_regdate, s_regtime, s_upddate, s_updtime;

- (void)dealloc {
    [s_cust_id release];
    [s_seq release];
    [s_phone release];
    [s_si release];
    [s_gu release];
	[s_dong release];
    [s_bunji release];
    [s_building release];
    [s_addrdesc release];
    [s_branchid release];
	[s_regdate release];
    [s_regtime release];
    [s_upddate release];
    [s_updtime release];
	[super dealloc];
}

@end



@implementation MyCustomerDelivery

@synthesize	Customer;
@synthesize ArrCustomer;
@synthesize currentString;

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

	NSString *string = @" <NewDataSet> \
	<item>\
	<SI>서울특별시</SI>\
	<GU>영등포구</GU>\
	<ADONG>신길5동</ADONG>\
	<LDONG>신길동</LDONG>\
	<POI_NM>411-11</POI_NM>\
	<POINT_X>303230.84375</POINT_X>\
	<POINT_Y>544574.0625</POINT_Y>\
	</item>\
	<item>\
	<SI>서울특별시</SI>\
	<GU>영등포구</GU>\
	<ADONG>신길1동</ADONG>\
	<LDONG>신길동</LDONG>\
	<POI_NM>산111-11</POI_NM>\
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
	NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
	self.currentString = [NSMutableString string];
	parser.delegate = self;
	NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
	[parser parse];
	NSTimeInterval duration = [NSDate timeIntervalSinceReferenceDate] - start;
	[parser release];
	
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


#pragma mark -
#pragma mark HttpRequestDelegate

- (void)didReceiveFinished:(NSString *)result
{
	
	// 로그인 성공하면 이뷰는 사라진다. 
	// xml에서 로그인처리 
	
	if(![result compare:@"error"])
	{
		[self ShowOKAlert:@"Login Error" msg:@"로그인에 실패 했습니다."];	
	}
	else {
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
		</NewDataSet>";
		NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
		
		NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
		self.currentString = [NSMutableString string];
		parser.delegate = self;
	    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
		[parser parse];
	    NSTimeInterval duration = [NSDate timeIntervalSinceReferenceDate] - start;
		[parser release];
	}
	
	
}



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

- (void)LastGetCust {
	[ArrCustomer addObject:Customer];
	Customer=nil;
}

#pragma mark NSXMLParser Parsing Callbacks

// Constants for the XML element names that will be considered during the parse. 
// Declaring these as static constants reduces the number of objects created during the run
// and is less prone to programmer error.
static NSString *s_item = @"item";
static NSString *s_cust_id	= @"cust_id";
static NSString *s_seq		= @"seq";
static NSString *s_phone	= @"phone";
static NSString *s_si		= @"si";
static NSString *s_gu		= @"gu";
static NSString *s_dong		= @"dong";
static NSString *s_bunji	= @"bunji";
static NSString *s_building	= @"building";
static NSString *s_addrdesc	= @"addr_desc";
static NSString *s_branchid	= @"branch_id";
static NSString *s_regdate	= @"reg_date";
static NSString *s_regtime	= @"reg_time";
static NSString *s_upddate	= @"upd_date";
static NSString *s_updtime	= @"upd_time";

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:s_item] )
	{
		Customer = nil;
		self.Customer = [[[CustomerDelivery alloc] init] autorelease];
	}
	else {
		
		Characters = YES;
		[currentString  setString:@""];
	}

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:s_item]) {
        [self LastGetCust];
	}
	else if ([elementName isEqualToString:s_cust_id]) {
		self.Customer.s_cust_id =  currentString;
	}
	else if ([elementName isEqualToString:s_seq]) {
		self.Customer.s_seq =  currentString;
	}
	else if ([elementName isEqualToString:s_phone]) {
		self.Customer.s_phone =  currentString;
	}
	else if ([elementName isEqualToString:s_si]) {
		self.Customer.s_si =  currentString;
	}
	else if ([elementName isEqualToString:s_gu]) {
		self.Customer.s_gu =  currentString;
	}	
	else if ([elementName isEqualToString:s_dong]) {
		self.Customer.s_dong =  currentString;
	}
	else if ([elementName isEqualToString:s_bunji]) {
		self.Customer.s_bunji =  currentString;
	}
	else if ([elementName isEqualToString:s_building]) {
		self.Customer.s_building =  currentString;
	}
	else if ([elementName isEqualToString:s_addrdesc]) {
		self.Customer.s_addrdesc =  currentString;
	}
	else if ([elementName isEqualToString:s_branchid]) {
		self.Customer.s_branchid =  currentString;
	}	
	else if ([elementName isEqualToString:s_regdate]) {
		self.Customer.s_regdate =  currentString;
	}
	else if ([elementName isEqualToString:s_regtime]) {
		self.Customer.s_regtime =  currentString;
	}
	else if ([elementName isEqualToString:s_upddate]) {
		self.Customer.s_upddate =  currentString;
	}
	else if ([elementName isEqualToString:s_updtime]) {
		self.Customer.s_updtime =  currentString;
	}
	
	Characters = NO;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (Characters) 
		[currentString appendString:string];
}

/*
 A production application should include robust error handling as part of its parsing implementation.
 The specifics of how errors are handled depends on the application.
 */
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    // Handle errors as appropriate for your application.
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




@end
