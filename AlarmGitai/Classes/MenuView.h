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


@class MenuController;
@interface MenuView : UIViewController  {
		UINavigationController *menuNavi;
	IBOutlet UITableView	*menucontrol;
	UIButton *configmenu[4]; // 나라설정 폰트&색 /  TIME VIEW 설정 & char 설정  / 
	
	UIButton *alarmView[4];
	
	UILabel  *menulabel[3];
	UIButton *countury[4];
	
		
	UIButton *Font[4];
	UIButton *FontColor[4];
	
	UIButton *Xbox;
	
	int choicenum;
	int choice;
}

- (IBAction)ButtonClick:(id)sender;
- (IBAction)ConfigButton:(id)sender;

- (void)CreatedAlarmView;
- (void)initAlarmView;
@end
