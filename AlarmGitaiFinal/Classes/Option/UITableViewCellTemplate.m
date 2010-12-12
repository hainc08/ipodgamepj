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

-(void)setInfo:(NSString*)tStr :(NSString*)rStr :(bool)isOn
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

	[alarmTime setText:tStr];
	[alarmRepeat setText:rStr];
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