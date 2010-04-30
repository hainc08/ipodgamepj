#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "DataManager.h"

@interface GameView : BaseView {
	UIImageView* chrView[3];
	UIImageView* bgView;

	UIImageView* oldChrView[3];
	UIImageView* oldBgView;
	
	IBOutlet id next;
	Scene* scene;
	int curSceneId;
	bool showOK;
	
	int showOkTick;
	
	IBOutlet id debugLabel;
	IBOutlet id serihuLabel;
}

- (IBAction)ButtonClick:(id)sender;

@end
