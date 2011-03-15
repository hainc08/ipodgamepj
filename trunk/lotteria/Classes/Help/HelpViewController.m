//
//  HelpViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 23..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpWebViewController.h"

@implementation HelpViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	closetype = true;
	naviImgIdx = 0;
    [super viewDidLoad];

	self.navigationItem.title = @"도움말";

}

- (IBAction)CloseButtonClicked:(id)sender
{
	[[ViewManager getInstance] closePopUp];
}

- (IBAction)HelpButtonInfo:(id)sender
{
	HelpWebViewController *Info  = [[HelpWebViewController alloc] initWithNibName:@"HelpWebView" bundle:nil];

	if		( OrderInfo == sender){			Info.URLInfo = [NSString stringWithFormat:@"%@/iphone/help/help_info.asp", SERVERURL ];
											Info.TitleName = @"주문안내";
	}
	else if ( PersonalInfo == sender){		Info.URLInfo = [NSString stringWithFormat:@"%@/iphone/help/privacy.asp", SERVERURL ];
											Info.TitleName = @"개인정보";
	}
	else if ( StipulationInfo == sender){	Info.URLInfo = [NSString stringWithFormat:@"%@/iphone/help/agreement.asp", SERVERURL ];
											Info.TitleName = @"이용약관";
	}
	else if ( CalorieInfo == sender){		Info.URLInfo = [NSString stringWithFormat:@"%@/iphone/help/calorie_info.asp", SERVERURL ];
											Info.TitleName = @"열량정보";
	}

	[self.navigationController pushViewController:Info animated:YES];
	[Info release];
	
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
