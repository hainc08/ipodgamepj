//
//  lotteriaAppDelegate.h
//  lotteria
//
//  Created by Sasin on 11. 2. 18..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@class WaitViewController;

@interface lotteriaAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;

- (void)UpdateMoveView:(int)index   viewType:(int)Type;

@end

