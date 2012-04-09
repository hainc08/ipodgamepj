#import <UIKit/UIKit.h>

bool isIn(CGPoint* a, CGPoint* b, float rad);

@interface GOManager : NSObject {
	NSMutableArray* enemys;
	NSMutableArray* boxes;
	NSMutableArray* candys;
	NSMutableArray* items;
	
	NSMutableIndexSet *discardedItems;
	
	int frameTick;
	
	int HeightInfo[480];
	bool boxDirty;
}

+ (GOManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (void)reset;
- (id)init;

- (void)addEnemy:(NSObject*)e;
- (void)addBox:(NSObject*)b;
- (void)addCandy:(NSObject *)i;
- (void)addItem:(NSObject*)i;

- (void)update;
- (void)updateArray:(NSMutableArray*)array;
- (void)drawEnemyDebug:(CGContextRef)context;

- (void)removeAllObject;
- (int)getEnemyCount;

- (void)updateBoxHeight;
- (int)getBoxHeight:(int)xPos;

- (NSObject*)hitCheck:(CGPoint)pos :(float)rad :(bool)dir;

@end
