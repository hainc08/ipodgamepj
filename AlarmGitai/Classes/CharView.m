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
	switch (idx)
	{
		case 0:
			baseIdx = 41;
			faceIdx = -1;
			break;
		case 1:
			baseIdx = 0;
			faceIdx = 1;
			break;
		case 2:
			baseIdx = 1;
			faceIdx = -1;
			break;
	}
	
	imgBase = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%d_%@.png", name, baseIdx, timeStr]];

	if (faceIdx == -1)
	{
		imgFace = nil;
	}
	else
	{
		imgFace = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%d_face_%@.png", name, faceIdx, timeStr]];
	}

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
//	CGContextDrawImage(context, CGRectMake(97, 307, 116, 121), [imgFace CGImage]);

	CGContextStrokePath(context);
}

- (void)dealloc {
	[super dealloc];	
}

@end
