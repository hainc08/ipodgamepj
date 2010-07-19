#import "MovieEndView.h"

@implementation MovieEndView

@synthesize showEnd;

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	showEnd = false;
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	showEnd = false;
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	showEnd = true;
}

@end