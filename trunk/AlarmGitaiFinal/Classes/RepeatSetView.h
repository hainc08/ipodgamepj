#import <UIKit/UIKit.h>
#import "AlarmConfig.h"
#import "FlipsideViewControllerDelegate.h"

@interface RepeatSetView : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	id <FlipsideViewControllerDelegate> delegate;

	IBOutlet id neverRepeat;
	IBOutlet id everyDay;
	IBOutlet id everyWeek;

	IBOutlet id weekView;

	IBOutlet id sonDay;
	IBOutlet id monDay;
	IBOutlet id tueDay;
	IBOutlet id wedDay;
	IBOutlet id theDay;
	IBOutlet id friDay;
	IBOutlet id satDay;
	
	id lastSelect;
	
	UIImage* img[4];
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) AlarmDate			*alarm;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)selectOption:(id)sender;
- (IBAction)selectWeekday:(id)sender;

@end
