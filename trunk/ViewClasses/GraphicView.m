#import "GraphicView.h"
#import "ViewManager.h"
#import "DataManager.h"

@implementation GraphicView

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
		UIImage* baseImg = [[UIImage imageNamed:@"noimage.jpg"] autorelease];
		
		for (int i=0; i<15; ++i)
		{
			imageButton[i] = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 75, 56)];
			[self addSubview:imageButton[i]];
			[imageButton[i] setImage:baseImg forState:UIControlStateNormal];
			[imageButton[i] setCenter:CGPointMake((i % 5) * 85 + 70, (i / 5) * 65 + 95)];
			[imageButton[i] addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
		}
	}
}

- (IBAction)ButtonClick:(id)sender
{	
	if (sender == backButton)
	{
		[[ViewManager getInstance] changeView:@"ExtraView"];
	}
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
}

@end