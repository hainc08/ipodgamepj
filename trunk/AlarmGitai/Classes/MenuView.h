//
//  MenuView.h
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 05.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AlarmView;
@interface MenuView : UIView {

	CGAffineTransform ClockTrans[5];
	CGAffineTransform DateTrans[5];
	CGPoint			ClockPoint[5];
	CGPoint			DatePoint[5];
	AlarmView *View[5];

	UIButton *buttonView[5];
	
	UIButton *Xbox;
	
	int choicenum;
}
- (IBAction)ButtonClick:(id)sender;
- (void)CreatedAlarmView;
@end
