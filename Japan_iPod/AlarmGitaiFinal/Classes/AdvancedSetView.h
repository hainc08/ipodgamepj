//
//  AdvancedSetView.h
//
//  Created by embmaster on 11. 1. 18..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FlipsideViewControllerDelegate.h"
@protocol PropertyEditing
- (void)setValue:(id)newValue forEditedProperty:(NSString *)field;
@end
@interface AdvancedSetView :UIViewController <UITableViewDataSource, UITableViewDelegate>  {
    IBOutlet id dataSource;
	BOOL		Snooze;
	BOOL		Vibrate;
	int		Volume;
	UISwitch *SnoozeOnOff;
	UISwitch *VibrateOnOff;
	UISlider *SoundVolume;
	
	IBOutlet UITableView *OptionTable; 
	
}
@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) id <PropertyEditing>  sourceController;
@property (nonatomic, retain) IBOutlet UITableView *OptionTable;
@property (nonatomic,  assign, getter=isSnooze) BOOL Snooze;
@property (nonatomic,  assign, getter=isVibrate) BOOL Vibrate;
@property (readwrite) int Volume;

- (IBAction)Done ;
@end
