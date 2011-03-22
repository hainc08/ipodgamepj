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


- (IBAction)ContinueButton:(id)sender
{
	if([Name.text compare:@""] == NSOrderedSame || [Phone.text compare:@""] == NSOrderedSame)
		[self ShowOKAlert:nil msg:@"수령자명과 핸드폰 번호를 입력 해주세요"];
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
	if (textField == Phone)
	{
		NSCharacterSet *numbers = [NSCharacterSet decimalDigitCharacterSet];
		
		NSUInteger currentLength = textField.text.length;
		if(currentLength > 13 || ![numbers characterIsMember:[string characterAtIndex:0]] ) return NO;
		
		
	}
	else if(textField == Name)
	{
		
		NSUInteger currentLength = textField.text.length;
		if(currentLength > 13) return NO;
		
	}
	return TRUE;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
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
