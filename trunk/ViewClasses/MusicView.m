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
		}
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
		[self loadPage:curPage+1];
	}
	else if (sender == prevButton)
	{
		[self loadPage:curPage-1];
	}
	else if (sender == stopButton)
	{
		[[SoundManager getInstance] stopBGM];
	}
	else
	{

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