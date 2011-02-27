#import "UIViewControllerTemplate.h"		

@interface FindCellView : UITableViewCell {
	IBOutlet UIImageView* underLine;
	IBOutlet UIImageView* menuImg;
}

@property (retain) UIImageView* menuImg;

- (IBAction)buttonClick:(id)sender;
- (void)setData:(NSString*)menuId;
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
