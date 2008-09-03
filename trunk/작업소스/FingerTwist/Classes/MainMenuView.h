#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface MainMenuView : BaseView {
    IBOutlet id Game1PButton;
    IBOutlet id Game2PButton;
    IBOutlet id HighScoreButton;
    IBOutlet id CreaditButton;
}

- (IBAction)ButtonClick:(id)sender;

@end
