#import "UIViewControllerTemplate.h"

@interface DetailViewController : UIViewControllerTemplate {
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

	IBOutlet UIButton* side1Select;
	IBOutlet UIButton* side2Select;

	IBOutlet UIButton* addCartButton;

	IBOutlet UIScrollView* contentScrollView;
	
	int count;
	NSString* productId;
	NSString* pId[3];
	
	IBOutlet UILabel* side1Label;
	IBOutlet UILabel* side2Label;
	IBOutlet UILabel* countLabel;

	IBOutlet UIButton* decCount;
	IBOutlet UIButton* incCount;

	IBOutlet UIButton* closeButton;

	bool fullType;
}

@property (readwrite) bool fullType;

- (void)showProduct:(NSString*)menu_id;
- (IBAction)ButtonClick:(id)sender;
- (void)makeHalfMode;
- (void)sideSelected:(int)idx :(ProductData*)data;

@end
