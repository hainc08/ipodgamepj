//
//  AlarmConfig.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AlarmConfig.h"
#import "SaveManager.h"

static AlarmConfig *AlarmConfigInst;

@implementation AlarmConfig
@synthesize heightnum;
@synthesize widthnum;
@synthesize FontType;
@synthesize CharName;

+ (AlarmConfig *)getInstance
{
	return AlarmConfigInst;
}
+ (void) initmanager {
	AlarmConfigInst = [AlarmConfig alloc];
	[AlarmConfigInst loadConfig];
}

- (void)SaveConfig
{
	[[SaveManager getInstance] setIntData:@"RotationTime"	idx:0 value:RotationTime];
	[[SaveManager getInstance] setIntData:@"heigthnum"		idx:0 value:heightnum];
	[[SaveManager getInstance] setIntData:@"widthnum"		idx:0 value:widthnum];
	[[SaveManager getInstance] setIntData:@"FontType"		idx:0 value:FontType];
	[[SaveManager getInstance] setStringData:@"FontType"	idx:1 value:FontUpImageType];
	[[SaveManager getInstance] setStringData:@"FontType"	idx:2 value:FontBgImageType];
	
	[[SaveManager getInstance] setIntData:@"HourMode"		idx:0 value:HourMode		== TRUE ? 1 : 0];
	[[SaveManager getInstance] setIntData:@"DateDisplay"	idx:0 value:DateDisplay		== TRUE ? 1 : 0];
	[[SaveManager getInstance] setIntData:@"WeekDisplay"	idx:0 value:WeekDisplay		== TRUE ? 1 : 0];
	
	[[SaveManager getInstance] setIntData:@"AlarmDate"		idx:0 value:AlarmONOFF		== TRUE ? 1	: 0];
	[[SaveManager getInstance] setStringData:@"AlarmDate"	idx:1 value:AlarmTime];
	
	
	[[SaveManager getInstance] setIntData:@"VibrationONOFF"	idx:0 value:VibrationONOFF  == TRUE ? 1 : 0];
	[[SaveManager getInstance] setIntData:@"SnoozeONOFF"	idx:0 value:SnoozeONOFF		== TRUE ? 1 : 0];
	[[SaveManager getInstance] setIntData:@"ShakeONOFF"		idx:0 value:ShakeONOFF		== TRUE ? 1 : 0];
	
	CGAffineTransform trans;
	CGPoint pos;
	
	//세로 세팅정보 저장----------------------
	trans = heigthviewpoint.ClockTrans;
	pos = heigthviewpoint.ClockPoint;
	[[SaveManager getInstance] setFloatData:@"ClockZoom"	idx:0 value:trans.a];
	[[SaveManager getInstance] setIntData:@"ClockPos"		idx:0 value:pos.x];
	[[SaveManager getInstance] setIntData:@"ClockPos"		idx:1 value:pos.y];
	
	trans = heigthviewpoint.DateTrans;
	pos = heigthviewpoint.DatePoint;
	[[SaveManager getInstance] setFloatData:@"DateZoom"		idx:0 value:trans.a];
	[[SaveManager getInstance] setIntData:@"DatePos"		idx:0 value:pos.x];
	[[SaveManager getInstance] setIntData:@"DatePos"		idx:1 value:pos.y];
	//-------------------------------------
	
	//가로 세팅정보 저장----------------------
	trans = widthviewpoint.ClockTrans;
	pos = widthviewpoint.ClockPoint;
	[[SaveManager getInstance] setFloatData:@"ClockZoom"	idx:1 value:trans.a];
	[[SaveManager getInstance] setIntData:@"ClockPos"		idx:2 value:pos.x];
	[[SaveManager getInstance] setIntData:@"ClockPos"		idx:3 value:pos.y];

	trans = widthviewpoint.DateTrans;
	pos = widthviewpoint.DatePoint;
	[[SaveManager getInstance] setFloatData:@"DateZoom"		idx:1 value:trans.a];
	[[SaveManager getInstance] setIntData:@"DatePos"		idx:2 value:pos.x];
	[[SaveManager getInstance] setIntData:@"DatePos"		idx:3 value:pos.y];
	//-------------------------------------

	[[SaveManager getInstance] saveFile];
}

