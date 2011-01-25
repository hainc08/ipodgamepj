#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "FlipsideViewControllerDelegate.h"

@class AlarmDate;
@interface CharSelectViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	id <FlipsideViewControllerDelegate> delegate;

	AlarmDate		* alarm;
	IBOutlet UITableView* optionTableView;
	int			SetFlag;
	int			index;

}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) AlarmDate			*alarm;
@property (nonatomic,  assign, getter=isSetFlagg) int	SetFlag;
@property (nonatomic,  assign, getter=isindex) int	index;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)deleteAlarm:(id)sender;

@end
