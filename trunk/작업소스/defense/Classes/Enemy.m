#import "Enemy.h"
#import "UnitTexManager.h"

@implementation Enemy

-(float)distance:(CGPoint)f to:(CGPoint)t
{
	f.x -= t.x;
	f.y -= t.y;
	return sqrt((f.x * f.x) + (f.y * f.y));
}

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	return self;
}

-(void)update:(UInt32)tick
{
	switch (state)
	{
		case 0:
			if (wait > 0) --wait;
			if (wait == 0)
			{
				[UIView beginAnimations:@"appear" context:NULL];
				[UIView setAnimationDuration:0.5];
				[UIView setAnimationCurve:UIViewAnimationCurveLinear];
				
				[self setAlpha:1.0];
				
				[UIView commitAnimations];
				state = 1;
			}
			return;
		case 2:
		case 3:
			return;
		case 1:
		{
			if (pathIdx == pathCount)
			{
				//빠져나갔다!
				[self goal];
				return;
			}
	
			float length = [self distance:curPos to:moveTo];
			CGPoint dir = curPos;
			
			if ((pathIdx+1 < pathCount)&&(length < 40))
			{
				CGPoint nextTo = pathPoints[pathIdx+1];

				float nextLength = [self distance:moveTo to:nextTo];

				moveTo.x += (nextTo.x - moveTo.x) / nextLength * (40 - length);
				moveTo.y += (nextTo.y - moveTo.y) / nextLength * (40 - length);
				
				length = [self distance:curPos to:moveTo];
				
				if ([self distance:moveTo to:nextTo] < speed) ++pathIdx;
			}
			else
			{
				if (length < speed) ++pathIdx;
			}
			
			curPos.x += (moveTo.x - curPos.x) / length * speed;
			curPos.y += (moveTo.y - curPos.y) / length * speed;

			[self setEnemyCenter:curPos];

			dir.x = curPos.x - dir.x;
			dir.y = curPos.y - dir.y;
			float l = sqrt((dir.x * dir.x) + (dir.y * dir.y));
			float cos_a = - dir.y / l;
			float sin_a = dir.x / l;
			
			self.transform = CGAffineTransformMake(cos_a, sin_a, -sin_a, cos_a, 0, 0);
		}
		break;
	}
}

-(void)setEnemy:(int)idx level:(int)level wait:(int)waitTick
{
	//나중에 메니져 하나 만들어서 중앙에서 관리하게 해준다.
	UIImage* img1 = [[UnitTexManager getInstance] getEnemyTex:idx];
	UIImage* img2 = [[UnitTexManager getInstance] getEnemyShadowTex:idx];
	[EnemyImage setImage:img1];
	[EnemyImage setSize:[img1 size]];
	[EnemyShadow setImage:img2];
	[EnemyShadow setSize:[img2 size]];

	speed = 10;
	maxHp = 10 * level;
	wait = waitTick;
	state = 0;
	randOffset.x = rand()%10;
	randOffset.y = rand()%10;

	[self setAlpha:0.0];
	
	curHp = maxHp;
}

-(void)hit:(int)amount
{
	curHp -= amount;
}

-(void)die
{
	state = 2;
	[UIView beginAnimations:@"goal" context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	
	[self setAlpha:0.0];
	
	[UIView commitAnimations];
}

-(void)goal
{
	state = 3;
	[UIView beginAnimations:@"goal" context:NULL];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	
	[self setAlpha:0.0];
	
	[UIView commitAnimations];
}

-(void)setEnemyCenter:(CGPoint)cent
{
	//	enemyCenter.x = cent.x + randOffset.x;
	//	enemyCenter.y = cent.y + randOffset.y;
	enemyCenter.x = cent.x;
	enemyCenter.y = cent.y;
	[self setCenter:enemyCenter];
}

-(CGPoint*)getEnemyCenter
{
	return &enemyCenter;
}

-(void)setPath:(CGPoint*)p count:(int)c
{
	pathPoints = p;
	pathCount = c;
	[self setEnemyCenter:pathPoints[0]];
	curPos = pathPoints[0];
	pathIdx = 1;
	moveTo = pathPoints[1];
}

@end
