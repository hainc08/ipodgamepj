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
@class SceneView;
@class MaskView;


@interface AlarmGitaiViewController : UIViewController {
	BOOL hiddenButton;
	BOOL menuEnable;

	UINavigationController *menuNavi;
	
	ClockView *clockview;
	DateView *dateview;
	SceneView *sceneView;
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

