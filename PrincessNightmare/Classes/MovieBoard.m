#import "MovieBoard.h"
#import "ViewManager.h"
#import "SerihuBoard.h"

@implementation MovieBoard

@synthesize isPLaying;

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	isPLaying = false;
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	isPLaying = false;
	return self;
}

- (void)playScene:(Scene*)s
{
	[self playAnime:[[NSString alloc] initWithFormat:@"%d",[s animeType]]];

	if ([[ViewManager getInstance] movieMode] == 1)
	{
		NSArray *windows = [[UIApplication sharedApplication] windows];
		if ([windows count] > 1)
		{
			// Locate the movie player window
			UIWindow *moviePlayerWindow = [[UIApplication sharedApplication] keyWindow];
			// Add our overlay view to the movie player's subviews so it is 
			// displayed above it.

			SerihuBoard* sBoard = (SerihuBoard*)[[ViewManager getInstance] getInstView:@"SerihuBoard"];
			[sBoard setTransform:CGAffineTransformMake(0, 1, -1, 0, 0, 0)];		
			[sBoard setCenter:CGPointMake(60, 290)];		
			[sBoard setSerihu:[s getChara] serihu:[s getSerihu]];
			 
			[moviePlayerWindow addSubview:sBoard];
			
			endView = (MovieEndView*)[[ViewManager getInstance] getInstView:@"MovieEndView"];
			[moviePlayerWindow addSubview:endView];
			[endView setCenter:CGPointMake(240,160)];
		}
	}
	
	isPLaying = true;
}

- (void)stopMovie
{
	[player stop];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
	[player release];
	player = nil;

	isPLaying = false;
}

- (void)didFinishPlaying:(NSNotification *)notification {
    if (player == [notification object]) {   
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
        [player release];
        player = nil;
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
	return [endView showEnd];
}

@end