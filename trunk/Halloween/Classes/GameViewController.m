#import "GameViewController.h"
#import "GameUIController.h"
#import "Ghost.h"
#import "GhostSparta.h"
#import "Candy.h"
#import "Box.h"
#import "BoxGum.h"
#import "GOManager.h"

#import "BackViewController.h"
#import "GameUIController.h"

Ghost* MakeGhost(int idx)
{
	if (idx == GHOST_BASE)		return [[Ghost alloc] initWithType:GHOST_BASE];
	if (idx == GHOST_SPARTA)	return [[GhostSparta alloc] initWithType:GHOST_SPARTA];
	
	return NULL;
}

@implementation GameViewController

@synthesize objectView;
@synthesize boxView;

- (id)init
{
	self = [super init];
	backView = NULL;
	gameUIView = NULL;
	return self;
}

- (void)reset:(NSObject*)param
{
	if (backView == NULL)
	{
		backView = [[BackViewController alloc] init];
		[self.view addSubview:backView.view];
	}
	if (gameUIView == NULL)
	{
		gameUIView = [[GameUIController alloc] init];
		[self.view addSubview:gameUIView.view];
		[(GameUIController*)gameUIView setGameView:self];
	}
	
	[(BackViewController*)backView reset];
	[(GameUIController*)gameUIView reset];
	
	//캔디 열개만 테스트삼아 생성해보자...
	for (int i=0; i<10; ++i)
	{
		Candy* testCandy = [[Candy alloc] init];
		[boxView addSubview:testCandy.view];
		[testCandy reset];
	}
	
	[frontGround setTransform:halfForm];
	
	[self.view sendSubviewToBack:backView.view];
	[self.view bringSubviewToFront:boxView];
	[self.view bringSubviewToFront:objectView];
	[self.view bringSubviewToFront:frontGround];
	[self.view bringSubviewToFront:gameUIView.view];
	
	[[GOManager getInstance] setGameView:self];
	
	testDelay = 0;
}

- (void)update
{
	[[GOManager getInstance] update];
	[(GameUIController*)gameUIView update];

	//고스트를 꾸준히 만들어 보자...
	--testDelay;
	if (testDelay <= 0)
	{
		Ghost* test = MakeGhost(rand()%2);
		[test setHealth:30];
		[objectView addSubview:test.view];
		[objectView sendSubviewToBack:test.view];
		[test reset];
		
		testDelay = 40 + rand() % 15;
	}
}

@end
