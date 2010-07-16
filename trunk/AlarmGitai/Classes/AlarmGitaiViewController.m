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
	[UIView setAnimationDuration:0.5];
	
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass :[menuview class]])
		{
			if(hiddenMenu)
			{
				
				[view setFrame:CGRectMake(view.frame.origin.x, -100, view.frame.size.width, view.frame.size.height)];
			}
			else
			{
				
				[view setFrame:CGRectMake(view.frame.origin.x, 0, view.frame.size.width, view.frame.size.height)];
			}
		}
		
	}
	[UIView commitAnimations];
	hiddenMenu = !hiddenMenu;
	
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
	
	hiddenMenu = false;


	
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
	
	[menuview setCenter:CGPointMake(160, 0)];
	[menuview setAlpha:1];
//	[self.view sendSubviewToBack:dateview];
	
	
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
