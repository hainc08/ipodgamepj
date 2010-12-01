#import "AlarmViewController.h"

#import "UITableViewCellTemplate.h"
#import "AlarmConfig.h"

@implementation AlarmViewController

@synthesize delegate;
@synthesize alarm, undoManager;
@synthesize	SetFlag;
@synthesize index;
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
//	[self setEditing:YES animated:YES ];
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
	if(alarm == nil) 
		alarm = [[AlarmDate alloc] init];
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

- (IBAction)AlarmONOFF:(id)sender {
	alarm.AlarmONOFF = !alarm.AlarmONOFF;
}

- (IBAction)done:(id)sender {
	if(SetFlag)
	{
		[[AlarmConfig getInstance] setAlarmAdd:alarm];
		[alarm release];
	}
	
	[[AlarmConfig getInstance] SaveConfig];
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (IBAction)cancel:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];	
}

/////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	// Set up the cell...
	if(indexPath.section == 0)
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

		NSString* text = @"Enable Alarm";
	
		UITableViewSwitchCell* swch_cell = (UITableViewSwitchCell*)cell;
		[swch_cell.switcher addTarget:self action:@selector(AlarmONOFF:) forControlEvents:UIControlEventValueChanged];
		[swch_cell setInfo:text :alarm.AlarmONOFF];
		
		return cell;
	}
	else if(indexPath.section == 1)
	{
		NSString* text;
		NSString* value;
		
		switch (indexPath.row)
		{
			case 0:
				text = @"Time";
				value = alarm.Time;
				break;
			case 1:
				text = @"Repeat";
				value = alarm.WeekDate;
				break;
			case 2:
				text = @"Sound";
				value = alarm.SoundName;

				break;
			case 3:
				text = @"Name";
				value = alarm.Name;
				break;
		}
		
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
		[buttonCell setInfo:text :value];
		return cell;
	}
	else if(indexPath.section == 2)
	{
		NSString* text = @"Advanced";
		NSString* value = @"";

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
		[buttonCell setInfo:text :value];
		return cell;
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
	if(section == 0) return 1;
	else if (section == 1) return 4;
	else if (section == 2) return 1;
	
	return 0;
}


////////////////////////////////////////////////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1)
	{
		AlarmViewSetController *setting = [[AlarmViewSetController alloc] initWithNibName:@"AlarmSetting" bundle:nil];
		setting.editedObject = alarm;
		setting.sourceController = self;
		
		switch (indexPath.row)
		{
			case 0:
				setting.title = @"Time";
				setting.editedPropertyKey = @"Time";
				setting.editingDate	= YES;
				break;
			case 1:
				setting.title = @"Repeat";
				setting.editedPropertyKey = @"Repeat";
				break;
			case 2:
				setting.title = @"Sound";
				setting.editedPropertyKey = @"Sound";
				break;
			case 3:
				setting.title = @"Name";
				setting.editedPropertyKey = @"Name";
					setting.editingDate	= NO;
			break;

		}
		setting.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		setting.delegate = self;
		
		[self presentModalViewController:setting animated:YES];
		
		[setting release];
	}
}



#pragma mark -
#pragma mark Editing

- (void)setValue:(id)newValue forEditedProperty:(NSString *)field {
	
	if([field compare:@"Time"] == NSOrderedSame )
		alarm.Time = newValue;
	else if([field compare:@"Sound"] == NSOrderedSame ) 
		alarm.SoundName = newValue;
	else if([field compare:@"Name"] == NSOrderedSame )
		alarm.Name	= newValue;
	else if([field compare:@"Repeat"] == NSOrderedSame )
		alarm.WeekDate	= newValue;
}

- (void)flipsideViewControllerDidFinish:(UIViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}


@end
