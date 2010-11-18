//
//  SelectViewController.m
//  AlarmGitai
//
//  Created by embmaster on 10. 08. 02.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MenuTimeOptionController.h"
#import "AlarmConfig.h"
#import	"ButtonView.h"
#import	"OptionPreview.h"

@implementation MenuTimeOptionController


- (CGRect) ButtonPlace:(int) row	y:(int) col
{
	int x = 0;
	int y = 0;
	
	if( 1 < col)
		x = ( BUTTON_X * (col-1) ) + (SPACE * (col-1));
	if( 1 < row ) 
		y = ( BUTTON_Y * (row-1) ) + (SPACE * (row-1));
	
	x += LRSIZE;
	y += UDSIZE;
	return CGRectMake( x , y , BUTTON_X, BUTTON_Y);
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor blackColor]];
	
	HourMode = [[ButtonView alloc] initWithFrame:[self ButtonPlace:1	y:3]];
	[HourMode setView:0  fontsize:12 fontColor:[UIColor whiteColor]  setText:@"HOUR MODE" bgColor:[UIColor redColor] chekImage:[[AlarmConfig getInstance] getHourMode]];
	UIButton *HourModeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_X, BUTTON_Y) ];
	[HourModeButton addTarget:self action:@selector(HourModeButton:) forControlEvents:UIControlEventTouchUpInside];
	[HourMode addSubview:HourModeButton];
	[self.view addSubview:HourMode];
	[HourModeButton release];
	
	DisplayDate = [[ButtonView alloc] initWithFrame:[self ButtonPlace:2	y:3]];
	[DisplayDate setView:0  fontsize:12 fontColor:[UIColor whiteColor]  setText:@"DISPLAY DATE" bgColor:[UIColor redColor] chekImage:[[AlarmConfig getInstance] getDateDisplay]];

	UIButton *DisplayButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_X, BUTTON_Y) ]; 
	[DisplayButton addTarget:self action:@selector(DateButton:) forControlEvents:UIControlEventTouchUpInside];
	[DisplayButton setBackgroundColor:nil];
	[DisplayDate addSubview:DisplayButton];
	[self.view addSubview:DisplayDate];
	[DisplayButton release];
	

	WeekDisplay = [[ButtonView alloc] initWithFrame:[self ButtonPlace:3	y:3]];
	[WeekDisplay setView:0  fontsize:12 fontColor:[UIColor whiteColor]  setText:@"SHOW Weekday" bgColor:[UIColor redColor] chekImage:[[AlarmConfig getInstance] getWeekDisplay]];
	
	UIButton *WeekDisplayButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_X, BUTTON_Y) ];
	[WeekDisplayButton addTarget:self action:@selector(WeekButton:) forControlEvents:UIControlEventTouchUpInside];
	[WeekDisplay addSubview:WeekDisplayButton];
	[self.view addSubview:WeekDisplay];
	[WeekDisplayButton release];
	
	
	Done = [[ButtonView alloc] initWithFrame:[self ButtonPlace:4 y:3]];
	[Done setView:0  fontsize:12 fontColor:[UIColor whiteColor]  setText:@"DONE" bgColor:[UIColor redColor] chekImage:FALSE];

	UIButton *DoneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_X, BUTTON_Y) ];
	[DoneButton addTarget:self action:@selector(DoneButton:) forControlEvents:UIControlEventTouchUpInside];
	[Done addSubview:DoneButton];
	[self.view addSubview:Done];
	[DoneButton release];
	

	
	preview = [[OptionPreview alloc] init];
	[self.view addSubview:preview.view];

	[preview SetHV:true];
	[preview refresh];
	[preview.view setCenter:CGPointMake(160, 160)];
}
-(void)HourModeButton:(id)sender
{
	[HourMode setCheck: [[AlarmConfig getInstance] setHourMode]];
	[preview refresh];
}
-(void)WeekButton:(id)sender
{
	[WeekDisplay setCheck: [[AlarmConfig getInstance] setWeekDisplay]];
	[preview refresh];
}
-(void)DateButton:(id)sender
{
	[DisplayDate setCheck:[[AlarmConfig getInstance] setDateDisplay]];
	[preview refresh];
}
-(void)DoneButton:(id)sender
{
	[[AlarmConfig getInstance] SaveConfig];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}
- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation {
	return NO;
}
- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	 [HourMode release];
	[DisplayDate release];
	[Done release]; 
    [super dealloc];
}


@end
