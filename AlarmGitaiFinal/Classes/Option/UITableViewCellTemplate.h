//
//  UITableViewCellTemplate.h
//  iNorebangBook
//
//  Created by kueec on 10. 3. 7..
//  Copyright 2010 집. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewSwitchCell : UITableViewCell
{
	IBOutlet UISwitch* switcher;
	IBOutlet UILabel* nameLabel;
}

@property (nonatomic, retain) UISwitch* switcher;

- (void)setInfo:(NSString*)name :(bool)isOn;

@end

@interface UITableViewAlarmCell : UITableViewCell
{
	IBOutlet UILabel* onOff;
	IBOutlet UILabel* alarmTime;
	IBOutlet UILabel* alarmRepeat;
}

-(void)setInfo:(NSString*)tStr :(NSString*)rStr :(bool)isOn;

@end


@interface UITableViewButtonCell : UITableViewCell
{
	IBOutlet UILabel* nameLabel;
	IBOutlet UILabel* valueLabel;
}

- (void)setInfo:(NSString*)name :(NSString*)value;

@end
