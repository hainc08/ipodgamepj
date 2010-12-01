//
//  AlarmViewSetController.m
//  AlarmGitaiFinal
//
//  Created by embmaster on 10. 11. 30..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AlarmViewSetController.h"


@implementation AlarmViewSetController
@synthesize editedObject,editingDate,editedPropertyKey,sourceController, delegate;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];

}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	textField.hidden = NO;
	optionTableView.hidden = YES;
    if (editingDate) {
		NSLocale *locale	=	[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
		dateFormatter	=	[[NSDateFormatter alloc] init];
		[dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
		[dateFormatter setDateStyle:NSDateFormatterLongStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
		[dateFormatter setLocale:locale];
		[locale release];
		
		[datePicker addTarget:self action:@selector(controlEventValueChanged:) forControlEvents:UIControlEventValueChanged];
        datePicker.hidden = NO;
		NSDate *date = [[NSDate alloc] init];
		
        if (DTime == nil) 
			date = [NSDate date];
		else {
			date = [dateFormatter dateFromString:DTime];
		}
		[dateFormatter setDateFormat:@"h:mm a"];
		NSString *_retvalue =  [dateFormatter stringFromDate:date];
		
		datePicker.date = date;
		[textField setText:_retvalue];
		textField.enablesReturnKeyAutomatically = NO;
	 	
    }
	else {
        datePicker.hidden = YES;
        [textField setText:[editedObject valueForKey:editedPropertyKey]];
        [textField becomeFirstResponder];
	}
}
- (IBAction)done:(id)sender {
	[sourceController setValue:textField.text forEditedProperty:editedPropertyKey];
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (IBAction)cancel:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];	
}


-(void)controlEventValueChanged:(id)sender
{
	[dateFormatter setDateFormat:@"h:mm a"];
	NSString *_retvalue =  [dateFormatter stringFromDate:[datePicker date]];
	[textField setText:_retvalue];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void)dealloc {
    [super dealloc];
}



@end
