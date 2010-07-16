#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface ExtraView : BaseView {
	IBOutlet id musicButton;
	IBOutlet id graphicButton;
	IBOutlet id scineButton;
	IBOutlet id itemButton;
	IBOutlet id backButton;
}

- (IBAction)ButtonClick:(id)sender;
@end
