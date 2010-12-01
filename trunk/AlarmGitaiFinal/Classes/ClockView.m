//
//  ClockView.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ClockView.h"
#import "DateFormat.h"
#import "AlarmConfig.h"
#import "ImgManager.h"
@implementation ClockView


- (id)init
{
	[self CreatedImageView];
	return self;
}

- (void)CreatedImageView 
{
	u_HourT = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,0, 0)];
	b_HourT = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,0, 0)];
	u_HourM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,0, 0)];
	b_HourM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,0, 0)];
	u_MinT = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,0, 0)];
	b_MinT = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,0, 0)];
	u_MinM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,0, 0)];
	b_MinM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,0, 0)];
	u_Dot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,0, 0)];
	b_Dot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,0, 0)];

	/*sec*/
	su_Dot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,0, 0)];
	sb_Dot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,0, 0)];
	u_SecM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,0, 0)];
	b_SecM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,0, 0)];
	u_SecT = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,0, 0)];
	b_SecT = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,0, 0)];

	
	//폰트에따라 글자 down이 up을 덮는 경우가 없도록
	//down먼저 add하고 up을 add하자.
	[self.view addSubview:b_HourT];
	[self.view addSubview:b_HourM];
	[self.view addSubview:b_MinT];
	[self.view addSubview:b_MinM];
	[self.view addSubview:b_Dot];
	
	[self.view addSubview:sb_Dot];
	[self.view addSubview:b_SecT];
	[self.view addSubview:b_SecM];
	
	
	[self.view addSubview:u_HourT];
	[self.view addSubview:u_HourM];
	[self.view addSubview:u_MinT];
	[self.view addSubview:u_MinM];
	[self.view addSubview:u_Dot];
	
	[self.view addSubview:su_Dot];
	[self.view addSubview:u_SecT];
	[self.view addSubview:u_SecM];
	
	[b_Dot setFrame:CGRectMake(110,-20,100,150)];
	[u_Dot setFrame:CGRectMake(110,-20,100,150)];

	[b_HourT setFrame:CGRectMake(-10,-20,100,150)];
	[b_HourM setFrame:CGRectMake(60,-20,100,150)];
	[b_MinT setFrame:CGRectMake(160,-20,100,150)];
	[b_MinM setFrame:CGRectMake(230,-20,100,150)];
	


	[u_HourT setFrame:CGRectMake(-10,-20,100,150)];
	[u_HourM setFrame:CGRectMake(60,-20,100,150)];
	[u_MinT setFrame:CGRectMake(160,-20,100,150)];
	[u_MinM setFrame:CGRectMake(230,-20,100,150)];

	[sb_Dot setFrame:CGRectMake(270,10,100,150)];
	[su_Dot setFrame:CGRectMake(270,10,100,150)];
	
	[b_SecT setFrame:CGRectMake(290,10,100,150)];
	[b_SecM setFrame:CGRectMake(310,10,100,150)];
	[u_SecT setFrame:CGRectMake(290,10,100,150)];
	[u_SecM setFrame:CGRectMake(310,10,100,150)];
	
	[sb_Dot setTransform:CGAffineTransformMake(0.3, 0.0, 0.0,0.3, 0.0, 0.0)];
	[su_Dot setTransform:CGAffineTransformMake(0.3, 0.0, 0.0,0.3, 0.0, 0.0)];
	[b_SecT setTransform:CGAffineTransformMake(0.3, 0.0, 0.0,0.3, 0.0, 0.0)];
	[b_SecM setTransform:CGAffineTransformMake(0.3, 0.0, 0.0,0.3, 0.0, 0.0)];
	[u_SecT setTransform:CGAffineTransformMake(0.3, 0.0, 0.0,0.3, 0.0, 0.0)];
	[u_SecM setTransform:CGAffineTransformMake(0.3, 0.0, 0.0,0.3, 0.0, 0.0)];
	
	[u_Dot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@dot.png", 
										 [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getUpImageType]]]];
	[b_Dot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@dot.png", 
										 [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getBgImageType]]]];

	[su_Dot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@dot.png", 
										 [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getUpImageType]]]];
	[sb_Dot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@dot.png", 
										 [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getBgImageType]]]];
	
}


