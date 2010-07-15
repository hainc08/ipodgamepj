#import "ItemView.h"
#import "ViewManager.h"
#import "SaveManager.h"

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
	}
	
	[[SaveManager getInstance] loadExtraFile];
	[self loadPage:1];
}

- (void)loadPage:(int)page
{
	curPage = page;
	if (curPage == 1) [prevButton setAlpha:0];
	else [prevButton setAlpha:1];

	if (curPage == 2) [nextButton setAlpha:0];
	else [nextButton setAlpha:1];
	
	for (int i=0; i<15; ++i)
	{
		int idx = (curPage-1) * 15 + i + 1;
		if (idx > 19)
		{
			[imageButton[i] setAlpha:0];
		}
		else
		{
			UIImage* baseImg = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg", idx]];
			[imageButton[i] setImage:baseImg forState:UIControlStateNormal];
			[imageButton[i] setAlpha:1];
		}
	}
}

- (IBAction)ButtonClick:(id)sender
{	
	if (sender == backButton)
	{
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