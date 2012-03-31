#import <UIKit/UIKit.h>
#import "SpecManager.h"

struct _BoxInfo
{
	float pos;
	int type;
};
typedef struct _BoxInfo BoxInfo;

@interface StageManager : NSObject {

@public	
	int curStage;
	int lastBox;
	SpecManager* sp;
	
	int boxCount;
	BoxInfo boxs[100];
	
	int enemyMakeCount[ENEMYCOUNT];
	float enemyMakeTerm[ENEMYCOUNT];
	int enemyOpt[2];
}

@property (readonly) int curStage;

+ (StageManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (void)makeStage:(int)stage;
- (int)getEnemyOpt:(int)type;
- (BoxInfo*)GetBoxType:(float)from :(float)to;

- (void)resetEnemyMakeInfo;
- (void)setEnemyMakeInfo:(int)idx :(int)count :(float)term;
- (int)getEnemyMakeCount:(int)idx;
- (float)getEnemyMakeTerm:(int)idx;

@end
