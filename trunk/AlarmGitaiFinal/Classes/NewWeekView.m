#import "NewWeekView.h"
#import "AlarmConfig.h"
#import "DateFormat.h"

@implementation NewWeekView

- (void)dealloc {
	[super dealloc];	
}

- (void)reset
{
	for (int i=0; i<2; ++i)
	{
		weekImg[0][i] = [[UIImage imageNamed:[NSString stringWithFormat:@"sun_%d.png",i]] retain];
		weekImg[1][i] = [[UIImage imageNamed:[NSString stringWithFormat:@"mon_%d.png",i]] retain];
		weekImg[2][i] = [[UIImage imageNamed:[NSString stringWithFormat:@"tue_%d.png",i]] retain];
		weekImg[3][i] = [[UIImage imageNamed:[NSString stringWithFormat:@"wed_%d.png",i]] retain];
		weekImg[4][i] = [[UIImage imageNamed:[NSString stringWithFormat:@"the_%d.png",i]] retain];
		weekImg[5][i] = [[UIImage imageNamed:[NSString stringWithFormat:@"fri_%d.png",i]] retain];
		weekImg[6][i] = [[UIImage imageNamed:[NSString stringWithFormat:@"sat_%d.png",i]] retain];
	}

	Week == nil;

	if( [[AlarmConfig getInstance] getWeekDisplay] ) 
		[self.view setAlpha:1];
	else
		[self.view setAlpha:0];
}

- (void)refresh
{
	if( [[AlarmConfig getInstance] getWeekDisplay] && ([[AlarmConfig getInstance] getWeekdayType] == 1))
	{
		[self.view setAlpha:1];
		
		if((![Week isEqualToString:[[DateFormat getInstance] getWeek]]) || Week == nil)
		{
			if( Week != nil ) [Week release];
			Week = [[NSString alloc] initWithString:[[DateFormat getInstance] getWeek]];
			
			[imgSun setImage:weekImg[0][0]];
			[imgMon setImage:weekImg[1][0]];
			[imgTue setImage:weekImg[2][0]];
			[imgWed setImage:weekImg[3][0]];
			[imgThe setImage:weekImg[4][0]];
			[imgFri setImage:weekImg[5][0]];
			[imgSat setImage:weekImg[6][0]];
			
			if ([Week compare:@"Sun"] == NSOrderedSame)
			{
				[imgSun setImage:weekImg[0][1]];
				[self.view bringSubviewToFront:imgSun];
			}
			else if ([Week compare:@"Mon"] == NSOrderedSame)
			{
				[imgMon setImage:weekImg[1][1]];
				[self.view bringSubviewToFront:imgMon];
			}
			else if ([Week compare:@"Tue"] == NSOrderedSame)
			{
				[imgTue setImage:weekImg[2][1]];
				[self.view bringSubviewToFront:imgTue];
			}
			else if ([Week compare:@"Wed"] == NSOrderedSame)
			{
				[imgWed setImage:weekImg[3][1]];
				[self.view bringSubviewToFront:imgWed];
			}
			else if ([Week compare:@"Thu"] == NSOrderedSame)
			{
				[imgThe setImage:weekImg[4][1]];
				[self.view bringSubviewToFront:imgThe];
			}
			else if ([Week compare:@"Fri"] == NSOrderedSame)
			{
				[imgFri setImage:weekImg[5][1]];
				[self.view bringSubviewToFront:imgFri];
			}
			else if ([Week compare:@"Sat"] == NSOrderedSame)
			{
				[imgSat setImage:weekImg[6][1]];
				[self.view bringSubviewToFront:imgSat];
			}
		}
	}
	else
	{
		[self.view setAlpha:0];
	}
}

@end
