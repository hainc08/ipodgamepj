//
//  ShipSearchViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 24..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShipSearchViewController.h"
#import "ShipAddressTable.h"
#import "HelpViewController.h"

@implementation ShipSearchViewController


- (void)viewDidLoad {
  [super viewDidLoad];	
	
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
- (IBAction) SearchButton:(id)sender
{
	ShipAddressTable *shiptable = [[ShipAddressTable alloc] initWithNibName:@"ShipAddressTable" bundle:nil];
	//ShipAddressTable *shiptable = [[ShipAddressTable alloc] init];
	[shiptable setDong:SearchText.text];
	shiptable.ShipType = 0;
	[self.navigationController pushViewController:shiptable animated:YES];
	[shiptable release];
	
}

#pragma mark  -
#pragma mark TextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}



#pragma mark -
#pragma mark AlertView
- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
												   delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// 필요한 엑션이 있으면 넣자 ..
}


@end
