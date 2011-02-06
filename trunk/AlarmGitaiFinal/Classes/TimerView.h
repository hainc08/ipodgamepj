//
//  TimerView.h
//
//  Created by embmaster on 11. 2. 1..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "FlipsideViewControllerDelegate.h"

@interface TimerView : UIViewController {
	
	id <FlipsideViewControllerDelegate> delegate;
	
	IBOutlet UIDatePicker	*TimePicker;
	IBOutlet UITableViewCell *TimeCell;
	IBOutlet UILabel	* TimeLabel;
	IBOutlet UIButton			*StartButton;
	IBOutlet UIButton			*StopButton;
	NSInteger secs;
	NSDateFormatter *dateFormatter;
	NSTimer *timer;
}
@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

- (void) TimeChange;
- (void)resumeTimer;
- (IBAction)TimerStart;
- (IBAction)TimerStop;
- (void)stopTimer;
- (void)update;
- (void)timeOver:(bool)valid;

@end
