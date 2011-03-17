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

- (void)webViewDidFinishLoad:(UIWebView *)webView1 { 

}
- (BOOL)webView:(UIWebView *)webview shouldStartLoadWithRequest:(NSURLRequest *)req navigationType:(UIWebViewNavigationType)navigationtype
{
	
	if([[[req URL] absoluteString] isEqualToString:@"about:blank"]){
		NSLog(@"webview close");
		
		[[ViewManager getInstance] closePopUp];	
		return NO;
	}
	return true;
}
@end
