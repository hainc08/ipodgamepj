#import "MainMenuView.h"
#import "ViewManager.h"
#import "GameView1P.h"
#import "GameView2P.h"

@implementation MainMenuView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//다음뷰로 이동 한다. - 여기는 단순한 화면터치...
}

- (IBAction)ButtonClick:(id)sender
{
	if (sender == Game1PButton)
	{
		Game1PParam* param = [Game1PParam alloc];
		param->stageNumber = 1;
		param->pointCount = 1;
		param->difficult = 0;
		[[ViewManager getInstance] changeView:@"GameView1P" param:param];
	}
	else if (sender == Game2PButton)
	{
		Game2PParam* param = [Game2PParam alloc];
		[[ViewManager getInstance] changeView:@"GameView2P" param:param];
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
