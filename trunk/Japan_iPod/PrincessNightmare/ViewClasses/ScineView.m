#import "ScineView.h"
#import "ViewManager.h"
#import "SaveManager.h"
#import "GameView.h"
#import "SoundManager.h"

@implementation ScineParam

@synthesize replayIdx;

@end


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
		baseImg[0] = [UIImage imageNamed:@"scine-expbox.png"];
		baseImg[1] = [UIImage imageNamed:@"scine-msgbox.png"];

		for (int i=0; i<10; ++i)
		{
			imageButton[i] = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 194, 27)];
			[self addSubview:imageButton[i]];
			[imageButton[i] setImage:baseImg[1] forState:UIControlStateNormal];
			[imageButton[i] setCenter:CGPointMake((i / 5) * 216 + 35 + 97, (i % 5) * 38 + 90)];
			[imageButton[i] addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
			
			buttonLabel[i] = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 194, 27)];
			[self addSubview:buttonLabel[i]];
			[buttonLabel[i] setCenter:CGPointMake((i / 5) * 216 + 35 + 97, (i % 5) * 38 + 90)];
			[buttonLabel[i] setTextColor:[UIColor blackColor]];
			[buttonLabel[i] setFont:[UIFont fontWithName:@"Helvetica" size:10]];
			[buttonLabel[i] setBackgroundColor:[UIColor clearColor]];
			[buttonLabel[i] setTextAlignment:UITextAlignmentCenter]; 
			[buttonLabel[i] setNumberOfLines:2];
		}
		
		imageBigButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 480, 360)];
		[self addSubview:imageBigButton];
		[self bringSubviewToFront:imageBigButton];
		[imageBigButton setCenter:CGPointMake(240, 160)];
		[imageBigButton addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
		[imageBigButton setAlpha:0];

		isInit = true;
	}
	
	int page = 1;
	
	if (param != NULL)
	{
		ScineParam* sparam = (ScineParam*)param;
		page = ([sparam replayIdx] - 1) / 10 + 1;
	}

	[[SaveManager getInstance] loadExtraFile];
	[self loadPage:page];
}

- (void)loadPage:(int)page
{
	curPage = page;

	[pageLabel setText:[NSString stringWithFormat:@"%d / 13", curPage]];

	if (curPage == 1) [prevButton setAlpha:0];
	else [prevButton setAlpha:1];

	if (curPage == 13) [nextButton setAlpha:0];
	else [nextButton setAlpha:1];

	for (int i=0; i<10; ++i)
	{
		int idx = (curPage-1) * 10 + i + 1;
		if (idx > 127)
		{
			[buttonLabel[i] setAlpha:0];
			[imageButton[i] setAlpha:0];
		}
		else
		{
			if ([[SaveManager getInstance] getSceneExp:idx])
			{
				[buttonLabel[i] setText:[[[DataManager getInstance] getScenario:idx] getStrVal]];
				[buttonLabel[i] setAlpha:1];
				[imageButton[i] setAlpha:1];
				[imageButton[i] setImage:baseImg[1] forState:UIControlStateNormal];
			}
			else
			{
				[buttonLabel[i] setAlpha:0];
				[imageButton[i] setAlpha:1];
				[imageButton[i] setImage:baseImg[0] forState:UIControlStateNormal];
			}
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
		for (int i=0; i<10; ++i)
		{
			if (sender == imageButton[i])
			{
				int idx = (curPage-1) * 10 + i + 1;

				if ([[SaveManager getInstance] getSceneExp:idx])
				{
					Scenario* scenario = [[DataManager getInstance] getScenario:idx];
					
					GameParam* param = [GameParam alloc];
					[param setStartScene:[scenario startIdx]];
					[param setEndScene:[scenario endIdx]];
					[param setIsReplay:true];
					[param setReplayIdx:idx];
					
					[[ViewManager getInstance] changeView:@"GameView" param:param];
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