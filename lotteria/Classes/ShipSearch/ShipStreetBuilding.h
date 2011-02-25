//
//  ShipStreetBuilding.h
//  lotteria
//
//  Created by embmaster on 11. 2. 26..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@interface ShipStreetBuilding : UIViewControllerTemplate {
	IBOutlet UITextField *Search;
	
	IBOutlet UIButton *Street;
	IBOutlet UIButton *Building;
	IBOutlet UIButton *Back;
}

- (IBAction)ButtonClick:(id)sender;

@end
