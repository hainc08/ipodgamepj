#import <UIKit/UIKit.h>
#import "SaveView.h"
#import "LoadView.h"
#import "ConfigurationView.h"

enum _MenuType {
	GAMEMENU = 0 ,
	SCINEMENU ,
};
@interface GameMenu : UIView {
	IBOutlet id backButton;
	IBOutlet id saveButton;
	IBOutlet id loadButton;
	IBOutlet id configButton;
	IBOutlet id exitButton;

	IBOutlet id yesButton;
	IBOutlet id noButton;

	IBOutlet id menuView;
	IBOutlet id exitView;

	SaveView* saveView;
	LoadView* loadView;
	ConfigurationView* configView;
	
	int		MenuType;
}

- (void)reset:(bool)isReplay;
- (IBAction)ButtonClick:(id)sender;

@end
