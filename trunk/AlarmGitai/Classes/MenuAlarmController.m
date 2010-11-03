//
//  MenuAlarmController.m
//  AlarmGitai
//
//  Created by embmaster on 10. 10. 24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MenuAlarmController.h"
#import "ButtonView.h"
#import	"AlarmConfig.h"

@implementation MenuAlarmController

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
	
	AlarmTxt = [[ButtonView alloc] initWithFrame:CGRectMake(140, 50,  240, 50)];
	[AlarmTxt setText:@" 3:2 오전 "];
	[self.view addSubview:AlarmTxt];
	
	Save = [[ButtonView alloc] initWithFrame:CGRectMake(40, 50,  70, 50)];
	[Save setText:@"Save"];
	UIButton *SaveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,  70, 50) ];
	[SaveButton addTarget:self action:@selector(SaveButton:) forControlEvents:UIControlEventTouchUpInside];
	[Save addSubview:SaveButton];
	[self.view addSubview:Save];
	[SaveButton release];
	
	Edit = [[ButtonView alloc] initWithFrame:CGRectMake(40, 50,  70, 50)];
	[Edit setText:@"EDIT"];
	UIButton *EditButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 50) ];
	[EditButton addTarget:self action:@selector(EditButton:) forControlEvents:UIControlEventTouchUpInside];
	[Edit addSubview:EditButton];
	[self.view addSubview:Edit];
	[EditButton release];
	
	
	AlarmSetTxt = [[ButtonView alloc] initWithFrame:CGRectMake(40, 100,  240, 50)];
	[AlarmSetTxt setText:@" ALARM SET ? "];
	[self.view addSubview:AlarmSetTxt];
	
	AlarmSet = [[ButtonView alloc] initWithFrame:CGRectMake(260, 100,  70, 50)];
	[AlarmSet setText:@"YES"];
	UIButton *SetButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 50) ];
	[SetButton addTarget:self action:@selector(AlarmSetButton:) forControlEvents:UIControlEventTouchUpInside];
	[AlarmSet addSubview:SetButton];
	[self.view addSubview:AlarmSet];
	[SetButton release];
	

	Shake = [[ButtonView alloc] initWithFrame:CGRectMake(40, 180,  BUTTON_X, BUTTON_Y)];
	[Shake setText:@"SHAKE"];
	UIButton *ShakeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_X, BUTTON_Y) ];
	[ShakeButton addTarget:self action:@selector(ShakeButton:) forControlEvents:UIControlEventTouchUpInside];
	[Shake addSubview:ShakeButton];
	[self.view addSubview:Shake];
	[ShakeButton release];
	
	Snooze = [[ButtonView alloc] initWithFrame:CGRectMake(180, 180,  BUTTON_X, BUTTON_Y)];
	[Snooze setText:@"SNOOZE"];
	UIButton *SnoozeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_X, BUTTON_Y) ];
	[SnoozeButton addTarget:self action:@selector(ShakeButton:) forControlEvents:UIControlEventTouchUpInside];
	[Snooze addSubview:SnoozeButton];
	[self.view addSubview:Snooze];
	[SnoozeButton release];
	
	
	Done = [[ButtonView alloc] initWithFrame:CGRectMake(340, 100,  BUTTON_X, BUTTON_Y)];
	[Done setText:@"DONE"];
	UIButton *DoneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_X, BUTTON_Y) ];
	[DoneButton addTarget:self action:@selector(DoneButton:) forControlEvents:UIControlEventTouchUpInside];
	[Done addSubview:DoneButton];
	[self.view addSubview:Done];
	[DoneButton release];
	
	datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(40.0, 150.0, 150, 100)];
	datePicker.datePickerMode = UIDatePickerModeTime;
	[datePicker addTarget:self action:@selector(controlEventValueChanged:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:datePicker];
	[datePicker setAlpha:0];
	
}

-(void)controlEventValueChanged:(id)sender
{
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterNoStyle];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	[dateFormatter setDateFormat:(NSString*) @"h:mm a"];

	[AlarmTxt setText:[dateFormatter stringFromDate:[datePicker date]]];	
	[dateFormatter dealloc];
}

-(void)DoneButton:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
-(void)AlarmSetButton:(id)sender
{
	[[AlarmConfig getInstance] setAlarmONOFF];
	[AlarmSet setText:[[AlarmConfig getInstance] getAlarmONOFF] ? @"YES" : @"NO"];
}
-(void)EditButton:(id)sender
{
	[Edit setAlpha:0];
[datePicker setAlpha:1];
}


-(void)SaveButton:(id)sender
{
	[Edit setAlpha:1];
	[datePicker setAlpha:0];
}
-(void)ShakeButton:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

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

- (void)dealloc {
	[AlarmTxt release];
	[AlarmSetTxt release];
	[AlarmSet release];
	[Shake release];
	[Snooze release];
	[Save release];
	[Edit release];
	[Done release];
	[datePicker release];
    [super dealloc];
}


@end

