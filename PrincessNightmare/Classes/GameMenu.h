#import <UIKit/UIKit.h>
#import "SaveView.h"

@interface GameMenu : UIView {
	IBOutlet id backButton;
	IBOutlet id saveButton;
	IBOutlet id exitButton;

	SaveView* saveView;
}

- (void)reset;
- (IBAction)ButtonClick:(id)sender;

@end
