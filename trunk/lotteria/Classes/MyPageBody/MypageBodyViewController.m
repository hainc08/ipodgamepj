#import "MypageBodyViewController.h"
#import "MyCustomerDelivery.h"
#import "LoginViewController.h"
#import "DataManager.h"


@implementation MypageBodyViewController



- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.title = @"마이페이지";


}


- (void)viewDidUnload {
	
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction)LogOutButton
{
	[[DataManager getInstance] setIsLoginNow:FALSE];
	
	UINavigationController *navicontrol = self.navigationController;
	NSMutableArray *Arr = [[self.navigationController.viewControllers mutableCopy] autorelease];
	[Arr removeLastObject];
	navicontrol.viewControllers = Arr;
	LoginViewController *login = [[LoginViewController alloc] init];
	[login setLoginNextType:MYPAGE];
	[navicontrol pushViewController:login animated:NO];
	[login release];
	
}

- (IBAction)OrderListButton
{
	MyCustomerDelivery *Coustomer = [[MyCustomerDelivery alloc] initWithNibName:@"MyCustomerDelivery" bundle:nil];
	[self.navigationController pushViewController:Coustomer animated:YES];
	[Coustomer release];
}

@end
