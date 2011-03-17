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
		
		for (int i=0; i<4; ++i)
		{
			imageBigButton[i] = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 480, 360)];
			[self addSubview:imageBigButton[i]];
			[self bringSubviewToFront:imageBigButton[i]];
			[imageBigButton[i] setCenter:CGPointMake(240, 160)];
			[imageBigButton[i] addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
			[imageBigButton[i] setAlpha:0];
		}
			
		isInit = true;
	}
	
	[[SaveManager getInstance] loadExtraFile];
	[self loadPage:1];
	showCount = 0;
}

- (void)loadPage:(int)page
{
	curPage = page;

	[pageLabel setText:[NSString stringWithFormat:@"%d / 11", curPage]];

	if (curPage == 1) [prevButton setAlpha:0];
	else [prevButton setAlpha:1];

	if (curPage == 11) [nextButton setAlpha:0];
	else [nextButton setAlpha:1];
	
	for (int i=0; i<12; ++i)
	{
		int idx = ((curPage - 1) * 12 + i + 1);
		if ( idx < EVENTCOUNT )
		{
			EventList* data = [[DataManager getInstance] getEventList:idx];
			if ([data valCount] == 0)
			{
				[imageButton[i] setAlpha:0];
				continue;
			}

			UIImage* tempImg;

			for (int j=0; j<[data valCount]; ++j)
			{
				if ([data getIsShow:j])
				{
					int imgId = [data getIntVal:j];
					tempImg = [UIImage imageNamed:[NSString stringWithFormat:@"ev_%03ds.jpg", imgId]];
					goto FINDIMG;
				}
			}

			tempImg = baseImg;
		FINDIMG:

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
	else
	{
		for (int i=0; i<4; ++i)
		{
			if (sender == imageBigButton[i])
			{
				if ([self ShowImg:nowIdx] == false)
				{
					--showCount;
					[imageBigButton[0] setAlpha:0];
					[imageBigButton[1] setAlpha:0];
					[imageBigButton[2] setAlpha:0];
					[imageBigButton[3] setAlpha:0];
					
					[imageBigButton[showCount] setAlpha:1];
					
					[UIView beginAnimations:@"scene" context:NULL];
					[UIView setAnimationDuration:0.5];
					[UIView setAnimationCurve:UIViewAnimationCurveLinear];
					[imageBigButton[showCount] setAlpha:0];
					[UIView commitAnimations];
					showCount = 0;
				}
			}
		}

		for (int i=0; i<12; ++i)
		{
			if (sender == imageButton[i])
			{
				nowIdx = ((curPage - 1) * 12 + i + 1);
				[self ShowImg:nowIdx];
				return;
			}
		}
	}
}

- (bool) ShowImg:(int)idx
{
	EventList* data = [[DataManager getInstance] getEventList:idx];

	for (int j=showCount; j<[data valCount]; ++j)
	{
		if ([data getIsShow:j])
		{
			int imgId = [data getIntVal:j];
			UIImage* tempImg;
			
			if (imgId >= 400)
			{
				[[SoundManager getInstance] stopBGM];
				[self playAnime:[NSString stringWithFormat:@"%d", imgId]];
				
				endView = (MovieEndView*)[[ViewManager getInstance] getInstView:@"MovieEndView"];
				
				NSArray *windows = [[UIApplication sharedApplication] windows];
				if ([windows count] > 1)
				{
					// Locate the movie player window
					UIWindow *moviePlayerWindow = [[UIApplication sharedApplication] keyWindow];
					// Add our overlay view to the movie player's subviews so it is 
					// displayed above it.
					
					[moviePlayerWindow addSubview:endView];
					[endView setCenter:CGPointMake(240,160)];
				}
				else
				{
					[self addSubview:endView];
					[endView setCenter:CGPointMake(240,160)];
				}
			}
			else
			{
				tempImg = [UIImage imageNamed:[NSString stringWithFormat:@"Aev_%03d.jpg", imgId]];

				[imageBigButton[j] setFrame:CGRectMake(0, 0, [tempImg size].width, [tempImg size].height)];
				[imageBigButton[j] setImage:tempImg forState:UIControlStateNormal];
				[imageBigButton[j] setImage:tempImg forState:UIControlStateHighlighted];
				[imageBigButton[j] setImage:tempImg forState:UIControlStateSelected];
				[self bringSubviewToFront:imageBigButton[j]];
				
				if ([tempImg size].height > 500)
				{
					[imageBigButton[j] setAlpha:1];

					[UIView beginAnimations:@"scene" context:NULL];
					[UIView setAnimationDuration:5];
					[UIView setAnimationCurve:UIViewAnimationCurveLinear];
					[imageBigButton[j] setCenter:CGPointMake(240, 340 - (int)([tempImg size].height / 2))];
					[UIView commitAnimations];
				}
				else
				{
					[imageBigButton[j] setAlpha:0];

					if ((imgId >= 123)&&(imgId <= 125))
					{
						[imageBigButton[j] setCenter:CGPointMake(240, 180)];
					}
					else
					{
						[imageBigButton[j] setCenter:CGPointMake(240, 160)];
					}
					
					[UIView beginAnimations:@"scene" context:NULL];
					[UIView setAnimationDuration:0.5];
					[UIView setAnimationCurve:UIViewAnimationCurveLinear];
					[imageBigButton[j] setAlpha:1];
					[UIView commitAnimations];
				}
			}
			
			[self bringSubviewToFront:button1];
			[self bringSubviewToFront:button2];
			
			++showCount;
			return true;
		}
	}
	
	return false;
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

	if ([endView showEnd])
	{
		[player stop];
		showCount = 0;
	}
}

- (void)didFinishPlaying:(NSNotification *)notification {
    if (player == [notification object]) {   
		if ([[ViewManager getInstance] movieMode] == 2)
		{
			[player.view removeFromSuperview];
		}

        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
        [player release];
        player = nil;

		[endView removeFromSuperview];
		endView = nil;

		[[SoundManager getInstance] playBGM:@"Abgm_10-1.mp3" idx:10];
    }
}

- (IBAction)playAnime:(NSString*)name {
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:name ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:moviePath];
	
    [self playVideoWithURL:url showControls:NO];
}

- (void)playVideoWithURL:(NSURL *)url showControls:(BOOL)showControls {
    if (!player) {
        player = [[MPMoviePlayerController alloc] initWithContentURL:url];
		
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishPlaying:) name:MPMoviePlayerPlaybackDidFinishNotification object:player];

		if ([player respondsToSelector:@selector(view)])
		{
			player.controlStyle = MPMovieControlStyleFullscreen;
			[player.view setFrame:self.bounds];
			[self addSubview:player.view];
		}
		
        if (!showControls) {
            player.scalingMode = MPMovieScalingModeAspectFill;
            player.movieControlMode = MPMovieControlModeHidden;
        }
		
        [player play];
    }
}

@end