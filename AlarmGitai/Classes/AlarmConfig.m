//
//  AlarmConfig.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AlarmConfig.h"

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

- (void)loadConfig
{
	
	fontArr = [[NSArray alloc] initWithObjects:@"굴림",
                      @"TEST", nil];
	heightnum = 2;
	widthnum = 2;
	CharName = @"natsuko";
	
	FontType = 1;
	FontUpImageType = [[NSString alloc] initWithString:@"ub"];
	FontBgImageType = [[NSString alloc] initWithString:@"dw"];
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

- (ViewCgPoint *) getHeigthViewPoint
{
	return heigthviewpoint[heightnum];
}

- (ViewCgPoint *) getWidthViewPoint
{
	return widthviewpoint[widthnum];
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

