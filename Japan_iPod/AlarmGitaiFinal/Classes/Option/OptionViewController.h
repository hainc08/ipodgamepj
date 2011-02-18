//
//  OptionViewController.h
//  iNorebangBook
//
//  Created by kueec on 10. 3. 7..
//  Copyright 2010 집. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FlipsideViewControllerDelegate.h"
#import "OptionPreview.h"

@interface OptionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, FlipsideViewControllerDelegate> {
	id <FlipsideViewControllerDelegate> delegate;

	IBOutlet UITableView* optionTableView;
	int alarmCount;
	
	NSMutableArray			*a_alarm;

	OptionPreview*			preview;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)buttonClicked:(id)sender;
- (IBAction)done:(id)sender;

@end
