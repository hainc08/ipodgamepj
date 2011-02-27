@interface CartCellView : UITableViewCell {
	IBOutlet UIImageView* underLine;
	UINavigationController *navi;

	NSString* mainId;
	NSString* drinkId;
	NSString* dessertId;
	
	IBOutlet UIButton* incCount;
	IBOutlet UIButton* decCount;
	IBOutlet UIButton* changeDessert;
	IBOutlet UIButton* changeDrink;
	
	IBOutlet UILabel* mainLabel;
	IBOutlet UILabel* sideLabel;
	IBOutlet UILabel* countLabel;
	IBOutlet UILabel* priceLabel;
	
	CartItem* cartItem;
	
	int count;
}

@property (nonatomic ,retain) UINavigationController* navi;

- (void)refreshData;
- (IBAction)buttonClick:(id)sender;
- (void)setLast:(bool)isLast;
- (void)setData:(CartItem*)item;
- (void)sideSelected:(int)idx :(ProductData*)data;

@end

@interface CartListViewController : UIViewController<UITableViewDataSource> {
	UINavigationController *navi;

	IBOutlet UIImageView* topImg;
	IBOutlet UITableView* listTable;

	int listIdx;
	int itemCount;
}

@property (nonatomic ,retain) UINavigationController* navi;

- (void)setCategory:(int)idx;

@end
