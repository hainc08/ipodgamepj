#import "SerihuBoard.h"

@implementation SerihuBoard

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];

	return self;
}

- (void)setSerihu:(NSString*)chr serihu:(NSString*)str
{
	NSString* serihu = [[NSString stringWithFormat:@"%@\n\n\n\n\n\n\n", str] retain];
	if ([chr length] == 0) [nameBoard setAlpha:0];
	else [nameBoard setAlpha:1];
	
	[charaLabel setText:chr];
	[charaLabel2 setText:chr];
	[charaLabel3 setText:chr];

	[serihuLabel setText:serihu];
	[serihuLabel2 setText:serihu];
	[serihuLabel3 setText:serihu];
	
	[serihu release];
}

@end