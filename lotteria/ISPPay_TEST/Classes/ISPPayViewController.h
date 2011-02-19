//
//  ISPPayViewController.h
//  ISPPay
//
//  Created by embmaster on 11. 2. 19..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnsimPayController.h"
#import "ISPPayController.h"

@interface ISPPayViewController : UIViewController <AnsimPayDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {

	ISPPayController	*ispController;
	AnsimPayController *ansimController;
	UIPickerView *cardPicker;
	NSArray		 *cardData;
	NSArray		 *cardCode;	
	
}

@property (nonatomic,retain) AnsimPayController *ansimController;
@property (nonatomic,retain) ISPPayController *ispController;
//카드사 선택 selected
@property (nonatomic,retain) IBOutlet UIPickerView *cardPicker;
//카드사 명 
@property (nonatomic,retain) NSArray *cardData;
//카드사 코드 
@property (nonatomic,retain) NSArray *cardCode;


-(IBAction) PayButtonPressed;

@end

