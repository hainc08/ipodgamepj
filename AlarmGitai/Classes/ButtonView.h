
#import <UIKit/UIKit.h>

//양 사이드 40  * 70
//개별 버튼 120 * 80 
// 버튼 사이 20 
#define	BUTTON_X	120
#define BUTTON_Y	80
#define LRSIZE		40
#define UDSIZE		70
#define SPACE		20

#define ARRAY		5

@class FontLabel;

@interface ButtonView : UIView  {
//	FontLabel *label;
	UIImageView  *checkimage;
	UILabel *label;
	int		TYPE;
	int		x;
	int		y;
}
- (void)setView:(int)_inTYPE  fontsize:(float)_insize fontColor:(UIColor *)_inColor  setText:(NSString *)_inText bgColor:(UIColor *)_inBgColor chekImage:(bool)_inCheck;
- (void)setText:(NSString *)_inText;
- (void)setCheck:(bool)_inCheck;
@end
