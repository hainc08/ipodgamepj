#import "CharSelectViewController.h"

#import "UITableViewCellTemplate.h"
#import "AlarmConfig.h"
#import "DateFormat.h"

@implementation CharSelectViewController

@synthesize delegate;
@synthesize alarm;
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

	[alarm ResetNSDate];
	[[AlarmConfig getInstance] SaveConfig];
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (IBAction)cancel:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (IBAction)deleteAlarm:(id)sender {
	[[AlarmConfig getInstance] deleteAlarm:alarm];
	[self.delegate flipsideViewControllerDidFinish:self];	
}

/////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Set up the cell...
	if(indexPath.section == 0)
	{
		NSString* text;
		NSString* value;
		
		text = @"Time";
		value = @"TEST";
//		switch (indexPath.row)
//		{
//			case 0:
//				text = @"Time";
//				value = alarm.Time;
//				break;
//			default:
//				break;
//		}
		
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
	return @"Select";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 7;
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
		if (indexPath.row == 1)
		{

		}
	}
}

#pragma mark -
#pragma mark Editing

- (void)flipsideViewControllerDidFinish:(UIViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}


@end
