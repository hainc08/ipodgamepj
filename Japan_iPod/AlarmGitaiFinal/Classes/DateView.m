#import "DateView.h"
#import "DateFormat.h"
#import "AlarmConfig.h"
#import "ImgManager.h"

@implementation DateView


- (id)init
{
	Mon = Day = -1;
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

	[self.view addSubview:b_Week];
	[self.view addSubview:b_MonT];
	[self.view addSubview:b_MonM];
	[self.view addSubview:b_DayT];
	[self.view addSubview:b_DayM];
	
	[self.view addSubview:u_Dot];

	[self.view addSubview:u_Week];
	[self.view addSubview:u_MonT];
	[self.view addSubview:u_MonM];
	[self.view addSubview:u_DayT];
	[self.view addSubview:u_DayM];

	[u_Dot setFrame:CGRectMake(95,-5,82,89)];
	[b_Dot setFrame:CGRectMake(95,-5,82,89)];
	
	[u_Week setFrame:CGRectMake(100,60,164,89)];
	[b_Week setFrame:CGRectMake(100,60,164,89)];

	[u_MonT setFrame:CGRectMake(-10,-5,82,89)];
	[u_MonM setFrame:CGRectMake(50,-5,82,89)];
	[u_DayT setFrame:CGRectMake(140,-5,82,89)];
	[u_DayM setFrame:CGRectMake(200,-5,82,89)];
	
	[b_MonT setFrame:CGRectMake(-10,-5,82,89)];
	[b_MonM setFrame:CGRectMake(50,-5,82,89)];
	[b_DayT setFrame:CGRectMake(140,-5,82,89)];
	[b_DayM setFrame:CGRectMake(200,-5,82,89)];
	
	[u_Dot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@Div.png", 
										 [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getUpImageType]]]];
	[b_Dot setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_%@Div.png", 
										 [[AlarmConfig getInstance] getFontType], [[AlarmConfig getInstance] getBgImageType]]]];
}

- (void)ChageNumberImage:(int)type changeImage:(int)number
{

	if(type == MON_T)
	{
		[u_MonT setImage:[[ImgManager getInstance] getUp:number]];
		[b_MonT setImage:[[ImgManager getInstance] getDown:number]];
	}
	else if(type == MON_M)
	{
		[u_MonM setImage:[[ImgManager getInstance] getUp:number]];
		[b_MonM setImage:[[ImgManager getInstance] getDown:number]];
	}
	else if(type == DAY_T)
	{
		[u_DayT setImage:[[ImgManager getInstance] getUp:number]];
		[b_DayT setImage:[[ImgManager getInstance] getDown:number]];
	}
	else if(type == DAY_M)
	{
		[u_DayM setImage:[[ImgManager getInstance] getUp:number]];
		[b_DayM setImage:[[ImgManager getInstance] getDown:number]];
	}
}
- (void)UpdateDate
{
	if( [[AlarmConfig getInstance] getDateDisplay] == false )
	{
		[self.view setAlpha:0];
		return;
	}

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
	
	int tmpMon = [[[DateFormat getInstance] getIMon] intValue];
	int tmpDay = [[[DateFormat getInstance] getDay] intValue];
	
	if( Mon != tmpMon )
	{
		Mon = tmpMon;

		[self ChageNumberImage:MON_T changeImage:Mon/10];
		[self ChageNumberImage:MON_M changeImage:Mon%10];
	}	

	if( Day != tmpDay )
	{
		Day = tmpDay;
		[self ChageNumberImage:DAY_T changeImage:Day/10];
		[self ChageNumberImage:DAY_M changeImage:Day%10];
	}		
}

- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation {
	//return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	return NO;
}
- (void)dealloc {
	[super dealloc];	
	[Week release];
	
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
