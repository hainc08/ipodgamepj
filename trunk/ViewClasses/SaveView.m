#import "SaveView.h"
#import "ViewManager.h"

@implementation SaveView

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
	
	if (isInit == false)
	{

	}
	
	[self loadPage:1];
}

- (void)loadPage:(int)page
{

}

- (IBAction)ButtonClick:(id)sender
{	

}

- (void)dealloc {
	[super dealloc];	
}

/* Base 사운드 제공 해야 함 */
- (void)update
{
	[super update];
}

@end