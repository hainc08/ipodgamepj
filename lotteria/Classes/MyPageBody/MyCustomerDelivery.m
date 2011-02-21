//
//  MyGetCustDelivery.m
//  lotteria
//
//  Created by embmaster on 11. 2. 22..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyGetCustDelivery.h"


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



@implementation MyGetCustDelivery

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	if (Characters) [currentString appendString:string];
}

/*
 A production application should include robust error handling as part of its parsing implementation.
 The specifics of how errors are handled depends on the application.
 */
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    // Handle errors as appropriate for your application.
}

@end
