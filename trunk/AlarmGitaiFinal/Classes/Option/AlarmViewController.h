//
//  OptionViewController.h
//  iNorebangBook
//
//  Created by kueec on 10. 3. 7..
//  Copyright 2010 집. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipsideViewControllerDelegate.h"

@interface AlarmViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	id <FlipsideViewControllerDelegate> delegate;

	IBOutlet UITableView* optionTableView;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)buttonClicked:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
