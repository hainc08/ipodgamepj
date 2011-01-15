//
//  FlipsideViewController.m
//  AlarmGitaiFinal
//
//  Created by Sasin on 10. 11. 25..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainClockViewController.h"
#import "OptionViewController.h"

#import "DateView.h"
#import	"ClockView.h"
#import "BaseView.h"
#import "SceneView.h"
#import "AlarmConfig.h"
#import "DateFormat.h"
#import "NewWeekView.h"
#import	"SoundManager.h"

@implementation MainClockViewController

@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
	
	stopalarm = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	stopalarm.frame = CGRectMake(0, 0, self.navigationController.toolbar.frame.size.width, self.navigationController.toolbar.frame.size.height);
	stopalarm.backgroundColor = [UIColor clearColor];
	[stopalarm setTitle:@"StopAlarm" forState:UIControlStateNormal];
	[stopalarm addTarget:self action:@selector(StopAlarm:)forControlEvents:UIControlEventTouchUpInside];
	[self.navigationController.toolbar addSubview:stopalarm];
	[stopalarm release];
	
	snoozealarm = [[UIButton buttonWithType:UIButtonTypeCustom ] retain];
	snoozealarm.frame = CGRectMake(0, 0, self.navigationController.toolbar.frame.size.width, self.navigationController.toolbar.frame.size.height);
	snoozealarm.backgroundColor = [UIColor clearColor];
	[snoozealarm setTitle:@"SnoozeAlarm" forState:UIControlStateNormal];
	[snoozealarm addTarget:self action:@selector(SnoozeButton:)forControlEvents:UIControlEventTouchUpInside];
	[self.navigationController.navigationBar addSubview:snoozealarm];
	[snoozealarm release];
	
	self.navigationController.toolbar.barStyle =UIBarStyleBlackTranslucent;
	self.navigationController.navigationBar.barStyle =UIBarStyleBlackTranslucent;
	
	[self AlarmBarHidden:YES];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
	self.view.autoresizesSubviews = NO;
	self.view.autoresizingMask =UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	
	viewrotate	= TRUE;
	editenable	= false;
	hiddenButton = false;
	menuEnable   = false;

	infoButton  = [UIButton buttonWithType:UIButtonTypeInfoLight];
	[infoButton addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:infoButton];
	
	ViewCgPoint	*alarmviewpoint	= [[AlarmConfig getInstance] getHeigthViewPoint];
	
	sceneView = [[SceneView alloc] init];
	[sceneView reset];
	[sceneView.view setCenter:CGPointMake(160,240)];
	[sceneView setChar:[AlarmConfig getInstance].CharName];
	[sceneView next];
	[self.view addSubview:sceneView.view];
	
	clockview = [[ClockView alloc] init];
	[clockview.view setFrame:CGRectMake(0, 0,320, 100)];
	[clockview.view setTransform:alarmviewpoint.ClockTrans]; 
	[clockview.view setCenter:alarmviewpoint.ClockPoint ];
	[clockview UpdateTime];
	[self.view addSubview:clockview.view];
	
	dateview = [[DateView alloc] init];
	[dateview.view setFrame:CGRectMake(0, 0, 320, 180)];
	[dateview.view setTransform:alarmviewpoint.DateTrans];
	[dateview.view setCenter:alarmviewpoint.DatePoint ];
	[dateview UpdateDate];
	[self.view addSubview:dateview.view];
	
	//요일표시를 두개를 넣었음...
	//선택할 수 있게 해야할텐데...UI가 어떻게 돌아가야할지 모르겠군...
	newWeekView = [[NewWeekView alloc] init];
	[newWeekView reset];
	[self.view addSubview:newWeekView.view];
	[newWeekView.view setCenter:CGPointMake(160, 460)];
	
	[self.view bringSubviewToFront:infoButton];
	[infoButton setCenter:CGPointMake(290, 30)];

	alarm_arr = [[AlarmConfig getInstance] getAlarmArr];
	frameTick = 0;
	//너무 자주 업데잇할 필요가 없을 듯~
	framePerSec = 1.f;
	isInit = false;
	isAlarmPlay = false;
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

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	[self FrameUpdate];

	[self resumeTimer];
	alarm_arr = [[AlarmConfig getInstance] getAlarmArr];
	viewrotate = TRUE;
	
	[infoButton setAlpha:0];

}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self stopTimer];
	viewrotate =FALSE;
}
- (IBAction)StopAlarm:(id)sender  {
	//[soundPlayer stop];
	[[SoundManager getInstance] stopAlarm];
	[self AlarmBarHidden:YES];
	isAlarmPlay = FALSE;
}
- (IBAction)SnoozeButton:(id)sender  {
	/* [soundPlayer stop]; */

	[self AlarmBarHidden:YES];
	isAlarmPlay = FALSE;
}
- (IBAction)ButtonClick:(id)sender
{
	if (sender == infoButton)
	{
	
		OptionViewController *controller = [[OptionViewController alloc] initWithNibName:@"OptionView" bundle:nil];
		controller.delegate = self;
		
		controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		[self presentModalViewController:controller animated:YES];
		
		[controller release];
	}
}

