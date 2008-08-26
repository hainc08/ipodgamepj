//
//  FingerTwistAppDelegate.m
//  FingerTwist
//
//  Created by Sasin on 08. 08. 26.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "FingerTwistAppDelegate.h"
#import "TeamLogoView.h"
#import "ViewManager.h"

@implementation FingerTwistAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[ViewManager initManager:window:viewController];
	[[ViewManager getInstance] changeView:@"TeamLogoView"];
}

- (void)dealloc {
	[[ViewManager getInstance] closeManager];
    [window release];
	[super dealloc];
}

@end
