//
//  AlarmGitaiViewController.h
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 13.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainAlarm;
@class ClockView;
@class DateView;
@class MenuView;
@interface AlarmGitaiViewController : UIViewController {
	BOOL hiddenButton;
	BOOL menuEnable;
	
	MainAlarm *mainAlarm;
	MenuView *menuview;
	ClockView *clockview;
	DateView  *dateview;
	
	UInt32 frameTick;
	NSTimer *updateTimer;
	bool isInit;
	
	float framePerSec;
	
	UIButton *MenuButton;
	
}

- (void)update;
- (void)stopTimer;
- (void)resumeTimer;
@end

