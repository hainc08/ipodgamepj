#import "MainTopView.h"
#import "ViewManager.h"
#import "DataManager.h"

@implementation MainTopView

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
	
	loadingDone = false;
	[start setAlpha:0];
}

- (IBAction)ButtonClick:(id)sender
{	
	if (sender == start)
	{
		[[ViewManager getInstance] changeViewWithInit:@"GameView"];
	}
	else if (sender == load)
	{
		[[ViewManager getInstance] changeView:@"LoadView"];
	}
	else if (sender == config)
	{
		[[ViewManager getInstance] changeView:@"ConfigView"];
	}
	else if (sender == config)
	{
		[[ViewManager getInstance] changeView:@"ExtraView"];
	}
	else if (sender == exit) /* 나중에 빼버려도 될듯 우선 넣어놓고.. */
	{
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
	
	if (loadingDone == false)
	{
		if ([[DataManager getInstance] loadingDone])
		{
			[loadingtime setText:[NSString stringWithFormat:@"%d", [[DataManager getInstance] loadingTime]]];
			loadingDone = true;
			[start setAlpha:1];
		}
	}
}

@end