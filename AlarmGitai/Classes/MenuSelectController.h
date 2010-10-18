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

@interface MenuSelectController : UIViewController {
	MenuTimeOptionController *TimeOption;
	
	ButtonView *DisplayOption;
	ButtonView *AlarmOption;
	ButtonView *Done;
}
@end
