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
#import "DateFormat.h"

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
	
	NSString *temp;
	AlarmTxt = [[ButtonView alloc] initWithFrame:CGRectMake(140, 50,  240, 50)];
	temp = [[AlarmConfig getInstance] getAlarmTime];
	NSRange Range = [temp rangeOfString:@"/"];
	if(Range.location == NSNotFound)
		[AlarmTxt setText: [[DateFormat getInstance] getAlarmFormat: @"h:mm a"]];
	else
	{
		NSString *res = [temp substringWithRange:NSMakeRange(0,Range.length-1)];
		NSString *res1 = [temp substringFromIndex:Range.length+1];

		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"kk:mm"];
		NSDate *dateFromString = [[NSDate alloc] init];
		
		dateFromString = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@:%@", res, res1]];
		[dateFormatter setDateFormat:@"h:mm a"];
		
		[AlarmTxt setText:[dateFormatter stringFromDate:dateFromString]];
	}
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
	
	Vibration = [[ButtonView alloc] initWithFrame:CGRectMake(320 , 180,  BUTTON_X, BUTTON_Y)];
	[Vibration setText:@"VIBRATION"];
	UIButton *VibrationButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_X, BUTTON_Y) ];
	[VibrationButton addTarget:self action:@selector(ShakeButton:) forControlEvents:UIControlEventTouchUpInside];
	[Vibration addSubview:VibrationButton];
	[self.view addSubview:Vibration];
	[VibrationButton release];
	
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

-(NSString *)GetPickerDate:(NSString *)_inFormat
{
	NSString *_retvalue;
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterNoStyle];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	[dateFormatter setDateFormat:(NSString*) _inFormat];
	_retvalue =  [dateFormatter stringFromDate:[datePicker date]];
	[dateFormatter dealloc];
	return _retvalue;
}


-(void)controlEventValueChanged:(id)sender
{
	[AlarmTxt setText:[self GetPickerDate: @"h:mm a"] ];
}

-(void)DoneButton:(id)sender
{
	[[AlarmConfig getInstance] SaveConfig];
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
	[[AlarmConfig getInstance] setAlarmTime:[self GetPickerDate: @"kk/mm"]];
	[[AlarmConfig getInstance] SaveConfig];
	[Edit setAlpha:1];
	[datePicker setAlpha:0];
}
-(void)ShakeButton:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation {
	return NO;
}
- (void) reset
{
	[datePicker setAlpha:0];
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
	[super dealloc];
	
	[AlarmTxt release];
	[AlarmSetTxt release];
	[AlarmSet release];
	[Shake release];
	[Snooze release];
	[Save release];
	[Edit release];
	[Done release];
	[datePicker release];
	[Vibration release];

}


@end

