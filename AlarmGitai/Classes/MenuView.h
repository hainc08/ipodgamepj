//
//  MenuView.h
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 05.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlarmView;
@class ViewCgPoint;

@interface MenuView : UIView {
	UIButton *configmenu[4];
	
	UIButton *alarmView[4];
	
	UILabel  *menulabel[3];
	UIButton *countury[4];
	//UIButton *
	
	UIButton *Xbox;
	
	int choicenum;
	int choice;
}
- (IBAction)ButtonClick:(id)sender;
- (IBAction)ConfigButton:(id)sender;

- (void)CreatedAlarmView;
- (void)initAlarmView;
@end
