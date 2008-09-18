#import <UIKit/UIKit.h>

@interface MessageView : UIView {
	NSString *msgCache;
	
    IBOutlet id GameOver;
    IBOutlet id StageClear;
    IBOutlet id Undefined;
}

- (void)setMessage:(NSString*)msg;
- (void)reset;

@end
