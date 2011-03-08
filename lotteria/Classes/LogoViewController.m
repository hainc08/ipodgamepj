#import "LogoViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kAnimationDuration  0.25

@implementation LogoViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	isNoticeCheck = false;

	CALayer *viewLayer = noticeView.layer;
    CAKeyframeAnimation* popInAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    popInAnimation.duration = kAnimationDuration;
    popInAnimation.values = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.6],
                             [NSNumber numberWithFloat:1.1],
							 [NSNumber numberWithFloat:.9],
							 [NSNumber numberWithFloat:1],
                             nil];
    popInAnimation.keyTimes = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0],
                               [NSNumber numberWithFloat:1.0],
							   [NSNumber numberWithFloat:1.1],
							   [NSNumber numberWithFloat:1.2],
                               nil];    
    popInAnimation.delegate = nil;
    
    [viewLayer addAnimation:popInAnimation forKey:@"transform.scale"];  

    CAKeyframeAnimation* fadeInAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    
    fadeInAnimation.duration = kAnimationDuration;
    fadeInAnimation.values = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.0],
							 [NSNumber numberWithFloat:1],
                             nil];
    fadeInAnimation.keyTimes = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0],
							   [NSNumber numberWithFloat:1],
                               nil];    
    fadeInAnimation.delegate = nil;
    
    [viewLayer addAnimation:fadeInAnimation forKey:@"opacity"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (isNoticeCheck)
	{
		[self.view setAlpha:0];
	}
}

- (IBAction)buttonClick
{
	[UIView beginAnimations:@"logoAni" context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	
	[noticeView setAlpha:0.f];
	[noticeView setTransform:CGAffineTransformMake(0.5, 0, 0, 0.5, 0, 0)];
	
	[UIView commitAnimations];
		
	isNoticeCheck = true;
}

@end
