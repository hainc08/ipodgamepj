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

@implementation MyCustomerDelivery


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	

	self.navigationItem.title = @"마이페이지";
	int timeout=10.0;
	/* URL 알려주면 */
	NSString *url = [NSString stringWithFormat:@"%@/iphone/mypage/order_list.asp?cust_id=%@&order_flag=%d", SERVERURL, [[DataManager getInstance] cust_id], 3 ];
	NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
														  cachePolicy:NSURLRequestReloadIgnoringCacheData 
													  timeoutInterval:timeout];
	

	
	[WebView loadRequest:request];	
    [super viewDidLoad];
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
		[WebView stopLoading];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
		[WebView stopLoading];
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}
#pragma mark - 
#pragma mark WebView 

- (void)webViewDidFinishLoad:(UIWebView *)webView1 { 
}

- (BOOL)webView:(UIWebView *)webview shouldStartLoadWithRequest:(NSURLRequest *)req navigationType:(UIWebViewNavigationType)navigationtype
{
	
	if (navigationtype == UIWebViewNavigationTypeFormSubmitted) 
	{
	}
	return true;
}
@end
