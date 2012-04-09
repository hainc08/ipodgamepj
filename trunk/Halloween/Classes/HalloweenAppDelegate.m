//
//  HalloweenAppDelegate.m
//  Halloween
//
//  Created by Sasin on 12. 3. 31..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HalloweenAppDelegate.h"
#import "HalloweenViewController.h"

#import "ErrorManager.h"
#import "SoundManager.h"
#import "TexManager.h"
#import "SaveManager.h"
#import "PointManager.h"
#import "StageManager.h"
#import "HighScoreManager.h"
#import "ViewManager.h"
#import "GOManager.h"

#import "DefaultInfo.h"

@implementation HalloweenAppDelegate

@synthesize window;
@synthesize viewController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	srand((unsigned) time(NULL));
	
	halfForm = CGAffineTransformMake(0.5, 0, 0, 0.5, 0, 0);
	halfForm_flip = CGAffineTransformMake(-0.5, 0, 0, 0.5, 0, 0);
	MakePoint[0] = CGPointMake(50, 280);
	MakePoint[1] = CGPointMake(50, 100);
	CandyPoint = CGPointMake(440, 270);
    BoxPoint =  CGPointMake(380, 280);
	GroundHeight = 310;

	[ErrorManager initManager];
	[SoundManager initManager];
	[TexManager initManager];
	[SaveManager initManager];
	[AchieveManager initManager];
	[PointManager initManager];
	[StageManager initManager];
	[HighScoreManager initManager];
	[GOManager initManager];
    [DefaultManager initManager];
	
	[application setStatusBarOrientation: UIInterfaceOrientationLandscapeRight animated:NO];
	
	[ViewManager initManager:self.window];
	[[ViewManager getInstance] changeView:viewController :NULL];
	
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	
	[[ViewManager getInstance] closeManager];
	[[GOManager getInstance] closeManager];
	[[HighScoreManager getInstance] closeManager];
	[[StageManager getInstance] closeManager];
	[[PointManager getInstance] closeManager];
	[[AchieveManager getInstance] closeManager];
	[[SaveManager getInstance] closeManager];
	[[TexManager getInstance] closeManager];
	[[SoundManager getInstance] closeManager];
	[[ErrorManager getInstance] closeManager];
	[[DefaultManager getInstance] closeManager];
	[viewController release];
    [window release];
    [super dealloc];
}


@end
