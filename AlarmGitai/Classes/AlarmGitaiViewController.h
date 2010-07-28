//
//  AlarmGitaiViewController.h
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 13.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ClockView;
@class DateView;
@class MenuView;
@class CharView;
@class MaskView;

@interface AlarmGitaiViewController : UIViewController {
	BOOL hiddenButton;
	BOOL menuEnable;

	
	MenuView *menuview;
	ClockView *clockview;
	DateView *dateview;
	CharView *charView;
	MaskView *maskView;
	
	UInt32 frameTick;
	NSTimer *updateTimer;
	bool isInit;
	
	float framePerSec;
	UIButton *MenuButton;
	
}

- (void)update;
- (void)stopTimer;
- (void)resumeTimer;
- (void)FrameUpdate;
@end

