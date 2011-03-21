#import "UIViewControllerTemplate.h"

@interface ChangeSideCellView : UITableViewCell {
	IBOutlet UIImageView* thumbImg;
	IBOutlet UIImageView* backImg;
	IBOutlet UIImageView* backImg2;

	IBOutlet UILabel* nameLabel;
	IBOutlet UILabel* calLabel;
	IBOutlet UILabel* priceLabel;
	
	UIColor* color1;
	UIColor* color2;
	
	ProductData* product;
	UIViewController* listView;
}

@property (retain) UIViewController* listView;

- (void)setData:(ProductData*)item;
- (void)setSelect:(bool)selected;
- (IBAction)Select;

@end

@interface ChangeSideViewController : UIViewControllerTemplate<UITableViewDataSource> {
	IBOutlet UITableView* listTable;
	
	NSMutableArray* products;
	
	ChangeSideCellView* selectCell;
	int sType;
	NSString* menuId;
}

- (IBAction) ButtonClick:(id)sender;
- (void)setSideType:(int)type;
- (void)selectId:(NSString*)mId;
- (void)reloadData;

@end
