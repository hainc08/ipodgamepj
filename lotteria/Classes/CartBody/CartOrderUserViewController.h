//
//  CartOrderUserViewController.h
//  lotteria
//
//  Created by embmaster on 11. 2. 23..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CartOrderUserViewController : UIViewController {
	IBOutlet UITextField	*Name;
	IBOutlet UITextField	*Phone;
}
- (IBAction)ContinueButton:(id)sender;
@end
