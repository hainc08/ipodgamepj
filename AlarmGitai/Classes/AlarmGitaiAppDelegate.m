#import "AlarmGitaiAppDelegate.h"
#import "AlarmGitaiViewController.h"
#import "ActionManager.h"
#import "SaveManager.h"
#import "DateFormat.h"
#import "AlarmConfig.h"
#import "ImgManager.h"

@implementation AlarmGitaiAppDelegate

@synthesize window;
@synthesize navigationController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    srand(time(NULL));
    // Override point for customization after app launch  
	/* config load */

	[SaveManager initManager];
	[AlarmConfig initmanager];
	
	/* 시간설정 */
	[DateFormat initmanager];
	
	/* image load*/
	[ImgManager initManager];
	[ActionManager initManager];
	[[ActionManager getInstance] setNavigationController:navigationController];
	
	/* view Controller */ 
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}

- (void)dealloc {
	[navigationController release];

	[[ActionManager getInstance] closeManager];
	[[SaveManager getInstance] closeManager];

    [window release];
    [super dealloc];
}


@end
