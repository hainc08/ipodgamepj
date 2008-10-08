#import <UIKit/UIKit.h>

@interface Enemy : UIView {
    IBOutlet id EnemyImage;
    IBOutlet id EnemyShadow;

	int			wait;
	int			state;
	//0 - 멈춰있음
	//1 - 움직임...
	//2 - Die~!!
	//3 - 빠져나감...점수체크전
	//4 - 빠져나감...점수체크완료

	float		speed;
	int			maxHp, curHp;

	CGPoint*	pathPoints;
	int			pathCount;
	int			pathIdx;

	CGPoint		moveTo;
	CGPoint		curPos;
	//길이 넓으니 약간씩 어긋나게 가자...
	//큰놈은 Offset값 적게...
	CGPoint		randOffset;
	CGPoint		enemyCenter;
}

-(float)distance:(CGPoint)f to:(CGPoint)t;

-(void)setEnemy:(int)idx level:(int)level wait:(int)waitTick;
-(void)setPath:(CGPoint*)p count:(int)c;

-(void)hit:(int)amount;
-(void)die;
-(void)goal;

-(void)update:(UInt32)tick;

-(void)setEnemyCenter:(CGPoint)cent;
-(CGPoint*)getEnemyCenter;

@end
