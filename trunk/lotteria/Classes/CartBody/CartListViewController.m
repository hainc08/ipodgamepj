#import "CartListViewController.h"

@implementation CartCellView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)setLast:(bool)isLast
{
	if (isLast) [underLine setAlpha:0];
	else [underLine setAlpha:1];
}

@end

@implementation CartListViewController

- (void)viewDidLoad {
	[super viewDidLoad];
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
	[topImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tit_cart_prd_0%d.png", idx+1]]];
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
	
	[(CartCellView*)cell setLast:(indexPath.row == 2)];
	
    return cell;
}

- (NSInteger)tableView:(UITableView*)sender numberOfRowsInSection:(NSInteger)section
{
	[listTable setFrame:CGRectMake(0, 45, 300, 300)];
	return 3;
}

@end
