#import "OptionPreview.h"
#import "AlarmConfig.h"
@implementation OptionPreview

- (id)init
{
	return self;
}

- (void)SetHV:(bool)horizon
{
	isHorizon = horizon;
	if (horizon)
	{
		[self.view setFrame:CGRectMake(0, 0, 270, 180)];
		[back_h setAlpha:1];
		[back_v setAlpha:0];
		[timeView_12 setCenter:CGPointMake(180, 130)];
		[timeView_24 setCenter:CGPointMake(180, 130)];
		[charView setTransform:CGAffineTransformMake(0.7, 0, 0, 0.7, 0, 0)];
		[charView setCenter:CGPointMake(135, 90)];
	}
	else
	{
		[self.view setFrame:CGRectMake(0, 0, 180, 270)];
		[back_h setAlpha:0];
		[back_v setAlpha:1];
		[timeView_12 setCenter:CGPointMake(90, 230)];
		[timeView_24 setCenter:CGPointMake(90, 230)];
		[charView setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, 0)];
		[charView setCenter:CGPointMake(90, 135)];
	}
}

- (void)refresh
{
	if([[AlarmConfig getInstance] getHourMode])
	{
		[timeView_12 setAlpha:0];
		[timeView_24 setAlpha:1];
	}
	else
	{
		[timeView_12 setAlpha:1];
		[timeView_24 setAlpha:0];
	}
	
	if ([[AlarmConfig getInstance] getDateDisplay])
	{
		[dateView setAlpha:1];
		if([[AlarmConfig getInstance] getWeekDisplay])
		{
			[weekView setAlpha:1];
		}
		else
		{
			[weekView setAlpha:0];
		}
	}
	else
	{
		[dateView setAlpha:0];
		[weekView setAlpha:0];
	}
}

- (void)dealloc {
	[super dealloc];	
}

@end
