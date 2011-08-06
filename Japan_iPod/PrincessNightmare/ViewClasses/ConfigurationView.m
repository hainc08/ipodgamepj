#import "ConfigurationView.h"
#import "ViewManager.h"
#import "SaveManager.h"
#import "SoundManager.h"

@implementation ConfigurationView

@synthesize viewtype;

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
		opt1 = [[SaveManager getInstance] opt1];
		opt2 = [[SaveManager getInstance] opt2];
		[self setOption];
	}
	
	viewtype = 0;
}

- (IBAction)ButtonClick:(id)sender
{	
	if (sender == backButton)
	{
		if (viewtype == 1)
		{
			[self setAlpha:0];
		}
		else
		{
			[[SoundManager getInstance] playFX:@"010_se.mp3" repeat:false];
			[[ViewManager getInstance] changeView:@"MainTopView"];
		}
		[[SaveManager getInstance] setOpt:opt1 :opt2];
	}
	else if (sender == opt1_p)
	{
		if (opt1 > 1)
		{
			--opt1;
			[self setOption];
			[[SoundManager getInstance] setBGMVolume:(opt1 - 1) * 0.25f];
		}
	}
	else if (sender == opt1_n)
	{
		if (opt1 < 5)
		{
			++opt1;
			[self setOption];
			[[SoundManager getInstance] setBGMVolume:(opt1 - 1) * 0.25f];
		}
	}
	else if (sender == opt2_p)
	{
		if (opt2 > 1)
		{
			--opt2;
			[self setOption];
			[[SoundManager getInstance] setFxVolume:(opt2 - 1) * 0.25f];
			[[SoundManager getInstance] playFX:@"001_se.mp3" repeat:false];
		}
	}
	else if (sender == opt2_n)
	{
		if (opt2 < 5)
		{
			++opt2;
			[self setOption];
			[[SoundManager getInstance] setFxVolume:(opt2 - 1) * 0.25f];
			[[SoundManager getInstance] playFX:@"001_se.mp3" repeat:false];
		}
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

- (void)setOption
{
	[opt1_1 setAlpha:0];
	[opt1_2 setAlpha:0];
	[opt1_3 setAlpha:0];
	[opt1_4 setAlpha:0];
	[opt1_5 setAlpha:0];
	[opt2_1 setAlpha:0];
	[opt2_2 setAlpha:0];
	[opt2_3 setAlpha:0];
	[opt2_4 setAlpha:0];
	[opt2_5 setAlpha:0];
	
	switch (opt1)
	{
		case 1:
			[opt1_1 setAlpha:1];
			break;
		case 2:
			[opt1_2 setAlpha:1];
			break;
		case 3:
			[opt1_3 setAlpha:1];
			break;
		case 4:
			[opt1_4 setAlpha:1];
			break;
		case 5:
			[opt1_5 setAlpha:1];
			break;
	}
	switch (opt2)
	{
		case 1:
			[opt2_1 setAlpha:1];
			break;
		case 2:
			[opt2_2 setAlpha:1];
			break;
		case 3:
			[opt2_3 setAlpha:1];
			break;
		case 4:
			[opt2_4 setAlpha:1];
			break;
		case 5:
			[opt2_5 setAlpha:1];
			break;
	}
}

@end