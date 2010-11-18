//
//  AlarmShakeController.h
//  AlarmGitai
//
//  Created by embmaster on 10. 11. 02.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AlarmShakeController : UIViewController {
	ButtonView	 *EndButton;
	ButtonView	 *SnoozeButton;
	ButtonView	 *Shake;
	int		 ShakeCount;
	
		NSTimer *vibrationTimer;
}
@end
