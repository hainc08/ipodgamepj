#import "GameUIController.h"
#import "Ghost.h"
#import "NumPanel.h"
#import "InfoPanel.h"
#import "GOManager.h"
#import "Box.h"

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
	[followBox setTransform:halfForm];
	[xMark setTransform:halfForm];

	[boxGuide setAlpha:0];
	[alphaBox setAlpha:0];
	[followBox setAlpha:0];
	[xMark setAlpha:0];

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

- (void)newBox:(CGPoint)pos :(bool)isDrop
{
	bool isValid = true;
	int posX = 25 * (int)(((pos.x - 15) / 25) + 0.5f) + 15;

	if (posX < 140) isValid = false;
	else if (posX > 340) isValid = false;

	if (isDrop)
	{
		[boxGuide setAlpha:0];
		[alphaBox setAlpha:0];
		[followBox setAlpha:0];
		[xMark setAlpha:0];

		pos.x = posX;
		pos.y = 30;
		
		float h1 = [[GOManager getInstance] getBoxHeight:pos.x - 24];
		float h2 = [[GOManager getInstance] getBoxHeight:pos.x + 24];

		if ((h1 < h2 ? h1 : h2) - 25 < 100) isValid = false;

		if (isValid)
		{
			Box* nBox = [[Box alloc] init];
			[nBox drop:pos.x :pos.y :[alphaBox center].y];
			[[gameView boxView] addSubview:nBox.view];
			[nBox reset];
		}
	}
	else
	{
		[boxGuide setAlpha:0.5];
		[alphaBox setAlpha:0.5];
		[followBox setAlpha:1];

		pos.y = 30;
		[followBox setCenter:pos];
		
		pos.x = posX;
		pos.y = GroundHeight - (290 * 0.5f);
		[boxGuide setCenter:pos];
		
		float h1 = [[GOManager getInstance] getBoxHeight:pos.x - 24];
		float h2 = [[GOManager getInstance] getBoxHeight:pos.x + 24];
		pos.y = (h1 < h2 ? h1 : h2) - 25;
		
		if (pos.y < 100) isValid = false;

		[alphaBox setCenter:pos];
		
		if (isValid)
		{
			[xMark setAlpha:0];
		}
		else
		{
			[xMark setAlpha:1];
			[xMark setCenter:pos];
		}
	}
}

@end

@implementation GameUIView

@synthesize buttonPos;
@synthesize parent;

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	isNewBox = false;
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	isNewBox = false;
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch;
	NSEnumerator *touchEnum = [touches objectEnumerator];
	
	touch = [touchEnum nextObject];
	CGPoint pos = [touch locationInView: self];
	CGPoint tempPos = pos;

	//pos와 buttonPos의 거리가 30이하이면 박스 생성 시작...parent의 함수를 호출하자...
	pos.x -= buttonPos.x;
	pos.y -= buttonPos.y;

	if ((pos.x * pos.x) + (pos.y * pos.y) < 900)
	{
		tempPos.y = 30;
		isNewBox = true;
		[parent newBox:tempPos :false];
	}

	return;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (isNewBox)
	{
		NSEnumerator *touchEnum = [touches objectEnumerator];
		UITouch *touch = [touchEnum nextObject];
	
		[parent newBox:[touch locationInView: self] :false];
	}

	return;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (isNewBox)
	{
		NSEnumerator *touchEnum = [touches objectEnumerator];
		UITouch *touch = [touchEnum nextObject];

		[parent newBox:[touch locationInView: self] :true];
	}
	
	isNewBox = false;
	
	return;
}

@end

