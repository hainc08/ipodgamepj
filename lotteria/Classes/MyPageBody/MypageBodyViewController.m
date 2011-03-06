#import "MypageBodyViewController.h"
#import "MyCustomerDelivery.h"
#import "LoginViewController.h"
#import "DataManager.h"

@implementation MypageBodyViewController

- (void)viewDidLoad {
	naviImgIdx = 0;
	[super viewDidLoad];
	self.navigationItem.title = @"마이페이지";
	
	if ([[DataManager getInstance] isLoginNow] == false)
	{
		LoginViewController* popView = [[LoginViewController alloc] init];
		[[ViewManager getInstance] popUp:popView button:[navi helpButton] owner:nil];
	}
}

- (void)viewDidUnload {
	[[ViewManager getInstance] closePopUp];
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction)LogOutButton
{
	[[DataManager getInstance] setIsLoginNow:FALSE];

	LoginViewController* popView = [[LoginViewController alloc] init];
	[[ViewManager getInstance] popUp:popView button:[navi helpButton] owner:nil];
}

- (IBAction)OrderListButton
{
	MyCustomerDelivery *Coustomer = [[MyCustomerDelivery alloc] initWithNibName:@"MyCustomerDelivery" bundle:nil];
	[self.navigationController pushViewController:Coustomer animated:YES];
	[Coustomer release];
}

@end
