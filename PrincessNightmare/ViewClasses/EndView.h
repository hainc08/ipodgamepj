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
	bool showEnd;

	IBOutlet id bad_end_View;
	IBOutlet id bad_end_img1;
	IBOutlet id bad_end_img2;
	IBOutlet id bad_end_img3;
	IBOutlet id bad_end_img4;

	IBOutlet id bad_base;
	
	MovieEndView* endView;
}

@property (nonatomic, retain) MPMoviePlayerController *player;

@end
