#import "GameLogoView.h"
#import "ViewManager.h"

@implementation GameLogoView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ( step == 1 ) step=2;
}

- (void)reset;
{
	[super reset];
	[logoImg setAlpha:0.f];
	step = 0;
}

- (void)update;
{
	[super update];
	
	switch (step)
	{
		case 0:
			alpha = 0.f;
			if (frameTick > 5) step = 1;
			break;
		case 1:
			alpha += 0.1f;
			if (alpha > 1.0f) alpha = 1.0f;
			break;
		case 2:
			alpha -= 0.1f;
			if (alpha <= 0.f) step = 3;
			break;
		case 3:
			//다음뷰로 이동 한다.
			[[ViewManager getInstance] changeView:@"MainMenuView"];
			break;
	}
	
	[logoImg setAlpha:alpha];
}

@end
