#import "FrameworkAppDelegate.h"
#import "ViewManager.h"
#import "SaveManager.h"
#import "SoundManager.h"
#import "DataManager.h"
#import "ErrorManager.h"

@implementation FrameworkAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	srand(time(nil));

#ifdef __DEBUGGING__
	[ErrorManager initManager];
#endif

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

#ifdef __DEBUGGING__
	[[ErrorManager getInstance] closeManager];
#endif
	
	[bgLoaderThread cancel];
	[bgLoaderThread release];
	bgLoaderThread = nil;

    [window release];
	[super dealloc];
}

@end
