#import "GOManager.h"
#import "Object.h"
#import "Box.h"

bool isIn(CGPoint* a, CGPoint* b, float rad)
{
	return ((a->x - b->x) * (a->x - b->x) + (a->y - b->y) * (a->y - b->y) < (rad * rad));
}

static GOManager *GOManagerInst;

@implementation GOManager

@synthesize GameView;

+ (GOManager*)getInstance
{
	return GOManagerInst;
}

+ (void)initManager;
{
	GOManagerInst = [[GOManager alloc] init];
	[GOManagerInst reset];
}

- (id)init
{
	enemys = [[NSMutableArray alloc] initWithCapacity:0];
	boxes = [[NSMutableArray alloc] initWithCapacity:0];
	candys = [[NSMutableArray alloc] initWithCapacity:0];
	items = [[NSMutableArray alloc] initWithCapacity:0];

	discardedItems = [[NSMutableIndexSet alloc] init];

	for (int i=0; i<480; ++i)
	{
		GroundInit[i] = GroundHeight;
	}
	
	return [super init];
}

- (void)closeManager
{
	[self reset];
	[enemys release];
	[boxes release];
	[candys release];
	[items release];
	[discardedItems release];
}

- (void)reset
{
	frameTick = 0;
	boxDirty = true;
	monPathDirty = true;
	
	[self removeAllObject];
}

- (void)addEnemy:(NSObject*)e
{
	[enemys addObject:e];
}

- (void)addBox:(NSObject*)b
{
	[boxes addObject:b];
	boxDirty = true;
}

- (void)addCandy:(NSObject*)i
{
	[candys addObject:i];
}

- (void)addItem:(NSObject*)i
{
	[items addObject:i];
}

- (void)update
{
	[self updateArray:enemys];
	
	//업데이트 이후 박스 개수가 달려졌다면 dirty상태...
	int boxCount = [boxes count];
	[self updateArray:boxes];
	boxDirty |= (boxCount != [boxes count]);

	[self updateArray:candys];
	[self updateArray:items];
	
	[self updateBoxHeight];

	++frameTick;
}

- (void)updateArray:(NSMutableArray*)array
{
	NSUInteger index = 0;
	[discardedItems removeAllIndexes];

	for (Object* obj in array)
	{
		if ([obj update:frameTick] == false)
		{
			[discardedItems addIndex:index];
			[obj release];
		}
		
		++index;
	}
	
	[array removeObjectsAtIndexes:discardedItems];
}

- (void)drawEnemyDebug:(CGContextRef)context
{
	for (Object *itr in enemys)
	{
		[itr debugDraw:context];
	}
}

- (void)removeAllObject
{
	for (Object *itr in enemys)
	{
		[itr release];
	}
	[enemys removeAllObjects];
	
	for (Object *itr in boxes)
	{
		[itr release];
	}
	[boxes removeAllObjects];

	for (Object *itr in candys)
	{
		[itr release];
	}
	[candys removeAllObjects];
	
	for (Object *itr in items)
	{
		[itr release];
	}
	[items removeAllObjects];
}

- (int)getEnemyCount
{
	return [enemys count];
}

//조금 더 최적화 할 수 있는 방안을 모색해야한다.
- (void)updateBoxHeight
{
	if (boxDirty == false)
	{
		if (monPathDirty) [self updateMonsterPath];
		return;
	}

	memcpy(BoxHeight, GroundInit, sizeof(int) * 480);
	memcpy(MonsterPath, GroundInit, sizeof(int) * 480);
			
	monPathDirty = false;

	for (Box *itr in boxes)
	{
		int x = [itr GetCenPos]->x - 25;
		int h = [itr fallYpos] - 25;

		for (int i=0; i<50; ++i)
		{
			if (BoxHeight[x+i] > h) BoxHeight[x+i] = h;
		}

		if ([itr isFall])
		{
			monPathDirty = true;
			continue;
		}

		x -= 20;
		
		for (int i=0; i<90; ++i)
		{
			if (MonsterPath[x+i] > h) MonsterPath[x+i] = h;
		}
	}

	boxDirty = false;
}

- (void)updateMonsterPath
{
	memcpy(MonsterPath, GroundInit, sizeof(int) * 480);
	
	monPathDirty = false;
	
	for (Box *itr in boxes)
	{
		int x = [itr GetCenPos]->x - 45;
		int h = [itr fallYpos] - 25;

		if ([itr isFall])
		{
			monPathDirty = true;
			continue;
		}
		
		for (int i=0; i<90; ++i)
		{
			if (MonsterPath[x+i] > h) MonsterPath[x+i] = h;
		}
	}
}

- (int)getBoxHeight:(int)xPos
{
	return BoxHeight[xPos];
}

- (int)getMonsterPath:(int)xPos
{
	return MonsterPath[xPos];
}

- (bool)HitGhostByBox:(CGPoint)pos
{
	//박스 범위안에 녀석은 다 데미지...
	for (Object *itr in enemys)
	{
		if ([itr isDead]) continue;
		CGPoint* epos = [itr GetCenPos];
		if (epos->x < pos.x - 25) continue;
		if (epos->x > pos.x + 25) continue;
		if (epos->y < pos.y - 50) continue;
		if (epos->y > pos.y + 50) continue;
		
		[itr die];
		
		return true;
	}
	
	return false;
}

- (NSObject*)hitCheck:(CGPoint)pos :(float)rad :(bool)dir
{
	Object* near = nil;
	float min;
	
	if (dir) min = 1000;
	else min = -1;

	for (Object *itr in enemys)
	{
		if ([itr isDead]) continue;

		float r = rad + [itr rad];
		r = r * r;

		CGPoint* epos = [itr GetCenPos];
		int x = epos->x - pos.x;
		int y = epos->y - pos.y;
		
		if ((x * x + y * y) < r)
		{
			//가장 가까운 녀석이 맞는다.
			if (dir)
			{
				if (min > epos->x)
				{
					near = itr;
					min = epos->x;
				}
			}
			else
			{
				if (min < epos->x)
				{
					near = itr;
					min = epos->x;
				}
			}
		}
	}
	
	return near;
}

@end
