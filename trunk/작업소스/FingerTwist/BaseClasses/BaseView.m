#import "BaseView.h"

@implementation BaseView

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	frameTick = 0;
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	return self;
}

- (void)reset:(NSObject*)param
{
	[self resumeTimer];
	frameTick = 0;
}

- (void)update
{
	++frameTick;
}

- (void)stopTimer
{
	[updateTimer invalidate]; 
	[updateTimer release]; 
}

- (void)resumeTimer
{
	updateTimer = [[NSTimer scheduledTimerWithTimeInterval: (1.0f/10.0f)
													target: self
												  selector: @selector(update)
												  userInfo: self
												   repeats: YES] retain];	
}

- (void)dealloc {
	[super dealloc];	
}

@end
