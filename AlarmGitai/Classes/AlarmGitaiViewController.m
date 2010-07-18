//
//  AlarmGitaiViewController.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 13.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AlarmGitaiViewController.h"
#import "ViewManager.h"
#import "MainAlarm.h"
#import "MenuView.h"
#import "DateView.h"
#import	"ClockView.h"
#import "BaseView.h"

@implementation AlarmGitaiViewController



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	[UIView	 beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.7];
	if(hiddenButton)
		[MenuButton setFrame:CGRectMake(0, -100, 112, 98)];
	else 
	{
		[MenuButton setTransform:CGAffineTransformMake(1, 0.0, 0.0, 1, 0.0, 0.0)];
		[MenuButton setFrame:CGRectMake(0, 0, 112, 98)];
	}
	if(menuEnable)
	{
		
		[menuview setFrame:CGRectMake(-300, -480, 300, 480)];
		menuEnable = !menuEnable;
	}
		
	[UIView commitAnimations];
	hiddenButton = !hiddenButton;
	
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
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
	
	hiddenButton = false;
	menuEnable   = false;

	
	mainAlarm = (MainAlarm *)[[ViewManager getInstance] getInstView:@"MainAlarm"];
	[self.view addSubview:mainAlarm];
	
	
	clockview = (ClockView *)[[ViewManager getInstance] getInstView:@"ClockView"];
	[clockview UpdateTime];
	clockview.transform =  CGAffineTransformMake(0.5, 0.0, 0.0, 0.5, 0.0, 0.0);
	
	[self.view addSubview:clockview];
	[clockview setCenter:CGPointMake(65,410)];

	[clockview setAlpha:1];

	dateview = (DateView *)[[ViewManager getInstance] getInstView:@"DateView"];
	[dateview UpdateDate];
	dateview.transform =  CGAffineTransformMake(0.3, 0.0, 0.0, 0.3, 0.0, 0.0);
	
	[self.view addSubview:dateview];
	[dateview setCenter:CGPointMake(35,50)];
	[dateview setAlpha:1];
	

	
	menuview = (MenuView *)[[ViewManager getInstance] getInstView:@"MenuView"];
	menuview.transform =  CGAffineTransformMake(1, 0.0, 0.0, 1, 0.0, 0.0);
	[self.view addSubview:menuview];
	
	[menuview setCenter:CGPointMake(-300, -480)];
	[menuview setAlpha:1];

	MenuButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0 , 112, 98)];
	
																																  
	[MenuButton setBackgroundImage:[ [UIImage imageNamed:@"menu_b.png" ] stretchableImageWithLeftCapWidth:112.0 topCapHeight:98.0] forState:UIControlStateNormal];
	
	
	[MenuButton setCenter:CGPointMake(55, -90)];
	[MenuButton addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[MenuButton setAlpha:1];
	[self.view addSubview:MenuButton];
	
	frameTick = 0;
	framePerSec = 10.f;
	isInit = false;
	
	
	[self resumeTimer];
	
}


#ifdef __IPHONE_3_0
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
#else
- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation: (UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration {    
		UIInterfaceOrientation interfaceOrientation = self.interfaceOrientation;
#endif
	
	if( interfaceOrientation == UIInterfaceOrientationPortrait ||interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) { 
	
		[clockview setCenter:CGPointMake(65,410)];
		[dateview setCenter:CGPointMake(35,50)];
		[clockview setTransform:CGAffineTransformMake(0.5, 0.0, 0.0, 0.5, 0.0, 0.0)];
	}
	else 
	{
		
		[clockview setCenter:CGPointMake(65,260)];
		[dateview setCenter:CGPointMake(45,50)];
		[clockview setTransform:CGAffineTransformMake(0.7, 0.0, 0.0, 0.7, 0.0, 0.0)];
	}
	
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
	
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
//	return YES;
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

- (void)ButtonClick:(id)sender
{
	if( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) { 
	
	}
	else
	{
		
	}
	
	
	[UIView	 beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.7];
	
	if(menuEnable)
	{
		[menuview setFrame:CGRectMake(-320, -480, 320, 480)];
		[MenuButton setTransform:CGAffineTransformMake(1, 0.0, 0.0, 1, 0.0, 0.0)];
		[MenuButton setCenter:CGPointMake(0, 0)];
	}
	else
	{
		[menuview setFrame:CGRectMake(0, -150, 320, 480)];
		[MenuButton setTransform:CGAffineTransformMake(0.5, 0.0, 0.0, 0.5, 0.0, 0.0)];
		[MenuButton setCenter:CGPointMake(297, 305)];
	}
	
	
	[UIView commitAnimations];
	
	menuEnable = !menuEnable;
	
}

	
- (void)update
{
		++frameTick;
	[clockview UpdateTime];
	[dateview UpdateDate];
}
	
- (void)stopTimer
{
	[updateTimer invalidate]; 
	[updateTimer release]; 
}
	
- (void)resumeTimer
	{
	updateTimer = [[NSTimer scheduledTimerWithTimeInterval: (1.0f/framePerSec)
														target: self
													  selector: @selector(update)
													  userInfo: self
													   repeats: YES] retain];	
}
	


- (void)dealloc {
    [super dealloc];
}

@end
