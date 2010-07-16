//
//  AlarmGitaiAppDelegate.h
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 13.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlarmGitaiViewController;

@interface AlarmGitaiAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AlarmGitaiViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AlarmGitaiViewController *viewController;

@end

