#import "SaveView.h"
#import "ViewManager.h"
#import "SaveManager.h"
#import "DataManager.h"

@implementation SaveView

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
	for (int i=0; i<4; ++i)
	{
		bars[i] = (LoadSaveBar*)[[ViewManager getInstance] getInstView:@"LoadSaveBar"];
		[self addSubview:bars[i]];
		[bars[i] setCenter:CGPointMake(290,59*i+80)];
		[[bars[i] getButton:0] addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
		[[bars[i] getButton:1] addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
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
		[self setAlpha:0];
	}
	else if (sender == nextButton)
	{
		[self loadPage:curPage+1];
	}
	else if (sender == prevButton)
	{
		[self loadPage:curPage-1];
	}
	else
	{
		for (int i=0; i<4; ++i)
		{
			if ((sender == [bars[i] getButton:0])||
				(sender == [bars[i] getButton:1]))
			{
				[[SaveManager getInstance] save:(curPage * 4) + i
										   data:[[[DataManager getInstance] getCurScene] sceneId]];
				[self loadPage:curPage];
			}
		}
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

@end