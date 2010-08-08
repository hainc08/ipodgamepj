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
#import "SaveManager.h"
#import "DateFormat.h"
#import "AlarmConfig.h"
#import "ImgManager.h"

@implementation AlarmGitaiAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch  
	/* config load */

	[SaveManager initManager];
	[AlarmConfig initmanager];
	
	/* 시간설정 */
	[DateFormat initmanager];
	
	/* image load*/
	[ImgManager initManager];
	
	/* view Controller */ 
	[ViewManager initManager:window:viewController];
	[window addSubview:viewController.view];
    [window makeKeyAndVisible];

   }


- (void)dealloc {
	[[SaveManager getInstance] closeManager];

    [viewController release];
    [window release];
    [super dealloc];
}


@end
