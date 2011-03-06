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
@synthesize Webview;


- (void)viewDidLoad {
    [super viewDidLoad];

	NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLInfo]
														  cachePolicy:NSURLRequestReloadIgnoringCacheData 
													  timeoutInterval:10.0];
	
	
	
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
