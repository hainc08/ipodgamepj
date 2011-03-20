//
//  ShipSearchViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 24..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShipSearchViewController.h"
#import "DataManager.h"

@implementation ShipSearchViewController


- (void)viewDidLoad {
	closetype = true;
	naviImgIdx = 0;
	self.navigationItem.title = @"배송지등록";
	NSString *url = [NSString stringWithFormat:@"%@/iphone/order/step_01.asp?cust_id=%@&cust_flag=%d", SERVERURL, @"seyogo", 3 ];
	NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] 
										cachePolicy:NSURLRequestReloadIgnoringCacheData 
													  timeoutInterval:10.0];
	[webview loadRequest:request];	
	[super viewDidLoad];	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	[webview stopLoading];
	webview.delegate = nil;
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}


#pragma mark - 
#pragma mark WebView 

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	
	NSRange rangeRound = [[[webView.request URL] absoluteString] rangeOfString:@"RESULT.asp"];
	
	if (rangeRound.length) {
		
		NSString *authToken = [[webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('token').innerHTML"]
							   stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
		NSLog(@"authToken: %@", authToken);
		
	}
}
- (BOOL)webView:(UIWebView *)webview shouldStartLoadWithRequest:(NSURLRequest *)req navigationType:(UIWebViewNavigationType)navigationtype
{
	
	if (navigationtype == UIWebViewNavigationTypeLinkClicked) 
	{
	if([[[req URL] absoluteString] isEqualToString:@"RESULT.asp"]){
		NSLog(@"webview close");
		
		[[ViewManager getInstance] closePopUp];	
		return NO;
	}
	}
	return true;
}
@end
