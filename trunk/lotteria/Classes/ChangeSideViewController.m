#import "ChangeSideViewController.h"

@implementation ChangeSideCellView

@synthesize listView;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)setData:(ProductData*)item
{
	product = item;

	[nameLabel setText:[item name]];
	[calLabel setText:@"/ 150 KCal"];//이거 정보가 아직 없네...
	[priceLabel setText:[NSString stringWithFormat:@"%d 원 추가", [item price]]];
	[thumbImg setImage:[[DataManager getInstance] getProductImg:[item menuId] type:SMALL]];
	
	color1 = nameLabel.textColor;
	color2 = calLabel.textColor;

	[self setSelect:false];
}

- (void)setSelect:(bool)selected
{
	if (selected)
	{
		[nameLabel setTextColor:[UIColor whiteColor]];
		[calLabel setTextColor:[UIColor whiteColor]];
		[priceLabel setTextColor:[UIColor whiteColor]];

		[backImg setAlpha:0];
		[backImg2 setAlpha:1];
	}
	else
	{
		[nameLabel setTextColor:color1];
		[calLabel setTextColor:color2];
		[priceLabel setTextColor:color1];

		[backImg setAlpha:1];
		[backImg2 setAlpha:0];
	}
}

- (IBAction)Select
{
	ChangeSideViewController* lView = (ChangeSideViewController*)listView;

	[lView selectId:[product menuId]];
	[lView reloadData];
}

@end

@implementation ChangeSideViewController

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)dealloc {
	[products release];
    [super dealloc];
}

- (void)setSideType:(int)type
{
	sType = type;
	if (type == SIDE_DRINK) products = [[DataManager getInstance] getProductArray:@"S40"];
	else if (type == SIDE_DESSERT) products = [[DataManager getInstance] getProductArray:@"S30"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 89;
}

- (UITableViewCell*)tableView:(UITableView*)sender cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [listTable dequeueReusableCellWithIdentifier:@"ChangeSideCellView"];
	
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChangeSideCellView" 
                                                     owner:self options:nil];
        for (id oneObject in nib)
		{
			if ([oneObject isKindOfClass:[ChangeSideCellView class]])
			{
				cell = oneObject;
			}
		}
    }
	
	ChangeSideCellView* sideCell = (ChangeSideCellView*)cell;
	
	int idx = indexPath.row;
	for (ProductData* data in products)
	{
		if (idx == 0)
		{
			[sideCell setData:data];
			if ([menuId compare:[data menuId]] == NSOrderedSame)
			{
				[sideCell setSelect:true];
				[backView sideSelected:sType :data];
			}
			else
			{
				[sideCell setSelect:false];
			}
			break;
		}
		--idx;
	}

	[sideCell setListView:self];
    return sideCell;
}

- (NSInteger)tableView:(UITableView*)sender numberOfRowsInSection:(NSInteger)section
{
	return [products count];
}

- (void)selectId:(NSString*)mId
{
	menuId = mId;
}

- (void)reloadData
{
	[listTable reloadData];
}

@end
