#import "SceneView.h"
#import "ViewManager.h"
#import "SoundManager.h"

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

- (bool)makeAfterScene:(Scene*)scene
{
	if ([scene nextChapter] != -1)
	{
		[subTitle2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"subtitle_%d.png", [scene subTitleIdx]]]];
		showOK = false;
		showEnd = false;
		waitTick = 20;
		phase = 0;
		
		[subTitle setAlpha:0];
		[subTitle2 setAlpha:1];
		[backImg setAlpha:0];
		[backImg2 setAlpha:1];
		[backImg3 setAlpha:0];
		
		return true;
	}
	
	return false;
}

- (bool)makeBeforeScene:(Scene*)scene
{
	if (([scene subTitleIdx] != -1)&&([scene serihuIdx] == 0))
	{		
		[subTitle setImage:[UIImage imageNamed:[NSString stringWithFormat:@"subtitle_%d.png", [scene subTitleIdx]]]];
		showOK = false;
		showEnd = false;
		waitTick = 20;
		phase = 2;

		[subTitle setAlpha:1];
		[subTitle2 setAlpha:0];
		[backImg setAlpha:1];
		[backImg2 setAlpha:0];
		[backImg3 setAlpha:0];
		
		return true;
	}

	return false;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ( showOK )
	{
		[UIView beginAnimations:@"scene" context:NULL];
		[UIView setAnimationDuration:1];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		[self setAlpha:0];
		[UIView commitAnimations];

		phase = 3;
		waitTick = 0;
	}
}

- (IBAction)ButtonClick:(id)sender
{
	if (sender == saveButton)
	{
		if (saveView == nil)
		{
			saveView = (SaveView*)[[ViewManager getInstance] getInstView:@"SaveView"];
			[saveView setCenter:CGPointMake(240,160)];
			[self addSubview:saveView];
		}
		[saveView reset:nil];
		[saveView setAlpha:1];
	}
	else if (sender == yesButton)
	{
		showEnd = true;
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
			phase = 1;
			
			[subTitle setAlpha:0];
			[subTitle2 setAlpha:0];
			[backImg setAlpha:0];
			[backImg2 setAlpha:0];
			[backImg3 setAlpha:1];
		}
		else if ( phase == 2)
		{
			showOK = true;
		}
		else if ( phase == 3)
		{
			showEnd = true;
		}
	}
}

@end