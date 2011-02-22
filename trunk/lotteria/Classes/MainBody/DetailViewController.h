
@interface DetailViewController : UIViewController {
	IBOutlet UIImageView* pImage;
	IBOutlet UIImageView* nameImage;
	IBOutlet UIImageView* descImage;
	
	IBOutlet UIView* selectView;
	IBOutlet UIView* optionView1;
	IBOutlet UIView* optionView2;

	IBOutlet UIImageView* singleBack;
	IBOutlet UIImageView* setBack;
	
	IBOutlet UIButton* singleButton;
	IBOutlet UIButton* setButton;

	IBOutlet UIButton* addCartButton;

	IBOutlet UIScrollView* contentScrollView;
	
	int count;
	NSString* pId[3];
	
	IBOutlet UILabel* countLabel;
	IBOutlet UIButton* decCount;
	IBOutlet UIButton* incCount;

	IBOutlet UIButton* closeButton;
}

- (void)showProduct:(NSString*)menu_id;
- (IBAction)ButtonClick:(id)sender;

@end
