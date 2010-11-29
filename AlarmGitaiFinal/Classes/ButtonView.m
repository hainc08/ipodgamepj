
#import "ButtonView.h"


@implementation ButtonView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		TYPE = 0; // box 
		self.backgroundColor =[UIColor redColor];
		label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 0, 0)];
		[self addSubview:label];
		//fontName:@"굴림" pointSize:12.0f
		x	= frame.size.width;
		y	= frame.size.height;
		label.font =  [UIFont boldSystemFontOfSize:12];
		
		checkimage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 20, 60, 30)];
		[self setCheckImg:@"check.png"];
		
		[self addSubview:checkimage];
    }
    return self;
}

- (void)setView:(int)_inTYPE  fontsize:(float)_insize fontColor:(UIColor *)_inColor  setText:(NSString *)_inText bgColor:(UIColor *)_inBgColor chekImage:(bool)_inCheck
{
	TYPE = _inTYPE;
	
	if(TYPE == 1)
	{
		[label setFrame:CGRectMake(35, 5, 0, 0)];
	}
	else if(TYPE == 2)
	{
		[label setFrame:CGRectMake(35, 25, 0, 0)];
	}
	
	if(_insize > 0.0f)
		label.font =  [UIFont boldSystemFontOfSize:_insize];
	if(_inColor != nil)
		label.textColor = _inColor;
	if(_inBgColor != nil)
		self.backgroundColor = _inBgColor;
	
	if(_inText != nil)
	{
		label.textColor = [UIColor whiteColor];
		label.text = _inText;
		[label sizeToFit];
		label.backgroundColor = nil;
		label.opaque = NO;
	}
	
	if(_inCheck)
		[checkimage setAlpha:1];
	else 
		[checkimage setAlpha:0];
		
	[self setNeedsDisplay];
}

- (void)setText:(NSString *)_inText
{
	label.textColor = [UIColor whiteColor];
	label.text = _inText;
	[label sizeToFit];
	label.backgroundColor = nil;
	label.opaque = NO;

}

- (void)setCheck:(bool)_inCheck
{
	if(_inCheck)
		[checkimage setAlpha:1];
	else 
		[checkimage setAlpha:0];
	
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];

	if(TYPE == 0 )
	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		CGContextSetRGBStrokeColor(context, 1,1,1,1);
		CGContextSetLineWidth(context, 1);
		
		int i = 0;
		
		while(i < y){
			if( i > ARRAY && i < y - ARRAY )
			{
				CGContextMoveToPoint(context, 0, i);
				CGContextAddLineToPoint(context, ARRAY, i);
				CGContextStrokePath(context);
				CGContextMoveToPoint(context, x - ARRAY, i);
				CGContextAddLineToPoint(context, x, i);
				CGContextStrokePath(context);
				
			}
			else 
			{
				CGContextMoveToPoint(context, 0, i);
				CGContextAddLineToPoint(context, x, i);
				CGContextStrokePath(context);
			}
			i++;
		}
	}
	else if((TYPE == 1)||(TYPE == 2))
	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		CGContextBeginPath(context);
		CGContextDrawImage(context, CGRectMake(0, 0, 150, 60), [[UIImage imageNamed:@"button.png"] CGImage]);
		CGContextStrokePath(context);
	}
}

- (void)setCheckImg:(NSString *)filename
{
	[checkimage setImage:[UIImage imageNamed:filename]];
}

- (void)dealloc {
    [super dealloc];
	[label release];
	[checkimage release];
}

@end

