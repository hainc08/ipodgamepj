#import "MainView.h"
#import "DateView.h"
#import	"ClockView.h"
#import "BaseView.h"
#import "SceneView.h"
#import "AlarmConfig.h"
#import "DateFormat.h"

#import "MenuController.h"
#import "AlarmController.h"

@implementation MainView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//캐릭터 리소스 확인용
	//static int k = 0;
	//[charView setChar:@"hitomi" idx:k isNight:true];
	//k++;
	//return;
	clockViewTouched = NO;
	dateViewTouched = NO;
	weekViewTouched = NO;
	if(editenable)
	{
		UITouch *currentTouch = [[event allTouches] anyObject];
		CGPoint touchPoint = [currentTouch locationInView:self.view];
		
		if (CGRectContainsPoint(clockview.view.frame, touchPoint)) {
			clockViewTouched = YES;
		}	
		else if (CGRectContainsPoint(dateview.view.frame, touchPoint)) {
			dateViewTouched = YES;
		}
		else if (CGRectContainsPoint(weekview.view.frame, touchPoint)) {
			weekViewTouched = YES;
		}
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(editenable)
	{
		UITouch *currentTouch = [[event allTouches] anyObject];	
		CGPoint currentPoint = [currentTouch locationInView:self.view];
	
		if(clockViewTouched == YES) {
			clockview.view.center = CGPointMake(currentPoint.x,currentPoint.y);
		}
		else if(dateViewTouched == YES) {
			dateview.view.center = CGPointMake(currentPoint.x,currentPoint.y);
		}
		else if(weekViewTouched == YES) {
			weekview.view.center = CGPointMake(currentPoint.x,currentPoint.y);
		}
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(editenable)
	{
		ViewCgPoint	*alarmviewpoint	;
		if( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
		alarmviewpoint	= [[AlarmConfig getInstance] getHeigthViewPoint];
		else	
		alarmviewpoint	= [[AlarmConfig getInstance] getWidthViewPoint];
		
		/* 메뉴를 화면에 보여주자..  글씨체.. 사이즈 조정 표현방식등 MenuClass 변경 */
		if(clockViewTouched == YES) {
			[menuconfig reset:(clockview.view.transform.a)*10];
		}
		else if(dateViewTouched == YES) {
		[menuconfig reset:dateview.view.transform.a];
		}
		else if(weekViewTouched == YES) {
		[menuconfig reset:weekview.view.transform.a];
		}
		menuEnable = true;
	}
	
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
	
	editenable	= false;
	hiddenButton = false;
	menuEnable   = false;

	ViewCgPoint	*alarmviewpoint	= [[AlarmConfig getInstance] getHeigthViewPoint];

	sceneView = [[SceneView alloc] init];
	[sceneView reset];
	[sceneView.view setCenter:CGPointMake(160,240)];
	[sceneView setChar:[AlarmConfig getInstance].CharName];
	[sceneView next];
	[self.view addSubview:sceneView.view];
	
	clockview = [[ClockView alloc] init];
	[clockview.view setFrame:CGRectMake(0, 0, 500, 360)];
	[clockview.view setTransform:alarmviewpoint.ClockTrans]; 
	[clockview.view setCenter:alarmviewpoint.ClockPoint ];
	[clockview UpdateTime];
	[self.view addSubview:clockview.view];
	
	dateview = [[DateView alloc] init];
	[dateview.view setFrame:CGRectMake(0, 0, 500, 360)];
	[dateview.view setTransform:alarmviewpoint.DateTrans];
	[dateview.view setCenter:alarmviewpoint.DatePoint ];
	[dateview UpdateDate];
	[self.view addSubview:dateview.view];
	
	
/*
	dateview = [[DateView alloc] init];
	[dateview.view setTransform:alarmviewpoint.DateTrans];
	[dateview.view setCenter:alarmviewpoint.DatePoint];
	[dateview UpdateDate];
	[dateview.view setAlpha:1];
	[self.view addSubview:dateview.view];
*/

 	MenuButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0 , 112, 98)];
	[MenuButton setTitle:@"enable" forState:UIControlStateNormal];
	[MenuButton addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[MenuButton setCenter:CGPointMake(290,10)];
	[MenuButton setAlpha:1];
	[self.view addSubview:MenuButton];
	
	
	/* xbox Button */
	MenuXbox = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30) ];
	[MenuXbox setBackgroundImage:[UIImage imageNamed:@"xbox.png" ] forState:UIControlStateNormal];
	[MenuXbox addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[MenuXbox setTransform:CGAffineTransformMake(0.7, 0,0,0.7, 0,0)];
	[MenuXbox setCenter:CGPointMake(290, 10)];
	[MenuXbox setAlpha:0];
	[self.view addSubview:MenuXbox];
	
	menuconfig = [[MenuController alloc] initWithStyle:UITableViewStylePlain];
	[menuconfig.tableView setFrame:CGRectMake(0, 0, 150, 100)];
	[self.view addSubview:[menuconfig view]];
	
	

/*
	AlarmButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0 , 32, 31)];
	[AlarmButton setBackgroundImage:[ [UIImage imageNamed:@"alarm.png" ] stretchableImageWithLeftCapWidth:32.0 topCapHeight:31.0] forState:UIControlStateNormal];
	[AlarmButton setCenter:CGPointMake(300, 20)];
	[AlarmButton addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[AlarmButton setAlpha:1];
	[self.view addSubview:AlarmButton];
	
	


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
- (void)ConfigSetup{
	ViewCgPoint *config = [ViewCgPoint alloc];
	
	[config setClockTrans:clockview.view.transform];
	[config setClockPoint:clockview.view.center];
	[config setDateTrans:dateview.view.transform];
	[config setDatePoint:dateview.view.center];

	if( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
		[[AlarmConfig getInstance] setHeigthViewPoint:config];
	else	
		[[AlarmConfig getInstance] setWidthViewPoint:config];
	
	[config release];
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
		[self stopTimer];
		[MenuXbox setAlpha:1];
		[MenuButton setAlpha:0];
		editenable = true;
	}
	else if( sender == MenuXbox)
	{
		[self resumeTimer];
		[self ConfigSetup];	
		[MenuXbox setAlpha:0];
		[MenuButton setAlpha:1];
		editenable = false;
		menuEnable = false;
	}
}
- (void) setTransView:(int)_inTrans
{
	if(menuEnable)
	{
		/* 메뉴를 화면에 보여주자..  글씨체.. 사이즈 조정 표현방식등 MenuClass 변경 */
		
		if(clockViewTouched == YES) {
			[clockview.view setTransform:CGAffineTransformMake((CGFloat)_inTrans/10, 0.0, 0.0, (CGFloat)_inTrans/10, 0.0, 0.0)];
		}
		else if(dateViewTouched == YES) {
			dateViewTouched = NO;
			[dateview.view setTransform:CGAffineTransformMake((CGFloat)_inTrans/10, 0.0, 0.0, (CGFloat)_inTrans/10, 0.0, 0.0)];
		}
		else if(weekViewTouched == YES) {
			weekViewTouched = NO;
			[weekview.view setTransform:CGAffineTransformMake((CGFloat)_inTrans/10, 0.0, 0.0, (CGFloat)_inTrans/10, 0.0, 0.0)];
		}
		
	}
}

