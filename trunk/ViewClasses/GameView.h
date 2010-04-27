#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "DataManager.h"

@interface GameView : BaseView {
	UIImageView* chrView[3];
	
	IBOutlet id next;
	Scene* scene;
	int curSceneId;
	bool showOK;
}

- (IBAction)ButtonClick:(id)sender;

@end
