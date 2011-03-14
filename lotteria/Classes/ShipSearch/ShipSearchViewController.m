//
//  ShipSearchViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 24..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShipSearchViewController.h"

@implementation ShipSearchViewController


- (void)viewDidLoad {
	closetype = true;
	naviImgIdx = 0;
	self.navigationItem.title = @"배송지등록";
	NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://m.naver.com"]
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
	/* 무슨처리 해야되나? */
}

@end
