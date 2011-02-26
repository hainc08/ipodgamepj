#import "MypageBodyViewController.h"
#import "MyCustomerDelivery.h"


@implementation MypageBodyViewController



- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.title = @"마이페이지";
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}


- (IBAction)OrderListButton
{
	MyCustomerDelivery *Coustomer = [[MyCustomerDelivery alloc] initWithNibName:@"MyCustomerDelivery" bundle:nil];
	[self.navigationController pushViewController:Coustomer animated:YES];
	[Coustomer release];
}

@end
