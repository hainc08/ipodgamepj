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

	//폰트에따라 글자 down이 up을 덮는 경우가 없도록
	//down먼저 add하고 up을 add하자.
	[self.view addSubview:b_HourT];
	[self.view addSubview:b_HourM];
	[self.view addSubview:b_MinT];
	[self.view addSubview:b_MinM];
	[self.view addSubview:b_Dot];
	
	[self.view addSubview:u_HourT];
	[self.view addSubview:u_HourM];
	[self.view addSubview:u_MinT];
	[self.view addSubview:u_MinM];
	[self.view addSubview:u_Dot];

	[b_Dot setFrame:CGRectMake(110,-10,100,150)];
	[u_Dot setFrame:CGRectMake(110,-10,100,150)];

	[b_HourT setFrame:CGRectMake(-10,-10,100,150)];
	[b_HourM setFrame:CGRectMake(60,-10,100,150)];
	[b_MinT setFrame:CGRectMake(160,-10,100,150)];
	[b_MinM setFrame:CGRectMake(230,-10,100,150)];

	[u_HourT setFrame:CGRectMake(-10,-10,100,150)];
	[u_HourM setFrame:CGRectMake(60,-10,100,150)];
	[u_MinT setFrame:CGRectMake(160,-10,100,150)];
	[u_MinM setFrame:CGRectMake(230,-10,100,150)];

	[u_Dot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@dot.png", 
										 [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getUpImageType]]]];
	[b_Dot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@dot.png", 
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
	
}
- (void)UpdateTime
{	

	
	NSString *tmpMin = [[DateFormat getInstance] getMin];
	
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
				[self ChageNumberImage:HOUR_T changeImage:0];
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
				[self ChageNumberImage:MIN_T changeImage:0];
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
}


@end
