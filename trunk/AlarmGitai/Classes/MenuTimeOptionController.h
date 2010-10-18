//
//  SelectViewController.h
//  AlarmGitai
//
//  Created by embmaster on 10. 08. 02.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ButtonView;

@interface MenuTimeOptionController : UIViewController {
	
	ButtonView *HourMode;
	
	ButtonView *DisplayDate;
	
	ButtonView *Done;
	
}
- (CGRect) ButtonPlace:(int) row	y:(int) col;
@end
