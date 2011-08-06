#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@class HTTPRequest;

@interface OnlinePayViewController : UIViewControllerTemplate {
	NSString *PayUrl;
	IBOutlet UIWebView *Webview; 
}

- (void)didReceiveFinished:(NSString *)result;
- (void)showPage:(NSString *)url bodyArray:(NSMutableArray *)bodyarr;

@end
