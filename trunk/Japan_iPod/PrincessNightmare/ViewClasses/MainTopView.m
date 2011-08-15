#import "MainTopView.h"
#import "ViewManager.h"
#import "DataManager.h"
#import "SaveManager.h"
#import "GameView.h"
#import "SoundManager.h"

@implementation MainTopView

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	loadView = nil;
	
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	loadView = nil;

	return self;
}

- (void)reset:(NSObject*)param
{
	[super reset:param];

	loadingDone = false;
	[start setAlpha:0];

	if (loadView == nil)
	{
		loadView = (LoadView*)[[ViewManager getInstance] getInstView:@"LoadView"];
		[loadView reset:nil];
		[self addSubview:loadView];
	}
	else
	{
		[loadView loadPage:[[SaveManager getInstance] lastPage]];
	}
	
	[loadView setCenter:CGPointMake(240,160)];
	[loadView setAlpha:0];
}

- (IBAction)ButtonClick:(id)sender
{
	[[SoundManager getInstance] playFX:@"001_se.mp3" repeat:false];

	if (sender == start)
	{
		[[SoundManager getInstance] stopBGM];
		GameParam* param = [GameParam alloc];
		[[DataManager getInstance] resetData];
		[[SaveManager getInstance] setFlagData:-1];
		
		[param setStartScene:0];//[[DataManager getInstance] getMsgIdx:0 idx2:1]];
//		[param setStartScene:[[DataManager getInstance] getMsgIdx:18 idx2:414]];
		[param setIsReplay:false];
		[[SaveManager getInstance] setQsaveSlot:-1];
//		[[ViewManager getInstance] changeViewWithInit:@"GameView" param:param];
		[[ViewManager getInstance] changeView:@"GameView" param:param];
	}
	else if (sender == load)
	{
		[loadView setAlpha:1];
	}
	else if (sender == config)
	{
		[[ViewManager getInstance] changeView:@"ConfigurationView"];
	}
	else if (sender == extra)
	{
		[[ViewManager getInstance] changeView:@"ExtraView"];
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
		[[SoundManager getInstance] playBGM:@"Abgm_10-1.mp3" idx:10];

		if ([[DataManager getInstance] loadingDone])
		{
			[loadingtime setText:[NSString stringWithFormat:@"%d", [[DataManager getInstance] loadingTime]]];
			loadingDone = true;
			[start setAlpha:1];
		}
	}
}

@end