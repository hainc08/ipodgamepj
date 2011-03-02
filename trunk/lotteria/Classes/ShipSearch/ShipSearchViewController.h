//
//  ShipSearchViewController.h
//  lotteria
//
//  Created by embmaster on 11. 2. 24..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@interface ShipSearchViewController : UIViewControllerDownTemplate {
	IBOutlet UITextField	*SearchText;
	IBOutlet UIButton		*SearchButton;
}

-(IBAction)SearchButton:(id)sender;
- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message;
@end
