//
//  AlarmController.h
//  AlarmGitai
//
//  Created by embmaster on 10. 08. 17.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlarmConfigController;
@interface AlarmController : UITableViewController {
	AlarmConfigController *alarmconfigConroller;
	UIBarButtonItem *addButton;
}

@end
