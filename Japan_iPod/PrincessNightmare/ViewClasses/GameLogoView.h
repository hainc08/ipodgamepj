#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "BaseView.h"
#import "MovieEndView.h"

@interface GameLogoView : BaseView {
    MPMoviePlayerController *player;

	IBOutlet id k;
	IBOutlet id a;
	IBOutlet id r;
	IBOutlet id i;
	IBOutlet id n;
	IBOutlet id base;
	IBOutlet id outline;
	IBOutlet id underChar;
	IBOutlet id enter;
	IBOutlet id shadow;
	IBOutlet id leaf;
	IBOutlet id flower;

	IBOutlet id background;
	
	id sprite[12];
	CGPoint originPos[12];
	CGPoint startPos[12];
	float delay[12];
	float life[12];
	float alpha[12];
	bool isMove[12];

	int step;
	int maxDelay;

	MovieEndView* endView;
}
@property (nonatomic, retain) MPMoviePlayerController *player;

- (IBAction)playAnime:(NSString*)name;
- (void)playVideoWithURL:(NSURL *)url showControls:(BOOL)showControls;
- (void)makeAni:(int)idx offset:(CGPoint)off delay:(float)d life:(float)l alpha:(float)al;

@end

