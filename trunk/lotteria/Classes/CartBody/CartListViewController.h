@interface CartCellView : UIViewController {
	IBOutlet UIImageView* underLine;
	UINavigationController *navi;
	
	IBOutlet UIButton* incCount;
	IBOutlet UIButton* decCount;
	IBOutlet UIButton* changeDessert;
	IBOutlet UIButton* changeDrink;
	
	IBOutlet UILabel* mainLabel;
	IBOutlet UILabel* sideLabel;
	IBOutlet UILabel* countLabel;
	IBOutlet UILabel* priceLabel;
	
	CartItem* cartItem;
	bool isLast;
}

@property (nonatomic ,retain) UINavigationController* navi;
@property (readwrite) bool isLast;

- (void)refreshData;
- (IBAction)buttonClick:(id)sender;
- (void)setData:(CartItem*)item;
- (void)sideSelected:(int)idx :(ProductData*)data;

@end

@interface CartListViewController : UIViewController {
	UINavigationController *navi;

	IBOutlet UIImageView* topImg;
	IBOutlet UIView* listView;

	int listIdx;
	int itemCount;
}

@property (nonatomic ,retain) UINavigationController* navi;

- (void)setCategory:(int)idx;
- (void)reloadData;

@end