- (void)defaultConfig
{
	/* file save 도 같이 하자 */
	[[SaveManager getInstance] setIntData:@"RotationTime"	idx:0 value:5];
	[[SaveManager getInstance] setIntData:@"heigthnum"		idx:0 value:0];
	[[SaveManager getInstance] setIntData:@"widthnum"		idx:0 value:0];
	[[SaveManager getInstance] setIntData:@"FontType"		idx:0 value:1];
	[[SaveManager getInstance] setStringData:@"FontType"	idx:1 value:@"ub"];
	[[SaveManager getInstance] setStringData:@"FontType"	idx:2 value:@"dw"];
	
	[[SaveManager getInstance] setIntData:@"HourMode"		idx:0 value:1];
	[[SaveManager getInstance] setIntData:@"DateDisplay"	idx:0 value:1];
	[[SaveManager getInstance] setIntData:@"WeekDisplay"	idx:0 value:1];
	
	[[SaveManager getInstance] setIntData:@"AlarmDate"		idx:0 value:0];
	[[SaveManager getInstance] setStringData:@"AlarmDate"	idx:1 value:@"-"];
	
	
	[[SaveManager getInstance] setIntData:@"VibrationONOFF"	idx:0 value:1];
	[[SaveManager getInstance] setIntData:@"SnoozeONOFF"	idx:0 value:1];
	[[SaveManager getInstance] setIntData:@"ShakeONOFF"		idx:0 value:1];

	[[SaveManager getInstance] setFloatData:@"ClockZoom"	idx:0 value:1.f];
	[[SaveManager getInstance] setIntData:@"ClockPos"		idx:0 value:160];
	[[SaveManager getInstance] setIntData:@"ClockPos"		idx:1 value:300];
	
	[[SaveManager getInstance] setFloatData:@"DateZoom"		idx:0 value:0.5f];
	[[SaveManager getInstance] setIntData:@"DatePos"		idx:0 value:200];
	[[SaveManager getInstance] setIntData:@"DatePos"		idx:1 value:50];

	[[SaveManager getInstance] setFloatData:@"ClockZoom"	idx:1 value:1.f];
	[[SaveManager getInstance] setIntData:@"ClockPos"		idx:2 value:300];
	[[SaveManager getInstance] setIntData:@"ClockPos"		idx:3 value:300];
	
	[[SaveManager getInstance] setFloatData:@"DateZoom"		idx:1 value:0.5f];
	[[SaveManager getInstance] setIntData:@"DatePos"		idx:2 value:50];
	[[SaveManager getInstance] setIntData:@"DatePos"		idx:3 value:50];
	
	[[SaveManager getInstance] saveFile];
}

- (void)loadConfig
{
	CharName = @"natsuko";
	
	
	RotationTime	=	[[SaveManager getInstance] getIntData:@"RotationTime"	idx:0 base:5];
	
	heightnum		=	[[SaveManager getInstance] getIntData:@"heigthnum"		idx:0 base:0];
	widthnum		=	[[SaveManager getInstance] getIntData:@"widthnum"		idx:0 base:0];
	
	FontType		=	[[SaveManager getInstance] getIntData:@"FontType"		idx:0 base:1];
	FontUpImageType =	[[SaveManager getInstance] getStringData:@"FontType"	idx:1 base:@"ub"];
	FontBgImageType =	[[SaveManager getInstance] getStringData:@"FontType"	idx:2 base:@"dw"];
	
	
	
	HourMode		=	[[SaveManager getInstance] getIntData:@"HourMode"		idx:0 base:1]	== 1 ? TRUE : FALSE;
	DateDisplay		=	[[SaveManager getInstance] getIntData:@"DateDisplay"	idx:0 base:1]	== 1 ? TRUE : FALSE;
	WeekDisplay		=	[[SaveManager getInstance] getIntData:@"WeekDisplay"	idx:0 base:1]	== 1 ? TRUE : FALSE;

	
	AlarmONOFF		=	[[SaveManager getInstance] getIntData:@"AlarmDate"		idx:0 base:0]	== 1 ? TRUE : FALSE;
	AlarmTime		=	[[SaveManager getInstance] getStringData:@"AlarmDate"	idx:1 base:@"-"];
	
	
	VibrationONOFF	=	[[SaveManager getInstance] getIntData:@"VibrationONOFF"	idx:0 base:0]	== 1 ? TRUE : FALSE;
	SnoozeONOFF		=	[[SaveManager getInstance] getIntData:@"SnoozeONOFF"	idx:0 base:0]	== 1 ? TRUE : FALSE;
	ShakeONOFF		=	[[SaveManager getInstance] getIntData:@"ShakeONOFF"		idx:0 base:0]	== 1 ? TRUE : FALSE;
	
	
	heigthviewpoint =	[ViewCgPoint alloc];
	widthviewpoint	=	[ViewCgPoint alloc];
	
	float cz		=	[[SaveManager getInstance] getFloatData:@"ClockZoom" idx:0 base:1.f];
	[heigthviewpoint setClockTrans:CGAffineTransformMake(cz, 0.0, 0.0, cz, 0.0, 0.0)];
	[heigthviewpoint setClockPoint:CGPointMake([[SaveManager getInstance] getIntData:@"ClockPos" idx:0 base:160],
											   [[SaveManager getInstance] getIntData:@"ClockPos" idx:1 base:300])];

	float dz		=	[[SaveManager getInstance] getFloatData:@"DateZoom" idx:0 base:0.5f];
	[heigthviewpoint setDateTrans:CGAffineTransformMake(dz, 0.0, 0.0, dz, 0.0, 0.0)];
	[heigthviewpoint setDatePoint:CGPointMake([[SaveManager getInstance] getIntData:@"DatePos" idx:0 base:200],
											  [[SaveManager getInstance] getIntData:@"DatePos" idx:1 base:50])];

	cz				=	[[SaveManager getInstance] getFloatData:@"ClockZoom" idx:1 base:1.f];
	[widthviewpoint setClockTrans:CGAffineTransformMake(cz, 0.0, 0.0, cz, 0.0, 0.0)];
	[widthviewpoint setClockPoint:CGPointMake([[SaveManager getInstance] getIntData:@"ClockPos" idx:2 base:160],
											   [[SaveManager getInstance] getIntData:@"ClockPos" idx:3 base:300])];
	
	dz				=	[[SaveManager getInstance] getFloatData:@"DateZoom" idx:1 base:0.5f];
	[widthviewpoint setDateTrans:CGAffineTransformMake(dz, 0.0, 0.0, dz, 0.0, 0.0)];
	[widthviewpoint setDatePoint:CGPointMake([[SaveManager getInstance] getIntData:@"DatePos" idx:2 base:200],
											  [[SaveManager getInstance] getIntData:@"DatePos" idx:3 base:50])];
}

