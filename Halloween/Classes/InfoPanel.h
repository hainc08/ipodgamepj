#import <UIKit/UIKit.h>

@interface InfoPanel : UIViewController {
	IBOutlet UIImageView* s_1;
	IBOutlet UIImageView* s_2;

	IBOutlet UIImageView* g_1;
	IBOutlet UIImageView* g_2;
	IBOutlet UIImageView* g_3;
	IBOutlet UIImageView* g_4;
	IBOutlet UIImageView* g_5;
	IBOutlet UIImageView* g_6;
	
	IBOutlet UIImageView* l_1;
	IBOutlet UIImageView* l_2;
	IBOutlet UIImageView* l_3;
	IBOutlet UIImageView* l_4;
	
	UIImage* numImg[10];
	
	int stageNum;
	int goldNum;
	int leftNum;
	int allNum;
}

- (void)setStage:(int)s;
- (void)setGold:(int)g;
- (void)setLeft:(int)lg :(int)ag;

- (void)setGoldNum:(int)i :(int)num;

@end

