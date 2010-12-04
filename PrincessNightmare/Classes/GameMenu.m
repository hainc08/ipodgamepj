#import "GameMenu.h"
#import "ViewManager.h"
#import "SoundManager.h"

@implementation GameMenu

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];

	return self;
}

- (void)reset:(bool)isReplay
{
	if (isReplay)
	{
		MenuType	= SCINEMENU;
		
		[saveButton setAlpha:0];
		[loadButton setAlpha:0];
		
		configView = (ConfigurationView*)[[ViewManager getInstance] getInstView:@"ConfigurationView"];
		[configView reset:nil];
		[self addSubview:configView];
		[configView setCenter:CGPointMake(240,160)];
		[configView setAlpha:0];
		[configView setViewtype:1];
	}
	else
	{
		MenuType	= GAMEMENU;
		
		[saveButton setAlpha:1];
		[loadButton setAlpha:1];
		
		saveView = (SaveView*)[[ViewManager getInstance] getInstView:@"SaveView"];
		[saveView reset:nil];
		[self addSubview:saveView];
		[saveView setCenter:CGPointMake(240,160)];
		[saveView setAlpha:0];
		
		loadView = (LoadView*)[[ViewManager getInstance] getInstView:@"LoadView"];
		[loadView reset:nil];
		[self addSubview:loadView];
		[loadView setCenter:CGPointMake(240,160)];
		[loadView setAlpha:0];

		configView = (ConfigurationView*)[[ViewManager getInstance] getInstView:@"ConfigurationView"];
		[configView reset:nil];
		[self addSubview:configView];
		[configView setCenter:CGPointMake(240,160)];
		[configView setAlpha:0];
		[configView setViewtype:1];
	}
}

- (IBAction)ButtonClick:(id)sender
{
	[[SoundManager getInstance] playFX:@"010_se.mp3" repeat:false];

	if (sender == backButton)
	{
		[self setAlpha:0];
	}
	else if (sender == saveButton)
	{
		[saveView loadPage:0];
		[saveView setAlpha:1];
	}
	else if (sender == loadButton)
	{
		[loadView loadPage:0];
		[loadView setAlpha:1];
	}
	else if (sender == exitButton)
	{
		if (MenuType == SCINEMENU)
			[[ViewManager getInstance] changeView:@"ScineView"];
		else
			[[ViewManager getInstance] changeView:@"MainTopView"];
	}
	else if (sender == configButton)
	{
		[configView setAlpha:1];
	}
}

@end