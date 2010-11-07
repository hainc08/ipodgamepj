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


@implementation MenuTimeOptionController


- (CGRect) ButtonPlace:(int) row	y:(int) col
{
	int x = 0;
	int y = 0;
	
	if( 1 < col)
		x = ( BUTTON_X * (col-1) ) + (SPACE * (col-1));
	if( 1 < row ) 
		y = ( BUTTON_Y * (row-1) ) + (SPACE * (col-1));
	
	x += LRSIZE;
	y += UDSIZE;
	return CGRectMake( x , y , BUTTON_X, BUTTON_Y);
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor blackColor]];
	
	HourMode = [[ButtonView alloc] initWithFrame:[self ButtonPlace:1	y:1]];
	[HourMode setText:@"HOUR MODE"];
	UIButton *HourModeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_X, BUTTON_Y) ];
	[HourModeButton addTarget:self action:@selector(HourModeButton:) forControlEvents:UIControlEventTouchUpInside];
	[HourMode addSubview:HourModeButton];
	[self.view addSubview:HourMode];
	[HourModeButton release];
	
	DisplayDate = [[ButtonView alloc] initWithFrame:[self ButtonPlace:1	y:2]];
	[DisplayDate setText:@"DISPLAY DATE"];
	UIButton *DisplayButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_X, BUTTON_Y) ]; 
	[DisplayButton addTarget:self action:@selector(DisplayButton:) forControlEvents:UIControlEventTouchUpInside];
	[DisplayButton setBackgroundColor:nil];
	[DisplayDate addSubview:DisplayButton];
	[self.view addSubview:DisplayDate];
	[DisplayButton release];
	
	
	Done = [[ButtonView alloc] initWithFrame:[self ButtonPlace:1	y:3]];
	[Done setText:@"DONE"];
	UIButton *DoneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_X, BUTTON_Y) ];
	[DoneButton addTarget:self action:@selector(DoneButton:) forControlEvents:UIControlEventTouchUpInside];
	[Done addSubview:DoneButton];
	[self.view addSubview:Done];
	[DoneButton release];
	
}
-(void)HourModeButton:(id)sender
{
	[[AlarmConfig getInstance] setHourMode];
}
-(void)DisplayButton:(id)sender
{
	[[AlarmConfig getInstance] setDateMode];
}
-(void)DoneButton:(id)sender
{
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
