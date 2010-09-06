#import <UIKit/UIKit.h>
#import "CharView.h"

@interface SceneView : UIView {
	IBOutlet UIImageView* imgBack1;
	IBOutlet UIImageView* imgBack2;

	CharView* charView[2];
	UIImageView* backView[2];
	NSString* charName;
	
	int curCharIdx, curBackIdx;
	int nextCount;
}

- (void)setChar:(NSString*)name;
- (void)next;
- (void)reset;

@end
