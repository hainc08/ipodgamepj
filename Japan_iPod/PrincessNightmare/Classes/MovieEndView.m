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

//		sBoard = (SerihuBoard*)[[ViewManager getInstance] getInstView:@"SerihuBoard"];
//		[sBoard setCenter:CGPointMake(290, 320 - 60)];
//		[movieView addSubview:sBoard];
//		[movieView setAlpha:0];

@end