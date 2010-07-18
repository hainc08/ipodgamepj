#import <UIKit/UIKit.h>
#import "SaveView.h"
#import "LoadView.h"

@interface GameMenu : UIView {
	IBOutlet id backButton;
	IBOutlet id saveButton;
	IBOutlet id loadButton;
	IBOutlet id exitButton;

	SaveView* saveView;
	LoadView* loadView;
}

- (void)reset:(bool)isReplay;
- (IBAction)ButtonClick:(id)sender;

@end
