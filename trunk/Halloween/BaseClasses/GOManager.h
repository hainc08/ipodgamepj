#import <UIKit/UIKit.h>

bool isIn(CGPoint* a, CGPoint* b, float rad);

@interface GOManager : NSObject {
	NSMutableArray* enemys;
	NSMutableArray* boxes;
	NSMutableArray* candys;
	NSMutableArray* items;
	
	NSMutableIndexSet *discardedItems;
	
	int frameTick;
	
	int GroundInit[480];
	int BoxHeight[480];
	int MonsterPath[480];

	bool boxDirty;
	bool monPathDirty;
	
	UIViewController* GameView;
}

@property (retain) UIViewController* GameView;

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
- (void)updateMonsterPath;

- (int)getBoxHeight:(int)xPos;
- (int)getMonsterPath:(int)xPos;
- (bool)HitGhostByBox:(CGPoint)pos;

- (NSObject*)hitCheck:(CGPoint)pos :(float)rad :(bool)dir;

@end
