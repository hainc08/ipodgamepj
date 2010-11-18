//
//  AlarmShakeController.m
//  AlarmGitai
//
//  Created by embmaster on 10. 11. 02.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import "ActionManager.h"
#import "ButtonView.h"
#import "MainView.h"

#import "AlarmShakeController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/AudioServices.h>
#import "AlarmConfig.h"


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

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	
	ShakeCount--;

	if(ShakeCount==0)
	{
	}
	

}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];	

	EndButton = [[ButtonView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
	[EndButton setView:0  fontsize:12 fontColor:[UIColor whiteColor]  setText:@"OFF" bgColor:[UIColor redColor] chekImage:FALSE];
	UIButton *Button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100) ];
	[Button addTarget:self action:@selector(OffButton:) forControlEvents:UIControlEventTouchUpInside];
	[EndButton addSubview:Button];
	[self.view addSubview:EndButton];
	[Button release];
	
	
	SnoozeButton = [[ButtonView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
	[SnoozeButton setView:0  fontsize:12 fontColor:[UIColor whiteColor]  setText:@"SNOOZ" bgColor:[UIColor redColor] chekImage:FALSE];
	UIButton *SnoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100) ];
	[SnoButton addTarget:self action:@selector(SnoozeButton:) forControlEvents:UIControlEventTouchUpInside];
	[SnoozeButton addSubview:SnoButton];
	[self.view addSubview:SnoozeButton];
	[SnoButton release];
	
}
-(void)OffButton:(id)sender
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)SnoozeButton:(id)sender
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}
- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation {
	return NO;
}

- (void)vibration
{
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
- (void)stopTimer
{
	[vibrationTimer invalidate]; 
	[vibrationTimer release];
}

- (void)resumeTimer
{
	vibrationTimer = [[NSTimer scheduledTimerWithTimeInterval: (0.5)
													target: self
												  selector: @selector(vibration)
												  userInfo: self
												   repeats: YES] retain];	
}

 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
	 if([[AlarmConfig getInstance] getVibrationONOFF])
		 [self resumeTimer];
 }

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	ShakeCount = 10;
	if([[AlarmConfig getInstance] getVibrationONOFF])
		[self stopTimer];
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


- (void)dealloc {
    [super dealloc];
}


@end
