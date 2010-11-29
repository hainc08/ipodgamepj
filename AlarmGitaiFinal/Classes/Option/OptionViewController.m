#import "OptionViewController.h"
#import "AlarmViewController.h"

#import "UITableViewCellTemplate.h"

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
		static NSString *CellIdentifier = @"SwitchCell";
		
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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

		NSString* text = @"텍스트";
		BOOL value = NO;
		
		switch (indexPath.row)
		{
			case 0:
				text = @"Show Seconds";
				value = false;
				break;
			case 1:
				text = @"Show Date";
				value = false;
				break;
			case 2:
				text = @"Show Weekday";
				value = false;
				break;
			case 3:
				text = @"24-Hour Time";
				value = false;
				break;
			case 4:
				text = @"Auto-Lock";
				value = false;
				break;
		}
		
		UITableViewSwitchCell* swch_cell = (UITableViewSwitchCell*)cell;
		
		[swch_cell setInfo:text :value];
		
		return cell;
	}
	else if(indexPath.section == 0)
	{
		if (indexPath.row == (alarmCount-1))
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
			//세팅...지금은 테스트용
			if (indexPath.row == 0)
				[alarm_cell setInfo:@"08:30 AM" :@"Every Day" :true];
			else
				[alarm_cell setInfo:@"03:30 PM" :@"Every Monday" :false];

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
		alarmCount = 3;
		return alarmCount;
	}
	else if (section == 1)
	{
		return 5;
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
	return 50;
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
		
		controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		[self presentModalViewController:controller animated:YES];
		
		[controller release];
	}
}

- (void)flipsideViewControllerDidFinish:(UIViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}

@end
