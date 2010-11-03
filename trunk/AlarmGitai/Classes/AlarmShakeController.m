//
//  AlarmShakeController.m
//  AlarmGitai
//
//  Created by embmaster on 10. 11. 02.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AlarmShakeController.h"


@implementation AlarmShakeController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	EndButton = [[UIButton buttonWithType:UIButtonTypeCustom] initWithFrame:CGRectMake(100, 100, 100, 100)];
	
	[EndButton addTarget:self action:@selector(EndButton:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:EndButton];
}
-(void)EndButton:(id)sender
{
	[self.navigationController popToRootViewControllerAnimated:YES];
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


- (void)dealloc {
    [super dealloc];
}


@end
