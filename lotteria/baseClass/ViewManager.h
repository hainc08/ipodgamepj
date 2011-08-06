@class	WaitViewController;
@class	OnlinePayViewController;

@interface ViewManager : NSObject
{
	UIViewController* cartView;
	UIViewController* mainView;

	int naviImgIdx;
	UIImage* naviBackImg[2];

	UINavigationController* popUpView;
	SEL refreshAction;
	UIViewController* popOwner;
	UIButton* helpButton;
	
	WaitViewController *WaitView;
	OnlinePayViewController *onlinePayView;
}

@property (retain) UIViewController* cartView;
@property (retain) UIViewController* mainView;
@property (readwrite) int naviImgIdx;
@property (nonatomic, retain) WaitViewController *WaitView;
@property (nonatomic, retain) UIButton* helpButton;

+ (ViewManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (void)reset;

//-------------------장바구니 처리---------------------
- (void)cartUpdate;

//-------------------네비게이션 바 배경화면 선택---------------------
- (UIImage*)getNaviImg;

//-------------------팝업처리---------------------
- (void)popUp:(UIViewController*)pop owner:(UIViewController*)owner;
- (void)closePopUp;
#pragma mark blockView
- (void) waitview: (UIView *) view isBlock: (BOOL) isBlock;
- (void) showOnlinePayView:(NSString *)url bodyArray:(NSMutableArray *)bodyarr;
@end
