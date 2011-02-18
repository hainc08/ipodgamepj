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
	
	int movieMode;
}

@property (readwrite) int movieMode;

+ (ViewManager*)getInstance;
+ (void)initManager:(UIWindow*)window:(UIViewController*)controller;
- (void)closeManager;
- (void)changeView:(NSString*)changeViewName param:(NSObject*)param;
- (void)changeView:(NSString*)changeViewName;
- (UIView*)getInstView:(NSString*)viewName;
- (BaseView*)getCurView;

//게임 리소스를 위한 공간 확보를 위해 뷰를 바꾸기 전에 모든 뷰를 초기화한다.
- (void)changeViewWithInit:(NSString*)changeViewName param:(NSObject*)param;
- (void)changeViewWithInit:(NSString*)changeViewName;

@end
