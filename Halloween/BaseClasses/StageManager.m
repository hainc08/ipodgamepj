#import "StageManager.h"

static StageManager *StageManagerInst;

void setOptProp(int opt1, int opt2)
{
	StageManagerInst->enemyOpt[0] = opt1;
	StageManagerInst->enemyOpt[1] = opt2;
}

@implementation StageManager

@synthesize curStage;

+ (StageManager*)getInstance
{
	return StageManagerInst;
}

+ (void)initManager;
{
	StageManagerInst = [StageManager alloc];
}

- (void)closeManager
{
	
}

- (void)makeStage:(int)stage
{
	curStage = stage;
	lastBox = 0;
	[self resetEnemyMakeInfo];

	//여기서 셋팅하는 건 디폴트값... 나중에는 파일에서 저장하는 값으로 읽자...
	//테스트 플레이 도중에 레벨링 가능하게...
//	switch (curStage)
	{
//		case 0:
			setOptProp(50, 50);
			[self setEnemyMakeInfo:0 :10 :30.f];
			[self setEnemyMakeInfo:1 :5 :30.f];
			boxCount = 0;
			for (int i=0; i<boxCount; ++i)
			{
				boxs[i].pos = i * 200 + 480;
				boxs[i].type = rand()%4;
			}
//			break;
	}
}

- (int)getEnemyOpt:(int)type
{
	int result = 0;
	if (type == 0)
	{
		if (rand()%100 < enemyOpt[0]) result = 0x01;
		if (rand()%100 < enemyOpt[1]) result |= 0x02;
	}
	
	return result;
}

- (BoxInfo*)GetBoxType:(float)from :(float)to
{
	for (int i=lastBox; i<boxCount; ++i)
	{
		if (boxs[i].pos > to) return NULL;

		if ((boxs[i].pos >= from)&&(boxs[i].pos < to))
		{
			lastBox = i + 1;
			return &boxs[i];
		}
	}
	
	return NULL;
}

- (void)resetEnemyMakeInfo
{
	for (int i=0; i<ENEMYCOUNT; ++i)
	{
		enemyMakeCount[i] = enemyMakeTerm[i] = 0;
	}
}

- (void)setEnemyMakeInfo:(int)idx :(int)count :(float)term
{
	enemyMakeCount[idx] = count;
	enemyMakeTerm[idx] = term;
}

- (int)getEnemyMakeCount:(int)idx
{
	return enemyMakeCount[idx];
}

- (float)getEnemyMakeTerm:(int)idx
{
	return enemyMakeTerm[idx];
}

@end
