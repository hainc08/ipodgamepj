//
//  AlarmConfig.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AlarmConfig.h"
#import "SaveManager.h"
#import "DateFormat.h"

static AlarmConfig *AlarmConfigInst;

@implementation AlarmConfig

@synthesize heightnum;
@synthesize widthnum;
@synthesize FontType;
@synthesize ForceUpdate;
@synthesize CharName;
@synthesize CharNameJP;

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
	
	int value;
	if (OfficeMode) value = 0;
	else value = 1;

	[[SaveManager getInstance] setIntData:@"OfficeMode"		idx:0 value:value];
	[[SaveManager getInstance] setIntData:@"WeekdayType"	idx:0 value:weekdayType];

	[self AlarmSaveConfig];
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

	OfficeMode = false;
	weekdayType = 0;
	
	[self AlarmSaveConfig];
	[[SaveManager getInstance] saveFile];
}

- (void)loadConfig
{
#ifdef NATSUKO
	CharName = @"natsuko";
	CharNameJP = @"なつこ";
#elif AKARI
	CharName = @"akari";
	CharNameJP = @"あかり";
#elif HARUKA
	CharName = @"haruka";
	CharNameJP = @"はるか";
#elif HITOMI
	CharName = @"hitomi";
	CharNameJP = @"ひとみ";
#elif IRIKA
	CharName = @"irika";
	CharNameJP = @"エリカ";
#elif REINA
	CharName = @"reina";
	CharNameJP = @"レイナ";
#elif FUMIKO
	CharName = @"fumiko";
	CharNameJP = @"文子";
#else
	//여기는 모든 캐릭터가 들어가는 패키지
	CharName = [[SaveManager getInstance] getStringData:@"CharName"	idx:0 base:@"natsuko"];
	CharNameJP = [[SaveManager getInstance] getStringData:@"CharName"	idx:1 base:@"なつこ"];
#endif

#if 0 
	akari
	あかり 
	
	natsuko
	なつこ
	
	haruka
	はるか
	
	hitomi
	ひとみ
	
	irika
	エリカ
	
	reina
	レイナ
	
	fumiko
	文子 
#endif
	SoundList = [[NSArray alloc] initWithObjects: @"Simple Alarm", 
				 @"現実との境界線",
				 @"平和な時",
				 @"世にも怪奇な物語"
				 @"神社",	
				 @"ゆらめく斜陽",
				 @"プラン６９ From M",
				 @"仮面夫婦クオリア",
				 @"純愛幻ヒプノツス",
				 @"東京エイリアン",
				 @"マインドシーカー村越",
				 @"混濁していく意識",
				 @"表から裏へ",
				 @"それはあまりに絶望的な",
				 @"ほとんど無害",
				 @"宇宙で一番愛しい人",
				 @"インドアゲーム",
				 @"神様はオレ様？",
				 @"同棲",
				 @"そして誰もいなくなった",
				 @"村越の野望", nil];
	AlarmArr = [[NSMutableArray alloc] initWithCapacity:0];
	
	RotationTime	=	[[SaveManager getInstance] getIntData:@"RotationTime"	idx:0 base:5];
	
	heightnum		=	[[SaveManager getInstance] getIntData:@"heigthnum"		idx:0 base:0];
	widthnum		=	[[SaveManager getInstance] getIntData:@"widthnum"		idx:0 base:0];
	
	FontType		=	[[SaveManager getInstance] getIntData:@"FontType"		idx:0 base:1];
	FontUpImageType =	[[SaveManager getInstance] getStringData:@"FontType"	idx:1 base:@"ub"];
	FontBgImageType =	[[SaveManager getInstance] getStringData:@"FontType"	idx:2 base:@"dw"];
	
	HourMode		=	[[SaveManager getInstance] getIntData:@"HourMode"		idx:0 base:1]	== 1 ? TRUE : FALSE;
	DateDisplay		=	[[SaveManager getInstance] getIntData:@"DateDisplay"	idx:0 base:1]	== 1 ? TRUE : FALSE;
	WeekDisplay		=	[[SaveManager getInstance] getIntData:@"WeekDisplay"	idx:0 base:1]	== 1 ? TRUE : FALSE;

	
	heigthviewpoint =	[ViewCgPoint alloc];
	widthviewpoint	=	[ViewCgPoint alloc];
	
	float cz		=	[[SaveManager getInstance] getFloatData:@"ClockZoom" idx:0 base:1.0f];
	[heigthviewpoint setClockTrans:CGAffineTransformMake(cz, 0.0, 0.0, cz, 0.0, 0.0)];
	[heigthviewpoint setClockPoint:CGPointMake([[SaveManager getInstance] getIntData:@"ClockPos" idx:0 base:280],
											   [[SaveManager getInstance] getIntData:@"ClockPos" idx:1 base:250])];

	float dz		=	[[SaveManager getInstance] getFloatData:@"DateZoom" idx:0 base:0.5f];
	[heigthviewpoint setDateTrans:CGAffineTransformMake(dz, 0.0, 0.0, dz, 0.0, 0.0)];
	[heigthviewpoint setDatePoint:CGPointMake([[SaveManager getInstance] getIntData:@"DatePos" idx:0 base:100],
											  [[SaveManager getInstance] getIntData:@"DatePos" idx:1 base:50])];

	cz				=	[[SaveManager getInstance] getFloatData:@"ClockZoom" idx:1 base:1.0f];
	[widthviewpoint setClockTrans:CGAffineTransformMake(cz, 0.0, 0.0, cz, 0.0, 0.0)];
	[widthviewpoint setClockPoint:CGPointMake([[SaveManager getInstance] getIntData:@"ClockPos" idx:2 base:160],
											   [[SaveManager getInstance] getIntData:@"ClockPos" idx:3 base:380])];
	
	dz				=	[[SaveManager getInstance] getFloatData:@"DateZoom" idx:1 base:0.5f];
	[widthviewpoint setDateTrans:CGAffineTransformMake(dz, 0.0, 0.0, dz, 0.0, 0.0)];
	[widthviewpoint setDatePoint:CGPointMake([[SaveManager getInstance] getIntData:@"DatePos" idx:2 base:200],
											  [[SaveManager getInstance] getIntData:@"DatePos" idx:3 base:50])];
	
	int value = [[SaveManager getInstance] getIntData:@"OfficeMode"		idx:0 base:1];
	if (value == 0) OfficeMode = true;
	else OfficeMode = false;
	weekdayType = [[SaveManager getInstance] getIntData:@"WeekdayType"		idx:0 base:0];

	[self AlarmLoadConfig];
}

