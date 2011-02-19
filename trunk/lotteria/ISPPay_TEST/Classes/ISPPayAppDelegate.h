//
//  ISPPayAppDelegate.h
//  ISPPay
//
//  Created by embmaster on 11. 2. 19..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ISPPayViewController;

@interface ISPPayAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ISPPayViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ISPPayViewController *viewController;

@end

