#import <UIKit/UIKit.h>

@interface CharView : UIView {
	UIImage* imgBase;
	UIImage* imgFace;

	UIImage* baseImg;
	UIImage* maskImg;
}

- (void)setChar:(NSString*)name idx:(int)idx isNight:(bool)isNight;

@end
