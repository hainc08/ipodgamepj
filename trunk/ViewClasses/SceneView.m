#import "SceneView.h"
#import "ViewManager.h"

@implementation SceneView

@synthesize showEnd;

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];

	return self;
}

- (void)reset:(NSObject*)param
{

}

- (bool)makeScene:(Scene*)scene
{
	if ([scene subTitleIdx] != -1)
	{
		[subTitle setImage:[UIImage imageNamed:[NSString stringWithFormat:@"subtitle_%d.png", [scene subTitleIdx]]]];
		showOK = false;
		showEnd = false;
		waitTick = 5;
		return true;
	}

	return false;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ( showOK )
	{
		showEnd = true;
	}
}

- (void)update
{
	if (waitTick > 0)
	{
		showOK = true;
		--waitTick;
	}
}

@end