- (BOOL) getAlarmONOFF
{
	return  AlarmONOFF;
}
- (BOOL) setAlarmONOFF
{
	AlarmONOFF = !AlarmONOFF;
	return AlarmONOFF;
}

- (BOOL) getWeekDisplay
{
	return  WeekDisplay;
}
- (BOOL) setWeekDisplay
{
	WeekDisplay = !WeekDisplay;
	return WeekDisplay;
}
- (BOOL) getHourMode
{
	return  HourMode;
}
- (BOOL) setHourMode
{
	HourMode = !HourMode;
	return HourMode;
}
- (BOOL) getDateDisplay
{
	return  DateDisplay;
}
- (BOOL) setDateDisplay
{
	DateDisplay = !DateDisplay;
	return DateDisplay;
}
- (int )getFontType
{
	return  FontType;
}

- (NSString *)getUpImageType
{
	return FontUpImageType;
}

- (NSString *)getBgImageType
{
	return FontBgImageType;
}

- (NSString *)getCharName
{
	return CharName;
}

- (ViewCgPoint *) getHeigthViewPoint
{
	return heigthviewpoint;
}

- (ViewCgPoint *) getWidthViewPoint
{
	return widthviewpoint;
}

- (void) setHeigthViewPoint:(ViewCgPoint *) _inPoint
{
	[heigthviewpoint setClockTrans:_inPoint.ClockTrans]; 
	[heigthviewpoint setClockPoint:_inPoint.ClockPoint];
	[heigthviewpoint setDateTrans:_inPoint.DateTrans];
	[heigthviewpoint setDatePoint:_inPoint.DatePoint];
	[self SaveConfig];
}

- (void) setWidthViewPoint:(ViewCgPoint *) _inPoint
{
	[widthviewpoint setClockTrans:_inPoint.ClockTrans]; 
	[widthviewpoint setClockPoint:_inPoint.ClockPoint];
	[widthviewpoint setDateTrans:_inPoint.DateTrans];
	[widthviewpoint setDatePoint:_inPoint.DatePoint];	
	[self SaveConfig];
}
- (void) setRotationTime:(int)value
{
	RotationTime = value;
}
- (int) getRotationTime
{
	return RotationTime;
}
- (NSString *)getAlarmTime
{
	return	AlarmTime;
}
- (void) setAlarmTime:(NSString *)_inAlarmTime
{
	AlarmTime = _inAlarmTime;
}


- (BOOL) setVibrationONOFF
{
	VibrationONOFF = !VibrationONOFF;
	return VibrationONOFF;
}

- (BOOL) getVibrationONOFF
{
	return VibrationONOFF;
}

- (BOOL) setSnoozeONOFF
{
	SnoozeONOFF = !SnoozeONOFF;
	return SnoozeONOFF;
}
- (BOOL) getSnoozeONOFF
{
	return SnoozeONOFF;
}

- (BOOL) setShakeONOFF
{
	ShakeONOFF = !ShakeONOFF;
	return ShakeONOFF;
}
- (BOOL) getShakeONOFF
{
	return ShakeONOFF;
}

- (void)dealloc {
	[super dealloc];	
	[FontUpImageType  release];
	[FontBgImageType  release];
}
- (void) closeManager {
}

@end


@implementation ViewCgPoint
@synthesize ClockTrans;	
@synthesize DateTrans;
@synthesize ClockPoint;
@synthesize DatePoint;
@end

