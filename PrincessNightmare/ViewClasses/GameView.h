#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "BaseView.h"
#import "SerihuBoard.h"
#import "SceneView.h"
#import "DataManager.h"
#import "Timer.h"

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
	IBOutlet id msgClose;

	GameParam* gParam;

	SerihuBoard* serihuBoard;
    MPMoviePlayerController *player;

	SceneView* sceneView;
	bool isShowScene;
	
	UIImageView* chrView[4];
	UIImageView* bgView;

	UIImageView* oldChrView[4];
	UIImageView* oldBgView;

	IBOutlet id blackBoard;
	
	IBOutlet id board;

	IBOutlet id next;
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
	
	int nowBgmIdx;
	int gameEnd;
}

@property (nonatomic, retain) MPMoviePlayerController *player;

- (IBAction)playAnime:(NSString*)name;

- (IBAction)ButtonClick:(id)sender;
- (void)showMenu;
- (void)update;

- (void)nowHide;
- (void)willShow:(float)delay;

@end
