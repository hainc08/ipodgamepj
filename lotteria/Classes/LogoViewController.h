@interface LogoViewController : UIViewController {
	IBOutlet UIButton* closeButton;
	IBOutlet UIImageView* noticeImg;
	IBOutlet UIView* noticeView;
	
	bool isNoticeCheck;
}

- (IBAction)buttonClick;

@end
