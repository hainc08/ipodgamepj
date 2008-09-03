#import "MainMenuView.h"
#import "ViewManager.h"

@implementation MainMenuView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//다음뷰로 이동 한다. - 여기는 단순한 화면터치...
}

- (IBAction)ButtonClick:(id)sender
{
	if (sender == Game1PButton)
	{
		[[ViewManager getInstance] changeView:@"GameView1P"];
	}
	else if (sender == Game2PButton)
	{
		[[ViewManager getInstance] changeView:@"GameView2P"];
	}
	else if (sender == HighScoreButton)
	{
		[[ViewManager getInstance] changeView:@"HighScoreView"];
	}
	else if (sender == CreaditButton)
	{
		[[ViewManager getInstance] changeView:@"CreaditView"];
	}	
}

@end
