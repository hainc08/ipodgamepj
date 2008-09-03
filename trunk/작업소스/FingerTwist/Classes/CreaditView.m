#import "CreaditView.h"
#import "ViewManager.h"

@implementation CreaditView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//여기는 단순한 화면터치...
}

- (IBAction)ButtonClick:(id)sender
{
	if (sender == MainMenuButton)
	{
		[[ViewManager getInstance] changeView:@"MainMenuView"];
	}
}

@end
