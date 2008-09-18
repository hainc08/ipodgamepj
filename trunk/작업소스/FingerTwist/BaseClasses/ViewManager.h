#import "BaseView.h"
#define MaxViewCount 10

typedef struct
{
	UIViewController* controller;
	NSString* viewName;
} ViewCon;

@interface ViewManager : NSObject
{
	int viewCount;
	//일단 10개로 제한 해 놓는다.
	//더 많이 필요하지는 않을 듯...
	ViewCon views[MaxViewCount];
	BaseView *curView;
    UIWindow *mainWindow;
	UIViewController* mainController;
}

+ (ViewManager*)getInstance;
+ (void)initManager:(UIWindow*)window:(UIViewController*)controller;
- (void)closeManager;
- (void)changeView:(NSString*)changeViewName param:(NSObject*)param;
- (void)changeView:(NSString*)changeViewName;
- (UIView*)getInstView:(NSString*)viewName;

@end
