@class HTTPRequest;
@interface LogoViewController : UIViewController {
	IBOutlet UIButton* closeButton;
	IBOutlet UIImageView* noticeImg;
	IBOutlet UIView* noticeView;
	
	bool isNoticeCheck;
	
	HTTPRequest *httpRequest;
}

- (IBAction)buttonClick;
- (void)GetVersion;
-(void)GetMenuList;
- (void)ShowOKCancleAlert:(NSString *)title msg:(NSString *)message;
@end
