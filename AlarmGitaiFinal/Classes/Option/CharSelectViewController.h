#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "FlipsideViewControllerDelegate.h"

@interface CharSelectViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	id <FlipsideViewControllerDelegate> delegate;

	IBOutlet UITableView *CharTable; 
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
