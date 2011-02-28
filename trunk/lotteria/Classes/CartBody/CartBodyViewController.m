#import "CartBodyViewController.h"
#import "CartMyShippingListView.h"
#import "DataList.h"

@implementation CartBodyViewController

@synthesize InfoOrder;

- (void)viewDidLoad {
	[super viewDidLoad];

	for (int i=0; i<5; ++i)
	{
		cartList[i] = [[CartListViewController alloc] init];
		[cartList[i] setNavi:navi];
		[cartList[i] setCategory:i];
		[scrollView addSubview:cartList[i].view];
	}

	[self setupData];

	[priceLabel setText:[[DataManager getInstance] getPriceStr:[[DataManager getInstance] getCartPrice]]];
	
	InfoOrder = [[[Order alloc] init] retain];

	[[DataManager getInstance] setCartView:self];
	
	self.navigationItem.title = @"장바구니";
}

- (void)update
{
	[self setupData];
	[priceLabel setText:[[DataManager getInstance] getPriceStr:[[DataManager getInstance] getCartPrice]]];
}

- (void)setupData
{
	int listCount = 0;
	int totListHeight = 0;
	for (int i=0; i<5; ++i)
	{
		int itemCount = [[DataManager getInstance] itemCount:i];

		if (itemCount == 0)
		{
			[cartList[i].view setAlpha:0];
			continue;
		}
		
		[cartList[i].view setAlpha:1];
		
		int listHeight = 45 + 100 * itemCount;
		
		[cartList[i] reloadData];
		[cartList[i].view setFrame:CGRectMake(0, 0, 300, listHeight)];
		[cartList[i].view setCenter:CGPointMake(160, totListHeight + (listHeight * 0.5) + 15)];
		
		totListHeight += listHeight + 15;
		++listCount;
	}
	
	[scrollView setContentSize:CGSizeMake(300, totListHeight + 15)];
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
	CartMyShippingList *UserInput = [[CartMyShippingList alloc] initWithNibName:@"CartMyShippingListView" bundle:nil];
	[self.navigationController pushViewController:UserInput animated:YES ];
	[UserInput release];
}

@end
