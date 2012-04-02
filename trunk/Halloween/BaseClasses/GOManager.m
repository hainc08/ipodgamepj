#import "GOManager.h"
#import "Object.h"

bool isIn(CGPoint* a, CGPoint* b, float rad)
{
	return ((a->x - b->x) * (a->x - b->x) + (a->y - b->y) * (a->y - b->y) < (rad * rad));
}

static GOManager *GOManagerInst;

@implementation GOManager

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

	[self removeAllObject];
}

- (void)addEnemy:(NSObject*)e
{
	[enemys addObject:e];
}

- (void)addBox:(NSObject*)b
{
	[boxes addObject:b];
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
	[self updateArray:boxes];
	[self updateArray:candys];
	[self updateArray:items];

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

@end
