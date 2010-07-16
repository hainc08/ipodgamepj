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
	
	IBOutlet UIImageView *u_DayT;
	IBOutlet UIImageView *u_DayM;
	IBOutlet UIImageView *u_MonT;
	IBOutlet UIImageView *u_MonM;
	IBOutlet UIImageView *u_Week;
	IBOutlet UIImageView *u_Dot;
	
	
	IBOutlet UIImageView *b_DayT;
	IBOutlet UIImageView *b_DayM;
	IBOutlet UIImageView *b_MonT;
	IBOutlet UIImageView *b_MonM;
	IBOutlet UIImageView *b_Week;
	IBOutlet UIImageView *b_Dot;
}
- (void)UpdateDate;
- (void)CreatedImageView ;
- (void)UpdateDate;
- (void)ChageNumberImage:(int)type changeImage:(char)number;
@end
