#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "SceneView.h"
#import "DataManager.h"

@interface GameParam : NSObject {
	int startScene;
}

@property (readwrite) int startScene;

@end

@interface GameView : BaseView {
	SceneView* sceneView;
	bool isShowScene;
	
	UIImageView* chrView[4];
	UIImageView* bgView;

	UIImageView* oldChrView[4];
	UIImageView* oldBgView;

	IBOutlet id blackBoard;
	
	IBOutlet id board;
	IBOutlet id nameBoard;

	IBOutlet id next;
	Scene* scene;
	int curSceneId;
	bool showOK;
	
	int showOkTick;
	
	IBOutlet id menuButton;
	IBOutlet id debugLabel;

	IBOutlet id serihuLabel;
	IBOutlet id serihuLabel2;
	IBOutlet id serihuLabel3;

	IBOutlet id charaLabel;
	IBOutlet id charaLabel2;
	IBOutlet id charaLabel3;

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
	
	int nowBgmIdx;
}

- (IBAction)ButtonClick:(id)sender;
- (void)showMenu;
- (void)update;

- (void)nowHide;
- (void)willShow:(float)delay;

@end
