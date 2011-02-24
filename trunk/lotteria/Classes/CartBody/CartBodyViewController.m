#import "CartBodyViewController.h"
#import "CartOrderUserViewController.h"
#import "DataList.h"
@implementation CartBodyViewController
@synthesize InfoOrder;
- (void)viewDidLoad {
	[super viewDidLoad];

	int listCount = 0;
	int totListHeight = 0;
	for (int i=0; i<5; ++i)
	{
		int itemCount = [[DataManager getInstance] itemCount:i];
		if (itemCount == 0) continue;
		int listHeight = 45 + 100 * itemCount;

		cartList[i] = [[CartListViewController alloc] init];
		[cartList[i] setCategory:i];
		[scrollView addSubview:cartList[i].view];
		[cartList[i].view setFrame:CGRectMake(0, 0, 300, listHeight)];
		[cartList[i].view setCenter:CGPointMake(160, listCount * (listHeight + 15) + (listHeight * 0.5) + 15)];
		
		totListHeight += listHeight + 15;
		++listCount;
	}
	
	[scrollView setContentSize:CGSizeMake(300, totListHeight + 15)];
	[priceLabel setText:[[DataManager getInstance] getPriceStr:[[DataManager getInstance] getCartPrice]]];
	
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
