#import "SceneView.h"
#import "DateFormat.h"
#import "AlarmConfig.h"

@implementation SceneView

- (void)setBackGround:(int)idx isNight:(bool)isNight
{
	NSString *timeStr;
	if (isNight)
	{
		//back_2_n.png, back_5_n.png, back_7_n.png가 없다.
		if ((idx == 2)||(idx == 5)||(idx == 7))
		{
			++idx;
		}
	
		timeStr = @"n";
	}
	else timeStr = @"d";

	[backView[curBackIdx] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"back_%d_%@.png", idx, timeStr]]];
}

- (void)reset
{
	for (int i=0; i<2; ++i)
	{
		charView[i] = [[CharView alloc] init];
		[charView[i].view setTransform:CGAffineTransformMake(1, 0, 0, -1, 0, 0)];
		[self.view addSubview:charView[i].view];
		[charView[i].view setCenter:CGPointMake(160,240)];
	}
	
	backView[0] = imgBack1;
	backView[1] = imgBack2;

	curBackIdx = curCharIdx = 1;
	nextCount = 0;
}

- (void)next
{
	bool isNight = [[DateFormat getInstance] getNight];
	
	NSString* charName = [AlarmConfig getInstance].CharName;

	if ((nextCount % 12) == 0)
	{
		int oldBackIdx = curBackIdx;
		if (curBackIdx == 0) curBackIdx = 1;
		else curBackIdx = 0;
		
		[self setBackGround:rand()%16 isNight:isNight];

		[UIView beginAnimations:@"anime1" context:NULL];
		[UIView setAnimationDuration:1];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		[backView[curBackIdx] setAlpha:1];
		[backView[oldBackIdx] setAlpha:0];
		[UIView commitAnimations];

		nextCount = 0;
	}
	
	int oldCharIdx = curCharIdx;
	if (curCharIdx == 0) curCharIdx = 1;
	else curCharIdx = 0;

	static int lastIdx = 0;
	int idx;
	int all, officeOffset, offset;

	//fumiko, akari, natsuko 는 해줄게 없음...
	if ([charName compare:@"haruka"] == NSOrderedSame)
	{
		all = 10 * 10;
		officeOffset = 6 * 10;
		offset = 2 * 10;
	}
	else if ([charName compare:@"irika"] == NSOrderedSame)
	{
		all = 8 * 6;
		officeOffset = 4 * 6;
		offset = 2 * 6;
	}
	else if ([charName compare:@"reina"] == NSOrderedSame)
	{
		all = 12 * 8;
		officeOffset = 8 * 8;
		offset = 4 * 8;
	}
	else if ([charName compare:@"hitomi"] == NSOrderedSame)
	{
		all = 12 * 14;
		officeOffset = 6 * 14;
		offset = 4 * 14;
	}
	else if ([charName compare:@"akari"] == NSOrderedSame)
	{
		all = 15 * 9;
		officeOffset = 8 * 9;
		offset = 4 * 9;
	}
	else if ([charName compare:@"fumiko"] == NSOrderedSame)
	{
		all = 13 * 9;
		officeOffset = 8 * 9;
		offset = 4 * 9;
	}
	else if ([charName compare:@"natsuko"] == NSOrderedSame)
	{
		all = 8 * 9;
		officeOffset = 4 * 9;
		offset = 2 * 9;
	}
	
	if ([[AlarmConfig getInstance] getOfficeMode])
	{
		idx = officeOffset + rand()%(all - officeOffset);
	}
	else
	{
		idx = offset + rand()%(all - offset);
	}
	
	[charView[curCharIdx] setChar:charName idx:idx isNight:false];

	[UIView beginAnimations:@"anime2" context:NULL];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[charView[curCharIdx].view setAlpha:1];
	[charView[oldCharIdx].view setAlpha:0];
	[UIView commitAnimations];

	++nextCount;
}

- (void)dealloc {
	[super dealloc];	
}

- (void)setOrientation:(bool)isHorizon
{
	for (int i=0; i<2; ++i)
	{
		if (isHorizon)
		{
			[charView[i].view setTransform:CGAffineTransformMake(0.8, 0, 0, -0.8, 0, 0)];
			[charView[i].view setCenter:CGPointMake(300,180)];
		}
		else
		{
			[charView[i].view setTransform:CGAffineTransformMake(1, 0, 0, -1, 0, 0)];
			[charView[i].view setCenter:CGPointMake(160,240)];
		}
	}
}

@end