-(void) AlarmSaveConfig
{
	int count= [AlarmArr count];
	
	[[SaveManager getInstance] setIntData:@"AlarmCount"		idx:0 value:count];
	
	for(int loop= 0; loop < count; loop++)
	{
		AlarmDate *t_alarm = [AlarmArr objectAtIndex:loop];
		[[SaveManager getInstance] setIntData:[NSString stringWithFormat:@"AlarmDate_%d",		loop] idx:0 value:t_alarm.AlarmONOFF ? 1:0];
		[[SaveManager getInstance] setStringData:[NSString stringWithFormat:@"AlarmDate_%d",	loop] idx:1 value:t_alarm.Name];
		[[SaveManager getInstance] setStringData:[NSString stringWithFormat:@"AlarmDate_%d",	loop] idx:2 value:t_alarm.Sound];
		[[SaveManager getInstance] setStringData:[NSString stringWithFormat:@"AlarmDate_%d",	loop] idx:3 value:t_alarm.Time ];
		[[SaveManager getInstance] setIntData:[NSString stringWithFormat:@"AlarmDate_%d",		loop] idx:4 value:t_alarm.SnoozeONOFF ? 1:0];
		[[SaveManager getInstance] setIntData:[NSString stringWithFormat:@"AlarmDate_%d",		loop] idx:5 value:t_alarm.VibrationONOFF?1:0];
		[[SaveManager getInstance] setIntData:[NSString stringWithFormat:@"AlarmDate_%d",		loop] idx:6 value:t_alarm.ShakeONOFF?1:0];
		[[SaveManager getInstance] setIntData:[NSString stringWithFormat:@"AlarmDate_%d",		loop] idx:7 value:t_alarm.RepeatIdx];
	}
}

