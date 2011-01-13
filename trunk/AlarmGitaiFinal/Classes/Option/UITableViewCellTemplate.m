//
//  UITableViewCellTemplate.m
//  iNorebangBook
//
//  Created by kueec on 10. 3. 7..
//  Copyright 2010 집. All rights reserved.
//

#import "UITableViewCellTemplate.h"


@implementation UITableViewSwitchCell

@synthesize switcher;

- (void)setInfo:(NSString*)name :(bool)isOn
{
	[nameLabel setText:name];
	[switcher setOn:isOn];
}

@end

@implementation UITableViewAlarmCell

-(void)setInfo:(NSString*)tStr :(int)repeatIdx :(bool)isOn
{
	if (isOn)
	{
		[onOff setTextColor:[UIColor blackColor]];
		[alarmTime setTextColor:[UIColor blackColor]];
		[alarmRepeat setTextColor:[UIColor blackColor]];
		[onOff setText:@"On"];
	}
	else
	{
		[onOff setTextColor:[UIColor grayColor]];
		[alarmTime setTextColor:[UIColor grayColor]];
		[alarmRepeat setTextColor:[UIColor grayColor]];
		[onOff setText:@"Off"];
	}

	//아오 프로그래밍을 이따위로 하면 안되는데...
	//귀찮아...[ㅡ_ㅡ ]
	NSString* value;
	char temp[256];

	if (repeatIdx == 0) value = @"Never Repeat";
	else if (repeatIdx == 1) value = @"Everyday";
	else
	{
		int idx = repeatIdx - 2;

		temp[0] = 0x00;

		if (idx & 0x01)
		{
			strcat(temp, "Sun");
		}
		if (idx & 0x02)
		{
			if (temp[0] != 0x00) strcat(temp, ",");
			strcat(temp, "Mon");
		}
		if (idx & 0x04)
		{
			if (temp[0] != 0x00) strcat(temp, ",");
			strcat(temp, "Tue");
		}
		if (idx & 0x08)
		{
			if (temp[0] != 0x00) strcat(temp, ",");
			strcat(temp, "Wed");
		}
		if (idx & 0x10)
		{
			if (temp[0] != 0x00) strcat(temp, ",");
			strcat(temp, "Thu");
		}
		if (idx & 0x20)
		{
			if (temp[0] != 0x00) strcat(temp, ",");
			strcat(temp, "Fri");
		}
		if (idx & 0x40)
		{
			if (temp[0] != 0x00) strcat(temp, ",");
			strcat(temp, "Sat");
		}
		
		value = [NSString stringWithFormat:@"%s", temp];
	}
	
	[alarmTime setText:tStr];
	[alarmRepeat setText:value];
}

@end

@implementation UITableViewButtonCell

- (void)setInfo:(NSString*)name :(NSString*)value
{
	[nameLabel setText:name];
	[valueLabel setText:value];
}

- (void)showArrow:(bool)show
{
	if (show) [arrow setAlpha:1];
	else [arrow setAlpha:0];
}

@end

@implementation UITableViewSelectCell

- (void)setInfo:(NSString*)name
{
	[nameLabel setText:name];
}

- (void)showSelect:(bool)show
{
	if (show) [select setAlpha:1];
	else [select setAlpha:0];
}

@end
