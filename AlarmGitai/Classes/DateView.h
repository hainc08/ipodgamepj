//
//  DateView.h
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

enum DATETYPE {
	DAY_T= 0,
	DAY_M,
	MON_T,
	MON_M,
	WEEK
};
@interface DateView : UIView {
	NSString *Week;
	NSString *Mon;
	NSString *Day;
	
	UIImageView *u_DayT;
	UIImageView *u_DayM;
	UIImageView *u_MonT;
	UIImageView *u_MonM;
	UIImageView *u_Week;
	UIImageView *u_Dot;
	
	
	UIImageView *b_DayT;
	UIImageView *b_DayM;
	UIImageView *b_MonT;
	UIImageView *b_MonM;
	UIImageView *b_Week;
	UIImageView *b_Dot;
}
- (void)UpdateDate;
- (void)CreatedImageView ;
- (void)UpdateDate;
- (void)ChageNumberImage:(int)type changeImage:(char)number;
@end
