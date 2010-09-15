//
//  AlarmGitaiViewController.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 13.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AlarmGitaiViewController.h"
#import "ViewManager.h"

#import "DateView.h"
#import	"ClockView.h"
#import "BaseView.h"
#import "SceneView.h"
#import "AlarmConfig.h"
#import "MaskView.h"
#import "DateFormat.h"
#import "LogoView.h"

#import "MenuController.h"
#import "AlarmController.h"

@implementation AlarmGitaiViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//캐릭터 리소스 확인용
	//static int k = 0;
	//[charView setChar:@"hitomi" idx:k isNight:true];
	//k++;
	//return;
	
	[UIView	 beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.7];
	if(hiddenButton)
	{
		[MenuButton setFrame:CGRectMake(0, -100, 112, 98)];

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
	

	sceneView = (SceneView *)[[ViewManager getInstance] getInstView:@"SceneView"];
	[sceneView reset];
	[sceneView setCenter:CGPointMake(160,240)];
	[sceneView setChar:[AlarmConfig getInstance].CharName];
	[sceneView next];
	[self.view addSubview:sceneView];

	
	clockview = (ClockView *)[[ViewManager getInstance] getInstView:@"ClockView"];	
	[clockview setTransform:alarmviewpoint.ClockTrans]; 
	[clockview setCenter:alarmviewpoint.ClockPoint ];
	[clockview UpdateTime];
	[clockview setAlpha:1];
	[self.view addSubview:clockview];


	
	dateview = (DateView *)[[ViewManager getInstance] getInstView:@"DateView"];
	[dateview setTransform:alarmviewpoint.DateTrans];
	[dateview setCenter:alarmviewpoint.DatePoint];
	[dateview UpdateDate];
	[dateview setAlpha:1];
	[self.view addSubview:dateview];


/*
 	MenuButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0 , 112, 98)];

	[MenuButton setBackgroundImage:[ [UIImage imageNamed:@"menu_b.png" ] stretchableImageWithLeftCapWidth:112.0 topCapHeight:98.0] forState:UIControlStateNormal];
	[MenuButton setCenter:CGPointMake(55, -90)];
	[MenuButton addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[MenuButton setAlpha:1];
	[self.view addSubview:MenuButton];
	

	AlarmButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0 , 32, 31)];
	[AlarmButton setBackgroundImage:[ [UIImage imageNamed:@"alarm.png" ] stretchableImageWithLeftCapWidth:32.0 topCapHeight:31.0] forState:UIControlStateNormal];
	[AlarmButton setCenter:CGPointMake(300, 20)];
	[AlarmButton addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[AlarmButton setAlpha:1];
	[self.view addSubview:AlarmButton];
	
	

	MenuController *menuconfig = [[MenuController alloc] initWithStyle:UITableViewStyleGrouped];

	menuNavi = [[UINavigationController alloc] initWithRootViewController:menuconfig] ;
	[menuconfig release];

*/	
	AlarmController *alarmconfig = [[AlarmController alloc] initWithStyle:UITableViewStylePlain];
	alarmNavi = [[UINavigationController alloc] initWithRootViewController:alarmconfig] ;
	[alarmconfig release];
	
	frameTick = 0;
	//너무 자주 업데잇할 필요가 없을 듯~
	framePerSec = 1.f;
	isInit = false;
/* 
	maskView = (MaskView *)[[ViewManager getInstance] getInstView:@"MaskView"];
	[maskView setTransform:CGAffineTransformMake(1, 0, 0, -1, 0, 0)];
	[maskView reset];
	[self.view addSubview:maskView];
	[maskView setAlpha:1];	
	[menuview setCenter:CGPointMake(160, 240)];
*/
	LogoView* logoView = (LogoView *)[[ViewManager getInstance] getInstView:@"LogoView"];
	[self.view addSubview:logoView];
	[logoView setAlpha:1];	

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
	if(sender == AlarmButton)
	{
		[self.view addSubview:alarmNavi.view];
		[alarmNavi.view setAlpha:1];
	}
	else if( sender == MenuButton )
	{
		[self.view addSubview:menuNavi.view];
		[menuNavi.view setAlpha:1];
	}
}

	
- (void)update
{
	++frameTick;
	if((frameTick % 5) == 0)
	{
		[sceneView next];
	}
	
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
