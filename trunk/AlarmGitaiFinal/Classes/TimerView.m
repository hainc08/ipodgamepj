//
//  TimerView.m
//
//  Created by embmaster on 11. 2. 1..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TimerView.h"
#import "SoundManager.h"
#import	"AlarmConfig.h"

@implementation TimerView

@synthesize delegate;
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"top.png"]]];
	
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
	[TimeLabel	setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self TimerStop];
}

- (IBAction)cancel:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];	
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
	[TimeLabel	setHidden:NO];
	
}
- (IBAction)TimerStop
{
	[self timeOver:false];
	[self stopTimer];
	[StopButton setHidden:YES];
	[StartButton setHidden:NO];
	[TimePicker setHidden:NO];
	[TimeLabel	setHidden:YES];
}


- (void)update
{
	if (secs <= 0) return;

	secs-=1;

	NSInteger hour = 0;
	NSInteger minute = 0;
	NSInteger sec = secs;
	
	hour = sec / 3600;
	sec = sec % 3600;
	
	minute = sec / 60;
	sec = sec % 60;
	
	[TimeLabel setText:[NSString stringWithFormat:@"%02d:%02d:%02d" , hour , minute , sec ]];	

	if (secs == 0)
	{
		//타이머가 끝났으니 뭐라도 하자...
		[self timeOver:true];
		return;
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

- (void)timeOver:(bool)valid
{
	if (valid)
	{
		AlarmDate* aDate = [[AlarmDate alloc] init];
		[aDate setSound:@"Simple Alarm"];
		[aDate setSoundVolume:6];
		[[SoundManager getInstance] playAlarm:aDate];
		[aDate release];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Timer Aler"
													   delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[alert show];
		[alert release];
	}
}

#pragma mark -
#pragma mark ViewChange

- (void)flipsideViewControllerDidFinish:(UIViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark  AlertView 

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	[[SoundManager getInstance] stopAlarm];
	[self TimerStop];
}

#pragma mark -
#pragma mark TableView


/////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Set up the cell...
	if(indexPath.section == 0)
	{
	
	}
	
	return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 7;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0)
	{
	}
}


@end
