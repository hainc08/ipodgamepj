//
//  TimerView.h
//
//  Created by embmaster on 11. 2. 1..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "FlipsideViewControllerDelegate.h"

@interface TimerView : UIViewController <UITableViewDataSource, UITableViewDelegate>  {
	
	id <FlipsideViewControllerDelegate> delegate;
	
	IBOutlet UIDatePicker	*TimePicker;
	IBOutlet UITableView *TimerView;
	IBOutlet UILabel	* TimeLabel;
	IBOutlet UIButton			*StartButton;
	IBOutlet UIButton			*StopButton;
	NSInteger secs;
	NSDateFormatter *dateFormatter;
	NSTimer *timer;
}
@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
- (IBAction)cancel:(id)sender;
- (void) TimeChange;
- (void)resumeTimer;
- (IBAction)TimerStart;
- (IBAction)TimerStop;
- (void)stopTimer;
- (void)update;
- (void)timeOver:(bool)valid;

@end
