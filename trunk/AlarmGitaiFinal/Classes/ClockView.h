//
//  ClockView.h
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

enum CLOCKTYPE {
	HOUR_T = 0,
	HOUR_M,
	MIN_T,
	MIN_M,
	SEC_T,
	SEC_M
};

@interface ClockView : UIViewController{
	int Hour;
	int Min;
	int Sec;
	
	UIImageView *u_HourT;
	UIImageView *u_HourM;
	UIImageView *u_MinT;
	UIImageView *u_MinM;
	UIImageView *u_Dot;
	
	UIImageView *su_Dot;
	UIImageView *u_SecT;
	UIImageView *u_SecM;
	
	UIImageView *b_HourT;
	UIImageView *b_HourM;
	UIImageView *b_MinT;
	UIImageView *b_MinM;
	UIImageView *b_Dot;

	UIImageView *sb_Dot;
	UIImageView *b_SecT;
	UIImageView *b_SecM;
	
}
- (void)CreatedImageView ;
- (void)ChageNumberImage:(int)type  changeImage:(int)number;
- (void)UpdateTime;
@end
