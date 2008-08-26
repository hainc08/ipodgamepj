//
//  FingerTwistAppDelegate.h
//  FingerTwist
//
//  Created by Sasin on 08. 08. 26.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FingerTwistAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UIViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UIViewController *viewController;

@end
