//
//  AlarmConfig.h
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface  AlarmDate : NSObject
{
	NSString	*Name;
	BOOL		AlarmONOFF;
	
	
	NSString *Sound;
	int		SoundVolume;
	
	BOOL	SnoozeONOFF;
	int		SnoozeCount;
	BOOL	VibrationONOFF;
	BOOL	ShakeONOFF;
	int RepeatIdx;
	
	/* 실제저장된 값 */
	NSString *Time;
	
	NSString *tmpTime;
	NSDate* alarmDate;
}
@property (nonatomic, retain) NSString *Name;
@property (nonatomic, retain) NSString *Time;
@property (nonatomic, retain) NSString *Sound;

@property (nonatomic, retain) NSString *tmpTime;

@property (nonatomic,  assign, getter=isAlarmONOFF)		BOOL	AlarmONOFF;
@property (nonatomic,  assign, getter=isSnoozeONOFF)	BOOL	SnoozeONOFF;
@property (nonatomic,  assign, getter=isShakeONOFF)		BOOL	ShakeONOFF;
@property (nonatomic,  assign, getter=isVibrationONOFF) BOOL	VibrationONOFF;
@property (readwrite) int SoundVolume;
@property (readwrite) int RepeatIdx;
@property (readwrite) int SnoozeCount;
- (NSDate*)GetNSDate;
- (void)ResetNSDateSnooze;
- (void)ResetNSDate;
- (void)NextDayNSDate;

@end



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
	
	/* 환경설정 */
	BOOL			HourMode;	
	BOOL			SecondMode;
	BOOL			DateDisplay; 
	BOOL			WeekDisplay;
	BOOL			OfficeMode;
	
	int				weekdayType;

	
	NSMutableArray			*AlarmArr; 
}
@property (readwrite) int heightnum;
@property (readwrite) int widthnum;
@property (readwrite) int FontType;
@property (retain) NSString *CharName;
//NSObject를 상속받은 객체의 경우 retain을 사용해야한다.

+ (AlarmConfig *)getInstance;
+ (void) initmanager;
- (void) closeManager;
- (void)loadConfig;

- (int)getFontType;

- (NSString *)getUpImageType;
- (NSString *)getBgImageType;
- (NSString *)getCharName;


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

- (BOOL) setSecondMode;
- (BOOL) getSecondMode;

- (BOOL) setOfficeMode;
- (BOOL) getOfficeMode;

- (int) toggleWeekdayType;
- (int) getWeekdayType;

- (void) SaveConfig;

- (int) getRotationTime;
- (void) setRotationTime:(int)value;

/* alarm set */
- (NSMutableArray *)getAlarmArr;
- (int) setAlarmAdd:(AlarmDate *)_inData;
- (void) deleteAlarm:(AlarmDate *)_inData;
-(void) AlarmLoadConfig;
-(void) AlarmSaveConfig;
@end
