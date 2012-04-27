#import "InfoPanel.h"

@implementation InfoPanel

- (id)init
{
	self = [super init];
	
	stageNum = goldNum = leftNum = allNum = 0;
	for (int i=0; i<10; ++i)
	{
		numImg[i] = [UIImage imageNamed:[NSString stringWithFormat:@"n_%d.png", i]];
	}
	
	return self;
}

- (void)setStage:(int)s
{
	if (stageNum == s) return;

	[s_1 setImage:numImg[(int)(s/10)]];
	[s_2 setImage:numImg[s%10]];
}

- (void)setLeft:(int)lg :(int)ag
{
	if (leftNum != lg)
	{
		[l_1 setImage:numImg[(int)(lg/10)]];
		[l_2 setImage:numImg[lg%10]];
	}

	if (allNum != ag)
	{
		[l_3 setImage:numImg[(int)(ag/10)]];
		[l_4 setImage:numImg[ag%10]];
	}
}

- (void)setGold:(int)g
{
	if (goldNum == g) return;
	
	goldNum = g;
	int k = 5;
	
	while (g > 0) {
		[self setGoldNum:k :g%10];
		--k;
		
		g = (int)(g/10);
	}

	for (int i=k; i>=0; --i)
	{
		[self setGoldNum:i :0];
	}
}

- (void)setGoldNum:(int)i :(int)num
{
	UIImageView* n = NULL;
	
	switch (i)
	{
		case 0:
			n = g_1;
			break;
		case 1:
			n = g_2;
			break;
		case 2:
			n = g_3;
			break;
		case 3:
			n = g_4;
			break;
		case 4:
			n = g_5;
			break;
		case 5:
			n = g_6;
			break;
	}
	
	if (n == NULL) return;
	
	[n setImage:numImg[num]];
}

@end
