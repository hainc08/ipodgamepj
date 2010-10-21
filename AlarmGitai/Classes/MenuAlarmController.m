//
//  AlarmConfigController.m
//  AlarmGitai
//
//  Created by embmaster on 10. 08. 20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MenuAlarmController.h"
#import "ButtonView.h"


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
 	
	Save = [[ButtonView alloc] initWithFrame:CGRectMake(40, 40,  50, 50)];
	[Save setText:@"SAVE"];
	[Edit setTYPE:1];
	UIButton *SaveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50) ];
	[SaveButton addTarget:self action:@selector(OptionButton:) forControlEvents:UIControlEventTouchUpInside];
	[Save setBackgroundColor:[UIColor redColor]];
	[Save addSubview:SaveButton];
	[self.view addSubview:Save];
	[SaveButton release];
	
	Edit = [[ButtonView alloc] initWithFrame:CGRectMake(40, 40,  50, 50)];
	[Edit setText:@"EDIT"];
	[Edit setTYPE:1];
	UIButton *EditButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,  50, 50) ];
	[EditButton addTarget:self action:@selector(OptionButton:) forControlEvents:UIControlEventTouchUpInside];
	[Edit setBackgroundColor:[UIColor redColor]];
	[Edit addSubview:EditButton];
	[self.view addSubview:Edit];
	[EditButton release];
	
	
	Done = [[ButtonView alloc] initWithFrame:CGRectMake(300, 200,  BUTTON_X, BUTTON_Y)];
	[Done setText:@"DONE"];
	UIButton *DoneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_X, BUTTON_Y) ];
	[DoneButton addTarget:self action:@selector(DoneButton:) forControlEvents:UIControlEventTouchUpInside];
	[Done addSubview:DoneButton];
	[self.view addSubview:Done];
	[DoneButton release];
}


- (void)DoneButton:(id)sender
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
    [super dealloc];
}


@end

