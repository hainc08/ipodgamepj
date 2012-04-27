#import <UIKit/UIKit.h>

@interface NumPanel : UIViewController {
	IBOutlet UIImageView* iconImg;
	IBOutlet UIImageView* number1;
	IBOutlet UIImageView* number2;
	IBOutlet UIImageView* number3;
	IBOutlet UIImageView* number4;
	IBOutlet UIImageView* number5;
	IBOutlet UIImageView* number6;
	
	bool fillZero;
	int len;
	
	int number;
}

@property (readwrite) bool fillZero;
@property (readwrite) int len;

- (id)initWithIcon:(int)idx;
- (void)setNumber:(int)n;
- (void)setPart:(int)i :(int)n;

@end

