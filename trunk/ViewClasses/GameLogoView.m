#import "GameLogoView.h"
#import "ViewManager.h"

@implementation GameLogoView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	step=1;
}

- (void)makeAni:(int)idx offset:(CGPoint)off delay:(float)d life:(float)l alpha:(float)al
{
	startPos[idx].x += off.x;
	startPos[idx].y += off.y;
	delay[idx] = d;
	alpha[idx] = al;
	life[idx] = l;
	isMove[idx] = true;
	
	maxDelay = (d + l + 0.5) * 10;
}

- (void)reset:(NSObject*)param
{
	[super reset:param];
	step = 0;
	maxDelay = 0;
	
	[background setAlpha:1];

	sprite[0] = k;
	sprite[1] = a;
	sprite[2] = r;
	sprite[3] = i;
	sprite[4] = n;
	sprite[5] = base;
	sprite[6] = outline;
	sprite[7] = underChar;
	sprite[8] = enter;
	sprite[9] = shadow;
	sprite[10] = leaf;
	sprite[11] = flower;

	for (int j=0; j<12; ++j)
	{
		originPos[j] = [sprite[j] center];
		startPos[j] = originPos[j];
		delay[j] = 0;
		alpha[j] = 1;
		life[j] = 0.5;
		isMove[j] = false;
	}

	[self makeAni:0 offset:CGPointMake(-20,-20) delay:0.3f life:0.5f alpha:0.f];
	[self makeAni:1 offset:CGPointMake(-10,-20) delay:0.6f life:0.5f alpha:0.f];
	[self makeAni:2 offset:CGPointMake(0,-20) delay:0.9f life:0.5f alpha:0.f];
	[self makeAni:3 offset:CGPointMake(10,-20) delay:1.2f life:0.5f alpha:0.f];
	[self makeAni:4 offset:CGPointMake(20,-20) delay:1.5f life:0.5f alpha:0.f];
	[self makeAni:6 offset:CGPointMake(0,-20) delay:2.4f life:0.5f alpha:0.f];
	[self makeAni:7 offset:CGPointMake(0,0) delay:1.8f life:0.5f alpha:1.f];
	[self makeAni:8 offset:CGPointMake(0,0) delay:2.1f life:0.1f alpha:0.f];

	[self makeAni:5 offset:CGPointMake(-20,10) delay:2.6f life:0.4f alpha:0.f];
	[self makeAni:9 offset:CGPointMake(20,10) delay:2.7f life:0.4f alpha:0.f];
	[self makeAni:10 offset:CGPointMake(0,-20) delay:2.8f life:0.4f alpha:0.f];
	[self makeAni:11 offset:CGPointMake(0,-20) delay:2.9f life:0.4f alpha:0.f];
	
	[sprite[7] setTransform:CGAffineTransformMake(1.0, 0.0, 0.0, 0.001, 0, 0)];
	
	for (int j=0; j<12; ++j)
	{
		if (isMove[j] == false) continue;

		[sprite[j] setCenter:startPos[j]];
		[sprite[j] setAlpha:alpha[j]];

		[UIView beginAnimations:@"logo" context:NULL];
		[UIView setAnimationDuration:life[j]];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		[UIView setAnimationDelay:delay[j]];
		
		[sprite[j] setAlpha:1];
		
		if (j == 7)
		{
			[sprite[7] setTransform:CGAffineTransformMake(1.0, 0.0, 0.0, 1.0, 0, 0)];
		}
		else
		{
			[sprite[j] setCenter: originPos[j]];
		}

		[UIView commitAnimations];
	}
}

- (void)update
{
	[super update];
	
	if (frameTick == maxDelay) step = 1;

	switch (step)
	{
		case 1:
		{
			float al = [background alpha];
			al -= 0.1f;
			[background setAlpha:al];
			if (al <= 0.f) step = 2;

			break;
		}
		case 2:
			//다음뷰로 이동 한다.
			[[ViewManager getInstance] changeViewWithInit:@"MainTopView"];
			break;
	}
}

@end
