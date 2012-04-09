#import "Ghost.h"
#import "GOManager.h"
#import "TexManager.h"

@implementation Ghost

@synthesize health;

- (id)initWithType:(int)type
{
	self = [super init];
	
	[[GOManager getInstance] addEnemy:self];
	pos = MakePoint[0];
	for (int i=0; i<4; ++i)
	{
		img[i] = [[TexManager getInstance] getGhostImg:type :i];
	}

	imgIdx = 0;
	rad = 25;
	cenOffset = CGPointMake(0, 0);
	ghost_state = GHOST_NONE;
	
	return self;
}

- (void)hit:(float)damage :(int)type :(bool)dir
{
	health -= damage;
	if (health <= 0) [self die];
}

- (void)die
{
	[super die];
	ghost_state = GHOST_DIE;
}

- (void)reset
{
	[self.view setCenter:CGPointMake(pos.x + cenOffset.x, pos.y + cenOffset.y)];
	[self.view setTransform:halfForm];
}

- (bool)update:(UInt32)tick
{
	imgIdx = (imgIdx + 1) % 4;
	[imgView setImage:img[imgIdx]];
	
    /* Candy 위치에서 Candy를 잡고 다시 돌아가자 */
    if(pos.x >= 400)
    {
        ghost_state = GHOST_CANDY;
        /* 이미지 반대로~ */
		[self.view setTransform:halfForm_flip];	//요부분이 뒤집어주는 코드...
    }

	//[[GOManager getInstance] getBoxHeight:pos.x]
	//이런식으로 높이를 가져와서 위로 올라가거나, 내려오거나, 옆으로 가거나...

    //오우 멋쪄! 스테이트 구분 이라니!
    switch (ghost_state) {
        case GHOST_NONE:
            pos.x += 3;
            break;
        case GHOST_CANDY:
            pos.x -= 3;
            break;
        case GHOST_DIE:
            /* 죽으면 위로~ 휘리릭~~*/
            pos.y -= 2;
            [self.view setAlpha:[self.view alpha] - 0.1];
            break;
        default:
            break;
    }
    
	[self.view setCenter:CGPointMake(pos.x + cenOffset.x, pos.y + cenOffset.y)];

	return [super update:tick];
}


@end
