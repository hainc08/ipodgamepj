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
	[[SaveManager getInstance] setIntData:@"RotationTime" idx:0 value:RotationTime];
	[[SaveManager getInstance] setIntData:@"heigthnum" idx:0 value:heightnum];
	[[SaveManager getInstance] setIntData:@"widthnum" idx:0 value:widthnum];
	[[SaveManager getInstance] setIntData:@"FontType" idx:0 value:FontType];
	[[SaveManager getInstance] setStringData:@"FontType" idx:1 value:FontUpImageType];
	[[SaveManager getInstance] setStringData:@"FontType" idx:2 value:FontBgImageType];
	
	[[SaveManager getInstance] saveFile];
}
- (void)defaultConfig
{
	/* file save 도 같이 하자 */
	[[SaveManager getInstance] setIntData:@"RotationTime" idx:0 value:5];
	[[SaveManager getInstance] setIntData:@"heigthnum" idx:0 value:0];
	[[SaveManager getInstance] setIntData:@"widthnum" idx:0 value:0];
	[[SaveManager getInstance] setIntData:@"FontType" idx:0 value:0];
	[[SaveManager getInstance] setStringData:@"FontType" idx:1 value:@"ub"];
	[[SaveManager getInstance] setStringData:@"FontType" idx:2 value:@"dw"];
	
	[[SaveManager getInstance] saveFile];
	

}

- (void)loadConfig
{
	CharName = @"natsuko";
	fontArr = [[NSArray alloc] initWithObjects:@"굴림", @"TEST", nil];
	
	RotationTime = [[SaveManager getInstance] getIntData:@"RotationTime" idx:0 base:5];
	
	heightnum = [[SaveManager getInstance] getIntData:@"heigthnum" idx:0 base:0];
	widthnum =  [[SaveManager getInstance] getIntData:@"widthnum" idx:0 base:0];
	
	FontType =		  [[SaveManager getInstance] getIntData:@"FontType" idx:0 base:0];
	FontUpImageType = [[SaveManager getInstance] getStringData:@"FontType" idx:1 base:@"ub"];
	FontBgImageType = [[SaveManager getInstance] getStringData:@"FontType" idx:2 base:@"dw"];
	
	heigthviewpoint = [ViewCgPoint alloc];
	widthviewpoint = [ViewCgPoint alloc];

	[heigthviewpoint setClockTrans:CGAffineTransformMake(0.5, 0.0, 0.0, 0.5, 0.0, 0.0)];
	[heigthviewpoint setClockPoint:CGPointMake(65,410)];
	[heigthviewpoint setDateTrans:CGAffineTransformMake(0.2, 0.0, 0.0, 0.2, 0.0, 0.0)];
	[heigthviewpoint setDatePoint:CGPointMake(35,50)];

	
	[widthviewpoint setClockTrans:CGAffineTransformMake(0.5, 0.0, 0.0, 0.5, 0.0, 0.0)];
	[widthviewpoint setClockPoint:CGPointMake(65,230)];
	[widthviewpoint setDateTrans:CGAffineTransformMake(0.3, 0.0, 0.0, 0.3, 0.0, 0.0)];
	[widthviewpoint setDatePoint:CGPointMake(35,50)];	
}
- (int )getFontType
{
	return  FontType;
}
- (NSArray *)getFontArr
{
	return fontArr;
}
- (NSString *)getCurrFontName
{
	return [fontArr objectAtIndex:FontType] ;
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
}

- (void) setWidthViewPoint:(ViewCgPoint *) _inPoint
{
	[widthviewpoint setClockTrans:_inPoint.ClockTrans]; 
	[widthviewpoint setClockPoint:_inPoint.ClockPoint];
	[widthviewpoint setDateTrans:_inPoint.DateTrans];
	[widthviewpoint setDatePoint:_inPoint.DatePoint];	
}
- (void) setRotationTime:(int)value
{
	RotationTime = value;
}
- (int) getRotationTime
{
	return RotationTime;
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

