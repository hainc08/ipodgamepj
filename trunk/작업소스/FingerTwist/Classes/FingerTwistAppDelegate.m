//
//  FingerTwistAppDelegate.m
//  FingerTwist
//
//  Created by Sasin on 08. 08. 26.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "FingerTwistAppDelegate.h"
#import "TeamLogoView.h"
#import "ViewManager.h"
#import "HighScoreManager.h"

@implementation FingerTwistAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[ViewManager initManager:window:viewController];
	[HighScoreManager initManager];

	[[ViewManager getInstance] changeView:@"TeamLogoView"];

	{
		ScoreCon score;
		score.playerName = @"TestPLayer";
		score.totScore = 1000;
		
		[[HighScoreManager getInstance] addNewScore:score];
	}
	{
		ScoreCon score;
		score.playerName = @"TestPLayer2";
		score.totScore = 3000;
		
		[[HighScoreManager getInstance] addNewScore:score];
	}
	{
		ScoreCon score;
		score.playerName = @"TestPLayer3";
		score.totScore = 100;
		
		[[HighScoreManager getInstance] addNewScore:score];
	}
}
	
- (void)dealloc {
	[[ViewManager getInstance] closeManager];
	[[HighScoreManager getInstance] closeManager];
    [window release];
	[super dealloc];
}

@end
