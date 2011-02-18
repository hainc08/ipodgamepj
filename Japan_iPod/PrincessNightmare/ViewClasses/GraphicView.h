#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "DataManager.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MovieEndView.h"

@interface GraphicView : BaseView {
	MPMoviePlayerController *player;

	IBOutlet id backButton;
	IBOutlet id nextButton;
	IBOutlet id prevButton;

	IBOutlet UILabel* pageLabel;

	UIButton* imageButton[12];
	UIButton* imageBigButton;
	
	int curPage;

	EventList* eList;
	UIImage* baseImg;

	MovieEndView* endView;
}

- (IBAction)ButtonClick:(id)sender;
- (void)loadPage:(int)page;
- (IBAction)playAnime:(NSString*)name;
- (void)playVideoWithURL:(NSURL *)url showControls:(BOOL)showControls;

@end
