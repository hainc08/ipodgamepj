#import "MypageBodyViewController.h"
#import "MyCustomerDelivery.h"
#import "LoginViewController.h"
#import "DataManager.h"


@implementation MypageBodyViewController



- (void)viewDidLoad {
	[super viewDidLoad];

	if (![[DataManager getInstance] isLoginNow])
	{
		LoginViewController *loginBody = [[LoginViewController alloc] init];
		[loginBody setNavi:navi];
		[loginBody setBackView:self];
		[navi pushViewController:loginBody animated:NO];
	}
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction)LogOutButton
{
	[[DataManager getInstance] setIsLoginNow:FALSE];
	/* LoginView 로이동 */
}

- (IBAction)OrderListButton
{
	MyCustomerDelivery *Coustomer = [[MyCustomerDelivery alloc] initWithNibName:@"MyCustomerDelivery" bundle:nil];
	[self.navigationController pushViewController:Coustomer animated:YES];
	[Coustomer release];
}

@end
