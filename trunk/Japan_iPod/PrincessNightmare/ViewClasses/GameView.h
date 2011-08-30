#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "SerihuBoard.h"
#import "SceneView.h"
#import "DataManager.h"
#import "Timer.h"
#import "MovieBoard.h"

@interface GameParam : NSObject {
	int startScene;
	int endScene;
	bool isReplay;
	int replayIdx;
	int qsave;
}

@property (readwrite) int startScene;
@property (readwrite) int endScene;
@property (readwrite) bool isReplay;
@property (readwrite) int replayIdx;
@property (readwrite) int qsave;

@end

@interface GameView : BaseView {
	enum GamePhase{
		LOAD = 0,
		BEFORE = 1,
		PLAY = 2,
		PLAYWAIT = 3,
		WAITINPUT = 4,
		TIMERWAIT = 5,
		AFTER = 6,
	};

	IBOutlet id msgClose;
	IBOutlet id skip;

	IBOutlet id buttonView;

	IBOutlet UIButton* prev;
	IBOutlet UIButton* prev2;
	IBOutlet UIButton* play;
	IBOutlet UIButton* play2;
	
	IBOutlet UIImageView* prev_dis;
	IBOutlet UIImageView* prev2_dis;
	IBOutlet UIImageView* play_dis;
	IBOutlet UIImageView* play2_dis;
	
	IBOutlet UIButton* autoButton;
	IBOutlet UIButton* qsave;
	IBOutlet UILabel* qsaveIdx;
	IBOutlet UILabel* saved;

	GameParam* gParam;

	SerihuBoard* serihuBoard;
	SerihuBoard* serihuBoard2;

	SceneView* sceneView;
	
	UIImageView* chrView[4];
	UIImageView* bgView;
	
	UIImage* originChr[4];
	UIImage* originBg;
	
	UIImageView* oldChrView[4];
	UIImageView* oldBgView;

	NSData* chrData[4];
	NSData* bgData;

	NSData* oldChrData[4];

	IBOutlet id blackBoard;
	
	IBOutlet id board;

	IBOutlet id next;

	IBOutlet id movieUI;
	IBOutlet id next2;

	Scene* scene;
	int curSceneId;
	bool showOK;
	
	int showOkTick;
	int updateWait;
	
	IBOutlet id menuButton;
	IBOutlet id debugLabel;

	IBOutlet id selectLabel1;
	IBOutlet id selectLabel2;
	IBOutlet id selectLabel3;

	IBOutlet id selectPanel1;
	IBOutlet id selectPanel2;
	IBOutlet id selectPanel3;

	IBOutlet id selectButton1;
	IBOutlet id selectButton2;
	IBOutlet id selectButton3;

	UIView* gameMenu;
	Timer* timer;
	
	int phase;
	bool isSkipMode;
	bool isAutoMode;
	float autoFrame;
	int skipEnd;

	MovieBoard* movieBoard;
	CGPoint menuButtonOrigin;
	
	bool isRecollNow;
}

- (IBAction)SkipButtonClick:(id)sender;
- (IBAction)AutoButtonClick:(id)sender;
- (IBAction)QSaveButtonClick:(id)sender;
- (IBAction)ButtonClick:(id)sender;
- (IBAction)RecollButton:(id)sender;
- (void)showMenu;
- (void)update;
- (void)refresh;

- (void)qSaveButtonShow:(bool)isShow;
- (void)buttonViewShow:(bool)isShow;

- (void)showChr:(float)delay;
- (void)hideChr:(float)delay;

- (void)showChar:(Scene*)s idx:(int)i;
- (void)showBg:(Scene*)s;

- (void)playBGM:(Scene*)s;
- (void)playFx:(Scene*)s;
- (bool)checkEnd:(Scene*)s;

- (void)playScene:(Scene*)s;
- (void)hideScene;

- (void)clearView;

- (void)setRecollMode:(bool)isRecoll;
- (UIImage*)getSepiaImage:(UIImage*)pImage;
@end
