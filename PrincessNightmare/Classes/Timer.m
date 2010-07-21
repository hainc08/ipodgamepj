#import "Timer.h"

@implementation Timer

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];

	return self;
}

- (void)startTimer:(float)t
{
	[sandUpMask setFrame:CGRectMake(15, 26, 50, 35)];
	[sandUp setCenter:CGPointMake(16, 17)];

	[sandDownMask setFrame:CGRectMake(15, 67 + 35, 50, 0)];
	[sandDown setCenter:CGPointMake(16, 17 - 35)];

	[UIView beginAnimations:@"bad_end" context:NULL];
	[UIView setAnimationDuration:t];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDelay:4];
	
	[sandUpMask setFrame:CGRectMake(15, 26 + 35, 50, 0)];
	[sandUp setCenter:CGPointMake(16, 17 - 35)];
	
	[sandDownMask setFrame:CGRectMake(15, 67, 50, 35)];
	[sandDown setCenter:CGPointMake(16, 17)];
	
	[UIView commitAnimations];
}

@end