#import "GameMenu.h"
#import "ViewManager.h"

@implementation GameMenu

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];

	return self;
}

- (void)reset
{
	saveView = (SaveView*)[[ViewManager getInstance] getInstView:@"SaveView"];
	[saveView reset:nil];
	[self addSubview:saveView];
	[saveView setCenter:CGPointMake(240,160)];
	[saveView setAlpha:0];
}

- (IBAction)ButtonClick:(id)sender
{
	if (sender == backButton)
	{
		[self setAlpha:0];
	}
	else if (sender == saveButton)
	{
		[saveView setAlpha:1];
	}
}

@end