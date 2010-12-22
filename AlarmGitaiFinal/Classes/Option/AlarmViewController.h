//
//  OptionViewController.h
//  iNorebangBook
//
//  Created by kueec on 10. 3. 7..
//  Copyright 2010 집. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "AlarmViewSetController.h"
#import "FlipsideViewControllerDelegate.h"

@class AlarmDate;
@interface AlarmViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, PropertyEditing> {
	id <FlipsideViewControllerDelegate> delegate;

	AlarmDate		* alarm;
	IBOutlet UITableView* optionTableView;
	int			SetFlag;
	int			index;

}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) AlarmDate			*alarm;
@property (nonatomic, retain) NSUndoManager		*undoManager;
@property (nonatomic,  assign, getter=isSetFlagg) int	SetFlag;
@property (nonatomic,  assign, getter=isindex) int	index;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end