//
//  OrderEndViewController.h
//  lotteria
//
//  Created by embmaster on 11. 2. 28..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@interface OrderEndViewController :UIViewControllerDownTemplate   {
	IBOutlet UIButton *OrderInfo;
	IBOutlet UILabel *Store;
	IBOutlet UILabel *StorePhone;
}

-(IBAction) OrderInfo;

@end
