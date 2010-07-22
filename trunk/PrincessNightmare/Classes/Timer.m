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
	leftTime = maxTime = t * 10;
	
	[sandUpMask setFrame:CGRectMake(15, 26, 50, 35)];
	[sandUp setCenter:CGPointMake(16, 17)];

	[sandDownMask setFrame:CGRectMake(15, 67 + 35, 50, 0)];
	[sandDown setCenter:CGPointMake(16, 17 - 35)];

	[timerBase setAlpha:1];
	[timeOver setAlpha:0];
}

- (bool)update
{
	if (maxTime == 0) return true;

	--leftTime;
	
	int del = (int)(35.f * leftTime / maxTime);

	[sandUpMask setFrame:CGRectMake(15, 26 + (35 - del), 50, 35 - (35 - del))];
	[sandUp setCenter:CGPointMake(16, 17 - (35 - del))];
	
	[sandDownMask setFrame:CGRectMake(15, 67 + del, 50, 35 - del)];
	[sandDown setCenter:CGPointMake(16, 17 - del)];
	
	if (leftTime == 0)
	{
		[UIView beginAnimations:@"timerHide" context:NULL];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		[UIView setAnimationDelay:0.7];
		
		[self setAlpha:0];
		
		[UIView commitAnimations];

		[timerBase setAlpha:0];
		[timeOver setAlpha:1];
		
		maxTime = 0;
		return false;
	}

	return true;
}

- (void)stop
{
	[self setAlpha:0];
	maxTime = 0;
}

@end