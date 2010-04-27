#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface GameView : BaseView {
	IBOutlet id next;

	int charCacheIdx[10];
	UIImage* charCache[10];

	bool loadingDone;
}

- (IBAction)ButtonClick:(id)sender;
@end
