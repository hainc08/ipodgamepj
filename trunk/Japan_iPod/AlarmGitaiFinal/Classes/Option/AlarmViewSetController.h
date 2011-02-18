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

enum _EDITTYPE {
	TIMETYPE,
	REPEAT,
	SOUND,
	NAME,
};

@interface AlarmViewSetController : UIViewController  <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate > {
	id <FlipsideViewControllerDelegate> delegate;
	
	int EditType;

	id editedObject;
	NSString *editedPropertyKey;
	NSDateFormatter *dateFormatter;
	
	IBOutlet UITextField	*textField;
	IBOutlet UIDatePicker	*datePicker;
	IBOutlet UITableView	*optionTableView;
	IBOutlet UINavigationBar *viewbar;
	IBOutlet UILabel		*u_Label;
	
	int		select_index;
	id <PropertyEditing> sourceController;

}
@property (nonatomic, assign, getter=isEditingDate) int EditType;
@property (nonatomic, retain) id editedObject;
@property (nonatomic, retain) NSString *editedPropertyKey;
@property (nonatomic, retain) IBOutlet UITableView *optionTableView;
@property (nonatomic, retain) IBOutlet UINavigationBar *viewbar;
@property (nonatomic, retain) IBOutlet UILabel		*u_Label;
@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) id <PropertyEditing>  sourceController;


- (IBAction)cancel;
- (IBAction)done;

@end