- (void)flipsideViewControllerDidFinish:(UIViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}
- (void) AlarmBarHidden:(BOOL)_hidden
{
	self.navigationController.toolbarHidden = _hidden;
	self.navigationController.navigationBarHidden = _hidden;
}
- (void) AlarmCheck
{
	if (isAlarmPlay == false) // 절대 스톱하기전에는 들어오지 않음...
	{
	int now = [[NSDate date] timeIntervalSince1970];

	for (int loop = 0; loop < [alarm_arr count] ; loop++) {
		AlarmDate *t_date  = [alarm_arr objectAtIndex:loop];
		if([t_date isAlarmONOFF])
		{
			//int alarm = [[t_date GetNSDate] timeIntervalSince1970];
			int alarm = [[t_date GetNSDate] timeIntervalSince1970];

			if(now >= alarm)
			{
				//다른 짓 하다가 1분이상 지나버렸다면 그냥 스킵...
			
				if ((now - alarm) < 60) 
				{
					//알람시간이 되었다!
					//여기서 뭘해줄꺼냐!
					[[SoundManager getInstance] playAlarm:t_date];
					
					[self AlarmBarHidden:NO]; // Alarm 화면을 보인다.. 
					isAlarmPlay = true;
						
					if ([t_date RepeatIdx] == 0){ 
						t_date.AlarmONOFF = false;
					}
					else
					{
						if([t_date isSnoozeONOFF] && (t_date.SnoozeCount > 0 )){
							t_date.SnoozeCount--;
							[t_date ResetNSDateSnooze]; // 기본 5분후에 
						}
						else // Snooze 전부 발생 했고 , 알람으로서 오늘 일은 끝~!! 내일 하자.
						{
							t_date.SnoozeCount = 5;
							[t_date NextDayNSDate];
						}	
					}
				}
				else {
				// 지났으니깐.. 다음날로 변경..
					t_date.SnoozeCount = 5;
					[t_date NextDayNSDate];
					if ([t_date RepeatIdx] == 0){ 
						t_date.AlarmONOFF = false;
					}
				}
				}
			}
		}
	}
}

- (void)update

{
	++frameTick;
	--infoButtonFrame;
	if((frameTick % 5) == 0)
	{
		[sceneView next];
		frameTick = 0;
	}
	
	if( infoButtonFrame == 0)
	{
		[infoButton setAlpha:0];
	}
	
	[self FrameUpdate];
	[self AlarmCheck];
	[clockview UpdateTime];
	[dateview UpdateDate];
	[newWeekView refresh];
}

