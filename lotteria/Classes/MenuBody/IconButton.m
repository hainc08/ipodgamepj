#import "IconButton.h"

@implementation IconButton

@synthesize menu_id;

- (void)dealloc {
    [super dealloc];
}

- (IBAction)ButtonClick:(id)sender
{
	//경고 무시해도 상관없음...
	[self setSelected:true];
	[actionListener iconClicked:self :menu_id];
}

- (void)setData:(NSString*)mid
{
	menu_id = mid;
	NSString* nameStr = [[[DataManager getInstance] getProduct:menu_id] name];
	[nameLabel setText:[nameStr substringToIndex:MIN(5, [nameStr length])]];

	[button setImage:[[DataManager getInstance] getProductImg:menu_id type:SMALL] forState:UIControlStateNormal];
}

- (void)setListener:(UIViewController*)listener
{
	actionListener = listener;
}

- (void)setSelected:(bool)isSelected
{
	if (isSelected)
		[selectedImg setAlpha:1];
	else
		[selectedImg setAlpha:0];
}

@end

