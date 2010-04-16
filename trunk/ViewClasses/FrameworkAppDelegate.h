#import <UIKit/UIKit.h>

@class FrameworkViewController;

@interface FrameworkAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet FrameworkViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FrameworkViewController *viewController;

@end

