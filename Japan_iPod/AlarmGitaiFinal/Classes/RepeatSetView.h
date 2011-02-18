#import <UIKit/UIKit.h>
#import "AlarmConfig.h"
#import "FlipsideViewControllerDelegate.h"
@protocol PropertyEditing
- (void)setValue:(id)newValue forEditedProperty:(NSString *)field;
@end
@interface RepeatSetView : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	id <FlipsideViewControllerDelegate> delegate;
	id <PropertyEditing> sourceController;
	IBOutlet UITableView	*ListTableview;
	NSString *editedPropertyKey;
	int repeatIdx;
	int repeatIdx2;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) id <PropertyEditing>  sourceController;
@property (nonatomic, retain) IBOutlet UITableView *ListTableview;
@property (nonatomic, retain) NSString *editedPropertyKey;
@property (readwrite) int	repeatIdx;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
