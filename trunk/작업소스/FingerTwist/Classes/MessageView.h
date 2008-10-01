#import <UIKit/UIKit.h>

@interface MessageView : UIView {
	NSString *msgCache;
	
    IBOutlet id GameOver;
    IBOutlet id StageClear;
    IBOutlet id Undefined;
    IBOutlet id Ready;
    IBOutlet id Start;
    IBOutlet id TouchNext;
    IBOutlet id StageInfo;

    IBOutlet id StageNumber10;
    IBOutlet id StageNumber1;
    IBOutlet id ButtonNumber10;
    IBOutlet id ButtonNumber1;

    IBOutlet id Difficult;
	
	UIImage* number[10];
	UIImage* number_s[10];
	UIImage* difficultImg[3];
}

//헛~ 디폴트값을 어떻게 쓰나?
- (void)setMessage:(NSString*)msg showNext:(bool)showNext;
- (void)setMessage:(NSString*)msg;
- (void)showStageInfo:(int)idx button:(int)count diff:(int)diff;
- (void)reset;
- (void)initImg;

@end
