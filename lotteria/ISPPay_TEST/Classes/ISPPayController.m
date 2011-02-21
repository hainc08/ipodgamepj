//
//  ISPPayController.m
//  ISPPay
//
//  Created by embmaster on 11. 2. 19..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ISPPayController.h"


@implementation ISPPayController


@synthesize CardNo_1;
@synthesize CardNo_2;
@synthesize CardNo_3;
@synthesize CardNo_4;


@synthesize delegate;

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

- (IBAction) ISPStartApp
{
	/* PList 에 URL Types 에  ispmobile 을 실행  입력 한다. */
	
	/* ISP App 을 실행 시킨다 . 
	 추가로 롯데리아가 ISP에 추가되면 해당 param 을 입력 해야서 앱을 실행시키자 .
	 
	 서버와의 통신도 추후에 협의에 따라 추가 하자.
	 */	
	NSURL *appUrl = [NSURL URLWithString:@"ispmobile://param"];
	BOOL installedApp = [[UIApplication sharedApplication] openURL:appUrl];
	
	if(!installedApp)
	{
		/* PList 에 URLTypes 에  itms  를 실행 입력 한다 .*/
		/* ISP App 을 다운 받을 수 있도록 appstore 가 실행 된다 */
		NSURL *downloadAppUrl = [NSURL URLWithString:@"itms://itunes.apple.com/kr/app/id369125087?mt=8"];
		
		BOOL downloadApp = [[UIApplication sharedApplication] openURL:downloadAppUrl];
		
	}
}


@end
