//
//  AlarmViewSetController.h
//  AlarmGitaiFinal
//
//  Created by embmaster on 10. 11. 30..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>
#import "FlipsideViewControllerDelegate.h"
@protocol PropertyEditing
- (void)setValue:(id)newValue forEditedProperty:(NSString *)field;
@end


@interface AlarmViewSetController : UIViewController  <UITextFieldDelegate > {
	id <FlipsideViewControllerDelegate> delegate;
	
	int EditType;

	id editedObject;
	NSString *editedPropertyKey;
	NSDateFormatter *dateFormatter;
	NSString *DTime;
	
	IBOutlet UITextField	*textField;
	IBOutlet UIDatePicker	*datePicker;
	IBOutlet UITableView	*optionTableView;

	id <PropertyEditing> sourceController;

}
@property (nonatomic, assign, getter=isEditingDate) BOOL editingDate;
@property (nonatomic, retain) id editedObject;
@property (nonatomic, retain) NSString *editedPropertyKey;

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) id <PropertyEditing>  sourceController;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
