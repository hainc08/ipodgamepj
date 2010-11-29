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
	int				FontType;
	NSString		*FontBgImageType;
	NSString		*FontUpImageType;
	
	int				heightnum;
	int				widthnum;
	ViewCgPoint		*heigthviewpoint;
	ViewCgPoint		*widthviewpoint;
	
	/* 배경사진 sec  Default : 5 */
	int				RotationTime;
	
	/* 알람 시간  */
	NSString		*AlarmTime;
	
	/* 환경설정 */
	BOOL			HourMode;	
	BOOL			DateDisplay; 
	BOOL			WeekDisplay;
	/* alarm 설정*/
	BOOL			AlarmONOFF;
	BOOL			VibrationONOFF;
	BOOL			SnoozeONOFF;
	BOOL			ShakeONOFF;
}
@property (readwrite) int heightnum;
@property (readwrite) int widthnum;
@property (readwrite) int FontType;
@property (retain) NSString *CharName;
//NSObject를 상속받은 객체의 경우 retain을 사용해야한다.

+ (AlarmConfig *)getInstance;
+ (void) initmanager;
- (void) closeManager;
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
- (BOOL) getDateDisplay;
- (BOOL) getWeekDisplay;

- (BOOL) setHourMode;
- (BOOL) setDateDisplay;
- (BOOL) setWeekDisplay;

- (BOOL) setAlarmONOFF;
- (BOOL) getAlarmONOFF;

- (BOOL) setVibrationONOFF;
- (BOOL) getVibrationONOFF;

- (BOOL) setSnoozeONOFF;
- (BOOL) getSnoozeONOFF;

- (BOOL) setShakeONOFF;
- (BOOL) getShakeONOFF;

- (void) SaveConfig;
- (int) getRotationTime;
- (void) setRotationTime:(int)value;

- (NSString *)getAlarmTime;
- (void) setAlarmTime:(NSString *)_inAlarmTime;
@end
