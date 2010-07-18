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
	[descView setAlpha:0];
	[self bringSubviewToFront:descView];
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
		//		if ((idx > 19) || ([[SaveManager getInstance] getFlag:500+idx] == false))
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
	if (sender == closeButton)
	{
		[descView setAlpha:0];
	}
	else if (sender == backButton)
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
		for (int i=0; i<15; ++i)
		{
			if (sender == imageButton[i])
			{
				int idx = (curPage - 1) * 15 + i + 1;
				[descView setCenter:CGPointMake(240,160)];
				[descView setAlpha:1];
				[itemImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg", idx]]];
				
				//이건 왜 건너띄게 스크립트를 만들어서...짱나...
				if (idx == 19) idx = 22;
				[itemName setText:[[DataManager getInstance] getItemName:idx idx2:0]];
				[itemDesc setText:[[DataManager getInstance] getItemName:idx idx2:1]];
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