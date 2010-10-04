#import <UIKit/UIKit.h>
#import "SaveView.h"
#import "LoadView.h"
#import "ConfigurationView.h"

@interface GameMenu : UIView {
	IBOutlet id backButton;
	IBOutlet id saveButton;
	IBOutlet id loadButton;
	IBOutlet id configButton;
	IBOutlet id exitButton;

	SaveView* saveView;
	LoadView* loadView;
	ConfigurationView* configView;
}

- (void)reset:(bool)isReplay;
- (IBAction)ButtonClick:(id)sender;

@end
