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
	NSString		*CharName;
	NSArray			*fontArr; 
	int				FontType;
	NSString		*FontBgImageType;
	NSString		*FontUpImageType;
	
	int				heightnum;
	int				widthnum;
	ViewCgPoint		*heigthviewpoint;
	ViewCgPoint		*widthviewpoint;
	
	
	
	NSString		*locale;		/* 나라 설정 */
	NSDateFormatter	AlarmCDate[10]; /* 알람 설정 */
	
	/* 배경사진 sec  Default : 5 */
	int				RotationTime;
	
	
	/* 환경설정 */
	
	BOOL			HourMode;
	BOOL			DateMode; 
	
	BOOL			AlamONOFF;
	
	
}
@property (readwrite) int heightnum;
@property (readwrite) int widthnum;
@property (readwrite) int FontType;
@property (retain) NSString *CharName;
//NSObject를 상속받은 객체의 경우 retain을 사용해야한다.

+ (AlarmConfig *)getInstance;
+ (void) initmanager;
- (void) closeManager;
- (NSArray *)getFontArr;
- (NSString *)getCurrFontName;
- (int)getFontType;
- (NSString *)getUpImageType;
- (NSString *)getBgImageType;
- (NSString *)getCharName;
- (void)loadConfig;
- (ViewCgPoint *) getHeigthViewPoint;
- (ViewCgPoint *) getWidthViewPoint;
- (void) setHeigthViewPoint:(ViewCgPoint *) _inPoint;
- (void) setWidthViewPoint:(ViewCgPoint *) _inPoint;

- (BOOL) getHourMode;
- (BOOL) getDateMode;
- (void) setHourMode;
- (void) setDateMode;

- (void) setAlarmONOFF;
- (BOOL) getAlarmONOFF;

- (void) SaveConfig;
- (int) getRotationTime;
- (void) setRotationTime:(int)value;
@end
