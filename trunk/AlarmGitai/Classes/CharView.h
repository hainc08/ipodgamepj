#import <UIKit/UIKit.h>

@interface CharView : UIView {
	UIImage* imgBack;

	UIImage* imgBase;
	UIImage* imgFace;
}

- (void)setChar:(NSString*)name idx:(int)idx isNight:(bool)isNight;
- (void)setBackGround:(int)idx isNight:(bool)isNight;

@end
