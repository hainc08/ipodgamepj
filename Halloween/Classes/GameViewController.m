#import "GameViewController.h"
#import "Ghost.h"

@implementation GameViewController

- (id)init
{
	self = [super init];
	backView = NULL;
	return self;
}

- (void)reset:(NSObject*)param
{
	if (backView == NULL)
	{
		backView = [[BackViewController alloc] init];
		[self.view addSubview:backView.view];
	}

	[backView reset];
	[self.view sendSubviewToBack:backView.view];
	
	Ghost* test = [[Ghost alloc] init];
	[self.view addSubview:test.view];
	[test.view setCenter:CGPointMake(50, 270)];
	[test.view setTransform:halfForm];
}

@end
