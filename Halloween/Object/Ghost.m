#import "Ghost.h"
#import "GOManager.h"
#import "TexManager.h"

@implementation Ghost

- (id)initWithType:(int)type
{
	self = [super init];
	
	[[GOManager getInstance] addEnemy:self];
	pos = CGPointMake(50, 240);
	for (int i=0; i<4; ++i)
	{
		img[i] = [[TexManager getInstance] getGhostImg:type :i];
	}

	imgIdx = 0;
	
	return self;
}

- (void)reset
{
	[self.view setCenter:pos];
	[self.view setTransform:halfForm];
}

- (bool)update:(UInt32)tick
{
	imgIdx = (imgIdx + 1) % 4;
	[imgView setImage:img[imgIdx]];
	
    /* Candy 위치에서 Candy를 잡고 다시 돌아가자 */
    if(pos.x >= 400)
    {
        ghost_type = GHOST_CANDY;
        /* 이미지 반대로~ */
    }
    
    
    switch (ghost_type) {
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
    
	[self.view setCenter:pos];

	return [super update:tick];
}


@end
