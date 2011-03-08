#import "LogoViewController.h"

@implementation LogoViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	isNoticeCheck = false;
	
	[noticeView setAlpha:0.f];
	[noticeView setTransform:CGAffineTransformMake(1, 0, 0, 1, 0.5, 0.5)];
	
	[UIView beginAnimations:@"logoAni" context:NULL];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDelay:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	
	[noticeView setAlpha:1.f];
	[noticeView setTransform:CGAffineTransformMake(1, 0, 0, 1, 1, 1)];
	
	[UIView commitAnimations];
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
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	
	[noticeView setAlpha:0.f];
	[noticeView setTransform:CGAffineTransformMake(1, 0, 0, 1, 0.5, 0.5)];
	
	[UIView commitAnimations];
		
	isNoticeCheck = true;
}

@end