- (void)ChageNumberImage:(int)type  changeImage:(char)number
{
	if(type == HOUR_T)
	{
		[u_HourT setImage:[[ImgManager getInstance] getUp:(int)number - 0x30]];
		[b_HourT setImage:[[ImgManager getInstance] getDown:(int)number - 0x30]];
	}
	else if(type == HOUR_M)
	{
		[u_HourM setImage:[[ImgManager getInstance] getUp:(int)number - 0x30]];
		[b_HourM setImage:[[ImgManager getInstance] getDown:(int)number - 0x30]];
	}
	else if(type == MIN_T)
	{
		[u_MinT setImage:[[ImgManager getInstance] getUp:(int)number - 0x30]];
		[b_MinT setImage:[[ImgManager getInstance] getDown:(int)number - 0x30]];
	}
	else if(type == MIN_M)
	{
		[u_MinM setImage:[[ImgManager getInstance] getUp:(int)number - 0x30]];
		[b_MinM setImage:[[ImgManager getInstance] getDown:(int)number - 0x30]];
	}
	else if(type == SEC_T)
	{
		[u_SecT setImage:[[ImgManager getInstance] getUp:(int)(number - 0x30)]];
		[b_SecT setImage:[[ImgManager getInstance] getDown:(int)(number - 0x30)]];
	}
	else if(type == SEC_M)
	{
		[u_SecM setImage:[[ImgManager getInstance] getUp:(int)(number - 0x30)]];
		[b_SecM setImage:[[ImgManager getInstance] getDown:(int)(number - 0x30)]];
	}
	
}
- (void)UpdateTime
{	
	NSString *tmpMin = [[DateFormat getInstance] getMin];
	NSString *tmpSec = [[DateFormat getInstance] getSec];
	NSString *tmpHour;
	if([[AlarmConfig getInstance] getHourMode])
		tmpHour = [[DateFormat getInstance] getHour24];
	else
		tmpHour = [[DateFormat getInstance] getHour];
	
	if( ![Hour isEqualToString:tmpHour] || Hour == nil)
	{
		if([tmpHour length] < 2)
		{		
			if([Hour length] > 1)
			{
				[self ChageNumberImage:HOUR_T changeImage:'0'];
			}
			[self ChageNumberImage:HOUR_M changeImage:[tmpHour characterAtIndex:0]];
		}
		else
		{
			[self ChageNumberImage:HOUR_T changeImage:[tmpHour characterAtIndex:0]];
			[self ChageNumberImage:HOUR_M changeImage:[tmpHour characterAtIndex:1]];
		
		}

		if( Hour != nil )
			[Hour release];
		
		Hour = [[NSString alloc] initWithFormat:@"%@", tmpHour];
	}

	if((![Min isEqualToString:tmpMin]) || Min == nil)
	{
		if([tmpMin length] < 2)
		{
			if([Min	length] > 1)
			{
				[self ChageNumberImage:MIN_T changeImage:'0'];
			}
			
			[self ChageNumberImage:MIN_M changeImage:[tmpMin characterAtIndex:0]];
		}
		else
		{
			[self ChageNumberImage:MIN_T changeImage:[tmpMin characterAtIndex:0]];
			[self ChageNumberImage:MIN_M changeImage:[tmpMin characterAtIndex:1]];
		}

		if( Min != nil )
			[Min release];
		Min = [[NSString alloc] initWithFormat:@"%@",tmpMin];
	}
	
	if((![Sec isEqualToString:tmpSec]) || Sec == nil)
	{
		if([tmpSec length] < 2)
		{
			if([Sec	length] > 1)
			{
				[self ChageNumberImage:SEC_T changeImage:'0'];
			}
			
			[self ChageNumberImage:SEC_M changeImage:[tmpSec characterAtIndex:0]];
		}
		else
		{
			[self ChageNumberImage:SEC_T changeImage:[tmpSec characterAtIndex:0]];
			[self ChageNumberImage:SEC_M changeImage:[tmpSec characterAtIndex:1]];
		}
		
		if( Sec != nil )
			[Sec release];
		Sec = [[NSString alloc] initWithFormat:@"%@",tmpSec];
	}

}


- (void)dealloc {
	[super dealloc];	
	
	[Hour release];
	[Min release];
	[Sec release];;
	
	[u_HourT release];
	[u_HourM release];
	[u_MinT release];
	[u_MinM release]; 
	[u_Dot release];
	
	[b_HourT release];
	[b_HourM release];
	[b_MinT release];
	[b_MinM release];
	[b_Dot release];
	
	[su_Dot release];
	[u_SecM release];
	[u_SecT	release];
	[b_SecM release];
	[b_SecT	release];
}


@end
