//
//  HalloweenAppDelegate.h
//  Halloween
//
//  Created by Sasin on 12. 3. 31..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HalloweenViewController;

@interface HalloweenAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    HalloweenViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HalloweenViewController *viewController;

@end

