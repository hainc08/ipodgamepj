#import "DateView.h"
#import "DateFormat.h"
#import "AlarmConfig.h"
#import "ImgManager.h"

@implementation DateView


- (id)init
{
	[self CreatedImageView];
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
	
	[self.view addSubview:b_Dot];
	[self.view addSubview:u_Dot];

	[self.view addSubview:b_Week];
	[self.view addSubview:b_MonT];
	[self.view addSubview:b_MonM];
	[self.view addSubview:b_DayT];
	[self.view addSubview:b_DayM];
	
	[self.view addSubview:u_Week];
	[self.view addSubview:u_MonT];
	[self.view addSubview:u_MonM];
	[self.view addSubview:u_DayT];
	[self.view addSubview:u_DayM];

	[u_Dot setFrame:CGRectMake(110,-10,100,150)];
	[b_Dot setFrame:CGRectMake(110,-10,100,150)];
	
	[u_Week setFrame:CGRectMake(160,100,130,100)];
	[b_Week setFrame:CGRectMake(160,100,130,100)];

	[u_MonT setFrame:CGRectMake(-10,-10,100,150)];
	[u_MonM setFrame:CGRectMake(60,-10,100,150)];
	[u_DayT setFrame:CGRectMake(160,-10,100,150)];
	[u_DayM setFrame:CGRectMake(230,-10,100,150)];
	
	[b_MonT setFrame:CGRectMake(-10,-10,100,150)];
	[b_MonM setFrame:CGRectMake(60,-10,100,150)];
	[b_DayT setFrame:CGRectMake(160,-10,100,150)];
	[b_DayM setFrame:CGRectMake(230,-10,100,150)];
	
	[u_Dot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@Div.png", 
										 [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getUpImageType]]]];
	[b_Dot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@Div.png", 
										 [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getBgImageType]]]];
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
	if( [[AlarmConfig getInstance] getDateDisplay] )
	{
		[self.view setAlpha:1];
	
		if( [[AlarmConfig getInstance] getWeekDisplay] && ([[AlarmConfig getInstance] getWeekdayType] == 0))
		{
			[b_Week setAlpha:1];
			[u_Week setAlpha:1];
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
		}
		else 
		{
			[b_Week setAlpha:0];
			[u_Week setAlpha:0];
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
	else 
		[self.view setAlpha:0];
}
- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation {
	//return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	return NO;
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
