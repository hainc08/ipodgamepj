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
	Hour = Min = Sec = -1;
	
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
	
	[b_Dot setFrame:CGRectMake(85,-5,80,89)];
	[u_Dot setFrame:CGRectMake(85,-5,80,89)];
	

	[b_HourT setFrame:CGRectMake(-10,-5,80,89)];
	[b_HourM setFrame:CGRectMake(45,-5,80,89)];
	[b_MinT setFrame:CGRectMake(125,-5,80,89)];
	[b_MinM setFrame:CGRectMake(180,-5,80,89)];
	

	[u_HourT setFrame:CGRectMake(-10,-5,80,89)];
	[u_HourM setFrame:CGRectMake(45,-5,80,89)];
	[u_MinT setFrame:CGRectMake(125,-5,80,89)];
	[u_MinM setFrame:CGRectMake(180,-5,80,89)];

	[sb_Dot setFrame:CGRectMake(237,35,41,44)];
	[su_Dot setFrame:CGRectMake(237,35,41,44)];
	
	[b_SecT setFrame:CGRectMake(260,35,41,44)];
	[b_SecM setFrame:CGRectMake(285,35,41,44)];
	[u_SecT setFrame:CGRectMake(260,35,41,44)];
	[u_SecM setFrame:CGRectMake(285,35,41,44)];
	
	
	[u_Dot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@dot.png", 
										 [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getUpImageType]]]];
	[b_Dot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@dot.png", 
										 [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getBgImageType]]]];

	[su_Dot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@dot.png", 
										 [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getUpImageType]]]];
	[sb_Dot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@dot.png", 
										 [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getBgImageType]]]];
	
}


- (void)ChageNumberImage:(int)type  changeImage:(int)number
{
	if(type == HOUR_T)
	{
		[u_HourT setImage:[[ImgManager getInstance] getUp:number]];
		[b_HourT setImage:[[ImgManager getInstance] getDown:number]];
	}
	else if(type == HOUR_M)
	{
		[u_HourM setImage:[[ImgManager getInstance] getUp:number]];
		[b_HourM setImage:[[ImgManager getInstance] getDown:number]];
	}
	else if(type == MIN_T)
	{
		[u_MinT setImage:[[ImgManager getInstance] getUp:number]];
		[b_MinT setImage:[[ImgManager getInstance] getDown:number]];
	}
	else if(type == MIN_M)
	{
		[u_MinM setImage:[[ImgManager getInstance] getUp:number]];
		[b_MinM setImage:[[ImgManager getInstance] getDown:number]];
	}
	else if(type == SEC_T)
	{
		[u_SecT setImage:[[ImgManager getInstance] getUp:number]];
		[b_SecT setImage:[[ImgManager getInstance] getDown:number]];
	}
	else if(type == SEC_M)
	{
		[u_SecM setImage:[[ImgManager getInstance] getUp:number]];
		[b_SecM setImage:[[ImgManager getInstance] getDown:number]];
	}
	
}
- (void)UpdateTime
{	
	int tmpMin = [[[DateFormat getInstance] getMin] intValue];
	int tmpSec = [[[DateFormat getInstance] getSec] intValue];
	int tmpHour;
	if([[AlarmConfig getInstance] getHourMode])
		tmpHour = [[[DateFormat getInstance] getHour24] intValue];
	else
		tmpHour = [[[DateFormat getInstance] getHour] intValue];
	
	if( Hour != tmpHour )
	{
		Hour = tmpHour;
		[self ChageNumberImage:HOUR_T changeImage:Hour/10];
		[self ChageNumberImage:HOUR_M changeImage:Hour%10];
	}

	if( Min != tmpMin )
	{
		Min = tmpMin;
		[self ChageNumberImage:MIN_T changeImage:Min/10];
		[self ChageNumberImage:MIN_M changeImage:Min%10];
	}

	if( [[AlarmConfig getInstance] getSecondMode] )
	{
		[su_Dot setAlpha:1];
		[sb_Dot setAlpha:1];
		[b_SecT setAlpha:1];
		[u_SecT	setAlpha:1];
		
		[b_SecM	setAlpha:1];
		[u_SecM	setAlpha:1];
		
		if( Sec != tmpSec )
		{
			Sec = tmpSec;
			[self ChageNumberImage:SEC_T changeImage:Sec/10];
			[self ChageNumberImage:SEC_M changeImage:Sec%10];
		}
	}
	else {
		[su_Dot setAlpha:0];
		[sb_Dot setAlpha:0];
		[b_SecT setAlpha:0];
		[u_SecT	setAlpha:0];
		
		[b_SecM	setAlpha:0];
		[u_SecM	setAlpha:0];
	}


}
- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation {
	//return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	return NO;
}

- (void)dealloc {
	[super dealloc];	

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
