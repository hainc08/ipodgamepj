#import "GraphicView.h"
#import "ViewManager.h"
#import "SaveManager.h"
#import "SoundManager.h"

@implementation GraphicView

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
		baseImg = [UIImage imageNamed:@"noimage.jpg"];
		
		for (int i=0; i<12; ++i)
		{
			imageButton[i] = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 75, 56)];
			[self addSubview:imageButton[i]];
			[imageButton[i] setImage:baseImg forState:UIControlStateNormal];
			[imageButton[i] setCenter:CGPointMake((i % 4) * 100 + 90, (i / 4) * 65 + 95)];
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
	[self loadPage:1];
}

- (void)loadPage:(int)page
{
	curPage = page;
	if (curPage == 1) [prevButton setAlpha:0];
	else [prevButton setAlpha:1];

	if (curPage == 14) [nextButton setAlpha:0];
	else [nextButton setAlpha:1];
	
	eList = [[DataManager getInstance] getEventList:page];

	for (int i=0; i<12; ++i)
	{
		if ( i < [eList valCount])
		{
			UIImage* tempImg;

			if ([eList getIsShow:i])
			{
				int imgId = [eList getIntVal:i];
				
				if (imgId < 10)
					tempImg = [UIImage imageNamed:[NSString stringWithFormat:@"ev_00%ds.jpg", imgId]];
				else if (imgId < 100)
					tempImg = [UIImage imageNamed:[NSString stringWithFormat:@"ev_0%ds.jpg", imgId]];
				else
					tempImg = [UIImage imageNamed:[NSString stringWithFormat:@"ev_%ds.jpg", imgId]];
			}
			else
			{
				tempImg = baseImg;
			}

			[imageButton[i] setAlpha:1];
			[imageButton[i] setImage:tempImg forState:UIControlStateNormal];
		}
		else
		{
			[imageButton[i] setAlpha:0];
		}
	}
}

- (IBAction)ButtonClick:(id)sender
{	
	if (sender == backButton)
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
		for (int i=0; i<12; ++i)
		{
			if (sender == imageButton[i])
			{
				if ([eList getIsShow:i] == false) return;

				UIImage* tempImg;
				
				int imgId = [eList getIntVal:i];
				
				if (imgId < 10)
					tempImg = [UIImage imageNamed:[NSString stringWithFormat:@"Aev_00%d.jpg", imgId]];
				else if (imgId < 100)
					tempImg = [UIImage imageNamed:[NSString stringWithFormat:@"Aev_0%d.jpg", imgId]];
				else
					tempImg = [UIImage imageNamed:[NSString stringWithFormat:@"Aev_%d.jpg", imgId]];
				
				[imageBigButton setImage:tempImg forState:UIControlStateNormal];
				[imageBigButton setAlpha:1];
				
				return;
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