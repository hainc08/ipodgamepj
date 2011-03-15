//
//  HelpWebViewController.m
//  lotteria
//
//  Created by embmaster on 11. 3. 6..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HelpWebViewController.h"


@implementation HelpWebViewController

@synthesize URLInfo;
@synthesize TitleName;


- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = TitleName;
	
	NSString *paramStr = [[NSString alloc] initWithFormat: @"CUST_ID=%@&CUST_FLAG=%d",@"seyogo", 3];
	
	int timeout=10.0;
	NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/order/step_01.asp", SERVERURL] ]
														  cachePolicy:NSURLRequestReloadIgnoringCacheData 
													  timeoutInterval:timeout];
	
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:[paramStr dataUsingEncoding:NSUTF8StringEncoding]];
	[paramStr release];
	[Webview loadRequest:request];	
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


#pragma mark - 
#pragma mark WebView 

- (void)webViewDidFinishLoad:(UIWebView *)webView1 { 
}

@end
