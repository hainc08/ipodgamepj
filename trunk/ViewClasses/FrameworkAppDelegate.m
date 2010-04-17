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

	bgLoaderThread = [[NSThread alloc] initWithTarget:self selector:@selector(loadProc:) object:@""];
	[bgLoaderThread start];
	
	[SaveManager initManager];
	[ViewManager initManager:window:viewController];
	[application setStatusBarOrientation: UIInterfaceOrientationLandscapeRight animated:NO];
	
	[[ViewManager getInstance] changeView:@"GameLogoView"];
}

- (void)loadProc:(id)args
{
	[[DataManager getInstance] parseData];
	[NSThread exit];
}

- (void)dealloc {
	[[ViewManager getInstance] closeManager];
	[[SaveManager getInstance] closeManager];
	[[DataManager getInstance] closeManager];
    [window release];
	[super dealloc];
}

@end
