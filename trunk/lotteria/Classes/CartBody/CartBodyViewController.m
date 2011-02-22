#import "CartBodyViewController.h"
#import "CartOrderUserViewController.h"
@implementation CartBodyViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	for (int i=0; i<5; ++i)
	{
		cartList[i] = [[CartListViewController alloc] init];
		[scrollView addSubview:cartList[i].view];
		[cartList[i].view setFrame:CGRectMake(0, 0, 300, 345)];
		[cartList[i].view setCenter:CGPointMake(160, i * (345 + 15) + (345 * 0.5) + 15)];
		[cartList[i] setCategory:i];
	}
	
	[scrollView setContentSize:CGSizeMake(300, 5 * (345 + 15) + 15)];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

-(IBAction)OrderButton
{
	CartOrderUserViewController *UserInput = [[CartOrderUserViewController alloc] initWithNibName:@"CartOrderUserView" bundle:nil];
	//UserInput.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	//[self presentModalViewController:UserInput animated:YES];
	[self.view addSubview:UserInput.view ];

	[UserInput release];

	
}

@end
