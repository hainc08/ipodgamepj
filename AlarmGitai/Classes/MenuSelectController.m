//
//  CharSelectController.m
//  AlarmGitai 
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainView.h"
#import "ActionManager.h"
#import "MenuSelectController.h"
#import "ButtonView.h"
#import "MenuTimeOptionController.h"
#import "AlarmConfig.h"

@implementation MenuSelectController


- (void)viewDidLoad {
    [super viewDidLoad];	
	/* resize 막기 */
//	self.view.autoresizesSubviews = NO;
//	self.view.autoresizingMask =UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	
	[self.view setBackgroundColor:[UIColor grayColor]];
	[self.view setAlpha:1];
		
	UIImageView *CharImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 90,238, 99)];
	 [CharImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"char_%@.png", 
										  [[AlarmConfig getInstance] getCharName]]]];
	[self.view addSubview:CharImage];
	[CharImage release];
	
	DisplayOption = [[ButtonView alloc] initWithFrame:CGRectMake(340, 40,  BUTTON_X, BUTTON_Y)];
	[DisplayOption setText:@"DISPLAY OPTION"];
	UIButton *OptionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,  BUTTON_X, BUTTON_Y) ];
	[OptionButton addTarget:self action:@selector(OptionButton:) forControlEvents:UIControlEventTouchUpInside];
	[DisplayOption setBackgroundColor:[UIColor redColor]];
	[DisplayOption addSubview:OptionButton];
	[self.view addSubview:DisplayOption];
	[OptionButton release];
	
	
	AlarmOption = [[ButtonView alloc] initWithFrame:CGRectMake(340, 140,  BUTTON_X, BUTTON_Y)];
	[AlarmOption setText:@"ALARM OPTION"];
	UIButton *AlarmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,  BUTTON_X, BUTTON_Y) ];
	[AlarmButton addTarget:self action:@selector(OptionButton:) forControlEvents:UIControlEventTouchUpInside];
	[AlarmOption addSubview:AlarmButton];
	[self.view addSubview:AlarmOption];
	[AlarmButton release];
	
	
	Done = [[ButtonView alloc] initWithFrame:CGRectMake(340, 240,  BUTTON_X, BUTTON_Y)];
	[Done setText:@"DONE"];
	UIButton *DoneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_X, BUTTON_Y) ];
	[DoneButton addTarget:self action:@selector(DoneButton:) forControlEvents:UIControlEventTouchUpInside];
	[Done addSubview:DoneButton];
	[self.view addSubview:Done];
	[DoneButton release];
	
	
	TimeOption = [[MenuTimeOptionController alloc] init];
	[TimeOption.view setFrame:CGRectMake(0, 0, 320, 480)];
	TimeOption.view.transform =  CGAffineTransformMakeRotation(3.14159/2);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	
}

- (void)DoneButton:(id)sender
{
	DataParam *data = [[DataParam alloc] init];
	[[ActionManager getInstance] setRootAction:ROTAGEUPDATE value:data];
	[data release];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)OptionButton:(id)sender
{
	[self.navigationController pushViewController:TimeOption animated:YES];
}

- (void)dealloc {
    [super dealloc];
}

@end

