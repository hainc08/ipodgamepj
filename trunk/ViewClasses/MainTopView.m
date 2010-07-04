#import "MainTopView.h"
#import "ViewManager.h"
#import "DataManager.h"
#import "GameView.h"
#import "SoundManager.h"

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
		[[SoundManager getInstance] stopBGM];
		GameParam* param = [GameParam alloc];
		[param setStartScene:0];
		[[SoundManager getInstance] stopBGM];
		[[ViewManager getInstance] changeViewWithInit:@"GameView" param:param];
	}
	else if (sender == load)
	{
		[[SoundManager getInstance] playBGM:@"Abgm_03-1.mp3"];
//		[[ViewManager getInstance] changeView:@"LoadView"];
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
		[[SoundManager getInstance] playBGM:@"Abgm_10-1.mp3"];

		if ([[DataManager getInstance] loadingDone])
		{
			[loadingtime setText:[NSString stringWithFormat:@"%d", [[DataManager getInstance] loadingTime]]];
			loadingDone = true;
			[start setAlpha:1];
		}
	}
}

@end