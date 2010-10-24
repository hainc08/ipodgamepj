//
//  CharSelectController.h
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ButtonView;
@class MenuTimeOptionController;
@class MenuAlarmController;
@interface MenuSelectController : UIViewController {
	MenuTimeOptionController *CT_TimeOption;
	MenuAlarmController *CT_AlarmOption;
	
	ButtonView *DisplayOption;
	ButtonView *AlarmOption;
	ButtonView *Done;
}
@end
