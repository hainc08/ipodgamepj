#import "FrameworkAppDelegate.h"
#import "ViewManager.h"
#import "SaveManager.h"
#import "SoundManager.h"
#import "DataManager.h"

@implementation FrameworkAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	srand(time(nil));

	[DataManager initManager];

	bgLoaderThread = [[NSThread alloc] initWithTarget:self selector:@selector(loadProc:) object:@""];
	[bgLoaderThread start];
	
	[SoundManager initManager];
	
	[SaveManager initManager];
	[ViewManager initManager:window:viewController];
	[application setStatusBarOrientation: UIInterfaceOrientationLandscapeRight animated:NO];
	
	[[ViewManager getInstance] changeView:@"GameLogoView"];
}

- (void)loadProc:(id)args
{
	[[DataManager getInstance] parseData];
	[[DataManager getInstance] preload];
}

- (void)dealloc {
	[[ViewManager getInstance] closeManager];
	[[SaveManager getInstance] closeManager];
	[[SoundManager getInstance] closeManager];
	[[DataManager getInstance] closeManager];
    [window release];
	[super dealloc];
}

@end
