#import "ConfigurationView.h"
#import "ViewManager.h"
#import "SaveManager.h"
#import "SoundManager.h"

@implementation ConfigurationView

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
		//나중에는 파일에서 읽어오자
		opt1 = [[SaveManager getInstance] opt1];
		opt2 = [[SaveManager getInstance] opt2];
		[self setOption];
	}
}

- (IBAction)ButtonClick:(id)sender
{	
	if (sender == backButton)
	{
		[[SoundManager getInstance] playFX:@"010_se.mp3" repeat:false];
		[[SaveManager getInstance] setOpt:opt1 :opt2];
		[[ViewManager getInstance] changeView:@"MainTopView"];
	}
	else if (sender == opt1_p)
	{
		if (opt1 > 1)
		{
			--opt1;
			[self setOption];
		}
	}
	else if (sender == opt1_n)
	{
		if (opt1 < 5)
		{
			++opt1;
			[self setOption];
		}
	}
	else if (sender == opt2_p)
	{
		if (opt2 > 1)
		{
			--opt2;
			[self setOption];
		}
	}
	else if (sender == opt2_n)
	{
		if (opt2 < 5)
		{
			++opt2;
			[self setOption];
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