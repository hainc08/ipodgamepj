#import "GameUIController.h"
#import "Ghost.h"
#import "NumPanel.h"
#import "InfoPanel.h"

@implementation GameUIController

//박스가 생성되면 gameView에 함수를 호출해주자...
@synthesize gameView;

- (id)init
{
	self = [super init];
	
	boxGold = NULL;
	
	return self;
}

- (void)reset
{
	[newBox setTransform:halfForm];
	[boxGuide setTransform:halfForm];
	[alphaBox setTransform:halfForm];

	[boxGuide setAlpha:0];
	[alphaBox setAlpha:0];
	
	if (boxGold == NULL)
	{
		boxGold = [[NumPanel alloc] initWithIcon:0];
		[self.view addSubview:boxGold.view];
		
		[(NumPanel*)boxGold setFillZero:false];
		[(NumPanel*)boxGold setLen:3];
		[(NumPanel*)boxGold setNumber:100];
		
		[boxGold.view setTransform:halfForm];
		
		CGPoint pos = [newBox center];
		pos.x += 10;
		pos.y += 35;
		[boxGold.view setCenter:pos];
	//---------------------------------------------------
		nowGold = [[InfoPanel alloc] init];
		[self.view addSubview:nowGold.view];
		
		[(InfoPanel*)nowGold setStage:67];
		[(InfoPanel*)nowGold setGold:123456];
		[(InfoPanel*)nowGold setLeft:78 :89];

		[nowGold.view setTransform:halfForm];
		[nowGold.view setCenter:CGPointMake(150, 20)];
	}

	[(GameUIView*)self.view setButtonPos:[newBox center]];
	[(GameUIView*)self.view setParent:self];
}

- (void)update
{

}

@end

@implementation GameUIView

@synthesize buttonPos;
@synthesize parent;

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch;
	NSEnumerator *touchEnum = [touches objectEnumerator];
	
	touch = [touchEnum nextObject];
	CGPoint pos = [touch locationInView: self];
	//pos와 buttonPos의 거리가 30이하이면 박스 생성 시작...parent의 함수를 호출하자...

	return;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch;
	NSEnumerator *touchEnum = [touches objectEnumerator];

	touch = [touchEnum nextObject];
	CGPoint pos = [touch locationInView: self];

	return;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch;
	NSEnumerator *touchEnum = [touches objectEnumerator];
	
	touch = [touchEnum nextObject];
	CGPoint pos = [touch locationInView: self];
	
	return;
}

@end

