//
//  MapSearchDetailViewController.h
//  lotteria
//
//  Created by embmaster on 11. 3. 2..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@class StoreInfo;
@interface MapSearchDetailViewController : UIViewControllerTemplate {
	
	IBOutlet UILabel *StoreName;
	IBOutlet UILabel *StoreType;
	IBOutlet UILabel *StorePhone;
	IBOutlet UILabel *StoreAddress;
	IBOutlet UIImageView *StoreImg;
	
	IBOutlet UIButton *callbutton;
	
	StoreInfo *Info;
	
}
@property (nonatomic, retain) StoreInfo *Info;
- (IBAction)callbutton;
@end
