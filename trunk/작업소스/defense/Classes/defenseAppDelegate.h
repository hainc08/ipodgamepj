//
//  defenseAppDelegate.h
//  defense
//
//  Created by Sasin on 08. 09. 24.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class defenseViewController;

@interface defenseAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet defenseViewController *viewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) defenseViewController *viewController;

@end