- (void)FrameUpdate
{
	if(viewmode == VIEWNORMAL)
	{
		ViewCgPoint	*alarmviewpoint	;
	
		if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
			alarmviewpoint	= [[AlarmConfig getInstance] getHeigthViewPoint];	
		else 
			alarmviewpoint	= [[AlarmConfig getInstance] getWidthViewPoint];
		
		[clockview.view setTransform:alarmviewpoint.ClockTrans]; 
		[clockview.view setCenter:alarmviewpoint.ClockPoint ];
		
		[dateview.view setTransform:alarmviewpoint.DateTrans];
		[dateview.view setCenter:alarmviewpoint.DatePoint];
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

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	
	if(viewrotate)
	{
		if( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
		{	
//			selectmenu.view.transform =  CGAffineTransformMakeRotation(3.14159/2);
//			[self.navigationController pushViewController:selectmenu animated:YES];
		}
		else
		{
//			selectmenu.view.transform =  CGAffineTransformMakeRotation(0);
//			[self.navigationController pushViewController:selectmenu animated:YES];
		}
		viewrotate = FALSE;
	}
}

-(CGFloat ) distanceBetweenTwoPoints:(CGPoint) fromPoint toPoint:(CGPoint)toPoint
{
	float x = toPoint.x - fromPoint.x;
	float y = toPoint.y - fromPoint.y;
	
	return sqrt(x*x + y*y);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
//	controller.delegate = self.delegate;
	
//	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//	[self presentModalViewController:controller animated:YES];
	
//	[controller release];

	viewmode = VIEWUPDATE;
	//캐릭터 리소스 확인용
	//static int k = 0;
	//[charView setChar:@"hitomi" idx:k isNight:true];
	//k++;
	//return;
	touchedCon = nil;
	
	NSSet *Alltouch = [event allTouches];
	switch ([Alltouch count]) {
		case 1:
		{
			
			UITouch *currentTouch = [[event allTouches] anyObject];
			CGPoint touchPoint = [currentTouch locationInView:self.view];
			
			if (CGRectContainsPoint(clockview.view.frame, touchPoint)) 
				touchedCon = clockview;
			else if (CGRectContainsPoint(dateview.view.frame, touchPoint)) 
				touchedCon = dateview;
			else {
				touchedCon = nil ;
				if(infoButton.alpha)
				{
					infoButtonFrame  = 0;
					[infoButton setAlpha:0];
				}
				else {
					[infoButton setAlpha:1];
					infoButtonFrame  = 5;
				}
			}

			
			if (touchedCon != nil)
			{
				dragOffset = CGPointMake(touchPoint.x - touchedCon.view.center.x,
										 touchPoint.y - touchedCon.view.center.y);
			}	
		}
			break;
		case 2:
		{
			UITouch *touch1 = [[Alltouch allObjects] objectAtIndex:0];
			UITouch *touch2 = [[Alltouch allObjects] objectAtIndex:1];
			
			initTouchPoint = [self distanceBetweenTwoPoints:[touch1 locationInView:self.view] toPoint:[touch2 locationInView:self.view]];
			
			if (CGRectContainsPoint(clockview.view.frame, [touch1 locationInView:self.view]) || CGRectContainsPoint(clockview.view.frame, [touch2 locationInView:self.view]) ) {
				touchedCon = clockview;
			}	
			else if (CGRectContainsPoint(dateview.view.frame, [touch1 locationInView:self.view]) || CGRectContainsPoint(dateview.view.frame, [touch2 locationInView:self.view])) {
				touchedCon = dateview;
			}
			
		}
			break;
		default:
			break;
	}
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	NSSet *Alltouch = [event allTouches];
	switch ([Alltouch count]) {
		case 1:
		{	
			UITouch *currentTouch = [[event allTouches] anyObject];	
			CGPoint currentPoint = [currentTouch locationInView:self.view];
			
			if (touchedCon != nil)
			{
				touchedCon.view.center = CGPointMake(currentPoint.x - dragOffset.x,
													 currentPoint.y - dragOffset.y);
			}
		}
			break;
		case 2:
		{
			UITouch *touch1 = [[Alltouch allObjects] objectAtIndex:0];
			UITouch *touch2 = [[Alltouch allObjects] objectAtIndex:1];
			CGFloat MoveTouch = [self distanceBetweenTwoPoints:[touch1 locationInView:self.view] toPoint:[touch2 locationInView:self.view]];
			
			if(initTouchPoint > MoveTouch )
			{
				
				[self resizeview:1 value:0];
				NSLog(@"Out");
			}
			else
			{
				[self resizeview:0 value:0];
				NSLog(@"IN");
			}
			initTouchPoint = MoveTouch;
		}
			break;
		default:
			break;
	}
	
	[clockview.view setFrame:[self viewcentersettle:clockview.view.frame]];
	[dateview.view setFrame:[self viewcentersettle:dateview.view.frame]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self ConfigSetup];
	viewmode = VIEWNORMAL;
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


/* 각각 v보여지는 크기를 조절 */
- (void) resizeview:(int)_type value:(int)value
{
	if (touchedCon == nil) return;
	
	int temp = 1;
	if(_type) temp = -1;
	
	CGFloat trans =  touchedCon.view.transform.a + 0.03 * temp;
	if(trans <= 1.0 && trans >= 0.3)
		[touchedCon.view setTransform:CGAffineTransformMake(trans, 0.0, 0.0,trans, 0.0, 0.0)];
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
	
	if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
		[[AlarmConfig getInstance] setHeigthViewPoint:config];
	else
		[[AlarmConfig getInstance] setWidthViewPoint:config];
	
	[[AlarmConfig getInstance] SaveConfig];
	[config release];
}

#ifdef __IPHONE_3_0
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{	
#else
- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation: (UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration
{	
#endif
	if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
	{

		[newWeekView.view setCenter:CGPointMake(240, 300)];
		[infoButton setCenter:CGPointMake(450, 30)];
		[sceneView setOrientation:true];
	}
	else
	{
		[newWeekView.view setCenter:CGPointMake(160, 460)];
		[infoButton setCenter:CGPointMake(290, 30)];
		[sceneView setOrientation:false];
	}
	
	snoozealarm.frame	= CGRectMake(0, 0, self.navigationController.toolbar.frame.size.width, self.navigationController.toolbar.frame.size.height);
	stopalarm.frame		= CGRectMake(0, 0, self.navigationController.toolbar.frame.size.width, self.navigationController.toolbar.frame.size.height);
	[self FrameUpdate];
}
	
- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
	
	[super dealloc];
	[weekview release];
	[newWeekView release];
	[clockview release];
	[dateview release];
	[sceneView release];
	[AlarmButton release];
}

@end
