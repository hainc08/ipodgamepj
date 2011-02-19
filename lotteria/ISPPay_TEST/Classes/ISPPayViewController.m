//
//  ISPPayViewController.m
//  ISPPay
//
//  Created by embmaster on 11. 2. 19..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ISPPayViewController.h"

@implementation ISPPayViewController


@synthesize ansimController;
@synthesize cardData;
@synthesize cardCode;
@synthesize cardPicker;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	NSArray *array=[[NSArray alloc] initWithObjects:@"BC카드",@"삼성카드",@"신한카드",@"롯데카드",@"현대카드",@"NH카드",@"제주카드",nil];
	NSArray *code =[[NSArray alloc] initWithObjects:@"51",@"41",@"71",@"61",@"91",@"42",nil];
	//91:NH , 51:삼성 ,   61:현대 ,   71:롯데,    41:신한  ,42:제주
	self.cardData=array;
	self.cardCode=code;
	[array release];
	[code release];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(IBAction) PayButtonPressed{
	
	/* 스마트폰에서는 세이블 관련 서비스는 제공하지 않습니다.
	 공인인증서 사용문제로 신한하이세이브 삼성 슈퍼세이브, 롯데 쇼핖세이브등은 지원하진 않습니다.
	 */
	/* 
	 안심클릭과 ISP 로 결제 해야되는 경우를 비교 해서 Ansim Controller를 
	 사용하는 것과 ISP Controller를 사용하는 부분과 분리 해야됨 
	 */
	NSString *x_mname=@"치즈세트외 1";		// 결제대상
	NSString *x_amount = @"1";			// 얼마 
	

	NSInteger row=[cardPicker selectedRowInComponent:0];
	////91:NH , 51:삼성 ,   61:현대 ,   71:롯데,    41:신한
	
	if(row == 0 )	// ISP 사용   : BC 카드 일 경우  
	{
		
	}
	else 
	{
		
		NSString *x_cardtype=[cardCode objectAtIndex:row-1];
		AnsimPayController *ansimController =[[AnsimPayController alloc] initWithNibName:@"AnsimPayController" bundle:nil];
	
	
		[ansimController setAnsimValue:x_mname  amount:x_amount cardtype:x_cardtype];

		self.ansimController=ansimController;
		self.ansimController.delegate=self;
		[self.view insertSubview:ansimController.view atIndex:9];
		[ansimController release];

	}	
	
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:2.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	[UIView setAnimationTransition:
	 UIViewAnimationTransitionCurlUp
						   forView:self.view cache:YES];
	[UIView commitAnimations];
}


#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [cardData count];
}
#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [cardData objectAtIndex:row];
}


- (void)dealloc {
    [super dealloc];
}

@end
