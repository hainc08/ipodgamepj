#import <UIKit/UIKit.h>

@interface CharView : UIView {
	UIImage* imgBase;
	UIImage* imgFace;
}

- (void)setChar:(NSString*)name idx:(int)idx isNight:(bool)isNight;

@end
