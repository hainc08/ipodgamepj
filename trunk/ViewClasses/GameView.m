#import "MainTopView.h"
#import "ViewManager.h"
#import "DataManager.h"

@implementation GameView

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];

	return self;
}

- (void)reset:(NSObject*)param
{
	[super reset:param];
	
	for (int i=0; i<10; ++i)
	{
		charCacheIdx[i] = 0;
		if (charCache[i])
		{
			[charCache[i] release];
			charCache[i] = NULL;
		}
	}
	
	loadingDone = false;
}

- (IBAction)ButtonClick:(id)sender
{	

}

- (void) BaseSoundPlay
{
}

- (void)dealloc {
	[super dealloc];	
}

/* Base 사운드 제공 해야 함 */
- (void)update
{
	[super update];
	
	if (loadingDone == false)
	{
		if ([[DataManager getInstance] loadingDone])
		{
			loadingDone = true;
		}
	}
}

@end