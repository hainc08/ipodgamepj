#import <UIKit/UIKit.h>
#import "BaseView.h"

@class HighScoreBoard;

@interface HighScoreView : BaseView {
	HighScoreBoard *highScoreBoard[10];
    IBOutlet id ResetPButton;
    IBOutlet id MainMenuButton;
}

- (IBAction)ButtonClick:(id)sender;
- (void)setUpHighScoreBoard;

@end
