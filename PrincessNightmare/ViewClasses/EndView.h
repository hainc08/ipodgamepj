#import <UIKit/UIKit.h>
#import "BaseView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MovieEndView.h"

@interface EndParam : NSObject {
	int endNum;
}

@property (readwrite) int endNum;

@end

@interface EndView : BaseView {
	MPMoviePlayerController *player;
	int coolTime;

	MovieEndView* endView;
}

@property (nonatomic, retain) MPMoviePlayerController *player;

@end
