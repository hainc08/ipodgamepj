#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface GraphicView : BaseView {
	IBOutlet id backButton;
	UIButton* imageButton[15];
}

- (IBAction)ButtonClick:(id)sender;
@end
