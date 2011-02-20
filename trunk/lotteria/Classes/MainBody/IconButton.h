@interface IconButton : UIViewController {
	NSString* action;
	int productIdx;
	
	IBOutlet UIButton* button;
	IBOutlet UILabel* nameLabel;
	
	UIViewController* actionListener;
}

@property (readonly) int productIdx;

- (IBAction)ButtonClick:(id)sender;
- (void)setData:(int)idx;
- (void)setListener:(UIViewController*)listener;

@end
