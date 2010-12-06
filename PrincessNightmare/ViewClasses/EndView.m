#import "EndView.h"
#import "ViewManager.h"
#import "DataManager.h"
#import "SoundManager.h"

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

- (IBAction)playAnime:(NSString*)name {
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:name ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:moviePath];
	
    [self playVideoWithURL:url showControls:NO];
}

- (void)reset:(NSObject*)param
{
	[super reset:param];
	showEnd = false;
	
	if (isInit == false)
	{
		isInit = true;
	}

	EndParam* p = (EndParam*)param;
	int endNum = [p endNum];
	if (endNum > 100)
	{
		[[SoundManager getInstance] playFX:@"009_jg.mp3" repeat:false];

		//엔딩처리...
		[bad_end_View setAlpha:1];
		Scene* scene = [[DataManager getInstance] getCurScene];
		UIImage* img = [[[UIImage alloc] initWithData:[scene getBgData]] autorelease];
		[bad_base setImage:img];
		
		[bad_end_img1 setAlpha:0];
		[bad_end_img2 setCenter:CGPointMake(240,-50)];
		[bad_end_img3 setCenter:CGPointMake(240,370)];
		[bad_end_img4 setAlpha:0];
		[bad_end_img4 setTransform:CGAffineTransformMake(2.f, 0.f, 0.f, 0.1f, 0.f, 0.f)];
		
		[UIView beginAnimations:@"bad_end" context:NULL];
		[UIView setAnimationDuration:3];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		[UIView setAnimationDelay:1.5];
		
		[bad_end_img1 setAlpha:1];
		[bad_end_img2 setCenter:CGPointMake(240,200)];
		[bad_end_img3 setCenter:CGPointMake(240,100)];
		[bad_end_img4 setAlpha:1];
		[bad_end_img4 setTransform:CGAffineTransformMake(1.f, 0.f, 0.f, 1.f, 0.f, 0.f)];

		[UIView commitAnimations];

		//여기는 4초만 봐~
		coolTime = 4 * framePerSec;
	}
	else
	{
		[bad_end_View setAlpha:0];
		if (endNum == 1)
		{
			[self playAnime:@"edA_1"];
		}
		else if (endNum == 2)
		{
			[self playAnime:@"edA_2"];
		}
		
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
		
		//힘들게 만들었는데 10초는 봐라 좀...
		coolTime = 10 * framePerSec;
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (showEnd)
	{
		[[ViewManager getInstance] changeView:@"MainTopView"];
	}
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
		showEnd = true;

		if (player != nil)
		{
			if ([endView showEnd])
			{
				[player stop];
			}
		}
	}
	
	[super update];
}

@end