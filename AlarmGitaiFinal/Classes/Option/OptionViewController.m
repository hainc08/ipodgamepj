#import "OptionViewController.h"
#import "AlarmViewController.h"

#import "UITableViewCellTemplate.h"
#import "AlarmConfig.h"

@implementation OptionViewController

@synthesize delegate;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	a_alarm = [[AlarmConfig getInstance] getAlarmArr];
	preview = [[OptionPreview alloc] init];
	self.title = @"Setting";
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[optionTableView reloadData];	
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
//	for (int i = 0 ; i < 3 ; i++)
//	{
//		NSIndexPath* index = [NSIndexPath indexPathForRow:i inSection:0];
//		UITableViewSwitchCell* cell = (UITableViewSwitchCell*)[optionTableView cellForRowAtIndexPath:index];
//		values[i] = cell.switcher.on;
//	}
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction)buttonClicked:(id)sender
{

}

- (IBAction)done:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (IBAction)ShowSeconds:(id)sender {
	[[AlarmConfig getInstance] setSecondMode];
	[preview refresh];
}

- (IBAction)OfficeMode:(id)sender {
	[[AlarmConfig getInstance] setOfficeMode];
	[preview refresh];
}

- (IBAction)ShowDate:(id)sender {
	[[AlarmConfig getInstance] setDateDisplay];
	[preview refresh];
}
- (IBAction)ShowTime:(id)sender {
	[[AlarmConfig getInstance] setHourMode];
	[preview refresh];
}
- (IBAction)ShowWeek:(id)sender {
	[[AlarmConfig getInstance] setWeekDisplay];
	[preview refresh];
}
- (IBAction)ShowLock:(id)sender {
//	[[AlarmConfig getInstance] setShowLock];
}

/////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	// Set up the cell...
	if(indexPath.section == 1)
	{
		UITableViewCell *cell;

		if (indexPath.row == 0)
		{
			static NSString *CellIdentifier = @"Cell";
			
			cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil)
			{
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			}
			
			[cell addSubview:[preview view]];
			[preview SetHV:true];
			[preview.view setCenter:CGPointMake([cell center].x, 100)];
			
			[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
			
			[preview refresh];
		}
		else
		{
			static NSString *CellIdentifier = @"SwitchCell";
			
			cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil)
			{
				NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier 
															 owner:self options:nil];
				for (id oneObject in nib)
				{
					if ([oneObject isKindOfClass:[UITableViewSwitchCell class]])
					{
						cell = oneObject;
						break;
					}
				}
			}

			UITableViewSwitchCell* swch_cell = (UITableViewSwitchCell*)cell;
			
			switch (indexPath.row)
			{
				case 1:
					[swch_cell setInfo:@"Show Seconds" :[[AlarmConfig getInstance] getSecondMode]];
					[swch_cell.switcher addTarget:self action:@selector(ShowSeconds:) forControlEvents:UIControlEventValueChanged];
					break;
				case 2:
					[swch_cell setInfo:@"Office Mode" :[[AlarmConfig getInstance] getOfficeMode]];
					[swch_cell.switcher addTarget:self action:@selector(OfficeMode:) forControlEvents:UIControlEventValueChanged];
					break;
				case 3:
					[swch_cell setInfo:@"Show Date" :[[AlarmConfig getInstance] getDateDisplay]];
					[swch_cell.switcher addTarget:self action:@selector(ShowDate:) forControlEvents:UIControlEventValueChanged];
					break;
				case 4:
					[swch_cell setInfo:@"Show Weekday" :[[AlarmConfig getInstance] getWeekDisplay]];
					[swch_cell.switcher addTarget:self action:@selector(ShowWeek:) forControlEvents:UIControlEventValueChanged];
					break;
				case 5:
					[swch_cell setInfo:@"24-Hour Time" :[[AlarmConfig getInstance] getHourMode]];
					[swch_cell.switcher addTarget:self action:@selector(ShowTime:) forControlEvents:UIControlEventValueChanged];
					break;
				case 6:
					[swch_cell setInfo:@"Auto-Lock" :FALSE];
					[swch_cell.switcher addTarget:self action:@selector(ShowLock:) forControlEvents:UIControlEventValueChanged];
					break;
			}
		}

		return cell;
	}
	else if(indexPath.section == 0)
	{
		if (indexPath.row == (alarmCount -1))
		{
			static NSString *CellIdentifier = @"ButtonCell";
			
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil)
			{
				NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier 
															 owner:self options:nil];
				for (id oneObject in nib)
				{
					if ([oneObject isKindOfClass:[UITableViewButtonCell class]])
					{
						cell = oneObject;
						break;
					}
				}
			}
			
			UITableViewButtonCell* buttonCell = (UITableViewButtonCell*)cell;
			[buttonCell setInfo:@"New Alarm..." :@""];

			return cell;
		}
		else
		{
			static NSString *CellIdentifier = @"AlarmCell";
			
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil)
			{
				NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier 
															 owner:self options:nil];
				for (id oneObject in nib)
				{
					if ([oneObject isKindOfClass:[UITableViewAlarmCell class]])
					{
						cell = oneObject;
						break;
					}
				}
			}

			UITableViewAlarmCell* alarm_cell = (UITableViewAlarmCell*)cell;

			AlarmDate	*alarm_date = [a_alarm objectAtIndex:indexPath.row];
			[alarm_cell setInfo:alarm_date.Time :alarm_date.WeekDate :alarm_date.AlarmONOFF];
			
			/*if (indexPath.row == 0)
				[alarm_cell setInfo:@"08:30 AM" :@"Every Day" :true];
			else
				[alarm_cell setInfo:@"03:30 PM" :@"Every Monday" :false];
			*/
			return cell;
		}
	}
	
	return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (section == 0)
		return @"Alarms";
	else
		return @"Display";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section == 0)
	{
		alarmCount = [a_alarm count]+1;
		return alarmCount;
	}
	else if (section == 1)
	{
		return 6;
	}
	
	return 0;
}


////////////////////////////////////////////////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0)
	{
		if (indexPath.row == alarmCount - 1) return 45;
		return 60;
	}
	else
	{
		if (indexPath.row == 0) return 200;
		return 50;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0)
	{
		switch (indexPath.row)
		{
			case 0:
				break;
			case 1:
				break;
			case 2:
				break;
		}
		AlarmViewController *controller = [[AlarmViewController alloc] initWithNibName:@"AlarmView" bundle:nil];
		controller.delegate = self;
		
		if(indexPath.row == alarmCount-1)
		{
			controller.alarm = nil;
			controller.SetFlag	= 1;
		}
		else {
			controller.alarm	= [a_alarm objectAtIndex:indexPath.row];
			controller.SetFlag	= 0;
		}

		controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		[self presentModalViewController:controller animated:YES];
		
		[controller release];
	}
}

- (void)flipsideViewControllerDidFinish:(UIViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}


@end
