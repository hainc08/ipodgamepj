#import "MainView.h"
#import "DateView.h"
#import	"ClockView.h"
#import "BaseView.h"
#import "SceneView.h"
#import "AlarmConfig.h"
#import "DateFormat.h"

#import "MenuController.h"
#import "MenuSelectController.h"
@implementation DataParam

@synthesize  iData;
@synthesize sData;

@end


@implementation MainView


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {

	if(viewrotate)
	{
	if( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
	{	
		selectmenu.view.transform =  CGAffineTransformMakeRotation(3.14159/2);
		[selectmenu.view setFrame:CGRectMake(0, 0, 320, 480 )];
		[self.navigationController pushViewController:selectmenu animated:YES];
	}
	else
	{
		selectmenu.view.transform =  CGAffineTransformMakeRotation(0);
		[selectmenu.view setFrame:CGRectMake(0, -320, 480, 320 )];
		[self.navigationController pushViewController:selectmenu animated:YES];
	}
		viewrotate = FALSE;
		[self stopTimer];
	}
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//캐릭터 리소스 확인용
	//static int k = 0;
	//[charView setChar:@"hitomi" idx:k isNight:true];
	//k++;
	//return;
	clockViewTouched = NO;
	dateViewTouched = NO;

	[menuconfig.view setAlpha:0];
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
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(editenable)
	{

		/* 메뉴를 화면에 보여주자..  글씨체.. 사이즈 조정 표현방식등 MenuClass 변경 */
			if(clockViewTouched == YES) {
				[clockview.view setFrame:[self viewcentersettle:clockview.view.frame]];
				[menuconfig reset:(clockview.view.transform.a)*10];
				[self menuViewFrameUpdate:clockview.view.frame];

			}
			else if(dateViewTouched == YES) {
				[dateview.view setFrame:[self viewcentersettle:dateview.view.frame]];
			[menuconfig reset:(dateview.view.transform.a)*10];
				[self menuViewFrameUpdate:dateview.view.frame];
			}

		menuEnable = true;
	}
}

-(CGRect)viewcentersettle:(CGRect) rect
{
	if( rect.origin.x + rect.size.width > self.view.frame.size.width )
		rect.origin.x -= ((rect.origin.x + rect.size.width )- self.view.frame.size.width);
	else if( rect.origin.x < 0)
		rect.origin.x = 1;
	
	if( rect.origin.y + rect.size.height > self.view.frame.size.height)
		rect.origin.y -= ((rect.origin.y + rect.size.height )- self.view.frame.size.height);
	else if (rect.origin.y < 0 )
		rect.origin.y = 1;
	
	return rect;
}

-(void)menuViewFrameUpdate:(CGRect ) rect
{
	int		x, y;

	x = rect.origin.x;
	if ( self.view.frame.size.height/2	< rect.origin.y ) 
		y = rect.origin.y  - 100;
	else
		y = rect.origin.y +rect.size.height ;

	[menuconfig.view setFrame:CGRectMake(x , y , 150, 100) ];
	[menuconfig.view setAlpha:1	];	
}

/* 각각 보여지는 크기를 조절 */
- (void) reset:(int)_type value:(NSObject *)_inValue
{
	if(_type == TRANSUPDATE)
	{
		if(menuEnable)
		{
			DataParam  *Trans = (DataParam *)_inValue;
			/* 메뉴를 화면에 보여주자..  글씨체.. 사이즈 조정 표현방식등 MenuClass 변경 */
			if(clockViewTouched == YES) {
				[clockview.view setTransform:CGAffineTransformMake((CGFloat)[Trans iData]/10, 0.0, 0.0, (CGFloat)[Trans iData]/10, 0.0, 0.0)];
			}
			else if(dateViewTouched == YES) {
				[dateview.view setTransform:CGAffineTransformMake((CGFloat)[Trans iData]/10, 0.0, 0.0, (CGFloat)[Trans iData]/10, 0.0, 0.0)];
			}
		}
	}
	else if (_type	== ROTAGEUPDATE)
	{
		[self resumeTimer];
		if( [[AlarmConfig getInstance] getDateMode] )
			[dateview.view setAlpha:1];
		else 
			[dateview.view setAlpha:0];
		viewrotate = TRUE;
		
	}
}

/* 흔들기를 사용하기 위해서 추가 */
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
	return YES;
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
	if( sender == MenuButton )
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
//	self.view.autoresizesSubviews = NO;
//	self.view.autoresizingMask =UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	
	viewrotate	= TRUE;
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
	[clockview.view setFrame:CGRectMake(0, 0, 520, 200)];
	[clockview.view setTransform:alarmviewpoint.ClockTrans]; 
	[clockview.view setCenter:alarmviewpoint.ClockPoint ];
	[clockview UpdateTime];
	[self.view addSubview:clockview.view];
	
	dateview = [[DateView alloc] init];
	[dateview.view setFrame:CGRectMake(0, 0, 520, 200)];
	[dateview.view setTransform:alarmviewpoint.DateTrans];
	[dateview.view setCenter:alarmviewpoint.DatePoint ];
	[dateview UpdateDate];
	[self.view addSubview:dateview.view];
	

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
	
	
	selectmenu = [[MenuSelectController alloc] init];
	[selectmenu.view setFrame:CGRectMake(0, 0, 320, 480)];

/*
	AlarmButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0 , 32, 31)];
	[AlarmButton setBackgroundImage:[ [UIImage imageNamed:@"alarm.png" ] stretchableImageWithLeftCapWidth:32.0 topCapHeight:31.0] forState:UIControlStateNormal];
	[AlarmButton setCenter:CGPointMake(300, 20)];
	[AlarmButton addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[AlarmButton setAlpha:1];
	[self.view addSubview:AlarmButton];

 */	
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
	if( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) 
		alarmviewpoint	= [[AlarmConfig getInstance] getHeigthViewPoint];	
	else 
		alarmviewpoint	= [[AlarmConfig getInstance] getWidthViewPoint];
	
	
	[clockview.view setTransform:alarmviewpoint.ClockTrans]; 
	[clockview.view setCenter:alarmviewpoint.ClockPoint ];

	[dateview.view setTransform:alarmviewpoint.DateTrans];
	[dateview.view setCenter:alarmviewpoint.DatePoint];
	
	/* Button Update */
	[MenuButton setCenter:CGPointMake(self.view.frame.size.width - 30, 10)];
	[MenuXbox	setCenter:CGPointMake(self.view.frame.size.width - 30, 10)];

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
