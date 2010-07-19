#import "SceneView.h"
#import "ViewManager.h"

@implementation SceneView

@synthesize showEnd;

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	saveView = nil;
	
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	saveView = nil;

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
		waitTick = 20;
		phase = 0;

		[subTitle setAlpha:0];
		[backImg setAlpha:0];
		[backImg2 setAlpha:1];
		[backImg3 setAlpha:0];
		
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

- (IBAction)ButtonClick:(id)sender
{
	if (sender == saveButton)
	{
		if (saveView == nil) saveView = (SaveView*)[[ViewManager getInstance] getInstView:@"SaveView"];
		[saveView reset:nil];
		[self addSubview:saveView];
		[saveView setCenter:CGPointMake(240,160)];
	}
	else if (sender == yesButton)
	{
		phase = 2;
		waitTick = 20;

		[subTitle setAlpha:1];
		[backImg setAlpha:1];
		[backImg2 setAlpha:0];
		[backImg3 setAlpha:0];
	}
	else if (sender == noButton)
	{
		[[ViewManager getInstance] changeView:@"MainTopView"];
	}
}

- (void)update
{
	if (waitTick > 0)
	{
		--waitTick;
	}
	else
	{
		if ( phase == 0)
		{
			//원래 버튼을 눌러야하는건데 일단 제끼고...
			phase = 1;
			
			[subTitle setAlpha:0];
			[backImg setAlpha:0];
			[backImg2 setAlpha:0];
			[backImg3 setAlpha:1];
		}
		else if ( phase == 2)
		{
			showOK = true;
		}
	}
}

@end