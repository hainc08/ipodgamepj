#import "FrameworkAppDelegate.h"
#import "ViewManager.h"
#import "SaveManager.h"
#import "DataManager.h"

@implementation FrameworkAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	srand(time(nil));

	[DataManager initManager];
	[SaveManager initManager];
	[ViewManager initManager:window:viewController];
	[application setStatusBarOrientation: UIInterfaceOrientationLandscapeRight animated:NO];
	
	[[ViewManager getInstance] changeView:@"GameLogoView"];
}


- (void)dealloc {
	[[ViewManager getInstance] closeManager];
	[[SaveManager getInstance] closeManager];
	[[DataManager getInstance] closeManager];
    [window release];
	[super dealloc];
}

@end
