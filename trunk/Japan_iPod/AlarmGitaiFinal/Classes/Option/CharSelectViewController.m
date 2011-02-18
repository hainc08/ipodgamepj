#import "CharSelectViewController.h"

#import "AlarmConfig.h"
#import "SaveManager.h"
#import "UITableViewCellTemplate.h"

@implementation CharSelectViewController

@synthesize delegate;

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

- (IBAction)done:(id)sender {
	[[SaveManager getInstance] saveFile];
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (IBAction)cancel:(id)sender {
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
		NSString* text2;
		
		switch (indexPath.row)
		{
			case 0:
				text = @"natsuko";
				text2 = @"なつこ";
				break;
			case 1:
				text = @"akari";
				text2 = @"あかり";
				break;
			case 2:
				text = @"haruka";
				text2 = @"はるか";
				break;
			case 3:
				text = @"hitomi";
				text2 = @"ひとみ";
				break;
			case 4:
				text = @"irika";
				text2 = @"エリカ";
				break;
			case 5:
				text = @"reina";
				text2 = @"レイナ";
				break;
			case 6:
				text = @"fumiko";
				text2 = @"文子";
				break;
		}
		
		static NSString *CellIdentifier = @"SelectCharCell";

		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (cell == nil)
		{
			NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier 
														 owner:self options:nil];
			for (id oneObject in nib)
			{
				if ([oneObject isKindOfClass:[UITableViewSelectCharCell class]])
				{
					cell = oneObject;
					break;
				}
			}
		}
		
		UITableViewSelectCharCell* charCell = (UITableViewSelectCharCell*)cell;
		[charCell setInfo:text :text2];
		[charCell showSelect:([[[AlarmConfig getInstance] CharNameJP] compare:text2] == NSOrderedSame)];

		return cell;
	}

	return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 7;
}


////////////////////////////////////////////////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0)
	{
		NSString* text;
		NSString* text2;

		switch (indexPath.row)
		{
			case 0:
				text = @"natsuko";
				text2 = @"なつこ";
				break;
			case 1:
				text = @"akari";
				text2 = @"あかり";
				break;
			case 2:
				text = @"haruka";
				text2 = @"はるか";
				break;
			case 3:
				text = @"hitomi";
				text2 = @"ひとみ";
				break;
			case 4:
				text = @"irika";
				text2 = @"エリカ";
				break;
			case 5:
				text = @"reina";
				text2 = @"レイナ";
				break;
			case 6:
				text = @"fumiko";
				text2 = @"文子";
				break;
		}
		
		[[AlarmConfig getInstance] SetNameInfo:text :text2];
		[[AlarmConfig getInstance] setForceUpdate:true];

		[CharTable reloadData];
	}
}

#pragma mark -
#pragma mark Editing

- (void)flipsideViewControllerDidFinish:(UIViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}


@end
