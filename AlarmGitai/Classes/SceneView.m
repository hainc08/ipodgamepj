#import "SceneView.h"
#import "DateFormat.h"

@implementation SceneView

- (void)setChar:(NSString*)name
{
	charName = name;
}

- (void)setBackGround:(int)idx isNight:(bool)isNight
{
	NSString *timeStr;
	if (isNight) timeStr = @"n";
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
	
	[charView[curCharIdx] setChar:charName idx:rand()%48 isNight:isNight];

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

@end
