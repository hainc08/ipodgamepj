#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface MainMenuView : BaseView {
    IBOutlet id NewGame;
    IBOutlet id ContinueGame;
    IBOutlet id HighScoreButton;
    IBOutlet id CreaditButton;
}

- (IBAction)ButtonClick:(id)sender;

@end
