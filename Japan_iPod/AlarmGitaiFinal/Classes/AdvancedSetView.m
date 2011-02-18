//
//  AdvancedSetView.m
//
//  Created by embmaster on 11. 1. 18..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AdvancedSetView.h"

@implementation AdvancedSetView 
@synthesize sourceController, delegate, Snooze, Vibrate, Volume ,OptionTable;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[super viewDidLoad];
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[OptionTable reloadData];
	
}


- (IBAction)Done  {
	[sourceController setValue:Volume forEditedProperty:@"SoundVolume"];
	[sourceController setValue:Snooze forEditedProperty:@"SnoozeONOFF"];
	[sourceController setValue:Vibrate forEditedProperty:@"VibrationONOFF"];
	
	[self.delegate flipsideViewControllerDidFinish:self];	
	
}

- (void)flipsideViewControllerDidFinish:(UIViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)SnoozeValueUpdate
{
	Snooze =  SnoozeOnOff.on;
}

-(void)SoundValueUpdate 
{
	Volume =  SoundVolume.value ;
}
-(void)VibrateValueUpdate 
{
	Vibrate =  VibrateOnOff.on;
}
/////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *CellIdentifier = @"List";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if(indexPath.section == 0)
	{
		
		
		if (cell == nil)
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellSelectionStyleNone reuseIdentifier:CellIdentifier] autorelease];
				
			switch (indexPath.row) {
				case 0:
					 SnoozeOnOff = [[UISwitch alloc] initWithFrame:CGRectMake(200,15, 30,30)];
					[SnoozeOnOff addTarget:self action:@selector(SnoozeValueUpdate) forControlEvents:UIControlEventValueChanged];
					 [cell.contentView addSubview:SnoozeOnOff];
					break;
				case 1:
					
					SoundVolume = [[UISlider alloc] initWithFrame:CGRectMake(200,15, 100,30)];
					SoundVolume.maximumValue = 5;
					SoundVolume.minimumValue = 1;

					SoundVolume.continuous = TRUE;
					
					[SoundVolume addTarget:self action:@selector(SoundValueUpdate) forControlEvents:UIControlEventValueChanged];
					[cell.contentView addSubview:SoundVolume];
					break;
				case 2:

					VibrateOnOff = [[UISwitch alloc] initWithFrame:CGRectMake(200,15, 30,30) ];
					
					[VibrateOnOff addTarget:self action:@selector(VibrateValueUpdate) forControlEvents:UIControlEventValueChanged];

					[cell.contentView addSubview:VibrateOnOff];
					
					break;

				default:
					break;
			}
		}
		switch (indexPath.row) {
			case 0:
				SnoozeOnOff.on = Snooze ;
				cell.textLabel.text = @"Snooze";
				break;
			case 1:
				SoundVolume.value = Volume; 
				
				cell.textLabel.text = @"Volume";
				break;
			case 2:
				VibrateOnOff.on = Vibrate;
		
				cell.textLabel.text = @"Vibrate";
				break;
			

		}
	cell.textLabel.backgroundColor = [UIColor clearColor];
	}
	
	return cell;
}

////////////////////////////////////////////////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}


- (void)dealloc {
    [super dealloc];
}

@end
