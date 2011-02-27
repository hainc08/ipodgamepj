#import "FindBodyViewController.h"
#import "MainBodyViewController.h"

@implementation FindCellView

@synthesize menuImg;

- (IBAction)buttonClick:(id)sender
{
	
}

- (void)setData:(NSString*)menuId
{
	
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

//	[navi popViewControllerAnimated:true];
//	
//	MainBodyViewController* bView = (MainBodyViewController*)backView;
//	[bView setScrollBar:[[[DataManager getInstance] getProduct:@"LB0011"] category]];
//	[bView iconClicked:@"LB0011"];
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
	
//	[findCell setData:[[DataManager getInstance] getCartItem:indexPath.row listIdx:listIdx]];
	[findCell setLast:(indexPath.row == itemCount[idx]-1)];
	
	if (idx == 0) [[findCell menuImg] setImage:[UIImage imageNamed:@"bg_bb_a.png"]];
	else if (idx == 1) [[findCell menuImg] setImage:[UIImage imageNamed:@"ck_cf2_a.png"]];
	else if (idx == 2) [[findCell menuImg] setImage:[UIImage imageNamed:@"dr_ame_a.png"]];
	else if (idx == 3) [[findCell menuImg] setImage:[UIImage imageNamed:@"ds_cs_a.png"]];
	else if (idx == 4) [[findCell menuImg] setImage:[UIImage imageNamed:@"pk_cfp_a.png"]];
	
    return cell;
}

- (NSInteger)tableView:(UITableView*)sender numberOfRowsInSection:(NSInteger)section
{
	itemCount[idx] = 10;
	return itemCount[idx];
}

@end