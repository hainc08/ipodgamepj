#import <UIKit/UIKit.h>
#import "CharView.h"

@interface SceneView : UIViewController {
	IBOutlet UIImageView* imgBack1;
	IBOutlet UIImageView* imgBack2;

	CharView* charView[2];
	UIImageView* backView[2];
	
	int curCharIdx, curBackIdx;
	int nextCount;
}

- (void)next;
- (void)reset;
- (void)setOrientation:(bool)isHorizon;

@end
