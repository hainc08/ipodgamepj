#import "CartListViewController.h"
#import "ChangeSideViewController.h"

@implementation CartCellView

@synthesize navi;
@synthesize isLast;

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self refreshData];
}

- (void)setData:(CartItem*)item
{
	cartItem = item;

	[self refreshData];
}

- (void)refreshData
{
	ProductData* product[3];
	int price;

	product[0] = [[DataManager getInstance] getProduct:[cartItem menuId]];
	[mainLabel setText:[product[0] name]];

	price = [product[0] price];

	if ([cartItem dessertId] != nil)
	{
		product[1] = [[DataManager getInstance] getProduct:[cartItem dessertId]];
		price += [product[1] price];
	}
	else
	{
		product[1] = nil;
	}

	if ([cartItem drinkId] != nil)
	{
		product[2] = [[DataManager getInstance] getProduct:[cartItem drinkId]];
		price += [product[2] price];
	}
	else
	{
		product[2] = nil;
	}
	
	if ((product[1] != nil)&&(product[2] != nil))
	{
		[sideLabel setText:[NSString stringWithFormat:@"%@ + %@",
							[product[1] name], [product[2] name]]];
		
		[changeDessert setAlpha:1];
		[changeDrink setAlpha:1];
	}
	else if (product[1] != nil)
	{
		[sideLabel setText:[product[1] name]];
		[changeDessert setAlpha:1];
		[changeDrink setAlpha:0];
	}
	else if (product[2] != nil)
	{
		[sideLabel setText:[product[2] name]];
		[changeDessert setAlpha:0];
		[changeDrink setAlpha:1];
	}
	else
	{
		[sideLabel setText:@""];
		[changeDessert setAlpha:0];
		[changeDrink setAlpha:0];
	}

	[countLabel setText:[NSString stringWithFormat:@"%d", [cartItem count]]];
	[priceLabel setText:[NSString stringWithFormat:@"%@원", [[DataManager getInstance] getPriceStr:price * [cartItem count]]]];
	
	if (isLast) [underLine setAlpha:0];
	else [underLine setAlpha:1];
}

- (IBAction)buttonClick:(id)sender
{
	if ((sender == incCount)||(sender == decCount))
	{
		int count = [cartItem count];
		if (count == 0) return;

		if (sender == incCount) ++count;
		if (sender == decCount) --count;

		[self refreshData];
		[cartItem setCount:count];
		
		if (count == 0) [[DataManager getInstance] removeCartItem:cartItem];

		[[ViewManager getInstance] cartUpdate];
	}
	else if (sender == changeDessert)
	{
		ChangeSideViewController* changeView = [[ChangeSideViewController alloc] init];
		[changeView setNavi:navi];
		[changeView setSideType:SIDE_DESSERT];
		[changeView setBackView:self];
		[changeView selectId:[cartItem dessertId]];
		
		[navi pushViewController:changeView animated:true];
	}
	else if (sender == changeDrink)
	{
		ChangeSideViewController* changeView = [[ChangeSideViewController alloc] init];
		[changeView setNavi:navi];
		[changeView setSideType:SIDE_DRINK];
		[changeView setBackView:self];
		[changeView selectId:[cartItem drinkId]];
		
		[navi pushViewController:changeView animated:true];
	}
}

- (void)sideSelected:(int)idx :(ProductData*)data
{
	if (idx == SIDE_DRINK)
	{
		[cartItem setDrinkId:[data menuId]];
	}
	else if (idx == SIDE_DESSERT)
	{
		[cartItem setDessertId:[data menuId]];
	}

	[[ViewManager getInstance] cartUpdate];
	
	[self refreshData];
}

@end

@implementation CartListViewController

@synthesize navi;

- (void)viewDidLoad {
	[super viewDidLoad];
	[topImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tit_cart_prd_0%d.png", listIdx+1]]];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

	 
- (void)dealloc {
    [super dealloc];
}

- (void)setCategory:(int)idx
{
	listIdx = idx;
}

- (void)reloadData
{
	//데이터 리로드...
	itemCount = [[DataManager getInstance] itemCount:listIdx];
	[listView setFrame:CGRectMake(0, 39, 300, itemCount * 100)];

	for (UIView* v in [listView subviews])
	{
		[v removeFromSuperview];
	}

	for (int i=0; i<itemCount; ++i)
	{
		CartCellView *cartCell = [[CartCellView alloc] init];
	
		[cartCell setData:[[DataManager getInstance] getCartItem:i listIdx:listIdx]];
		[cartCell setIsLast:(i == itemCount-1)];
		[cartCell setNavi:navi];
		[cartCell.view setCenter:CGPointMake(150, i * 100 + 50)];

		[listView addSubview:cartCell.view];
	}
}

@end
