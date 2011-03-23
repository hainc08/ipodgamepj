@class HTTPRequest;
@interface LogoViewController : UIViewController {
	IBOutlet UIButton* closeButton;
	IBOutlet UIImageView* noticeImg;
	IBOutlet UIView* noticeView;
	
	IBOutlet UIActivityIndicatorView* loadingNow;
	
	bool isNoticeCheck;
	
	HTTPRequest *httpRequest;
	
	int doneStep;
}

- (IBAction)buttonClick;
- (void)GetVersion;
- (void)GetMenuList;
- (void)loadingDone;
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)ShowOKCancleAlert:(NSString *)title msg:(NSString *)message;
- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message;

@end
