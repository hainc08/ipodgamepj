#import "PlaceMark.h"

@implementation PlaceMark

@synthesize shopType;
@synthesize title;
@synthesize subtitle;
@synthesize coordinate;

@synthesize idx;

-(void) dealloc
{
	[title release];
	[subtitle release];
	
	[super dealloc];
}

@end
