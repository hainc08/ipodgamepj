@class	WaitViewController;

@interface ViewManager : NSObject
{
	UIViewController* cartView;
	UIViewController* mainView;

	int naviImgIdx;
	UIImage* naviBackImg[2];

	UINavigationController* popUpView;
	UIButton* popButton;
	SEL refreshAction;
	UIViewController* popOwner;
	
	WaitViewController *WaitView;
}

@property (retain) UIViewController* cartView;
@property (retain) UIViewController* mainView;
@property (readwrite) int naviImgIdx;
@property (nonatomic, retain) WaitViewController *WaitView;


+ (ViewManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (void)reset;

//-------------------장바구니 처리---------------------
- (void)cartUpdate;

//-------------------네비게이션 바 배경화면 선택---------------------
- (UIImage*)getNaviImg;

//-------------------팝업처리---------------------
- (void)popUp:(UIViewController*)pop button:(UIButton*)button owner:(UIViewController*)owner;
- (void)closePopUp;
#pragma mark blockView
- (void) waitview: (UIView *) view isBlock: (BOOL) isBlock;
@end
