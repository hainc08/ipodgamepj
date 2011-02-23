#import "CartBodyViewController.h"
#import "CartOrderUserViewController.h"
#import "DataList.h"
@implementation CartBodyViewController
@synthesize InfoOrder;
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
	
	InfoOrder = [[[Order alloc] init] retain];
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
	UserInput.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	OrderProductInfo *Product = [[[OrderProductInfo alloc] init ] retain];
	[Product setMenuID:@"D10"];
	[Product setMenuName:@"블고기 버거"];
	[Product setMenuNumber:@"1"];
	[Product setMenuPrice:@"10000"];
	[InfoOrder setProduct:Product];
	[Product release];
	OrderUserInfo *User = [[[OrderUserInfo alloc] init ] retain];
	[InfoOrder setUser:User];
	[User release];
	UserInput.InfoOrder	= self.InfoOrder;
	[self presentModalViewController:UserInput animated:YES];
//	[self.view addSubview:UserInput.view ];

	[UserInput release];

	
}

@end
