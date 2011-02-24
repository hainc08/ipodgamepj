@interface CartCellView : UITableViewCell {
	IBOutlet UIImageView* underLine;

	NSString* mainId;
	NSString* side1Id;
	NSString* side2Id;
	
	IBOutlet UIButton* incCount;
	IBOutlet UIButton* decCount;
	IBOutlet UIButton* changeSide1;
	IBOutlet UIButton* changeSide2;
	
	IBOutlet UILabel* mainLabel;
	IBOutlet UILabel* sideLabel;
	IBOutlet UILabel* countLabel;
	IBOutlet UILabel* priceLabel;

	int count;
}

- (void)refreshData;
- (IBAction)buttonClick:(id)sender;
- (void)setLast:(bool)isLast;
- (void)setData:(CartItem*)item;

@end

@interface CartListViewController : UIViewController<UITableViewDataSource> {
	IBOutlet UIImageView* topImg;
	IBOutlet UITableView* listTable;

	int listIdx;
	int itemCount;
}

- (void)setCategory:(int)idx;

@end
