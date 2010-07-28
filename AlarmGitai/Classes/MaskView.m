#import "MaskView.h"

@implementation MaskView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch;
	NSEnumerator *touchEnum = [touches objectEnumerator];

	touch = [touchEnum nextObject];
	drawTo = drawAt = [touch locationInView: self];
	isDirty = false;
}

//Lina리소스 변환에 관한 정보
//step1: 하단부를 잘라서 600을 530으로 줄인다.
//step2: 리사이즈로 480으로 만든다.

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch;
	NSEnumerator *touchEnum = [touches objectEnumerator];
	
	touch = [touchEnum nextObject];
	drawTo = [touch locationInView: self];

	float x = (drawTo.x - drawAt.x);
	float y = (drawTo.y - drawAt.y);
	
	float leng = x * x + y * y;
	int count = (int)(sqrt(leng) / 14) + 1;
	
	x /= count;
	y /= count;
	
	for (int i=0; i<count; ++i)
	{
		CGContextDrawImage(testContext, CGRectMake(drawAt.x + x * i - 10, drawAt.y + y * i - 10, 20, 20), [maskImg CGImage]);
	}
		
	drawAt = drawTo;

	isDirty = true;
}

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	return self;
}

-(void)reset
{
	baseImg = [UIImage imageNamed:@"base.png"];
	maskImg = [UIImage imageNamed:@"mask.png"];
	char1 = [UIImage imageNamed:@"lina_0_d.png"];
	char2 = [UIImage imageNamed:@"lina_1_d.png"];

    CGColorSpaceRef     colorSpace;
    void *                  bitmapData;
    int                 bitmapByteCount;
    int                 bitmapBytesPerRow;
	
	size_t pixelsWide = 320;
	size_t pixelsHigh = 480;
	bitmapBytesPerRow = (pixelsWide * 4);
	bitmapByteCount = (bitmapBytesPerRow * pixelsHigh);
	colorSpace = CGColorSpaceCreateDeviceRGB();
	
	bitmapData = malloc(bitmapByteCount);
    testContext = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, 8, bitmapBytesPerRow, colorSpace, kCGImageAlphaPremultipliedFirst);
	temp = CGBitmapContextCreateImage(testContext);
	isDirty = false;
	
	profile1 = 0;
	profile2 = 0;
	
	[self resumeTimer];
}

-(void)drawRect:(CGRect)rect
{	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextBeginPath(context);

	CGContextDrawImage(context, CGRectMake(0, 0, 320, 480), [char1 CGImage]);
	CGContextClipToMask(context, CGRectMake(0, 0, 320, 480), temp);
	CGContextDrawImage(context, CGRectMake(0, 0, 320, 480), [char2 CGImage]);
	
	CGContextStrokePath(context);
}

- (void)update
{
	if (isDirty == false) return;

	temp = CGBitmapContextCreateImage(testContext);
	
	[self setNeedsDisplay];
}

- (void)stopTimer
{
	[updateTimer invalidate]; 
	[updateTimer release]; 
}

- (void)resumeTimer
{
	updateTimer = [[NSTimer scheduledTimerWithTimeInterval: (1.0f/3.f)
													target: self
												  selector: @selector(update)
												  userInfo: self
												   repeats: YES] retain];	
}

- (void)dealloc {
	[super dealloc];	
}

@end
