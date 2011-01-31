//
//  DateFormat.m
//  Framework
//
//  Created by embmaster on 10. 04. 21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DateFormat.h"

static DateFormat *DateFormatInst;
@implementation DateFormat



+ (DateFormat *)getInstance
{
	return DateFormatInst;
}

+ (void) initmanager {
	DateFormatInst = [DateFormat alloc];
	[DateFormatInst initalize];
}

- (void) initalize
{
	locale	=	[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
	FormatDate	=	[[NSDateFormatter alloc] init];
	[FormatDate setFormatterBehavior:NSDateFormatterBehavior10_4];
	[FormatDate setDateStyle:NSDateFormatterLongStyle];
	[FormatDate setTimeStyle:NSDateFormatterNoStyle];
	[FormatDate setLocale:locale];
}

- (void) initContry:(NSString *)Country
{/* en_US , en_JP */
	[locale initWithLocaleIdentifier:Country];
	[FormatDate setLocale:locale];
}

- (NSString *)getWeek 
{
	return [self getTimeString:@"EEE"];
}

- (NSString *)getSMon
{
	return [self getTimeString:@"MMMM"];
}

- (NSString *)getIMon
{
	return [self getTimeString:@"MM"];
}

- (NSString *)getDay 
{
	return [self getTimeString:@"dd"];
}

- (NSString *)getHour 
{
	return [self getTimeString:@"hh"];
}

- (NSString *)getHour24 
{
	return [self getTimeString:@"kk"];
}

- (NSString *)getMin 
{
	return [self getTimeString:@"mm"];
}

- (NSString *)getSec 
{
	return [self getTimeString:@"si"];
}

- (NSString *)getAlarm 
{
	return [self getTimeString:@"h:mm a"];
}

- (NSString *)getAlarmFormat:(NSString *)_informat
{
	return [self getTimeString:@"_informat"];
}

- (BOOL)getNight 
{
	BOOL ret = FALSE;

	NSString *Hour = [self getTimeString:@"kk"];
	
	int value = [Hour intValue];
	if(value > 18 || value < 6 )
	{
		ret = TRUE;
	}
	
	return ret;
}
- (int)getWeekType
{
	int ret = 0;
	[FormatDate setDefaultDate:[NSDate date]];
	if( [[self getTimeString:@"EEE"] compare:@"Sun"]) ret = 0x01;
	else if ( [[self getTimeString:@"EEE"] compare:@"Mon"]) ret = 0x02;
	else if ( [[self getTimeString:@"EEE"] compare:@"Tue"]) ret = 0x04;
	else if ( [[self getTimeString:@"EEE"] compare:@"Wed"])	ret = 0x08;
	else if ( [[self getTimeString:@"EEE"] compare:@"Thu"])	ret = 0x10;
	else if ( [[self getTimeString:@"EEE"] compare:@"Fri"])	ret = 0x20;
	else if ( [[self getTimeString:@"EEE"] compare:@"Sat"])	ret = 0x40;

	return ret;
}

- (NSString *)getAP
{
	return [self getTimeString:@"a"];
}

- (NSString *)getTimeString:(NSString *)format
{
	[FormatDate setDateFormat:format];
	NSString *str = [FormatDate stringFromDate:[NSDate date]];
	return str;
}

- (NSData *) getStringToDate:(NSString *)_indate format:(NSString *)_informat
{
	[FormatDate setDefaultDate:[NSDate date]];
	[FormatDate setDateFormat:_informat];
	return [[FormatDate dateFromString:_indate] retain];
}

- (NSData *) getCurrentDate
{
	return  [NSDate date];
}

- (void)dealloc {
	[locale release];
	[FormatDate release];

	[super dealloc];
}

- (void) closeManager {
}
@end
