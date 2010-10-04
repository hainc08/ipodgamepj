#import "LoadView.h"
#import "ViewManager.h"
#import "SaveManager.h"
#import "GameView.h"
#import "SoundManager.h"

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
	
	[pageLabel setText:[NSString stringWithFormat:@"%d / 7", curPage + 1]];

	if (page == 0) [prevButton setAlpha:0];
	else [prevButton setAlpha:1];
	
	if (page == 6) [nextButton setAlpha:0];
	else [nextButton setAlpha:1];

	for (int i=0; i<4; ++i)
	{
		int saveIdx = [[SaveManager getInstance] getSaveData:(page * 4 + i)];
		[[bars[i] getButton:0] setEnabled:(saveIdx > 0)];
		[[bars[i] getButton:1] setEnabled:(saveIdx > 0)];
		[bars[i] setSaveIdx:saveIdx];
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
				GameParam* param = [GameParam alloc];
				[param setStartScene:[bars[i] saveIdx]];
				[param setIsReplay:false];
				
				[[SaveManager getInstance] setFlagData:curPage*4+i];
				[[ViewManager getInstance] changeViewWithInit:@"GameView" param:param];
				return;
			}
		}
	}
}

- (void) BaseSoundPlay
{
}

- (void)dealloc {
	[super dealloc];	
}

@end