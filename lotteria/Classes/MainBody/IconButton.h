@interface IconButton : UIViewController {
	NSString* action;
	NSString* menu_id;
	
	IBOutlet UIButton* button;
	IBOutlet UILabel* nameLabel;
	
	UIViewController* actionListener;
}

@property (retain) NSString* menu_id;

- (IBAction)ButtonClick:(id)sender;
- (void)setData:(NSString*)mid;
- (void)setListener:(UIViewController*)listener;

@end
