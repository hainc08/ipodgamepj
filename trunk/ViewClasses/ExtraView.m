#import "ExtraView.h"
#import "ViewManager.h"

@implementation ExtraView

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];

	return self;
}

- (void)reset:(NSObject*)param
{
	[super reset:param];
}

- (IBAction)ButtonClick:(id)sender
{	
	if (sender == musicButton)
	{
		[[ViewManager getInstance] changeView:@"MusicView"];
	}
	else if (sender == graphicButton)
	{
		[[ViewManager getInstance] changeView:@"GraphicView"];
	}
	else if (sender == scineButton)
	{
		[[ViewManager getInstance] changeView:@"ScineView"];
	}
	else if (sender == itemButton)
	{
		[[ViewManager getInstance] changeView:@"ItemView"];
	}
	else if (sender == backButton)
	{
		[[ViewManager getInstance] changeView:@"MainTopView"];
	}
}

- (void) BaseSoundPlay
{
}

- (void)dealloc {
	[super dealloc];	
}

/* Base 사운드 제공 해야 함 */
- (void)update
{
	[super update];
}

@end