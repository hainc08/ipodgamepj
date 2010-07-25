#import "MusicView.h"
#import "ViewManager.h"
#import "SaveManager.h"
#import "SoundManager.h"
#import "DataManager.h"

@implementation MusicView

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
	[[SaveManager getInstance] loadMusicFile];
	[[SoundManager getInstance] stopBGM];
	
	if (isInit == false)
	{
		UIImage* baseImg = [[UIImage imageNamed:@"w-box.png"] autorelease];
		
		for (int i=0; i<16; ++i)
		{
			imageButton[i] = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 109, 40)];
			[self addSubview:imageButton[i]];
			[imageButton[i] setImage:baseImg forState:UIControlStateNormal];
			[imageButton[i] setCenter:CGPointMake((i % 4) * 116 + 66, (i / 4) * 47 + 90)];
			[imageButton[i] addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
			
			buttonLabel[i] = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
			[self addSubview:buttonLabel[i]];
			[buttonLabel[i] setCenter:CGPointMake((i % 4) * 116 + 66, (i / 4) * 47 + 90)];
			[buttonLabel[i] setTextColor:[UIColor blackColor]];
			[buttonLabel[i] setFont:[UIFont fontWithName:@"Helvetica" size:10]];
			[buttonLabel[i] setBackgroundColor:[UIColor clearColor]];
			[buttonLabel[i] setTextAlignment:UITextAlignmentCenter]; 
			[buttonLabel[i] setNumberOfLines:2];
		}

		isInit = true;
	}
	
	[self loadPage:1];
}

- (void)loadPage:(int)page
{
	curPage = page;
	if (curPage == 1) [prevButton setAlpha:0];
	else [prevButton setAlpha:1];
	
	if (curPage == 2) [nextButton setAlpha:0];
	else [nextButton setAlpha:1];
	
	for (int i=0; i<16; ++i)
	{
		if (((curPage == 2) && (i > 11)) ||
			([[DataManager getInstance] getMusicShow:(curPage - 1) * 16 + i + 1] == false))
		{
			[imageButton[i] setAlpha:0];
			[buttonLabel[i] setAlpha:0];
			continue;
		}

		[imageButton[i] setAlpha:1];
		[buttonLabel[i] setAlpha:1];

		[buttonLabel[i] setText:[[DataManager getInstance] getBGMname:(curPage - 1) * 16 + i + 1]];
	}
}

- (IBAction)ButtonClick:(id)sender
{	
	if (sender == backButton)
	{
		[[SoundManager getInstance] stopBGM];
		[[ViewManager getInstance] changeView:@"ExtraView"];
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
	else if (sender == stopButton)
	{
		[[SoundManager getInstance] stopBGM];
	}
	else
	{
		for (int i=0; i<16; ++i)
		{
			if (sender == imageButton[i])
			{
				[[SoundManager getInstance] stopBGM];
				
				NSString* fileName;
				int idx = (curPage - 1) * 16 + i + 1;
				
				if (idx < 10) fileName = [NSString stringWithFormat: @"Abgm_0%d-1.mp3", idx];
				else fileName = [NSString stringWithFormat: @"Abgm_%d-1.mp3", idx];
				[[SoundManager getInstance] playBGM:fileName];
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

/* Base 사운드 제공 해야 함 */
- (void)update
{
	[super update];
}

@end