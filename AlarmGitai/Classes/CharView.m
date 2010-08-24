#import "CharView.h"

@implementation CharView


- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
		
	return self;
}

- (void)setChar:(NSString*)name idx:(int)idx isNight:(bool)isNight
{
	int baseIdx;
	int faceIdx;
	
	NSString *timeStr;
	if (isNight) timeStr = @"n";
	else timeStr = @"d";

	//나중에 이부분을 데이터화 시켜서 로딩해서 쓴다.
	int step = 9;
	int faceOffset = 0;
	int baseOffset = 0;
	
	if ([name compare:@"haruka"] == NSOrderedSame) step = 10;
	else if ([name compare:@"hitomi"] == NSOrderedSame)
	{
		if (idx >= 84)
		{
			faceOffset = 14;
			baseOffset = -12;
		}
		step = 7;
	}

	baseIdx = idx / step + baseOffset;
	faceIdx = idx % (step * 2) + faceOffset;

	imgBase = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%d_%@_b.png", name, baseIdx, timeStr]];
	
	if ((faceIdx == 0)||(faceIdx == step))
		imgFace = nil;
	else
		imgFace = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%d_%@.png", name, faceIdx, timeStr]];

	[self setNeedsDisplay];
}

- (void)setBackGround:(int)idx isNight:(bool)isNight
{
	NSString *timeStr;
	if (isNight) timeStr = @"n";
	else timeStr = @"d";

	imgBack = [UIImage imageNamed:[NSString stringWithFormat:@"back_%d_%@.png", idx, timeStr]];

	[self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextBeginPath(context);

	CGContextDrawImage(context, CGRectMake(-160, 0, 640, 480), [imgBack CGImage]);
	CGContextDrawImage(context,
					   CGRectMake((320 - [imgBase size].width)/2,
								  480 - [imgBase size].height,
								  [imgBase size].width,
								  [imgBase size].height),
					   [imgBase CGImage]);
	if (imgFace != nil)
	{
		CGContextDrawImage(context,
						   CGRectMake((320 - [imgFace size].width)/2,
									  480 - [imgFace size].height,
									  [imgFace size].width,
									  [imgFace size].height),
						   [imgFace CGImage]);
	}
		
	CGContextStrokePath(context);
}

- (void)dealloc {
	[super dealloc];	
}

@end
