//
//  HelpWebViewController.h
//  lotteria
//
//  Created by embmaster on 11. 3. 6..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HelpWebViewController : UIViewController {
	NSString *URLInfo;
	UIWebView *Webview; 
}

@property (nonatomic , retain) NSString *URLInfo;
@property (nonatomic , retain) UIWebView *Webview;
@end
