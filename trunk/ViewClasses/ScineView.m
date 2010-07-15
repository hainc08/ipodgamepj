#import "ScineView.h"
#import "ViewManager.h"
#import "SaveManager.h"

@implementation ScineView

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
		baseImg[0] = [[UIImage imageNamed:@"scine-expbox.png"] autorelease];
		baseImg[1] = [[UIImage imageNamed:@"scine-msgbox.png"] autorelease];
		
		for (int i=0; i<10; ++i)
		{
			imageButton[i] = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 194, 27)];
			[self addSubview:imageButton[i]];
			[imageButton[i] setImage:baseImg[0] forState:UIControlStateNormal];
			[imageButton[i] setCenter:CGPointMake((i / 5) * 216 + 35 + 97, (i % 5) * 38 + 90)];
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

	if (curPage == 13) [nextButton setAlpha:0];
	else [nextButton setAlpha:1];
	
	for (int i=0; i<10; ++i)
	{
		int idx = (curPage-1) * 10 + i + 1;
		if (idx > 127)
		{
			[imageButton[i] setAlpha:0];
		}
		else
		{
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
		for (int i=0; i<10; ++i)
		{
			if (sender == imageButton[i])
			{

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