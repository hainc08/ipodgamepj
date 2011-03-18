#import "SaveView.h"
#import "ViewManager.h"
#import "SaveManager.h"
#import "DataManager.h"
#import "SoundManager.h"

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
		if (bars[i] == nil)
		{
			bars[i] = (LoadSaveBar*)[[ViewManager getInstance] getInstView:@"LoadSaveBar"];
			[self addSubview:bars[i]];
			[bars[i] setCenter:CGPointMake(290,59*i+80)];
			[[bars[i] getButton:0] addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
			[[bars[i] getButton:1] addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
		}
	}
	
	[[SaveManager getInstance] loadSaveFile];
	
	[self loadPage:[[SaveManager getInstance] lastPage]];
}

- (void)loadPage:(int)page
{
	curPage = page;
	
	[[SaveManager getInstance] setLastPage:curPage];
	
	[pageLabel setText:[NSString stringWithFormat:@"%d / 7", curPage + 1]];
	
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
		[[SoundManager getInstance] playFX:@"010_se.mp3" repeat:false];
		[self setAlpha:0];
	}
	else if (sender == nextButton)
	{
		[[SoundManager getInstance] playFX:@"010_se.mp3" repeat:false];
		[self loadPage:curPage+1];
	}
	else if (sender == prevButton)
	{
		[[SoundManager getInstance] playFX:@"010_se.mp3" repeat:false];
		[self loadPage:curPage-1];
	}
	else
	{
		for (int i=0; i<4; ++i)
		{
			if ((sender == [bars[i] getButton:0])||
				(sender == [bars[i] getButton:1]))
			{
				[[SoundManager getInstance] playFX:@"001_se.mp3" repeat:false];
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
		[bars[i] removeFromSuperview];
		[bars[i] release];
	}
		
	[super dealloc];	
}

@end