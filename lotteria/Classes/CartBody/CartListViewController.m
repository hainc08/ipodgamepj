#import "CartListViewController.h"
#import "ChangeSideViewController.h"

@implementation CartCellView

@synthesize navi;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)setData:(CartItem*)item
{
	mainId = [item menuId];
	dessertId = [item dessertId];
	drinkId = [item drinkId];
	count = [item count];
	cartItem = item;

	[self refreshData];
}

- (void)setLast:(bool)isLast
{
	if (isLast) [underLine setAlpha:0];
	else [underLine setAlpha:1];
}

- (void)refreshData
{
	ProductData* product[3];
	int price;

	product[0] = [[DataManager getInstance] getProduct:mainId];
	[mainLabel setText:[product[0] name]];

	price = [product[0] price];

	if (dessertId != nil)
	{
		product[1] = [[DataManager getInstance] getProduct:dessertId];
		price += [product[1] price];
	}
	else
	{
		product[1] = nil;
	}

	if (drinkId != nil)
	{
		product[2] = [[DataManager getInstance] getProduct:drinkId];
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

	[countLabel setText:[NSString stringWithFormat:@"%d", count]];
	[priceLabel setText:[NSString stringWithFormat:@"%@원", [[DataManager getInstance] getPriceStr:price * count]]];
}

- (IBAction)buttonClick:(id)sender
{
	if ((sender == incCount)||(sender == decCount))
	{
		if (count == 0) return;

		if (sender == incCount) ++count;
		if (sender == decCount) --count;

		[self refreshData];
		[cartItem setCount:count];
		
		if (count == 0) [[DataManager getInstance] removeCartItem:cartItem];

		[[DataManager getInstance] cartUpdate];
	}
	else if (sender == changeDessert)
	{
		ChangeSideViewController* changeView = [[ChangeSideViewController alloc] init];
		[changeView setNavi:navi];
		[changeView setSideType:SIDE_DESSERT];
		[changeView setBackView:self];
		[changeView selectId:dessertId];
		
		[navi pushViewController:changeView animated:true];
	}
	else if (sender == changeDrink)
	{
		ChangeSideViewController* changeView = [[ChangeSideViewController alloc] init];
		[changeView setNavi:navi];
		[changeView setSideType:SIDE_DRINK];
		[changeView setBackView:self];
		[changeView selectId:drinkId];
		
		[navi pushViewController:changeView animated:true];
	}
}

- (void)sideSelected:(int)idx :(ProductData*)data
{
	if (idx == SIDE_DRINK)
	{
		drinkId = [data menuId];	
		[cartItem setDrinkId:drinkId];
	}
	else if (idx == SIDE_DESSERT)
	{
		dessertId = [data menuId];
		[cartItem setDessertId:dessertId];
	}

	[[DataManager getInstance] cartUpdate];
	
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 100;
}

- (UITableViewCell*)tableView:(UITableView*)sender cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [listTable dequeueReusableCellWithIdentifier:@"CartCellView"];
	
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CartCellView" 
                                                     owner:self options:nil];
        for (id oneObject in nib)
		{
			if ([oneObject isKindOfClass:[CartCellView class]])
			{
				cell = oneObject;
			}
		}
    }

	CartCellView* cartCell = (CartCellView*)cell;
	
	[cartCell setData:[[DataManager getInstance] getCartItem:indexPath.row listIdx:listIdx]];
	[cartCell setLast:(indexPath.row == itemCount-1)];
	[cartCell setNavi:navi];
	
    return cell;
}

- (NSInteger)tableView:(UITableView*)sender numberOfRowsInSection:(NSInteger)section
{
	itemCount = [[DataManager getInstance] itemCount:listIdx];
	[listTable setFrame:CGRectMake(0, 45, 300, itemCount*100)];
	return itemCount;
}

- (void)reloadData
{
	[listTable reloadData];
}

@end
