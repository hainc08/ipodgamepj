#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface ConfigurationView : BaseView {
	IBOutlet id backButton;

	IBOutlet id opt1_1;
	IBOutlet id opt1_2;
	IBOutlet id opt1_3;
	IBOutlet id opt1_4;
	IBOutlet id opt1_5;

	IBOutlet id opt2_1;
	IBOutlet id opt2_2;
	IBOutlet id opt2_3;
	IBOutlet id opt2_4;
	IBOutlet id opt2_5;

	IBOutlet id opt1_p;
	IBOutlet id opt1_n;
	IBOutlet id opt2_p;
	IBOutlet id opt2_n;
	
	int opt1;
	int opt2;
}

- (IBAction)ButtonClick:(id)sender;
- (void)setOption;

@end
