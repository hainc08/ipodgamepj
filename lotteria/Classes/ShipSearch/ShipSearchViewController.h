//
//  ShipSearchViewController.h
//  lotteria
//
//  Created by embmaster on 11. 2. 24..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@interface ShipSearchViewController : UIViewControllerDownTemplate {
	IBOutlet UIWebView *webview;
}

- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message;
@end
