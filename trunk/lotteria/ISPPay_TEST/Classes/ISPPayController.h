//
//  ISPPayController.h
//  ISPPay
//
//  Created by embmaster on 11. 2. 19..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
/* 할부시 이자여부도 확인 해야함.. 
 무이자 카드 등록 분리 해야됨 
 */
#import <UIKit/UIKit.h>


@protocol ISPPayDelegate;

@interface ISPPayController : UIViewController {


	id<ISPPayDelegate> delegate;
	
}

- (IBAction) ISPStartApp;
@property (nonatomic,assign) id<ISPPayDelegate> delegate;

@end




@protocol ISPPayDelegate <NSObject>;
@required 
-(void)returnAnsimValue:(NSString *)r_code
					msg:(NSString *)r_msg
					xid:(NSString *)r_xid
					eci:(NSString *)r_eci
				   cavv:(NSString *)r_cavv
				 cardno:(NSString *)r_cardno
			   joincode:(NSString *)r_joincode;
@end
