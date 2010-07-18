//
//  AlarmConfig.h
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AlarmConfig : NSObject {
	int FontType;
	NSString *FontBgImageType;
	NSString *FontUpImageType;
	
	CGAffineTransform ClockTrans;
	CGAffineTransform DateTrans;
	
	CGPoint			ClockPoint;
	CGPoint			DatePoint;
	
	
	NSLocale *locale;		/* 나라 설정 */
	NSDateFormatter *AlarmCDate[10]; /* 알람 설정 */
	
	/* 배경사진 sec */
	int RotationTime;
	
	
}

+ (AlarmConfig *)getInstance;
+ (void) initmanager;
- (void) closeManager;
- (int)getFontType;
- (NSString *)getUpImageType;
- (NSString *)getBgImageType;
- (void)loadConfig;
@end
