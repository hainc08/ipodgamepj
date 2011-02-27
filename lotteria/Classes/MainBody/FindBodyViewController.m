#import "FindBodyViewController.h"
#import "MainBodyViewController.h"

@implementation FindCellView

@synthesize menuImg;

- (IBAction)buttonClick:(id)sender
{
	
}

- (void)setData:(ProductData*)data
{
	[nameLabel setText:[data name]];
	[descLabel setText:@"설명은 어디에?"];
	[priceLabel setText:[[DataManager getInstance] getPriceStr:[data price]]];
	[menuImg setImage:[data getProductImg:MIDDLE]];
}

- (void)setLast:(bool)isLast
{
	if (isLast) [underLine setAlpha:0];
	else [underLine setAlpha:1];
}

@end

@implementation FindBodyViewController

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (IBAction)button:(id)sender;
{
	int i;

	if (sender == bgButton)
	{
		i = 0;
	}
	else if (sender == chButton)
	{
		i = 1;
	}
	else if (sender == drButton)
	{
		i = 2;
	}
	else if (sender == dsButton)
	{
		i = 3;
	}
	else if (sender == pcButton)
	{
		i = 4;
	}

	if (idx == i) return;
	
	idx = i;
	[tableView reloadData];
	[tableView scrollRectToVisible:CGRectMake(0,0,320,330) animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 80;
}

- (UITableViewCell*)tableView:(UITableView*)sender cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FindCellView"];
	
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FindCellView" 
                                                     owner:self options:nil];
        for (id oneObject in nib)
		{
			if ([oneObject isKindOfClass:[FindCellView class]])
			{
				cell = oneObject;
			}
		}
    }
	
	FindCellView* findCell = (FindCellView*)cell;
	
	[findCell setData:[[DataManager getInstance] getSearchProduct:indexPath.row listIdx:idx]];
	[findCell setLast:(indexPath.row == itemCount[idx]-1)];

    return cell;
}

- (NSInteger)tableView:(UITableView*)sender numberOfRowsInSection:(NSInteger)section
{
	itemCount[idx] = [[DataManager getInstance] getSearchProductCount:idx];
	return itemCount[idx];
}

@end