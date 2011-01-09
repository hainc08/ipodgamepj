//
//  
//  Framework
//
//  Created by embmaster on 10. 04. 21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface DateFormat : NSObject {

	/* 나라 설정 */ 
	NSLocale *locale;
	NSDateFormatter *FormatDate;
	/* 값을 저장한다 */
	
}
+ (DateFormat *)getInstance;
+ (void) initmanager ;
- (void) closeManager;

- (void) initalize;
- (void) initContry:(NSString *)Country;
- (NSString *)getWeek;
- (NSString *)getSMon;
- (NSString *)getIMon;
- (NSString *)getDay;
- (NSString *)getHour;
- (NSString *)getHour24;
- (NSString *)getMin;
- (NSString *)getSec;
- (NSString *)getAP;
- (NSString *)getAlarm;
- (BOOL)getNight ;
- (int)getWeekType;
- (NSData *)getStringToDate:(NSString *)_indate;
- (NSString *)getAlarmFormat:(NSString *)_informat;

- (NSString *)getTimeString:(NSString *)format;
- (NSData *) getAlarmDate;

@end
