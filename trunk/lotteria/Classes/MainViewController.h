//
//  MainViewController.h
//  lotteria
//
//  Created by Sasin on 11. 2. 18..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

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
}

- (IBAction)buttonClick:(id)sender;
- (IBAction)helpClick;
- (void)cartUpdate;

- (void)viewAlign;

@end
