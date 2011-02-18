#import <UIKit/UIKit.h>

@interface NewWeekView : UIViewController {
	IBOutlet UIImageView* imgSun;
	IBOutlet UIImageView* imgMon;
	IBOutlet UIImageView* imgTue;
	IBOutlet UIImageView* imgWed;
	IBOutlet UIImageView* imgThe;
	IBOutlet UIImageView* imgFri;
	IBOutlet UIImageView* imgSat;
	
	UIImage* weekImg[7][2];

	NSString* Week;
}

- (void)reset;
- (void)refresh;

@end
