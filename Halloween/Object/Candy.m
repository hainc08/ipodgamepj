#import "Candy.h"
#import "GOManager.h"
#import "TexManager.h"

@implementation Candy

- (id)init
{
	self = [super init];
	
	[[GOManager getInstance] addCandy:self];
	
	pos = CandyPoint;
	//사탕을 어떻게 뿌려놔야 좀 더 예쁘게 보일까나?
	//사탕더미 이미지를 따로 만들어야 하려나?
	pos.x += rand() % 15 - 30;
	pos.y -= rand() % 10 - 20;
	
	return self;
}

- (void)reset
{
	[imgView setImage:[[TexManager getInstance] getCandyImg:rand()%CANDYCOUNT]];

	[self.view setCenter:pos];
	[self.view setTransform:halfForm];
}

- (bool)update:(UInt32)tick
{
	//유령에 소지(?)한 경우 따라가게 하자.
	return [super update:tick];
}


@end
