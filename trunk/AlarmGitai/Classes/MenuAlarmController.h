//
//  CharSelectController.h
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ButtonView;

@interface MenuAlarmController : UIViewController {
	ButtonView	*AlarmTxt;
	ButtonView	*AlarmSetTxt;
	ButtonView *AlarmSet;
	ButtonView *Shake;
	ButtonView *Snooze;
	ButtonView *Save;
	ButtonView *Edit;
	ButtonView *Done;
	UIActionSheet	*action;
	UIDatePicker *datePicker;
}
@end
