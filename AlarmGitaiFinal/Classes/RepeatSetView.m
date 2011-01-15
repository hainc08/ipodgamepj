#import "RepeatSetView.h"
#import "UITableViewCellTemplate.h"

@implementation RepeatSetView

@synthesize delegate;
@synthesize editedPropertyKey;
@synthesize repeatIdx;
@synthesize sourceController;
@synthesize ListTableview;
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Alarm Repeat";
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	if (repeatIdx > 1)
	{
		repeatIdx2 = repeatIdx - 2;
		repeatIdx = 2;
	}
	else 
	{
		repeatIdx2 = 0;
	}
	[ListTableview reloadData];
}

- (IBAction)done:(id)sender
{
	int setdata = 0;
	if(repeatIdx == 2 && repeatIdx2 == 0)
		setdata = 0;
	else
		setdata = (repeatIdx + repeatIdx2);
	[sourceController setValue:setdata forEditedProperty:editedPropertyKey];
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (IBAction)cancel:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (void)dealloc {
	[super dealloc];	
}

/////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if (repeatIdx < 2) return 1;
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell* cell;

	static NSString *CellIdentifier = @"SelectCell";
	cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier 
													 owner:self options:nil];
		for (id oneObject in nib)
		{
			if ([oneObject isKindOfClass:[UITableViewSelectCell class]])
			{
				cell = oneObject;
				break;
			}
		}
	}

	UITableViewSelectCell* buttonCell = (UITableViewSelectCell*)cell;
	
	// Set up the cell...
	if(indexPath.section == 0)
	{
		switch(indexPath.row)
		{
			case 0:
				[buttonCell setInfo:@"Never Repeat"];
				[buttonCell showSelect:(repeatIdx == 0)];
				break;
			case 1:
				[buttonCell setInfo:@"Everyday"];
				[buttonCell showSelect:(repeatIdx == 1)];
				break;
			case 2:
				[buttonCell setInfo:@"Weekday"];
				[buttonCell showSelect:(repeatIdx >= 2)];
				break;
		}
	}
	else if(indexPath.section == 1)
	{
		switch(indexPath.row)
		{
			case 0:
				[buttonCell setInfo:@"Sunday"];
				break;
			case 1:
				[buttonCell setInfo:@"Monday"];
				break;
			case 2:
				[buttonCell setInfo:@"TuesDay"];
				break;
			case 3:
				[buttonCell setInfo:@"WednesDay"];
				break;
			case 4:
				[buttonCell setInfo:@"Thursday"];
				break;
			case 5:
				[buttonCell setInfo:@"FriDay"];
				break;
			case 6:
				[buttonCell setInfo:@"SaturDay"];
				break;
		}
		BOOL isSelect;
		if (repeatIdx < 2) { isSelect = false; repeatIdx2 = 0;}
		else isSelect = repeatIdx2 & (0x01<<indexPath.row);
		[buttonCell showSelect:isSelect];
	}

	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (section == 0)
		return @"Repeat";
	else
		return @"Weekday";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section == 0)
	{
		return 3;
	}
	else if (section == 1)
	{
		return 7;
	}
	
	return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0)
	{
		switch (indexPath.row)
		{
			case 0:
				repeatIdx = 0;
				repeatIdx2 = 0;
				break;
			case 1:
				repeatIdx = 1;
				repeatIdx2 = 0;
				break;
			case 2:
				repeatIdx = 2;
				break;
		}
	}
	else if (indexPath.section == 1)
	{
		int bit = (0x01 << indexPath.row);

		if (repeatIdx2 | bit)
			repeatIdx2 ^= bit;
		else
			repeatIdx2 |= bit;

	}

	[tableView reloadData];
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}

- (void)flipsideViewControllerDidFinish:(UIViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}

@end
