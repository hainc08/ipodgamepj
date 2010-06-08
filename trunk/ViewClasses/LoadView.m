#import "LoadView.h"
#import "ViewManager.h"
#import "SaveManager.h"

@implementation LoadView

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
	
	if (isInit == false)
	{
		for (int i=0; i<4; ++i)
		{
			bars[i] = (LoadSaveBar*)[[ViewManager getInstance] getInstView:@"LoadSaveBar"];
			[self addSubview:bars[i]];
			[bars[i] setCenter:CGPointMake(290,59*i+80)];
		}
	}
	
	[[SaveManager getInstance] loadSaveFile];
	
	[self loadPage:0];
}

- (void)loadPage:(int)page
{
	curPage = page;
	
	if (page == 0) [prevButton setAlpha:0];
	else [prevButton setAlpha:1];
	
	if (page == 6) [nextButton setAlpha:0];
	else [nextButton setAlpha:1];

	for (int i=0; i<4; ++i)
	{
		[bars[i] setSaveIdx:[[SaveManager getInstance] getSaveData:(page * 4 + i)]];
		[bars[i] setSaveDate:[[SaveManager getInstance] getSaveDate:(page * 4 + i)]];
	}
}

- (IBAction)ButtonClick:(id)sender
{	
	if (sender == backButton)
	{
		[[ViewManager getInstance] changeView:@"MainTopView"];
	}
	else if (sender == nextButton)
	{
		[self loadPage:curPage+1];
	}
	else if (sender == prevButton)
	{
		[self loadPage:curPage-1];
	}
}

- (void) BaseSoundPlay
{
}

- (void)dealloc {
	for (int i=0; i<4; ++i)
	{
		[bars[i] dealloc];
	}
	[super dealloc];	
}

/* Base 사운드 제공 해야 함 */
- (void)update
{
	[super update];
}

@end