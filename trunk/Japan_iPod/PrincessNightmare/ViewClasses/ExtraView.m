#import "ExtraView.h"
#import "ViewManager.h"
#import "SoundManager.h"

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
		[[SoundManager getInstance] playFX:@"001_se.mp3" repeat:false];
		[[ViewManager getInstance] changeView:@"MusicView"];
	}
	else if (sender == graphicButton)
	{
		[[SoundManager getInstance] playFX:@"001_se.mp3" repeat:false];
		[[ViewManager getInstance] changeView:@"GraphicView"];
	}
	else if (sender == scineButton)
	{
		[[SoundManager getInstance] playFX:@"001_se.mp3" repeat:false];
		[[ViewManager getInstance] changeView:@"ScineView"];
	}
	else if (sender == itemButton)
	{
		[[SoundManager getInstance] playFX:@"001_se.mp3" repeat:false];
		[[ViewManager getInstance] changeView:@"ItemView"];
	}
	else if (sender == backButton)
	{
		[[SoundManager getInstance] playFX:@"010_se.mp3" repeat:false];
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