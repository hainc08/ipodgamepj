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
	locale	=	[[NSLocale alloc] init];
	FormatDate	=	[[NSDateFormatter alloc] init];
	[self initContry:@"en_KR"];
	
}
- (void) initContry:(NSString *)Country
{/* en_US , en_JP */
	[locale initWithLocaleIdentifier:Country];
	[FormatDate setLocale:locale];
}

- (NSString *)getWeek 
{
	[FormatDate setDateFormat:@"EEE"];
	NSString *Week = [FormatDate stringFromDate:[[NSDate date] autorelease]];
	return Week;
}

- (NSString *)getSMon
{
	[FormatDate setDateFormat:@"MMMM"];
	NSString *Mon = [FormatDate stringFromDate:[[NSDate date] autorelease]];
	return Mon;
}
- (NSString *)getIMon
{
	[FormatDate setDateFormat:@"MM"];
	NSString *Mon = [FormatDate stringFromDate:[[NSDate date] autorelease]];
	return Mon;
}
- (NSString *)getDay 
{
	[FormatDate setDateFormat:@"dd"];
	NSString *Day = [FormatDate stringFromDate:[[NSDate date] autorelease]];
	return Day;
}

- (NSString *)getHour 
{
	[FormatDate setDateFormat:@"hh"];
	NSString *Hour = [FormatDate stringFromDate:[[NSDate date] autorelease]];
	return Hour;
}
- (NSString *)getHour24 
{
	[FormatDate setDateFormat:@"kk"];
	NSString *Hour = [FormatDate stringFromDate:[[NSDate date] autorelease]];
	return Hour;
}

- (NSString *)getMin 
{
	[FormatDate setDateFormat:@"mm"];
	NSString *Min	= [FormatDate stringFromDate:[[NSDate date] autorelease]];
	return Min;
}

- (NSString *)getSec 
{
	[FormatDate setDateFormat:@"si"];
	NSString *Sec	= [FormatDate stringFromDate:[[NSDate date] autorelease]];
	return Sec;
}

- (NSString *)getAP
{
	
	[FormatDate setDateFormat:@"a"];
	NSString *AP	= [FormatDate stringFromDate:[[NSDate date] autorelease]];

	return AP;
}

- (void)dealloc {
	[super dealloc];
	[locale release];
	[FormatDate release];

}

- (BOOL)getNight 
{
	BOOL ret = FALSE;
	NSUInteger value ;
	[FormatDate setDateFormat:@"hh"];
	NSString *Hour = [FormatDate stringFromDate:[[NSDate date] autorelease]];
	
	value = [Hour intValue];
	if(value > 18 || value < 6 )
	{
		ret = TRUE;
	}
	return ret;
}

- (void) closeManager {
}
@end
