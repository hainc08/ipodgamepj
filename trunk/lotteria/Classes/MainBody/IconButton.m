#import "IconButton.h"

@implementation IconButton

@synthesize menu_id;

- (void)dealloc {
    [super dealloc];
}

- (IBAction)ButtonClick:(id)sender
{
	//경고 무시해도 상관없음...
	[actionListener iconClicked:menu_id];
}

- (void)setData:(NSString*)mid
{
	menu_id = mid;
	[nameLabel setText:[[[DataManager getInstance] getProduct:menu_id] name]];

	[button setImage:[[DataManager getInstance] getProductImg:menu_id type:SMALL] forState:UIControlStateNormal];
}

- (void)setListener:(UIViewController*)listener
{
	actionListener = listener;
}

@end