-(void) AlarmLoadConfig
{
	int	AlarmCount		=	[[SaveManager getInstance] getIntData:@"AlarmCount"		idx:0 base:0];

	for(int loop= 0; loop < AlarmCount; loop++)
	{
		AlarmDate *t_alarm  = [[AlarmDate alloc] init];
		t_alarm.AlarmONOFF	=	[[SaveManager getInstance] getIntData:[NSString stringWithFormat:@"AlarmDate_%d",		loop] idx:0 base:0] == 1 ? TRUE : FALSE;
		t_alarm.Name		=	[[SaveManager getInstance] getStringData:[NSString stringWithFormat:@"AlarmDate_%d",	loop] idx:1 base:@"Alarm"];
		t_alarm.Sound =	[[SaveManager getInstance] getStringData:[NSString stringWithFormat:@"AlarmDate_%d",	loop] idx:2 base:@"NONE"];
		t_alarm.Time		=	[[SaveManager getInstance] getStringData:[NSString stringWithFormat:@"AlarmDate_%d",		loop] idx:3 base:@"-"];
		t_alarm.SnoozeONOFF	=	[[SaveManager getInstance] getIntData:[NSString stringWithFormat:@"AlarmDate_%d",		loop] idx:4 base:0] == 1 ? TRUE : FALSE;
		t_alarm.VibrationONOFF	=	[[SaveManager getInstance] getIntData:[NSString stringWithFormat:@"AlarmDate_%d",	loop] idx:5 base:0] == 1 ? TRUE : FALSE;
		t_alarm.ShakeONOFF	=	[[SaveManager getInstance] getIntData:[NSString stringWithFormat:@"AlarmDate_%d",		loop] idx:6 base:0] == 1 ? TRUE : FALSE;
		t_alarm.RepeatIdx	=	[[SaveManager getInstance] getIntData:[NSString stringWithFormat:@"AlarmDate_%d",		loop] idx:7 base:0];

		[AlarmArr addObject:t_alarm];
		[t_alarm release];
	}
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

- (BOOL) setSecondMode;
{
	SecondMode = !SecondMode;
	return	 SecondMode;
}

- (BOOL) getSecondMode
{
	return SecondMode;
}

- (BOOL) setOfficeMode
{
	OfficeMode = !OfficeMode;
	return	 OfficeMode;
}

- (BOOL) getOfficeMode
{
	//망할 애플 때문에 무조건 오피스모드...
	return true;
	//return OfficeMode;
}

- (int) toggleWeekdayType
{
	++weekdayType;
	if (weekdayType == 2) weekdayType = 0;
	return weekdayType;
}

- (int) getWeekdayType
{
	return weekdayType;
}

- (NSMutableArray *)getAlarmArr
{
	return AlarmArr;
}
- (AlarmDate *)getAlarmIndex:(int)_inRow
{
	return [AlarmArr objectAtIndex:_inRow];
}
- (int)getAlarmCount
{
	return [AlarmArr count];
}
- (int) setAlarmAdd:(AlarmDate *)_inData
{
	[AlarmArr addObject:_inData];
	return [AlarmArr count];
}

- (void) deleteAlarm:(AlarmDate *)_inData
{
	int i = 0;
	for (AlarmDate* data in AlarmArr)
	{
		if (_inData == data)
		{
			[AlarmArr removeObjectAtIndex:i];
			return;
		}
		++i;
	}
}
- (NSString *) getSoundList:(int)_row
{
	return [SoundList objectAtIndex:_row];
}
- (int) getSoundRow:(NSString *)_bgm
{
	return [SoundList indexOfObject:_bgm];
}
- (void)dealloc {
	[super dealloc];	
	[FontUpImageType  release];
	[FontBgImageType  release];
}
- (void) closeManager {
}

- (void) SetNameInfo:(NSString*)name :(NSString*)nameJP
{
	CharName = name;
	CharNameJP = nameJP;
	[[SaveManager getInstance] setStringData:@"CharName"	idx:0	value:name];
	[[SaveManager getInstance] setStringData:@"CharName"	idx:1	value:nameJP];
}

@end


@implementation ViewCgPoint

@synthesize ClockTrans;	
@synthesize DateTrans;
@synthesize ClockPoint;
@synthesize DatePoint;

@end


@implementation AlarmDate

@synthesize Time;
@synthesize tmpTime;
@synthesize Name;
@synthesize	Sound;
@synthesize AlarmONOFF;
@synthesize SnoozeONOFF;
@synthesize SnoozeCount;
@synthesize ShakeONOFF;
@synthesize VibrationONOFF;
@synthesize RepeatIdx;
@synthesize SoundVolume;

- (id)init
{
	[super init];
	Time = @"00:00 AM";
	Name = @"Alarm";
	Sound = @"Simple Alarm";
	AlarmONOFF = NO;
	SnoozeONOFF	= NO;
	SnoozeCount = 5;
	ShakeONOFF = NO;
	VibrationONOFF = NO;
	RepeatIdx = 0;
	SoundVolume = 3;
	alarmDate = nil;
	return self;
}

- (NSDate*)GetNSDate
{
	if (alarmDate == nil)
	{
		NSString *Temp = [Time stringByReplacingOccurrencesOfString:@" " withString:@":00 " ]; // 그냥 하면 00초에 알람이 안울려서 

		NSDate* now = [[[DateFormat getInstance] getCurrentDate] retain];
		NSDate* tempDate = [[[DateFormat getInstance] getStringToDate:Temp format:@"h:mm:ss a"] retain];
		 
		if (RepeatIdx > 1)
		{
			int idx = RepeatIdx - 2;

			if (idx == 0) return nil;

			for (int i=0; i<7; ++i)
			{				
				NSDate* weekDay = [tempDate addTimeInterval:60*60*24*i];

				if ([[DateFormat getInstance] getWeekType:weekDay] & idx)
				{
					if ([now timeIntervalSince1970] < [weekDay timeIntervalSince1970])
					{
						alarmDate = [weekDay retain];
						return alarmDate;
					}
				}
			}
		}
		else if ([now timeIntervalSince1970] > [tempDate timeIntervalSince1970])
		{
			//다음날로...
			alarmDate = [[tempDate addTimeInterval:60*60*24] retain];
		}
		else
		{
			alarmDate = [tempDate retain];
		}
	}
	
	return alarmDate;
}

- (void)ResetNSDateSnooze
{
		alarmDate = [[alarmDate addTimeInterval:60*5] retain];
}
- (void)ResetNSDate
{
	if (alarmDate != nil)
	{
		[alarmDate release];
		alarmDate = nil;
	}
}
- (void)NextDayNSDate
{
	//다음날로 보내보려 
	//alarmDate = [[alarmDate addTimeInterval:60*60*24] retain];
	if (alarmDate != nil)
	{
		[alarmDate release];
		alarmDate = nil;
	}
}

@end
