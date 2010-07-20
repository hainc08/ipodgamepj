#import "EndView.h"
#import "ViewManager.h"

@implementation EndParam

@synthesize endNum;

@end

@implementation EndView

@synthesize player;

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];

	return self;
}

- (void)playVideoWithURL:(NSURL *)url showControls:(BOOL)showControls {
    if (!player) {
        player = [[MPMoviePlayerController alloc] initWithContentURL:url];
		
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishPlaying:) name:MPMoviePlayerPlaybackDidFinishNotification object:player];
		
        if (!showControls) {
            player.scalingMode = MPMovieScalingModeAspectFill;
            player.movieControlMode = MPMovieControlModeHidden;
        }
		
        [player play];
    }
}

- (IBAction)playAnime:(NSString*)name {
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:name ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:moviePath];
	
    [self playVideoWithURL:url showControls:NO];
}

- (void)reset:(NSObject*)param
{
	[super reset:param];
	
	if (isInit == false)
	{
		isInit = true;
	}

	EndParam* p = (EndParam*)param;
	int endNum = [p endNum];
	if (endNum > 100)
	{
		//엔딩처리...
	}
	else
	{
		if (endNum == 1)
		{
			[self playAnime:@"edA_1"];
		}
		else if (endNum == 2)
		{
			[self playAnime:@"edA_2"];
		}
		
		NSArray *windows = [[UIApplication sharedApplication] windows];
		if ([windows count] > 1)
		{
			// Locate the movie player window
			UIWindow *moviePlayerWindow = [[UIApplication sharedApplication] keyWindow];
			// Add our overlay view to the movie player's subviews so it is 
			// displayed above it.
			
			endView = (MovieEndView*)[[ViewManager getInstance] getInstView:@"MovieEndView"];
			[moviePlayerWindow addSubview:endView];
			[endView setCenter:CGPointMake(240,160)];
		}
	}
	
	//힘들게 만들었는데 10초는 봐라 좀...
	coolTime = 10 * framePerSec;
}

- (void)dealloc {
	[super dealloc];	
}

- (void)didFinishPlaying:(NSNotification *)notification {
    if (player == [notification object]) {   
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
        [player release];
        player = nil;

		[[ViewManager getInstance] changeView:@"MainTopView"];
    }
}

/* Base 사운드 제공 해야 함 */
- (void)update
{
	if (coolTime > 0) --coolTime;
	else
	{
		if ([endView showEnd])
		{
			[player stop];
		}
	}
	
	[super update];
}

@end