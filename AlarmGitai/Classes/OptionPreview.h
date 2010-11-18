#import <UIKit/UIKit.h>

@interface OptionPreview : UIViewController{
	bool isHorizon;
	
	IBOutlet id back_h;
	IBOutlet id back_v;
	IBOutlet id charView;
	IBOutlet id timeView;
	IBOutlet id dateView;
	IBOutlet id weekView;
}

- (void)SetHV:(bool)horizon;
- (void)refresh;

@end
