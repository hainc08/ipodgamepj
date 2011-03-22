//
//  HelpWebViewController.h
//  lotteria
//
//  Created by embmaster on 11. 3. 6..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@interface HelpWebViewController : UIViewControllerTemplate {
	NSString *URLInfo;
	NSString *TitleName;
	IBOutlet UIWebView *Webview; 
}

@property (nonatomic , retain) NSString *URLInfo;
@property (nonatomic , retain) NSString *TitleName;
@end