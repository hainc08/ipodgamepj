#import <UIKit/UIKit.h>

struct _BaseSpec
{
	float defense;
	float maxLife;
	float speed;
	int point;
	int level;
};
typedef struct _BaseSpec BaseSpec;

@interface SpecManager : NSObject {
	BaseSpec enemy[ENEMYCOUNT];
}

+ (SpecManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (void)initSpec;

- (void)loadFromFile;
- (void)saveToFile;

- (BaseSpec*)getEnemySpec:(int)idx;

@end
