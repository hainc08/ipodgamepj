//
//  TimerView.m
//
//  Created by embmaster on 11. 2. 1..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TimerView.h"

@implementation TimerView

@synthesize delegate;
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
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

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[StopButton setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)TimeChange
{
	[dateFormatter setDateFormat:@"HH:MM:SS"];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents * comps = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[TimePicker date]];
	secs = [comps hour] * 60 * 60 + [comps minute] * 60;
	


	[TimeLabel setText:[NSString stringWithFormat:@"%02d:%02d:%02d" , [comps hour] , [comps minute], 0 ]];
	
}

- (IBAction)TimerStart
{
	[self resumeTimer];
	[self TimeChange];
	[StartButton setHidden:YES];
	[StopButton setHidden:NO];
	[TimePicker setHidden:YES];
	
}
- (IBAction)TimerStop
{
	[self stopTimer];
	[StopButton setHidden:YES];
	[StartButton setHidden:NO];
	[TimePicker setHidden:NO];
}


- (void)update
{
	NSInteger hour = 0;
	NSInteger minute = 0;
	NSInteger sec = 0;
	
	secs--;
	
	{
	if(secs >= 3600) 
		hour = secs / 3600;
	
	if ( (secs - (hour * 60 * 60) ) >= 60)
		minute =   (secs - (hour * 60 * 60) ) / 60;
	
	sec =  secs - (hour * 60 * 60) - (minute  * 60);
	
	
	[TimeLabel setText:[NSString stringWithFormat:@"%02d:%02d:%02d" , hour , minute , sec ]];
	}
	
}

- (void)stopTimer
{
	[timer invalidate]; 
	[timer release]; 
}

- (void)resumeTimer
{
	timer = [[NSTimer scheduledTimerWithTimeInterval: (1.0f)
													target: self
												  selector: @selector(update)
												  userInfo: self
												   repeats: YES] retain];	
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark ViewChange

- (void)flipsideViewControllerDidFinish:(UIViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}

@end
