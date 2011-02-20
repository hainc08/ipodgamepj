@interface CartCellView : UITableViewCell {
	IBOutlet UIImageView* underLine;
}

- (void)setLast:(bool)isLast;

@end

@interface CartListViewController : UIViewController<UITableViewDataSource> {
	IBOutlet UIImageView* topImg;
	IBOutlet UITableView* listTable;
}

- (void)setCategory:(int)idx;

@end
