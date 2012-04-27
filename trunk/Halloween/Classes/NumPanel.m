#import "NumPanel.h"

@implementation NumPanel

@synthesize fillZero;
@synthesize len;

- (id)initWithIcon:(int)idx
{
	self = [super init];
	
	fillZero = false;
	len = 6;
	
	return self;
}

- (void)setNumber:(int)n
{
	if (number == n) return;
	
	number = n;
	
	int k = len - 1;
	
	while (n > 0) {
		[self setPart:k :n%10];
		--k;
		
		n = (int)(n/10);
	}
	
	for (int i=k; i>=0; --i)
	{
		if (fillZero)
			[self setPart:i :0];
		else
			[self setPart:i :-1];
	}
	
	for (int i=len; i<6; ++i)
	{
		[self setPart:i :-1];
	}
}

- (void)setPart:(int)i :(int)num
{
	UIImageView* n = NULL;
	
	switch (i)
	{
		case 0:
			n = number1;
			break;
		case 1:
			n = number2;
			break;
		case 2:
			n = number3;
			break;
		case 3:
			n = number4;
			break;
		case 4:
			n = number5;
			break;
		case 5:
			n = number6;
			break;
	}
	
	if (n == NULL) return;
	
	if (num == -1) [n setAlpha:0];
	else
	{
		[n setAlpha:1];
		[n setImage:[UIImage imageNamed:[NSString stringWithFormat:@"n_%d.png", num]]];
	}
}

@end
