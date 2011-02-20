#import "IconButton.h"

@implementation IconButton

@synthesize productIdx;

- (void)dealloc {
    [super dealloc];
}

- (IBAction)ButtonClick:(id)sender
{
	//경고 무시해도 상관없음...
	[actionListener iconClicked:productIdx];
}

- (void)setData:(int)idx
{
	productIdx = idx;
	[nameLabel setText:[[[DataManager getInstance] getProduct:idx] name]];

	[button setImage:[[DataManager getInstance] getProductImg:idx type:SMALL] forState:UIControlStateNormal];
}

- (void)setListener:(UIViewController*)listener
{
	actionListener = listener;
}

@end

