
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
	int pIdx[3];
	
	IBOutlet UILabel* countLabel;
	IBOutlet UIButton* decCount;
	IBOutlet UIButton* incCount;

	IBOutlet UIButton* closeButton;
}

- (void)showProduct:(int)idx;
- (IBAction)ButtonClick:(id)sender;

@end
