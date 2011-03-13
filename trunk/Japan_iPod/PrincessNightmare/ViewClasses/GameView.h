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
}

@property (readwrite) int startScene;
@property (readwrite) int endScene;
@property (readwrite) bool isReplay;
@property (readwrite) int replayIdx;

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

	GameParam* gParam;

	SerihuBoard* serihuBoard;
	SerihuBoard* serihuBoard2;

	SceneView* sceneView;
	
	UIImageView* chrView[4];
	UIImageView* bgView;
	
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
	int skipEnd;
	
	MovieBoard* movieBoard;
}

- (IBAction)SkipButtonClick:(id)sender;
- (IBAction)ButtonClick:(id)sender;
- (void)showMenu;
- (void)update;

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

@end
