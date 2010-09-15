//
//  MenuCustomCell.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MenuCustomCell.h"


@implementation MenuCustomCell
@synthesize selectName;
@synthesize charImage;
@synthesize titleName;
@synthesize textField;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

	textField.delegate = self;
	 textField.borderStyle = UITextBorderStyleNone;
	 textField.keyboardType = UIKeyboardTypeNumberPad;
	 textField.returnKeyType = UIReturnKeyDone;
	 textField.textAlignment = UITextAlignmentLeft;
	//textField.text = @"5";
	 
	 // add observer for the respective notifications (depending on the os version)
	 if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		 [[NSNotificationCenter defaultCenter] addObserver:self 
												  selector:@selector(keyboardDidShow:) 
													  name:UIKeyboardDidShowNotification 
													object:nil];		
	 } else {
		 [[NSNotificationCenter defaultCenter] addObserver:self 
												  selector:@selector(keyboardWillShow:) 
													  name:UIKeyboardWillShowNotification 
													object:nil];
	 }
 }
 



- (void)addButtonToKeyboard {
	// create custom button
	UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
	doneButton.frame = CGRectMake(0, 163, 106, 53);
	doneButton.adjustsImageWhenHighlighted = NO;
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.0) {
		[doneButton setImage:[UIImage imageNamed:@"DoneUp3.png"] forState:UIControlStateNormal];
		[doneButton setImage:[UIImage imageNamed:@"DoneDown3.png"] forState:UIControlStateHighlighted];
	} else {        
		[doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
		[doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
	}
	[doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
	// locate keyboard view
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
	UIView* keyboard;
	for(int i=0; i<[tempWindow.subviews count]; i++) {
		keyboard = [tempWindow.subviews objectAtIndex:i];
		// keyboard found, add the button
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
			if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES)
				[keyboard addSubview:doneButton];
		} else {
			if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
				[keyboard addSubview:doneButton];
		}
	}
}

- (void)keyboardWillShow:(NSNotification *)note {
	// if clause is just an additional precaution, you could also dismiss it
	if ([[[UIDevice currentDevice] systemVersion] floatValue] < 3.2) {
		[self addButtonToKeyboard];
	}
}

- (void)keyboardDidShow:(NSNotification *)note {
	// if clause is just an additional precaution, you could also dismiss it
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		[self addButtonToKeyboard];
    }
}


- (void)doneButton:(id)sender {
	NSLog(@"doneButton");
    NSLog(@"Input: %@", textField.text);
    [textField resignFirstResponder];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	if(string && [string length] && [self.textField.text length]  >= 2)
		return NO;
	return TRUE;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [textField release];
	[titleName release];
    [selectName release];
	[charImage release];
    [super dealloc];
}


@end
