//
//  AlarmConfig.h
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewCgPoint : NSObject
{
	CGAffineTransform ClockTrans;
	CGAffineTransform DateTrans;
	
	CGPoint			ClockPoint;
	CGPoint			DatePoint;
}

@property (readwrite) CGAffineTransform ClockTrans;	
@property (readwrite) CGAffineTransform DateTrans;
@property (readwrite) CGPoint			ClockPoint;
@property (readwrite) CGPoint			DatePoint;

@end

@interface  AlarmDate : NSObject
{
	NSString *Name;
	NSString *SoundName;
	
	
	int type;  // 매일 / 하루만 / 평일만/ 주말만 / 몇시간후    
	int hour;
	int min;
}

@end



@interface AlarmConfig : NSObject {
	int FontType;
	NSString *FontBgImageType;
	NSString *FontUpImageType;
	
	int			heightnum;
	int			widthnum;
	ViewCgPoint	*heigthviewpoint[5];
	ViewCgPoint	*widthviewpoint[5];
	
	
	
	NSString *locale;		/* 나라 설정 */
	NSDateFormatter AlarmCDate[10]; /* 알람 설정 */
	
	/* 배경사진 sec */
	int RotationTime;
	
	
}
@property (readwrite) int heightnum;
@property (readwrite) int widthnum;

+ (AlarmConfig *)getInstance;
+ (void) initmanager;
- (void) closeManager;
- (int)getFontType;
- (NSString *)getUpImageType;
- (NSString *)getBgImageType;
- (void)loadConfig;
- (ViewCgPoint *) getHeigthViewPoint;
- (ViewCgPoint *) getWidthViewPoint;
@end
