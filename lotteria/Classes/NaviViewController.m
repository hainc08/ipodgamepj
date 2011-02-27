#import "NaviViewController.h"

#import "MainBodyViewController.h"
#import "CartBodyViewController.h"
#import "MypageBodyViewController.h"
#import "LoginViewController.h"
#import "MapBodyViewController.h"
#import "ShipSearchViewController.h"

@implementation NaviViewController

@synthesize idx;
@synthesize helpButton;
@synthesize listButton;

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.view setCenter:CGPointMake(160, 220)];
	
	UIViewController* body;

	switch (idx) {
		case 0:
			body = [[MainBodyViewController alloc] init];
			break;
		case 1:
			body = [[CartBodyViewController alloc] init];
			break;
		case 2:
		//	if ([[DataManager getInstance] isLoginNow])
				body = [[MypageBodyViewController alloc] init];
		//	else
		//		body = [[LoginViewController alloc] init];
			break;
		case 3:
			body = [[MapBodyViewController alloc] init];
			break;
		case 4:
			body = [[ShipSearchViewController alloc] init];
			break;
	}
	
	[self pushViewController:body animated:false];
	[body setNavi:self];
	

	UINavigationBar* bar = [self navigationBar];
	[bar setTintColor:[UIColor clearColor]];
}

@end
