//
//  AlarmGitaiAppDelegate.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 13.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AlarmGitaiAppDelegate.h"
#import "AlarmGitaiViewController.h"
#import "ViewManager.h"
#import "DateFormat.h"
#import "AlarmConfig.h"
#import "ImgManager.h"

@implementation AlarmGitaiAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch   
	[DateFormat initmanager];
	[AlarmConfig initmanager];
	
	[ImgManager initManager];
	[ViewManager initManager:window:viewController];
//	[[ViewManager getInstance] changeView:@"MainAlarm"];
   [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
