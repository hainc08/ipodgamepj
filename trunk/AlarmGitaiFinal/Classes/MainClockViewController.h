//
//  FlipsideViewController.h
//  AlarmGitaiFinal
//
//  Created by Sasin on 10. 11. 25..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipsideViewControllerDelegate.h"

@class ClockView;
@class DateView;
@class SceneView;
@class NewWeekView;

enum VIEWMODE {
	VIEWNORMAL = 0,
	VIEWUPDATE,
};

@interface MainClockViewController : UIViewController <FlipsideViewControllerDelegate>{
	id <FlipsideViewControllerDelegate> delegate;

	CGFloat initTouchPoint;
	
	BOOL	viewrotate;
	BOOL	editenable;
	BOOL	weekViewTouched;
	UIViewController* touchedCon;
	
	CGPoint dragOffset;
	
	BOOL hiddenButton;
	BOOL menuEnable;
	
	int		viewmode;
	DateView *weekview;
	ClockView *clockview;
	DateView *dateview;
	SceneView *sceneView;
	NewWeekView *newWeekView;
	
	UInt32 frameTick;
	NSTimer *updateTimer;
	bool isInit;
	
	float framePerSec;
	/* Button */
	UIButton *AlarmButton;
	
	NSMutableArray *alarm_arr;
	IBOutlet UIButton* infoButton;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)ButtonClick:(id)sender;
- (CGRect)viewcentersettle:(CGRect) rect;
- (void) resizeview:(int)_type value:(int)value;
- (void)update;
- (void)stopTimer;
- (void)resumeTimer;
- (void)FrameUpdate;
- (void)ConfigSetup;

@end
