#import <UIKit/UIKit.h>

bool isIn(CGPoint* a, CGPoint* b, float rad);

@interface GOManager : NSObject {
	NSMutableArray* enemys;
	NSMutableArray* boxes;
	NSMutableArray* items;
	
	NSMutableIndexSet *discardedItems;
	
	int frameTick;
}

+ (GOManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (void)reset;
- (id)init;

- (void)addEnemy:(NSObject*)e;
- (void)addBox:(NSObject*)b;
- (void)addItem:(NSObject*)i;

- (void)update;
- (void)updateArray:(NSMutableArray*)array;
- (void)drawEnemyDebug:(CGContextRef)context;

- (void)removeAllObject;
- (int)getEnemyCount;

@end
