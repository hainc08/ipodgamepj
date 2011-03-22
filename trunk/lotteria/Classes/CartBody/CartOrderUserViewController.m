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
	if(Name.text == nil || Phone.text == nil)
		[self ShowCancelOKAlert:nil msg:@"수령자명과 핸드폰 번호를 입력 해주세요"];
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
		if(currentLength > 11 || ![numbers characterIsMember:[string characterAtIndex:0]] ) return NO;
		
		/*
		NSCharacterSet *numbers = [NSCharacterSet decimalDigitCharacterSet];
		
			
		if (range.length == 1) {
			return YES;
		}
		
		
		if ([numbers characterIsMember:[string characterAtIndex:0]]) {
			
			
			if ( currentLength == 3 ) 
			{
				
				if (range.length != 1) 
				{
					
					NSString *firstThreeDigits = [textField.text substringWithRange:NSMakeRange(0, 3)];
					
					NSString *updatedText;
					
					if ([string isEqualToString:@"-"]) 
					{
						updatedText = [NSString stringWithFormat:@"%@",firstThreeDigits];
					}
					
					else 
					{
						updatedText = [NSString stringWithFormat:@"%@-",firstThreeDigits];
					}
					
					[textField setText:updatedText];
				}           
			}
			
			else if ( currentLength > 3 && currentLength < 8 ) 
			{
				
				if ( range.length != 1 ) 
				{
					
					NSString *firstThree = [textField.text substringWithRange:NSMakeRange(0, 3)];
					NSString *dash = [textField.text substringWithRange:NSMakeRange(3, 1)];
					
					NSUInteger newLenght = range.location - 4;
					
					NSString *nextDigits = [textField.text substringWithRange:NSMakeRange(4, newLenght)];
					
					NSString *updatedText = [NSString stringWithFormat:@"%@%@%@",firstThree,dash,nextDigits];
					
					[textField setText:updatedText];
					
				}
				
			}
			
			else if ( currentLength == 8 ) 
			{
				
				if ( range.length != 1 ) 
				{
					NSString *areaCode = [textField.text substringWithRange:NSMakeRange(0, 3)];
					
					NSString *firstThree = [textField.text substringWithRange:NSMakeRange(4, 3)];
					
					NSString *nextDigit = [textField.text substringWithRange:NSMakeRange(7, 1)];
					
					[textField setText:[NSString stringWithFormat:@"%@-%@-%@",areaCode,firstThree,nextDigit]];
				}
				
			}
			else if ( currentLength == 9 ) 
			{
				
				if ( range.length != 1 ) 
				{
					NSString *areaCode = [textField.text substringWithRange:NSMakeRange(0, 3)];
					
					NSString *firstThree = [textField.text substringWithRange:NSMakeRange(4, 4)];
					
					NSString *nextDigit = [textField.text substringWithRange:NSMakeRange(8, 1)];
					
					[textField setText:[NSString stringWithFormat:@"%@-%@-%@",areaCode,firstThree,nextDigit]];
				}
				
			}
			
		}
		
		else {
			return NO;
		}
		 */
		
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
