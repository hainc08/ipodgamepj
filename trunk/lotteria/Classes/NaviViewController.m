#import "NaviViewController.h"

#import "MainBodyViewController.h"
#import "CartBodyViewController.h"
#import "MypageBodyViewController.h"
#import "LoginViewController.h"
#import "MapBodyViewController.h"
#import "ShipSearchViewController.h"
#import "HelpViewController.h"

@implementation NaviViewController

@synthesize idx;
@synthesize helpButton;
@synthesize listButton;
@synthesize body;

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.view setCenter:CGPointMake(160, 220)];

	switch (idx) {
		case 0:
			body = [[MainBodyViewController alloc] init];
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
		case 4:
			body = [[HelpViewController alloc] init];
			break;
		case 5:
			body = [[LoginViewController alloc] init];
			break;
	}

	[self pushViewController:body animated:NO];
	[body setNavi:self];

	UINavigationBar* bar = [self navigationBar];
	[bar setTintColor:[UIColor clearColor]];
}
@end
