#import "CartListViewController.h"

@implementation CartCellView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)setData:(CartItem*)item
{
	mainId = [item menuId];
	side1Id = [item dessertId];
	side2Id = [item drinkId];
	count = [item count];

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

	if (side1Id != nil)
	{
		product[1] = [[DataManager getInstance] getProduct:side1Id];
		price += [product[1] price];
	}
	else
	{
		product[1] = nil;
	}

	if (side2Id != nil)
	{
		product[2] = [[DataManager getInstance] getProduct:side2Id];
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
		
		[changeSide1 setAlpha:1];
		[changeSide2 setAlpha:1];
	}
	else if (product[1] != nil)
	{
		[sideLabel setText:[product[1] name]];
		[changeSide1 setAlpha:1];
		[changeSide2 setAlpha:0];
	}
	else if (product[2] != nil)
	{
		[sideLabel setText:[product[2] name]];
		[changeSide1 setAlpha:0];
		[changeSide2 setAlpha:1];
	}
	else
	{
		[sideLabel setText:@""];
		[changeSide1 setAlpha:0];
		[changeSide2 setAlpha:0];
	}

	[countLabel setText:[NSString stringWithFormat:@"%d", count]];
	[priceLabel setText:[NSString stringWithFormat:@"%@원", [[DataManager getInstance] getPriceStr:price * count]]];
}

- (IBAction)buttonClick:(id)sender
{
	if ((sender == incCount)||(sender == decCount))
	{
		if (sender == incCount) ++count;
		if (sender == decCount) --count;

		[self refreshData];
	}
}

@end

@implementation CartListViewController

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
	
    return cell;
}

- (NSInteger)tableView:(UITableView*)sender numberOfRowsInSection:(NSInteger)section
{
	itemCount = [[DataManager getInstance] itemCount:listIdx];
	[listTable setFrame:CGRectMake(0, 45, 300, itemCount*100)];
	return itemCount;
}

@end
