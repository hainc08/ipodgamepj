//
//  MenuController.h
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MenuController : UITableViewController  {
	int defaultdata;
}
- (void)reset:(int)param;
- (void)sliderAction:(UISlider*)sender;
@end

