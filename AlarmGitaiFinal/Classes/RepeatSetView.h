#import <UIKit/UIKit.h>
#import "AlarmConfig.h"
#import "FlipsideViewControllerDelegate.h"

@interface RepeatSetView : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	id <FlipsideViewControllerDelegate> delegate;

	int repeatIdx;
	int repeatIdx2;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) AlarmDate			*alarm;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
