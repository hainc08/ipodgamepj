@class HTTPRequest;
@interface LogoViewController : UIViewController <UIWebViewDelegate> {
	IBOutlet UIButton* closeButton;
	IBOutlet UIImageView* noticeImg;
	IBOutlet UIView* noticeView;
	
	IBOutlet UIActivityIndicatorView* loadingNow;
	
	bool isNoticeCheck;
	
	HTTPRequest *httpRequest;
	
	IBOutlet UIWebView* webView;

	int doneStep;
}

- (IBAction)buttonClick;
- (void)GetVersion;
- (void)GetMenuList;
- (void)loadingDone;
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message button:(NSString*)button;

@end
