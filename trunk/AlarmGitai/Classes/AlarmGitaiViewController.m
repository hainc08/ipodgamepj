//
//  AlarmGitaiViewController.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 13.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AlarmGitaiViewController.h"
#import "ViewManager.h"

#import "MenuView.h"
#import "DateView.h"
#import	"ClockView.h"
#import "BaseView.h"
#import "CharView.h"
#import "AlarmConfig.h"
@implementation AlarmGitaiViewController



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	[UIView	 beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.7];
	if(hiddenButton)
	{
		[MenuButton setFrame:CGRectMake(0, -100, 112, 98)];
		if(menuEnable)
		{
			[menuview setFrame:CGRectMake(-300, -480, 300, 480)];
			menuEnable = !menuEnable;

		}

	}
	else 
	{
		[MenuButton setTransform:CGAffineTransformMake(1, 0.0, 0.0, 1, 0.0, 0.0)];
		[MenuButton setFrame:CGRectMake(0, 0, 112, 98)];

	}
	[UIView commitAnimations];
/* 보이는게 구리네..;; 나중에 조정 */
	hiddenButton = !hiddenButton;
	[MenuButton setAlpha:1];
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
	
	ViewCgPoint	*alarmviewpoint	= [[AlarmConfig getInstance] getHeigthViewPoint];
	
	charView = (CharView *)[[ViewManager getInstance] getInstView:@"CharView"];
	[self.view addSubview:charView];
	[charView setTransform:CGAffineTransformMake(1, 0, 0, -1, 0, 0)];
	[charView setCenter:CGPointMake(160,240)];
	[charView setChar:@"natsuko" idx:1 isNight:false];
	
	clockview = (ClockView *)[[ViewManager getInstance] getInstView:@"ClockView"];
	
	[clockview setTransform:alarmviewpoint.ClockTrans]; 
	[clockview setCenter:alarmviewpoint.ClockPoint ];
	
	[clockview UpdateTime];
	[self.view addSubview:clockview];
	[clockview setAlpha:1];

	
	dateview = (DateView *)[[ViewManager getInstance] getInstView:@"DateView"];

	[dateview setTransform:alarmviewpoint.DateTrans];
	[dateview setCenter:alarmviewpoint.DatePoint];
	[dateview UpdateDate];
	[self.view addSubview:dateview];
	[dateview setAlpha:1];
	
	//menuview  = (MenuView *) [[ViewManager getInstance] addSubInstView:@"MenuView"];
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

	[self FrameUpdate];
	
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
	
	if(sender == MenuButton )
	{
		[MenuButton setAlpha:0];
		
		[UIView	 beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.7];
		[menuview setFrame:CGRectMake(0, -100, 320, 480)];
		[UIView commitAnimations];
	
		menuEnable = !menuEnable;
	}
}

	
- (void)update
{
		++frameTick;
	if(frameTick % 10)
		[self FrameUpdate];
	[clockview UpdateTime];
	[dateview UpdateDate];
}
		
- (void)FrameUpdate
{
	ViewCgPoint	*alarmviewpoint	;
	if( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) { 
		alarmviewpoint	= [[AlarmConfig getInstance] getHeigthViewPoint];	
		
		[clockview setTransform:alarmviewpoint.ClockTrans]; 
		[clockview setCenter:alarmviewpoint.ClockPoint ];
		
		[dateview setTransform:alarmviewpoint.DateTrans];
		[dateview setCenter:alarmviewpoint.DatePoint];
	}
	else 
	{
		alarmviewpoint	= [[AlarmConfig getInstance] getWidthViewPoint];
		[clockview setTransform:alarmviewpoint.ClockTrans]; 
		[clockview setCenter:alarmviewpoint.ClockPoint ];
		
		[dateview setTransform:alarmviewpoint.DateTrans];
		[dateview setCenter:alarmviewpoint.DatePoint];
	}
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
