#import "defenseAppDelegate.h"
#import "TeamLogoView.h"
#import "ViewManager.h"
#import "HighScoreManager.h"
#import "UnitTexManager.h"

@implementation defenseAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	[ViewManager initManager:window:viewController];
	[HighScoreManager initManager];
	[UnitTexManager initManager];
	
	[[ViewManager getInstance] changeView:@"TeamLogoView"];
}


- (void)dealloc {
	[[UnitTexManager getInstance] closeManager];
	[[ViewManager getInstance] closeManager];
	[[HighScoreManager getInstance] closeManager];
    [window release];
	[super dealloc];
}


@end
