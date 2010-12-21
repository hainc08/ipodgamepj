#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "MovieEndView.h"
#import "SerihuBoard.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MovieBoard : UIView {
	MPMoviePlayerController *player;
	MovieEndView* endView;
	SerihuBoard* sBoard;
	bool isPLaying;
}

@property (readonly) bool isPLaying;

- (void)playScene:(Scene*)s;
- (void)stopMovie;
- (IBAction)playAnime:(NSString*)name;
- (void)playVideoWithURL:(NSURL *)url showControls:(BOOL)showControls;
- (void)didFinishPlaying:(NSNotification *)notification;
- (bool)update;
			
@end
