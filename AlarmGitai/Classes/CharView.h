#import <UIKit/UIKit.h>

@interface CharView : UIView {
	CGImageRef temp;
	CGContextRef charContext;
}

- (void)setChar:(NSString*)name idx:(int)idx isNight:(bool)isNight;

@end
