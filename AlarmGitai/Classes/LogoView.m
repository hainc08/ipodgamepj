#import "LogoView.h"

@implementation LogoView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[UIView beginAnimations:@"anime2" context:NULL];
	[UIView setAnimationDuration:1.5];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[self setAlpha:0];
	[UIView commitAnimations];
}

- (void)viewDidLoad
{

}

- (void)dealloc
{
	[super dealloc];
}

@end
