#import "GameUIController.h"

@implementation GameUIController

//박스가 생성되면 gameView에 함수를 호출해주자...
@synthesize gameView;

- (void)reset
{
	[newBox setTransform:halfForm];
	[boxGuide setTransform:halfForm];
	[alphaBox setTransform:halfForm];

	[boxGuide setAlpha:0];
	[alphaBox setAlpha:0];
	
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

