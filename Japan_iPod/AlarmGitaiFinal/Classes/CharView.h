#import <UIKit/UIKit.h>

@interface CharUIView : UIView {
	CGImageRef temp;
}

- (void)setTemp:(CGImageRef)img;

@end

@interface CharView : UIViewController {
	CGImageRef temp;
	CGContextRef charContext;
}

- (void)setChar:(NSString*)name idx:(int)idx isNight:(bool)isNight;

@end
