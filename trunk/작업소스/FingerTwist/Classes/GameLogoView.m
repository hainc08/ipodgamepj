#import "GameLogoView.h"
#import "ViewManager.h"

@implementation GameLogoView

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//다음뷰로 이동 한다.
	[[ViewManager getInstance] changeView:@"TeamLogoView"];
}

- (void)dealloc {
	[super dealloc];	
}

@end
