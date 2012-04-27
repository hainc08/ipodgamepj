#import <UIKit/UIKit.h>
#import "GameViewController.h"

@interface GameUIController : UIViewController {
	IBOutlet UIImageView* newBox;
	IBOutlet UIImageView* boxGuide;
	IBOutlet UIImageView* alphaBox;
	
	GameViewController* gameView;

	UIViewController* boxGold;
	UIViewController* nowGold;
}

@property (retain) GameViewController* gameView;

- (void)reset;
- (void)update;

@end

@interface GameUIView : UIView {
	CGPoint buttonPos;
	GameUIController* parent;
}

@property (readwrite) CGPoint buttonPos;
@property (retain) GameUIController* parent;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end

