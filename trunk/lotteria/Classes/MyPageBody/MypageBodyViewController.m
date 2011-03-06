#import "MypageBodyViewController.h"
#import "MyCustomerDelivery.h"
#import "NaviViewController.h"
#import "DataManager.h"

@implementation MypageBodyViewController



- (void)viewDidLoad {
	naviImgIdx = 0;
	[super viewDidLoad];
	self.navigationItem.title = @"마이페이지";
	
	if ([[DataManager getInstance] isLoginNow] == false)
	{
		NaviViewController* naviCon = [[NaviViewController alloc] init];
		[naviCon setIdx:5];
		[self.parentViewController.view addSubview:naviCon.view];
		[self.parentViewController.parentViewController viewAlign];
	}
}


- (void)viewDidUnload {
	
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction)LogOutButton
{
	[[DataManager getInstance] setIsLoginNow:FALSE];

	NaviViewController* naviCon = [[NaviViewController alloc] init];
	[naviCon setIdx:5];
	[self.parentViewController.view addSubview:naviCon.view];
	[self.parentViewController.parentViewController viewAlign];
}

- (IBAction)OrderListButton
{
	MyCustomerDelivery *Coustomer = [[MyCustomerDelivery alloc] initWithNibName:@"MyCustomerDelivery" bundle:nil];
	[self.navigationController pushViewController:Coustomer animated:YES];
	[Coustomer release];
}

@end
