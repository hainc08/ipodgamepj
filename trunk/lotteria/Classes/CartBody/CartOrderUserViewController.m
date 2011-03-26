//
//  CartOrderUserViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 23..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CartOrderUserViewController.h"
#import "OrderViewController.h"
#import "DataManager.h"
@implementation CartOrderUserViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"수령자 정보";

	doneButton = nil;
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillShow:)
												 name:UIKeyboardDidShowNotification
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillHide:)
												 name:UIKeyboardWillHideNotification
											   object:nil];
}

- (IBAction)done:(id)sender
{
	[doneButton setAlpha:0.f];
	[Phone resignFirstResponder];
}

- (void)makeDoneButton
{
	if (doneButton != nil) return;
	
    doneButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    doneButton.frame = CGRectMake(0, 163, 106, 53);
    doneButton.adjustsImageWhenHighlighted = NO;
    [doneButton setImage:[UIImage imageNamed:@"doneup.png"] forState:UIControlStateNormal];
    [doneButton setImage:[UIImage imageNamed:@"donedown.png"] forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)keyboardWillShow:(NSNotification *)note {  
    // create custom button
	[self makeDoneButton];
	
    // locate keyboard view
    UIView* keyboard;
	UIView* subView;
	for (int j=0; j<[[[UIApplication sharedApplication] windows] count]; ++j)
	{
		UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:j];
		for(int i=0; i<[tempWindow.subviews count]; ++i) {
			subView = [tempWindow.subviews objectAtIndex:i];
			keyboard = [self findKeyboard:subView];
			if (keyboard != nil)
			{
				[keyboard addSubview:doneButton];
				return;
			}
		}
    }
}

- (void)keyboardWillHide:(NSNotification *)note {  
	if (doneButton != nil) [doneButton setAlpha:0];
}

- (UIView*)findKeyboard:(UIView*)tempWindow
{
	if([[tempWindow description] hasPrefix:@"<UIKeyboard"] == YES)
		return tempWindow;

    UIView* keyboard;
    UIView* subView;

    for(int i=0; i<[tempWindow.subviews count]; i++) {
        subView = [tempWindow.subviews objectAtIndex:i];
        // keyboard view found; add the custom button to it

		keyboard = [self findKeyboard:subView];
		if (keyboard != nil) return keyboard;
    }

	return nil;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	[doneButton release];
	doneButton = nil;

    [super viewDidUnload];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction)doneButton
{
	int k =0;
	k=0;
}

- (IBAction)ContinueButton:(id)sender
{
	bool CheckOk = false;
	//정확한 핸드폰 번호인지 확인
	int numberLength = [Phone.text length];
	if (numberLength > 9)
	{
		NSString* first3 = [Phone.text substringToIndex:3];
		
		if (numberLength == 11)
		{
			if (([first3 compare:@"010"] == NSOrderedSame)||
				([first3 compare:@"011"] == NSOrderedSame)||
				([first3 compare:@"016"] == NSOrderedSame)||
				([first3 compare:@"019"] == NSOrderedSame))
			{
				CheckOk = true;
			}
		}
		else if (numberLength == 10)
		{
			if (([first3 compare:@"011"] == NSOrderedSame)||
				([first3 compare:@"016"] == NSOrderedSame)||
				([first3 compare:@"017"] == NSOrderedSame)||
				([first3 compare:@"018"] == NSOrderedSame)||
				([first3 compare:@"019"] == NSOrderedSame))
			{
				CheckOk = true;
			}
		}
		
		if (CheckOk == false)
		{
			//경고 메세지를 보낸다.
			[self ShowOKAlert:ALERT_TITLE msg:ORDER_PHONE_ERROR_MSG];
			return;
		}
	}

	if([Name.text compare:@""] == NSOrderedSame || [Phone.text compare:@""] == NSOrderedSame)
		[self ShowOKAlert:ALERT_TITLE msg:ORDER_USER_ERROR_MSG];
	else {
		Order *Data = [[DataManager getInstance] UserOrder];
		
		[Data setUserName:Name.text];
		[Data setUserPhone:Phone.text];
		
		OrderViewController *shipping = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
		[self.navigationController pushViewController:shipping animated:YES];
		[shipping release];		
	}

}

#pragma mark  -
#pragma mark TextField
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string 
{     
	if(textField == Name)
	{
		NSUInteger currentLength = textField.text.length + string.length;
		if(currentLength > 13)
		{
			[self ShowOKAlert:ALERT_TITLE msg:ORDER_NAME_ERROR_MSG];
			[textField setText:[textField.text substringToIndex:13]];
			return FALSE;
		}
	}
	return TRUE;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	[self makeDoneButton];

	if (textField == Phone) [doneButton setAlpha:1.f];
	else [doneButton setAlpha:0.f];

	return TRUE;
}

#pragma mark -
#pragma mark AlertView
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	[super alertView:actionSheet clickedButtonAtIndex:buttonIndex];
	
	if(buttonIndex)
	{
	}
}
@end
