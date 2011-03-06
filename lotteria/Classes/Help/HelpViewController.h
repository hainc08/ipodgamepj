//
//  HelpViewController.h
//  lotteria
//
//  Created by embmaster on 11. 2. 23..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@interface HelpViewController : UIViewControllerDownTemplate {
	IBOutlet UIButton *OrderInfo;
	IBOutlet UIButton *PersonalInfo;
	IBOutlet UIButton *StipulationInfo;
	IBOutlet UIButton *CalorieInfo;
}

- (IBAction)HelpButtonInfo:(id)sender;
@end
