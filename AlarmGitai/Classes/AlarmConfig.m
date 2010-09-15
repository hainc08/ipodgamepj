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
	
	for(int loop = 0; loop < 4; loop ++)
	{
		heigthviewpoint[loop] = [ViewCgPoint alloc];
		widthviewpoint[loop] = [ViewCgPoint alloc];
	}
	[heigthviewpoint[0] setClockTrans:CGAffineTransformMake(0.5, 0.0, 0.0, 0.5, 0.0, 0.0)];
	[heigthviewpoint[0] setClockPoint:CGPointMake(65,410)];
	[heigthviewpoint[0] setDateTrans:CGAffineTransformMake(0.3, 0.0, 0.0, 0.3, 0.0, 0.0)];
	[heigthviewpoint[0] setDatePoint:CGPointMake(35,50)];

	
	[heigthviewpoint[1] setClockTrans:CGAffineTransformMake(0.3, 0.0, 0.0, 0.3, 0.0, 0.0)];
	[heigthviewpoint[1] setClockPoint:CGPointMake(40,450)];
	[heigthviewpoint[1] setDateTrans:CGAffineTransformMake(0.16, 0.0, 0.0, 0.16, 0.0, 0.0)];
	[heigthviewpoint[1] setDatePoint:CGPointMake(33,370)];
	
	[heigthviewpoint[2] setClockTrans:CGAffineTransformMake(0.3, 0.0, 0.0, 0.3, 0.0, 0.0)];
	[heigthviewpoint[2] setClockPoint:CGPointMake(35,130)];	
	[heigthviewpoint[2] setDateTrans:CGAffineTransformMake(0.25, 0.0, 0.0, 0.25, 0.0, 0.0)];
	[heigthviewpoint[2] setDatePoint:CGPointMake(45,200)];

	[heigthviewpoint[3] setClockTrans:CGAffineTransformMake(0.5, 0.0, 0.0, 0.5, 0.0, 0.0)];
	[heigthviewpoint[3] setClockPoint:CGPointMake(65,410)];	
	[heigthviewpoint[3] setDateTrans:CGAffineTransformMake(0.3, 0.0, 0.0, 0.3, 0.0, 0.0)];
	[heigthviewpoint[3] setDatePoint:CGPointMake(35,50)];
	
	
	
	
	[widthviewpoint[0] setClockTrans:CGAffineTransformMake(0.5, 0.0, 0.0, 0.5, 0.0, 0.0)];
	[widthviewpoint[0] setClockPoint:CGPointMake(65,410)];
	[widthviewpoint[0] setDateTrans:CGAffineTransformMake(0.3, 0.0, 0.0, 0.3, 0.0, 0.0)];
	[widthviewpoint[0] setDatePoint:CGPointMake(35,50)];
	
	
	[widthviewpoint[1] setClockTrans:CGAffineTransformMake(0.3, 0.0, 0.0, 0.3, 0.0, 0.0)];
	[widthviewpoint[1] setClockPoint:CGPointMake(40,450)];
	[widthviewpoint[1] setDateTrans:CGAffineTransformMake(0.16, 0.0, 0.0, 0.16, 0.0, 0.0)];
	[widthviewpoint[1] setDatePoint:CGPointMake(33,370)];
	
	[widthviewpoint[2] setClockTrans:CGAffineTransformMake(0.3, 0.0, 0.0, 0.3, 0.0, 0.0)];
	[widthviewpoint[2] setClockPoint:CGPointMake(35,130)];	
	[widthviewpoint[2] setDateTrans:CGAffineTransformMake(0.25, 0.0, 0.0, 0.25, 0.0, 0.0)];
	[widthviewpoint[2] setDatePoint:CGPointMake(45,200)];
	
	[widthviewpoint[3] setClockTrans:CGAffineTransformMake(0.5, 0.0, 0.0, 0.5, 0.0, 0.0)];
	[widthviewpoint[3] setClockPoint:CGPointMake(65,410)];	
	[widthviewpoint[3] setDateTrans:CGAffineTransformMake(0.3, 0.0, 0.0, 0.3, 0.0, 0.0)];
	[widthviewpoint[3] setDatePoint:CGPointMake(35,50)];
	
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
	return heigthviewpoint[heightnum];
}

- (ViewCgPoint *) getWidthViewPoint
{
	return widthviewpoint[widthnum];
}

- (void) setRotationTime:(int)value
{
	RotationTime = value;
}
- (int) getRotationTime
{
	return RotationTime;
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

