#import "TexManager.h"
static TexManager *texManagerInst;

@implementation TexManager

+ (TexManager*)getInstance
{
	return texManagerInst;
}

+ (void)initManager
{
	texManagerInst = [TexManager alloc];
	return;
}

- (void)closeManager
{
}

@end
