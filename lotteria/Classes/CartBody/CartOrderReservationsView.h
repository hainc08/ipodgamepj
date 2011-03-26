//
//  CartOrderReservationsView.h
//  lotteria
//
//  Created by embmaster on 11. 2. 26..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@interface CartOrderReservationsView : UIViewControllerTemplate<UITableViewDataSource, UITableViewDelegate >  {
	IBOutlet UIDatePicker	*Picket;
	IBOutlet UIButton		*reButton;
	IBOutlet UITableView	*OrderBurial;
}
@property (nonatomic, retain) IBOutlet UIDatePicker	*Picket;
@property (nonatomic, retain) IBOutlet UIButton		*reButton;
@property (nonatomic, retain) IBOutlet UITableView	*OrderBurial;

- (IBAction)ReservationButton;
- (void)controlEventValueChanged:(id)sender;
- (bool)checkTime;

@end
