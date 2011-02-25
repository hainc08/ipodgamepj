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
	
	UIImage *buttonImage = [UIImage imageNamed:@"btn_box_close_on.png"];
	UIButton *closebutton = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[closebutton setImage:buttonImage forState:UIControlStateNormal];
	
	closebutton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
	
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:closebutton];
	
	[closebutton addTarget:self action:@selector(CloseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	self.navigationController.navigationBarHidden =NO;
	self.navigationItem.leftBarButtonItem  = leftButton;		
	[closebutton release];
	[leftButton release];
	self.view.backgroundColor = 
	[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_content.png"]];
	
	
    [super viewDidLoad];
}

- (IBAction)CloseButtonClicked:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
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