- (void)update
{
	++frameTick;
	if((frameTick % 5) == 0)
	{
		[sceneView next];
		[self FrameUpdate];
	}
	

	[clockview UpdateTime];
	[dateview UpdateDate];
}
		
- (void)FrameUpdate
{
	ViewCgPoint	*alarmviewpoint	;
	if( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) { 
		alarmviewpoint	= [[AlarmConfig getInstance] getHeigthViewPoint];	
		
		[clockview.view setTransform:alarmviewpoint.ClockTrans]; 
		[clockview.view setCenter:alarmviewpoint.ClockPoint ];
		
		[dateview.view setTransform:alarmviewpoint.DateTrans];
		[dateview.view setCenter:alarmviewpoint.DatePoint];
		
		/* Button Update */
		[MenuButton setCenter:CGPointMake(290, 10)];
		[MenuXbox	setCenter:CGPointMake(290, 10)];
		
	}
	else 
	{
		alarmviewpoint	= [[AlarmConfig getInstance] getWidthViewPoint];
		[clockview.view setTransform:alarmviewpoint.ClockTrans]; 
		[clockview.view setCenter:alarmviewpoint.ClockPoint ];
		
		[dateview.view setTransform:alarmviewpoint.DateTrans];
		[dateview.view setCenter:alarmviewpoint.DatePoint];
		
		
		[MenuButton setCenter:CGPointMake(450, 10)];
		[MenuXbox	setCenter:CGPointMake(450, 10)];
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
