//
//  MainViewController.h
//  lotteria
//
//  Created by Sasin on 11. 2. 18..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@class WaitViewController;
@interface MainViewController : UIViewController {
	id curView;
	IBOutlet UIImageView* backImg;
	IBOutlet UIButton* helpButton;
	IBOutlet UIButton* listButton;

	UIButton* lastButton;

	IBOutlet UIButton* tapButton1;
	IBOutlet UIButton* tapButton2;
	IBOutlet UIButton* tapButton3;
	IBOutlet UIButton* tapButton4;
	IBOutlet UIImageView* selectedBack;

	IBOutlet UIImageView* cartCountBack1;
	IBOutlet UIImageView* cartCountBack2;
	IBOutlet UIImageView* cartCountBack3;
	IBOutlet UILabel* cartCountLabel;
	
	WaitViewController *WaitView;
}
@property (nonatomic, retain) WaitViewController *WaitView;
- (IBAction)buttonClick:(id)sender;
- (void)ClieckEvent:(int)index  viewType:(int)Type;
- (IBAction)helpClick;
- (void)cartUpdate;

- (void)viewAlign;

@end
