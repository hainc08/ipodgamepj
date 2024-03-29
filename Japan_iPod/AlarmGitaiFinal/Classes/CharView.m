#import "CharView.h"

@implementation CharUIView

- (void)setTemp:(CGImageRef)img
{
	temp = img;
}

-(void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextBeginPath(context);
	CGContextDrawImage(context, CGRectMake(0, 0, 480, 480), temp);
	CGContextStrokePath(context);
}

@end

@implementation CharView

- (void)setChar:(NSString*)name idx:(int)idx isNight:(bool)isNight
{
	int baseIdx = 0;
	int faceIdx = 0;
	
	//나중에 이부분을 데이터화 시켜서 로딩해서 쓴다.
	int step = 9;

	NSString *timeStr;
	
	if (isNight) timeStr = @"n";
	else timeStr = @"d";
	
	//fumiko, akari, natsuko 는 해줄게 없음...
	if ([name compare:@"haruka"] == NSOrderedSame) step = 10;
	else if ([name compare:@"irika"] == NSOrderedSame) step = 6;
	else if ([name compare:@"reina"] == NSOrderedSame) step = 8;
	else if ([name compare:@"hitomi"] == NSOrderedSame) step = 14;

	baseIdx = idx / step;
	faceIdx = idx % (step * 2);

	if (([name compare:@"akari"] == NSOrderedSame) && (baseIdx == 14)) faceIdx += 9;

	UIImage* imgBase = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%d_%@_b.png", name, baseIdx, timeStr]];

    CGColorSpaceRef     colorSpace;
    void*				bitmapData;
    int                 bitmapByteCount;
    int                 bitmapBytesPerRow;
	
	size_t pixelsWide = 480;
	size_t pixelsHigh = 480;
	bitmapBytesPerRow = (pixelsWide * 4);
	bitmapByteCount = (bitmapBytesPerRow * pixelsHigh);
	colorSpace = CGColorSpaceCreateDeviceRGB();

	bitmapData = malloc(bitmapByteCount);
    charContext = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, 8, bitmapBytesPerRow, colorSpace, kCGImageAlphaPremultipliedFirst);
	
	CGContextBeginPath(charContext);

	CGContextDrawImage(charContext,
					   CGRectMake((480 - [imgBase size].width)/2,
								  480 - [imgBase size].height,
								  [imgBase size].width,
								  [imgBase size].height),
					   [imgBase CGImage]);

	if ((faceIdx != 0)&&(faceIdx % step != 0))
	{
		UIImage* imgFace = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%d_%@.png", name, faceIdx, timeStr]];

		CGContextDrawImage(charContext,
						   CGRectMake((480 - [imgFace size].width)/2,
									  480 - [imgFace size].height,
									  [imgFace size].width,
									  [imgFace size].height),
						   [imgFace CGImage]);
		[imgFace release];
	}
	CGContextStrokePath(charContext);
	
	if (temp != nil) CGImageRelease(temp);
	temp = CGBitmapContextCreateImage(charContext);

	[(CharUIView*)self.view setTemp:temp];
	[self.view setNeedsDisplay];
	
	CGContextRelease(charContext);
	free(bitmapData);
}

- (void)dealloc {
	[super dealloc];	
}

@end
