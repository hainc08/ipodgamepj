#import "GameMenu.h"
#import "ViewManager.h"
#import "SoundManager.h"
#import "SaveManager.h"

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
		
		if (configView == nil)
		{
			configView = (ConfigurationView*)[[ViewManager getInstance] getInstView:@"ConfigurationView"];
			[self addSubview:configView];
		}
		[configView reset:nil];
		[configView setCenter:CGPointMake(240,160)];
		[configView setAlpha:0];
		[configView setViewtype:1];
	}
	else
	{
		MenuType	= GAMEMENU;
		
		[saveButton setAlpha:1];
		[loadButton setAlpha:1];
		
		if (saveView == nil)
		{
			saveView = (SaveView*)[[ViewManager getInstance] getInstView:@"SaveView"];
			[self addSubview:saveView];
		}
		[saveView reset:nil];
		[saveView setCenter:CGPointMake(240,160)];
		[saveView setAlpha:0];
		
		if (loadView == nil)
		{
			loadView = (LoadView*)[[ViewManager getInstance] getInstView:@"LoadView"];
			[self addSubview:loadView];
		}
		[loadView reset:nil];
		[loadView setCenter:CGPointMake(240,160)];
		[loadView setAlpha:0];

		if (configView == nil)
		{
			configView = (ConfigurationView*)[[ViewManager getInstance] getInstView:@"ConfigurationView"];
			[self addSubview:configView];
		}
		[configView reset:nil];
		[configView setCenter:CGPointMake(240,160)];
		[configView setAlpha:0];
		[configView setViewtype:1];
	}
	
	[menuView setAlpha:1];
	[exitView setAlpha:0];
}

- (IBAction)ButtonClick:(id)sender
{
	[[SoundManager getInstance] playFX:@"010_se.mp3" repeat:false];

	if (sender == backButton)
	{
		[self setAlpha:0];
		[[[ViewManager getInstance] getCurView] refresh];
	}
	else if (sender == saveButton)
	{
		[saveView loadPage:[[SaveManager getInstance] lastPage]];
		[saveView setAlpha:1];
	}
	else if (sender == loadButton)
	{
		[loadView loadPage:[[SaveManager getInstance] lastPage]];
		[loadView setAlpha:1];
	}
	else if (sender == exitButton)
	{
		[menuView setAlpha:0];
		[exitView setAlpha:1];
	}
	else if (sender == noButton)
	{
		[menuView setAlpha:1];
		[exitView setAlpha:0];
	}
	else if (sender == yesButton)
	{
		if (MenuType == SCINEMENU)
			[[ViewManager getInstance] changeView:@"ScineView"];
		else
		{
			[[ViewManager getInstance] changeView:@"MainTopView"];
		}
	}
	else if (sender == configButton)
	{
		[configView setAlpha:1];
	}
}

@end