#import <UIKit/UIKit.h>

@interface LoadSaveBar : UIView {
	int saveIdx;
	int bgImgIdx;
	
	IBOutlet id dateLabel;
	IBOutlet UIButton* sceneImg;
	IBOutlet UIButton* bar;
}

@property (readonly) int saveIdx;

-(void)setSaveIdx:(int)idx;
-(void)setSaveDate:(NSDate*)date;
-(UIButton*)getButton:(int)idx;

@end
