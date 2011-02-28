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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


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

	
	Order *Data = [[DataManager getInstance] UserOrder];
	
	[Data setUserName:Name.text];
	[Data setUserPhone:Phone.text];
	
	
	OrderViewController *List = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
	[self.navigationController pushViewController:List animated:YES];
	[List release];
}

#pragma mark  -
#pragma mark TextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}
@end
