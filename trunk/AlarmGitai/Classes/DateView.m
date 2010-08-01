//
//  DateView.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DateView.h"
#import "DateFormat.h"
#import "AlarmConfig.h"
#import "ImgManager.h"

@implementation DateView


- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	[self CreatedImageView];
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	return self;
}


- (void)CreatedImageView 
{
	b_Week = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,240, 360)];
	u_Week = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 0,240, 360)];
	b_MonT = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,240, 360)];
	u_MonT = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 0,240, 360)];
	u_MonM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,240, 360)];
	b_MonM = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 0,240, 360)];
	u_DayT = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,240, 360)];
	b_DayT = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,240, 360)];
	u_DayM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,240, 360)];
	b_DayM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,240, 360)];
	u_Dot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,240, 360)];
	b_Dot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,240, 360)];
	
	[u_Dot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@Div.png", 
										 [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getUpImageType]]]];
	[b_Dot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@Div.png", 
										 [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getBgImageType]]]];
	
	[self addSubview:b_Dot];
	[self addSubview:u_Dot];

	
	[self addSubview:b_Week];
	[self addSubview:b_MonT];
	[self addSubview:b_MonM];
	[self addSubview:b_DayT];
	[self addSubview:b_DayM];
	
	
	
	[self addSubview:u_Week];
	[self addSubview:u_MonT];
	[self addSubview:u_MonM];
	[self addSubview:u_DayT];
	[self addSubview:u_DayM];

	[u_Dot setFrame:CGRectMake(220,23,240, 360)];
	[b_Dot setFrame:CGRectMake(220,23,240, 360)];
	
	[u_Week setFrame:CGRectMake(220,180,240, 360)];
	[b_Week setFrame:CGRectMake(220,180,240, 360)];
	

	[u_MonT setFrame:CGRectMake(25,0,240, 360)];
	[u_MonM setFrame:CGRectMake(140,0,240, 360)];
	[u_DayT setFrame:CGRectMake(300,0,240, 360)];
	[u_DayM setFrame:CGRectMake(415,0,240, 360)];
	
	[b_MonT setFrame:CGRectMake(25,0,240, 360)];
	[b_MonM setFrame:CGRectMake(140,0,240, 360)];
	[b_DayT setFrame:CGRectMake(310,0,240, 360)];
	[b_DayM setFrame:CGRectMake(425,0,240, 360)];

}


- (void)ChageNumberImage:(int)type changeImage:(char)number
{

	if(type == MON_T)
	{
		[u_MonT setImage:[[ImgManager getInstance] getUp:(int)number-0x30]];
		[b_MonT setImage:[[ImgManager getInstance] getDown:(int)number-0x30]];
	}
	else if(type == MON_M)
	{
		[u_MonM setImage:[[ImgManager getInstance] getUp:(int)number-0x30]];
		[b_MonM setImage:[[ImgManager getInstance] getDown:(int)number-0x30]];
	}
	else if(type == DAY_T)
	{
		[u_DayT setImage:[[ImgManager getInstance] getUp:(int)number-0x30]];
		[b_DayT setImage:[[ImgManager getInstance] getDown:(int)number-0x30]];
	}
	else if(type == DAY_M)
	{
		[u_DayM setImage:[[ImgManager getInstance] getUp:(int)number-0x30]];
		[b_DayM setImage:[[ImgManager getInstance] getDown:(int)number-0x30]];
	}
}
- (void)UpdateDate
{
	if((![Week isEqualToString:[[DateFormat getInstance] getWeek]]) || Week == nil)
	{
	
		if( Week != nil )
			[Week release];
		Week = [[NSString alloc] initWithFormat:@"%@", [[DateFormat getInstance] getWeek]];

		[u_Week setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@%@.png", 
											  [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getUpImageType], Week]]];
		[b_Week setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@%@.png", 
											  [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getBgImageType], Week]]];
		
	}
	
	
	NSString *tmpMon = [[DateFormat getInstance] getIMon];
	NSString *tmpDay = [[DateFormat getInstance] getDay];
	
	if((![Mon isEqualToString:tmpMon]) || Day == nil)
	{
		if([tmpMon length] < 2)
		{
			if([Mon	length] > 1)
			{
				[self ChageNumberImage:MON_T changeImage:0];
			}
			
			[self ChageNumberImage:MON_M changeImage:[tmpMon characterAtIndex:0]];
		}
		else
		{
			[self ChageNumberImage:MON_T changeImage:[tmpMon characterAtIndex:0]];
			[self ChageNumberImage:MON_M changeImage:[tmpMon characterAtIndex:1]];
		}
		if( Mon != nil )
			[Mon release];
		
		Mon = [[NSString alloc] initWithFormat:@"%@", tmpMon];
	}	
	

	if((![Day isEqualToString:tmpDay]) || Day == nil)
	{
		if([tmpDay length] < 2)
		{
			if([Day	length] > 1)
			{
				[self ChageNumberImage:DAY_T changeImage:0];
			}
			
			[self ChageNumberImage:DAY_M changeImage:[tmpDay characterAtIndex:0]];
		}
		else
		{
			[self ChageNumberImage:DAY_T changeImage:[tmpDay characterAtIndex:0]];
			[self ChageNumberImage:DAY_M changeImage:[tmpDay characterAtIndex:1]];
		}
		if( Day != nil )
			[Day release];
		
		Day = [[NSString alloc] initWithFormat:@"%@", tmpDay];
	}		
}

- (void)dealloc {
	[super dealloc];	
	[Week release];
	[Mon release];
	[Day release];
	
	[u_Week release];
	[u_DayT	release];
	[u_DayM	 release];
	[u_MonT	release];
	[u_MonM	release];
	[u_Dot	release];
	
	[b_Week release];
	[b_DayT	release];
	[b_DayM	 release];
	[b_MonT	release];
	[b_MonM	release];
	[b_Dot	release];
}

@end
