#import "UIViewControllerTemplate.h"		

@interface FindCellView : UITableViewCell {
	UINavigationController *navi;
	
	ProductData* product;
	IBOutlet UIImageView* underLine;
	IBOutlet UIImageView* menuImg;
	
	IBOutlet UILabel* nameLabel;
	IBOutlet UILabel* descLabel;
	IBOutlet UILabel* priceLabel;
}

@property (retain) UIImageView* menuImg;
@property (nonatomic , retain) UINavigationController *navi;

- (IBAction)buttonClick:(id)sender;
- (void)setData:(ProductData*)data;
- (void)setLast:(bool)isLast;

@end

@interface FindBodyViewController : UIViewControllerTemplate<UITableViewDataSource> {
	IBOutlet UIButton* bgButton;
	IBOutlet UIButton* chButton;
	IBOutlet UIButton* drButton;
	IBOutlet UIButton* dsButton;
	IBOutlet UIButton* pcButton;
	
	IBOutlet UITableView* tableView;
	int itemCount[5];
	int idx;
}

- (IBAction)button:(id)sender;

@end
