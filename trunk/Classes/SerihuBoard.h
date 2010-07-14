#import <UIKit/UIKit.h>

@interface SerihuBoard : UIView {
	IBOutlet id nameBoard;
	
	IBOutlet id serihuLabel;
	IBOutlet id serihuLabel2;
	IBOutlet id serihuLabel3;
	
	IBOutlet id charaLabel;
	IBOutlet id charaLabel2;
	IBOutlet id charaLabel3;
}

- (void)setSerihu:(NSString*)chr serihu:(NSString*)serihu;

@end
