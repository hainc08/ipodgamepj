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

	updateTimer = [[NSTimer scheduledTimerWithTimeInterval: 1.0f
													target: self
												  selector: @selector(update)
												  userInfo: self
												   repeats: YES] retain];	
	self.navigationItem.title = @"장바구니";
}

- (void)update
{
	if ([[DataManager getInstance] isCartDirty] == false) return;
	
	[priceLabel setText:[[DataManager getInstance] getPriceStr:[[DataManager getInstance] getCartPrice]]];
	[[DataManager getInstance] setIsCartDirty:false];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[updateTimer invalidate]; 
	[updateTimer release]; 
}

- (void)dealloc {
    [super dealloc];
}

-(IBAction)OrderButton
{
	NSMutableArray *arr = [[[NSMutableArray alloc] init]  retain];

	CartOrderUserViewController *UserInput = [[CartOrderUserViewController alloc] initWithNibName:@"CartOrderUserView" bundle:nil];
	OrderProductInfo *Product = [[[OrderProductInfo alloc] init ] retain];
	[Product setMenuID:@"D10"];
	[Product setMenuName:@"블고기 버거"];
	[Product setMenuNumber:@"1"];
	[Product setMenuPrice:@"10000"];
	[arr insertObject:Product atIndex:0];
	InfoOrder.Product = arr;
	[Product release];
	[arr release];
	OrderUserInfo *User = [[[OrderUserInfo alloc] init ] retain];
	[InfoOrder setUser:User];
	[User release];
	UserInput.InfoOrder	= self.InfoOrder;
	
	[self.navigationController pushViewController:UserInput animated:YES ];
	[UserInput release];
}

@end
