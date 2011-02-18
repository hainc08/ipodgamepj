#import "MovieBoard.h"
#import "ViewManager.h"

@implementation MovieBoard

@synthesize isPLaying;

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	isPLaying = false;
	sBoard = nil;
	endView = nil;
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	isPLaying = false;
	sBoard = nil;
	endView = nil;
	return self;
}

- (void)playScene:(Scene*)s
{
	curScene = s;

	if ([[ViewManager getInstance] movieMode] == 1)
	{
		isStart = false;
	}
	else
	{
		[self playAnime:[[NSString alloc] initWithFormat:@"%d",[s animeType]]];
	}

	
	isPLaying = true;
}

- (void)stopMovie
{
	if (sBoard != nil)
	{
		[sBoard.view removeFromSuperview];
	}

	if (player != nil)
	{
		[player stop];
		[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
		[player release];
		player = nil;
	}
	
	if (endView != nil)
	{
		[endView removeFromSuperview];
		[endView release];
		endView = nil;
	}

	isPLaying = false;
}

- (void)didFinishPlaying:(NSNotification *)notification {
    if (player == [notification object]) {
		if ([[ViewManager getInstance] movieMode] == 1)
		{
			[endView setShowEnd:true];
		}
		else
		{
			[self stopMovie];
		}
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

- (bool)update
{
	if (([[ViewManager getInstance] movieMode] == 1) && (isStart == false))
	{
		NSArray *windows = [[UIApplication sharedApplication] windows];
		if ([windows count] == 1)
		{
			NSString* aniName = [[NSString alloc] initWithFormat:@"%d",[curScene animeType]];
			[self playAnime:aniName];

			// Locate the movie player window
			UIWindow *moviePlayerWindow = [[UIApplication sharedApplication] keyWindow];
			// Add our overlay view to the movie player's subviews so it is 
			// displayed above it.
			
			if (sBoard == nil)
			{
				sBoard = [[[SerihuBoard alloc] init] retain];
			}

			[sBoard.view setTransform:CGAffineTransformMake(0, 1, -1, 0, 0, 0)];		
			[sBoard.view setCenter:CGPointMake(60, 290)];		
			[sBoard setSerihu:[curScene getChara] serihu:[curScene getSerihu]];
			
			[moviePlayerWindow addSubview:sBoard.view];
			
			endView = (MovieEndView*)[[ViewManager getInstance] getInstView:@"MovieEndView"];
			[moviePlayerWindow addSubview:endView];
			[endView setCenter:CGPointMake(240,160)];
			
			[aniName release];

			isStart = true;
		}
		
		return false;
	}
	
	if (endView == nil) return true;
	return [endView showEnd];
}

@end