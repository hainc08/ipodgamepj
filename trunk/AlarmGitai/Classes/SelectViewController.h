//
//  SelectViewController.h
//  AlarmGitai
//
//  Created by embmaster on 10. 08. 02.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuBaseController.h"

@interface SelectViewController : MenuBaseController {
	
	UIButton *alarmView[4];
	UIButton *Xbox;
	
	int choicenum;
	int choice;
}

@end
