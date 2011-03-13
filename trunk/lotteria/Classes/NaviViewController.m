#import "NaviViewController.h"

#import "MenuBodyViewController.h"
#import "CartBodyViewController.h"
#import "MypageBodyViewController.h"
#import "MapBodyViewController.h"
#import "ShipSearchViewController.h"

@implementation NaviViewController

@synthesize idx;
@synthesize listButton;
@synthesize body;
@synthesize parentView;

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.view setCenter:CGPointMake(160, 220)];

	if (body == nil)
	{
		switch (idx) {
			case 0:
				body = [[MenuBodyViewController alloc] init];
				break;
			case 1:
				body = [[CartBodyViewController alloc] init];
				break;
			case 2:
				body = [[MypageBodyViewController alloc] init];
				break;
			case 3:
				body = [[MapBodyViewController alloc] init];
				break;
		}
	}

	[self pushViewController:body animated:NO];
	[body setNavi:self];

	UINavigationBar* bar = [self navigationBar];
	[bar setTintColor:[UIColor clearColor]];
}
@end
