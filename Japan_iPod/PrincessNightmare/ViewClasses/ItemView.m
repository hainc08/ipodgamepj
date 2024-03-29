#import "ItemView.h"
#import "ViewManager.h"
#import "SaveManager.h"
#import "SoundManager.h"

@implementation ItemView

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
		for (int i=0; i<15; ++i)
		{
			imageButton[i] = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 66, 56)];

			[self addSubview:imageButton[i]];
			[imageButton[i] setCenter:CGPointMake((i % 5) * 80 + 80, (i / 5) * 70 + 90)];
			[imageButton[i] addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
		}
		
		imageBigButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 480, 360)];
		[self addSubview:imageBigButton];
		[self bringSubviewToFront:imageBigButton];
		[imageBigButton setCenter:CGPointMake(240, 160)];
		[imageBigButton addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
		[imageBigButton setAlpha:0];

		isInit = true;
	}
	
	[[SaveManager getInstance] loadExtraFile];
	[descView setAlpha:0];
	[self bringSubviewToFront:descView];
	[self loadPage:1];
}

- (void)loadPage:(int)page
{
	curPage = page;
	
	[pageLabel setText:[NSString stringWithFormat:@"%d / 2", curPage]];
	
	if (curPage == 1) [prevButton setAlpha:0];
	else [prevButton setAlpha:1];

	if (curPage == 2) [nextButton setAlpha:0];
	else [nextButton setAlpha:1];
	
	for (int i=0; i<15; ++i)
	{
		[imageButton[i] setAlpha:0];

		int idx = (curPage-1) * 15 + i + 1;
		for (int j=1; j<22; ++j)
		{
			if ([[[DataManager getInstance] getItemName:j idx2:0] length] > 0)
			{
				--idx;
				if (idx == 0)
				{
					if ([[SaveManager getInstance] getItemFlag:j])
					{
						UIImage* baseImg = [UIImage imageNamed:[NSString stringWithFormat:@"item%d.jpg", j]];
						[imageButton[i] setImage:baseImg forState:UIControlStateNormal];
						[imageButton[i] setAlpha:1];
					}
					goto FINDITEM;
				}
			}
		}
	FINDITEM:
		continue;
	}
}

- (IBAction)ButtonClick:(id)sender
{
	if (sender == closeButton)
	{
		[descView setAlpha:0];
	}
	else if (sender == backButton)
	{
		[[SoundManager getInstance] playFX:@"010_se.mp3" repeat:false];
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
	else if (sender == imageBigButton)
	{
		[imageBigButton setAlpha:0];
	}
	else
	{
		for (int i=0; i<15; ++i)
		{
			if (sender == imageButton[i])
			{
				int idx = (curPage-1) * 15 + i + 1;
				for (int j=1; j<22; ++j)
				{
					if ([[[DataManager getInstance] getItemName:j idx2:0] length] > 0)
					{
						--idx;
						if (idx == 0)
						{
							[descView setCenter:CGPointMake(240,160)];
							[descView setAlpha:1];
							[itemImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"item%d.jpg", j]]];
							
							[itemName setText:[[DataManager getInstance] getItemName:j idx2:0]];
							[itemDesc setText:[[DataManager getInstance] getItemName:j idx2:1]];
							return;
						}
					}
				}
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