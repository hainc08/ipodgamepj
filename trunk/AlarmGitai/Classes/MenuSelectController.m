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
#import "MenuAlarmController.h"
#import "AlarmConfig.h"

@implementation MenuSelectController


- (void)viewDidLoad {
    [super viewDidLoad];	
	
	
	[self.view setBackgroundColor:[UIColor grayColor]];
	[self.view setAlpha:1];
		
	UIImageView *CharImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 90,238, 99)];
	 [CharImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"char_%@.png", 
										  [[AlarmConfig getInstance] getCharName]]]];
	[self.view addSubview:CharImage];
	[CharImage release];
	
	DisplayOption = [[ButtonView alloc] initWithFrame:CGRectMake(340, 40,  BUTTON_X, BUTTON_Y)];
	[DisplayOption setView:0  fontsize:12 fontColor:[UIColor whiteColor]  setText:@"DISPLAY OPTION" bgColor:[UIColor redColor] chekImage:FALSE];
	UIButton *OptionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,  BUTTON_X, BUTTON_Y) ];
	[OptionButton addTarget:self action:@selector(DisplayOptionButton:) forControlEvents:UIControlEventTouchUpInside];
	[DisplayOption addSubview:OptionButton];
	[self.view addSubview:DisplayOption];
	[OptionButton release];
	
	
	AlarmOption = [[ButtonView alloc] initWithFrame:CGRectMake(340, 140,  BUTTON_X, BUTTON_Y)];
	[AlarmOption setView:0  fontsize:12 fontColor:[UIColor whiteColor]  setText:@"ALARM OPTION" bgColor:[UIColor redColor] chekImage:FALSE];

	UIButton *AlarmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,  BUTTON_X, BUTTON_Y) ];
	[AlarmButton addTarget:self action:@selector(AlarmOptionButton:) forControlEvents:UIControlEventTouchUpInside];
	[AlarmOption addSubview:AlarmButton];
	[self.view addSubview:AlarmOption];
	[AlarmButton release];
	
	
	Done = [[ButtonView alloc] initWithFrame:CGRectMake(340, 240,  BUTTON_X, BUTTON_Y)];
	[Done setView:0  fontsize:12 fontColor:[UIColor whiteColor]  setText:@"DONE" bgColor:[UIColor redColor] chekImage:FALSE];

	UIButton *DoneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_X, BUTTON_Y) ];
	[DoneButton addTarget:self action:@selector(DoneButton:) forControlEvents:UIControlEventTouchUpInside];
	[Done addSubview:DoneButton];
	[self.view addSubview:Done];
	[DoneButton release];
	
	
	CT_TimeOption = [[MenuTimeOptionController alloc] init];
	[CT_TimeOption.view setFrame:CGRectMake(0, 0, 320, 480)];
//	CT_TimeOption.view.transform =  CGAffineTransformMakeRotation(3.14159/2);
	
	CT_AlarmOption = [[MenuAlarmController alloc] init];
	[CT_AlarmOption.view setFrame:CGRectMake(0, 0, 320, 480)];
//	CT_AlarmOption.view.transform =  CGAffineTransformMakeRotation(3.14159/2);
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
- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation {
	return NO;
}
- (void)DoneButton:(id)sender
{
	[[AlarmConfig getInstance] SaveConfig];
	[[ActionManager getInstance] setRootAction:ROTAGEUPDATE value:nil];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)DisplayOptionButton:(id)sender
{	//
	if( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
		CT_TimeOption.view.transform =  CGAffineTransformMakeRotation(3.14159/2);
	else
		CT_TimeOption.view.transform =  CGAffineTransformMakeRotation(0);
	[self.navigationController pushViewController:CT_TimeOption animated:YES];
}
- (void)AlarmOptionButton:(id)sender
{
	if( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
		CT_AlarmOption.view.transform =  CGAffineTransformMakeRotation(3.14159/2);
	else
		CT_AlarmOption.view.transform =  CGAffineTransformMakeRotation(0);
	[CT_AlarmOption reset];
	[self.navigationController pushViewController:CT_AlarmOption animated:YES];
}

- (void)dealloc {
	[CT_TimeOption release];
	[CT_AlarmOption release];
	[DisplayOption release];
	[AlarmOption release];
	[Done release]; 
    [super dealloc];
}

@end

